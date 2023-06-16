Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFB733AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjFPUQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjFPUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:16:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE2635BD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:16:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1171463E33
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 20:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B24DC433C8;
        Fri, 16 Jun 2023 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686946600;
        bh=r1/rE7q7B9G5wovZrruNQFK13c8rxM+QTwTPz01sOds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CQQ0nM2W/E3WihKX0NzuD7GwsVcjouhHPg/g91HOOpEfR7CnzsBas+4HZEvy4671e
         L+BXCS4lhiz7qZGBJ841n+xMxZC3dky2IZ6SDYvZx/4RE0HtVzklxm0m/DMa7Ioflm
         OOeF/lkyACPF9a2h3KdaEN907rAdHS83g0MrjlFY=
Date:   Fri, 16 Jun 2023 13:16:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Feng Tang <feng.tang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Message-Id: <20230616131639.992998157fe696eb0e0589aa@linux-foundation.org>
In-Reply-To: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 10:35:36 -0400 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
> performed by context switch. This causes false-sharing for surrounding
> mm_struct fields which are read-mostly.
> 
> This has been observed on a 2sockets/112core/224cpu Intel Sapphire
> Rapids server running hackbench, and by the kernel test robot
> will-it-scale testcase.
> 
> Move the mm_count field into its own cache line to prevent false-sharing
> with other mm_struct fields.
> 
> Move mm_count to the first field of mm_struct to minimize the amount of
> padding required: rather than adding padding before and after the
> mm_count field, padding is only added after mm_count.
> 
> Note that I noticed this odd comment in mm_struct:
> 
> commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
> 
>                 /*
>                  * With some kernel config, the current mmap_lock's offset
>                  * inside 'mm_struct' is at 0x120, which is very optimal, as
>                  * its two hot fields 'count' and 'owner' sit in 2 different
>                  * cachelines,  and when mmap_lock is highly contended, both
>                  * of the 2 fields will be accessed frequently, current layout
>                  * will help to reduce cache bouncing.
>                  *
>                  * So please be careful with adding new fields before
>                  * mmap_lock, which can easily push the 2 fields into one
>                  * cacheline.
>                  */
>                 struct rw_semaphore mmap_lock;
> 
> This comment is rather odd for a few reasons:
> 
> - It requires addition/removal of mm_struct fields to carefully consider
>   field alignment of _other_ fields,
> - It expresses the wish to keep an "optimal" alignment for a specific
>   kernel config.
> 
> I suspect that the author of this comment may want to revisit this topic
> and perhaps introduce a split-struct approach for struct rw_semaphore,
> if the need is to place various fields of this structure in different
> cache lines.
> 
> ...
>
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -583,6 +583,21 @@ struct mm_cid {
>  struct kioctx_table;
>  struct mm_struct {
>  	struct {
> +		/*
> +		 * Fields which are often written to are placed in a separate
> +		 * cache line.
> +		 */
> +		struct {
> +			/**
> +			 * @mm_count: The number of references to &struct
> +			 * mm_struct (@mm_users count as 1).
> +			 *
> +			 * Use mmgrab()/mmdrop() to modify. When this drops to
> +			 * 0, the &struct mm_struct is freed.
> +			 */
> +			atomic_t mm_count;
> +		} ____cacheline_aligned_in_smp;
> +

Why add the anonymous struct?

	atomic_t mm_count ____cacheline_aligned_in_smp;

would suffice?

Secondly, the ____cacheline_aligned_in_smp doesn't actually do
anything?  mm_count is at offset 0 which is cacheline aligned anyway. 
The next field (mm_mt) will share a cacheline with mm_count.

If the plan is to put mm_count in "its own" cacheline then padding will
be needed?


