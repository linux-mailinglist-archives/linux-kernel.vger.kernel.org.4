Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403A060BF3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJYAHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJYAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:07:08 -0400
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7215B78A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:25:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 6DCF722C2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:55:57 +0100 (IST)
Received: (qmail 12650 invoked from network); 24 Oct 2022 14:55:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Oct 2022 14:55:57 -0000
Date:   Mon, 24 Oct 2022 15:55:55 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] mm: fix pcp count beyond pcp high in pcplist allocation
Message-ID: <20221024145555.oaoisy6m723h4axc@techsingularity.net>
References: <20221024134146.3442393-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221024134146.3442393-1-chenwandun@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:41:46PM +0800, Chen Wandun wrote:
> Nowadays there are several orders in pcplist, Function __rmqueue_pcplist
> would alloc pcp batch pages to refill pcplist, when list of target order
> if empty meanwhile other lists is not all empty, that result in pcp count
> beyond pcp high after allocation. This behaviour can be easily observed by
> adding debugging information in __rmqueue_pcplist.
> 
> Fix this by recalculate the batch pages to be allocated.

Are any problems observed other than the PCP lists temporarily exceed
pcp->high? As is, the patch could result in a batch request of 0 and
fall through to allocating from the zone list anyway defeating the
purpose of the PCP allocator and probably regressing performance in some
csaes.

The intention was to allow high to be briefly exceeded on the refill side,
particularly for THP pages and to always refill by at least two pages. In
the THP case, one would be allocated and maybe one in the near future
without acquiring the zone lock. If the limits are exceeded, it's only
exceeded until the next free.

-- 
Mel Gorman
SUSE Labs
