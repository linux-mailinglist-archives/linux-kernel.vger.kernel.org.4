Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39673386E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbjFPSyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjFPSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:54:14 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1643C0E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1686941631;
        bh=VNT5xnOEGjWm0oQ2Ve65fcX3U8t0E0DrHtFvp2I4rpU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ypp9IPZEVGqp4u7FDGXa2iHYNous6G9/mLXHipj0tNQjDggg/VmIUC4LTKUcqGMf2
         kkpWMzYOwKRSFYVzoUN+f4OE1uAjl8d4HpQoG7qoc8ad//nrlMRAiA4PVAqs8hQjr7
         6X8OGs0fQDtILv3sV/asT7eT87w1H729KzAZe0GR8v6r3Qoe/Rzk688/d5l/RBn00c
         ER5yXpaGO9/3P5yh7jrT2GgBu8NGG0XyCCdpnTJ6s62Tj90r8ZiDnhBScDS/5yZqDz
         ji3jIaFW/ekkUSFtbc+bsbi3V/uoqjDv3vz+Pw2jWCLNj/n5iCUURIfyR/YmSWol70
         Z+2OXTiu7gPXg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QjSxC0KyPz18gY;
        Fri, 16 Jun 2023 14:53:51 -0400 (EDT)
Message-ID: <313c3bea-d710-a769-8cb7-0964614425a2@efficios.com>
Date:   Fri, 16 Jun 2023 14:54:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Feng Tang <feng.tang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:35, Mathieu Desnoyers wrote:
> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
> performed by context switch. This causes false-sharing for surrounding
> mm_struct fields which are read-mostly.

Hi Andrew,

Given that this patch touches mm code, I think it should go through your 
tree. Nobody has voiced any objection for a month, Aaron Lu gave his 
Reviewed-by tag [1], and it solves measurable performance regressions.

Would you be willing to pick it up ?

Please let me know if something else is needed.

Thanks!

Mathieu

[1] https://lore.kernel.org/lkml/20230516044050.GA315678@ziqianlu-desk2

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
>                  /*
>                   * With some kernel config, the current mmap_lock's offset
>                   * inside 'mm_struct' is at 0x120, which is very optimal, as
>                   * its two hot fields 'count' and 'owner' sit in 2 different
>                   * cachelines,  and when mmap_lock is highly contended, both
>                   * of the 2 fields will be accessed frequently, current layout
>                   * will help to reduce cache bouncing.
>                   *
>                   * So please be careful with adding new fields before
>                   * mmap_lock, which can easily push the 2 fields into one
>                   * cacheline.
>                   */
>                  struct rw_semaphore mmap_lock;
> 
> This comment is rather odd for a few reasons:
> 
> - It requires addition/removal of mm_struct fields to carefully consider
>    field alignment of _other_ fields,
> - It expresses the wish to keep an "optimal" alignment for a specific
>    kernel config.
> 
> I suspect that the author of this comment may want to revisit this topic
> and perhaps introduce a split-struct approach for struct rw_semaphore,
> if the need is to place various fields of this structure in different
> cache lines.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
> Link: https://lore.kernel.org/lkml/7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Olivier Dion <odion@efficios.com>
> Cc: michael.christie@oracle.com
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-mm@kvack.org
> ---
>   include/linux/mm_types.h | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..de10fc797c8e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -583,6 +583,21 @@ struct mm_cid {
>   struct kioctx_table;
>   struct mm_struct {
>   	struct {
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
>   		struct maple_tree mm_mt;
>   #ifdef CONFIG_MMU
>   		unsigned long (*get_unmapped_area) (struct file *filp,
> @@ -620,14 +635,6 @@ struct mm_struct {
>   		 */
>   		atomic_t mm_users;
>   
> -		/**
> -		 * @mm_count: The number of references to &struct mm_struct
> -		 * (@mm_users count as 1).
> -		 *
> -		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
> -		 * &struct mm_struct is freed.
> -		 */
> -		atomic_t mm_count;
>   #ifdef CONFIG_SCHED_MM_CID
>   		/**
>   		 * @pcpu_cid: Per-cpu current cid.

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

