Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4A688AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjBBXZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjBBXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E393402E0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEC55B827D6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 23:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467ACC433D2;
        Thu,  2 Feb 2023 23:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675380302;
        bh=p6iGgW+S3so5tfsC9Yq/DTYA9eV8RMMsa/ZHihwLc9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ReneXY26xWv6cvGo9Uc9bLyavSQJVlF9mcn7BzXyImSKlGY8UouFUaos0rW5PE9qf
         HhgE3/IEikRj9Y6/qqHBd7eCKPVk77stMXQpZdQ/+gUbpIwR7Za5j0QISj7rCLtU1L
         0HM1pVpMxaLmq0+HzIovbAZtUc3aSItpkZw2VeFw=
Date:   Thu, 2 Feb 2023 15:25:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Halbuer <halbuer@sra.uni-hannover.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
Message-Id: <20230202152501.297639031e96baad35cdab17@linux-foundation.org>
In-Reply-To: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Feb 2023 17:25:49 +0100 Alexander Halbuer <halbuer@sra.uni-hannover.de> wrote:

> The `rmqueue_bulk` function batches the allocation of multiple elements to
> refill the per-CPU buffers into a single hold of the zone lock. Each
> element is allocated and checked using the `check_pcp_refill` function.
> The check touches every related struct page which is especially expensive
> for higher order allocations (huge pages). This patch reduces the time
> holding the lock by moving the check out of the critical section similar
> to the `rmqueue_buddy` function which allocates a single element.
> Measurements of parallel allocation-heavy workloads show a reduction of
> the average huge page allocation latency of 50 percent for two cores and
> nearly 90 percent for 24 cores.

Sounds nice.

Were you able to test how much benefit we get by simply removing the
check_new_pages() call from rmqueue_bulk()?

Vlastimil, I find this quite confusing:

#ifdef CONFIG_DEBUG_VM
/*
 * With DEBUG_VM enabled, order-0 pages are checked for expected state when
 * being allocated from pcp lists. With debug_pagealloc also enabled, they are
 * also checked when pcp lists are refilled from the free lists.
 */
static inline bool check_pcp_refill(struct page *page, unsigned int order)
{
	if (debug_pagealloc_enabled_static())
		return check_new_pages(page, order);
	else
		return false;
}

static inline bool check_new_pcp(struct page *page, unsigned int order)
{
	return check_new_pages(page, order);
}
#else
/*
 * With DEBUG_VM disabled, free order-0 pages are checked for expected state
 * when pcp lists are being refilled from the free lists. With debug_pagealloc
 * enabled, they are also checked when being allocated from the pcp lists.
 */
static inline bool check_pcp_refill(struct page *page, unsigned int order)
{
	return check_new_pages(page, order);
}
static inline bool check_new_pcp(struct page *page, unsigned int order)
{
	if (debug_pagealloc_enabled_static())
		return check_new_pages(page, order);
	else
		return false;
}
#endif /* CONFIG_DEBUG_VM */

and the 4462b32c9285b5 changelog is a struggle to follow.

Why are we performing *any* checks when CONFIG_DEBUG_VM=n and when
debug_pagealloc_enabled is false?

Anyway, these checks sounds quite costly so let's revisit their
desirability?

