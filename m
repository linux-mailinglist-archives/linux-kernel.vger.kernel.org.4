Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47462EA0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiKRAFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKRAFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:05:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974D0BC0;
        Thu, 17 Nov 2022 16:05:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32F0C6204B;
        Fri, 18 Nov 2022 00:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286C3C433D6;
        Fri, 18 Nov 2022 00:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668729947;
        bh=H8A+VfcBwEu+5oVlM/ylb1vTzqKOVIIzcbV2vdm5TRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNCkZVXFUcZFrQOGW2YcialIeFX2flA6n9/RBkJDbCfCY9LmBmCE3MgkOEZQfWc8B
         r1C0j6NWb7hABNH5zw6S8MnxBvSeFMlZzxMDwOFGI82U9okzQT0I/MYOTHkzR/VBlG
         ENEIaDjfLvFb3KLLNDmEjQYT7teUAImhdOIlX1ze7TlNZKGj0h/ahNC0kVQnrjTBXD
         t8C4O6KpOdHy4mcjNkwV1cgZDf0Y5SoGkSAgEpls7z9/IEA5mk9R0x2kJMw7BIi9Pz
         bvU5pLfmS/8q4QtuzGSU7s3OJNr7sCAjrhGiKIa9pNnqARqduJu4+EYFkIguGMlyx9
         xr1LcP95PEu+g==
Date:   Thu, 17 Nov 2022 18:05:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Ananda <a.badmaev@clicknet.pro>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zblock_reclaim_block(): Control flow issues
Message-ID: <Y3bMTK+558whA1VX@work>
References: <202211171421.914F0F3719@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211171421.914F0F3719@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:21:46PM -0800, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221117 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Wed Nov 16 16:19:12 2022 -0800
>     9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")
> 
> Coverity reported the following:
> 
> *** CID 1527349:  Control flow issues  (NO_EFFECT)
> mm/zblock.c:412 in zblock_reclaim_block()
> 406     	unsigned long handle, block_type, slot;
> 407     	int ret, i, reclaimed;
> 408
> 409     	/* start with list storing blocks with the worst compression and try
> 410     	 * to evict the first added (oldest) block in this list
> 411     	 */
> vvv     CID 1527349:  Control flow issues  (NO_EFFECT)
> vvv     This greater-than-or-equal-to-zero comparison of an unsigned value is always true. "block_type >= 0UL".
> 412     	for (block_type = ARRAY_SIZE(block_desc) - 1; block_type >= 0; --block_type) {

This seems like a legit issue.

--
Gustavo

> 413     		list = &(pool->block_lists[block_type]);
> 414     		spin_lock(&list->lock);
> 415
> 416     		/* find the oldest block in list */
> 417     		block = list_last_entry(&list->head, struct zblock_block, block_node);
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527349 ("Control flow issues")
> Fixes: 9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")
> 
> Thanks for your attention!
> 
> -- 
> Coverity-bot
