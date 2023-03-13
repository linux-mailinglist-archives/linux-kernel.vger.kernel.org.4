Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E96B81BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCMTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCMTbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09AB7C3FF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE2961485
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DA6C433D2;
        Mon, 13 Mar 2023 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678735863;
        bh=5XeMF8jQzp3Dp3pYeKgR8FPosfe763x1qsXohvbYslA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rcgrwrft7kR4eHoesRwq0phMWCnKTm9rS2/Q5S9ax9cmVT0Uteeux58qylmfFQwG9
         RhucOsKTfBCuWRMeAS2pFqSLqRHlsbDLtRTWcskLexY7wzNZQQPd+Bc0lt9eBE8k0k
         N3jlCcZTltPkwNP2L0lxsFa+j5lUdv2Q3G/jZovY=
Date:   Mon, 13 Mar 2023 12:31:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        mgorman@techsingularity.net, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
Message-Id: <20230313123102.52118e6007f21c45063fbe79@linux-foundation.org>
In-Reply-To: <20230313170838.GA3044@monkey>
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
        <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
        <20230313170838.GA3044@monkey>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 10:08:38 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> I suspect holding the lru lock when calling isolate_or_dissolve_huge_page was
> not considered.  However, I wonder if this can really happen in practice?
> 
> Before the code below, there is this:
> 
> 		/*
> 		 * Periodically drop the lock (if held) regardless of its
> 		 * contention, to give chance to IRQs. Abort completely if
> 		 * a fatal signal is pending.
> 		 */
> 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
> 			if (locked) {
> 				unlock_page_lruvec_irqrestore(locked, flags);
> 				locked = NULL;
> 			}
> 			...
> 		}
> 
> It would seem that the pfn of a hugetlb page would always be a multiple of
> COMPACT_CLUSTER_MAX so we would drop the lock.  However, I am not sure if
> that is ALWAYS true and would prefer something like the code you suggested.
> 
> Did you actually see this deadlock in practice?

Presumably the lack of lockdep reports about this tells us something?
