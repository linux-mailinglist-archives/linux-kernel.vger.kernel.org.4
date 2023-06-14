Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8176C72B8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjFLHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjFLHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:40:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CCAB8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:39:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3c8f454b0so4905495ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686555508; x=1689147508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X9ekp0+zYZM4xZosq7yl9dSi5Xn4lH/oGLlFM9hpWsc=;
        b=V9qmwSHVSBOHeoKQ062q4BaRSDS+69A5xPgRuoMJYE0OnJKTdCgiQSqoLL5mK5ciUk
         zJwyYolx991wpHEqSontgOaQTZ6pwogtbmi2HPBpvVFJzcbb066qI2AEgGdWl9H2ah/6
         +a7Ka5GZwlQVkNDYqMXa1/Ugi9IdzGvGxzCMVveI5rO31L7pUbbGR/7CHfhV3Rapq21d
         UACKKSg+y0c6z8iwyFOb49p58KHzahtO2ZTQk0S+y0LCoQuSJnWLRPfHVJdJgu4zdvYF
         JIsQoS69vL37NkW5UmzZS7NF71306mhpGHohQ1/rFY6PU1xpqx2bVxchRmX2Rv1zI+7F
         RA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686555508; x=1689147508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9ekp0+zYZM4xZosq7yl9dSi5Xn4lH/oGLlFM9hpWsc=;
        b=Ucmvk1t2azaXK1wtIn1DGZVfnpPAi1Hlx1+aNLHfY/p8p3OpuJDsuYlWP17IJtfJuz
         HZR4DzanpSRfBUXhVsAR0F0kcJIiuRm9b/Vq0H+xNYjQqsiaZHo8AaSkmyuQS4efAV5d
         uuZXmPl91AFjNJSBgm1Bbj5dpa7iAyR79BgtBShs7AshnJjqrIoQ4BOo3crcZNuqcKBk
         ZR0Ypsk3TUzCcvjPBkWfQVft046z+dNV5EiDJ1h7eo09o3b/5TKLgqNd59gpbAPPLt9U
         GQe6dDj7j+gtlKBkXnTGa5tp5BI/CAAu88O5jSCkcO1wiSPq+hfwWlJYtPKQBhZwfPzc
         96Aw==
X-Gm-Message-State: AC+VfDwwA6qLFaiSE58zjbl0G2dYPUVMfjLEWdg/WsfSsQEBv9tPT3kr
        5EeiBnkMEOQCAc2i3wkroLvq/Q==
X-Google-Smtp-Source: ACHHUZ62gTRvApHSkcoj5JgqBZy76bhty8dc6nXQwh8ODmS+zUwB0MWgqDJcnSgEbsRHCU40l50gUg==
X-Received: by 2002:a17:902:e744:b0:1b2:6054:862d with SMTP id p4-20020a170902e74400b001b26054862dmr7248175plf.50.1686555507784;
        Mon, 12 Jun 2023 00:38:27 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001b03b1bcf6bsm2080977pld.252.2023.06.12.00.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 00:38:27 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:38:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/core: Bail out early if the request AUX area is
 out of bound
Message-ID: <20230612073821.GB217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612052452.53425-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuai,

On Mon, Jun 12, 2023 at 01:24:51PM +0800, Shuai Xue wrote:
> When perf-record with a large AUX area, e.g 4GB, it fails with:
> 
>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>     failed to mmap with 12 (Cannot allocate memory)
> 
> and it reveals a WARNING with __alloc_pages:
> 
> [   66.595604] ------------[ cut here ]------------
> [   66.600206] WARNING: CPU: 44 PID: 17573 at mm/page_alloc.c:5568 __alloc_pages+0x1ec/0x248
> [   66.608375] Modules linked in: ip6table_filter(E) ip6_tables(E) iptable_filter(E) ebtable_nat(E) ebtables(E) aes_ce_blk(E) vfat(E) fat(E) aes_ce_cipher(E) crct10dif_ce(E) ghash_ce(E) sm4_ce_cipher(E) sm4(E) sha2_ce(E) sha256_arm64(E) sha1_ce(E) acpi_ipmi(E) sbsa_gwdt(E) sg(E) ipmi_si(E) ipmi_devintf(E) ipmi_msghandler(E) ip_tables(E) sd_mod(E) ast(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) nvme(E) sysimgblt(E) i2c_algo_bit(E) nvme_core(E) drm_shmem_helper(E) ahci(E) t10_pi(E) libahci(E) drm(E) crc64_rocksoft(E) i40e(E) crc64(E) libata(E) i2c_core(E)
> [   66.657719] CPU: 44 PID: 17573 Comm: perf Kdump: loaded Tainted: G            E      6.3.0-rc4+ #58
> [   66.666749] Hardware name: Default Default/Default, BIOS 1.2.M1.AL.P.139.00 03/22/2023
> [   66.674650] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> [   66.681597] pc : __alloc_pages+0x1ec/0x248
> [   66.685680] lr : __kmalloc_large_node+0xc0/0x1f8
> [   66.690285] sp : ffff800020523980
> [   66.693585] pmr_save: 000000e0
> [   66.696624] x29: ffff800020523980 x28: ffff000832975800 x27: 0000000000000000
> [   66.703746] x26: 0000000000100000 x25: 0000000000100000 x24: ffff8000083615d0
> [   66.710866] x23: 0000000000040dc0 x22: ffff000823d6d140 x21: 000000000000000b
> [   66.717987] x20: 000000000000000b x19: 0000000000000000 x18: 0000000000000030
> [   66.725108] x17: 0000000000000000 x16: ffff800008f05be8 x15: ffff000823d6d6d0
> [   66.732229] x14: 0000000000000000 x13: 343373656761705f x12: 726e202c30206574
> [   66.739350] x11: 00000000ffff7fff x10: 00000000ffff7fff x9 : ffff8000083af570
> [   66.746471] x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 000000000005fff4
> [   66.753592] x5 : 0000000000000000 x4 : ffff000823d6d8d8 x3 : 0000000000000000
> [   66.760713] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000040dc0
> [   66.767834] Call trace:
> [   66.770267]  __alloc_pages+0x1ec/0x248
> [   66.774003]  __kmalloc_large_node+0xc0/0x1f8
> [   66.778259]  __kmalloc_node+0x134/0x1e8
> [   66.782081]  rb_alloc_aux+0xe0/0x298
> [   66.785643]  perf_mmap+0x440/0x660
> [   66.789031]  mmap_region+0x308/0x8a8
> [   66.792593]  do_mmap+0x3c0/0x528
> [   66.795807]  vm_mmap_pgoff+0xf4/0x1b8
> [   66.799456]  ksys_mmap_pgoff+0x18c/0x218
> [   66.803365]  __arm64_sys_mmap+0x38/0x58
> [   66.807187]  invoke_syscall+0x50/0x128
> [   66.810922]  el0_svc_common.constprop.0+0x58/0x188
> [   66.815698]  do_el0_svc+0x34/0x50
> [   66.818999]  el0_svc+0x34/0x108
> [   66.822127]  el0t_64_sync_handler+0xb8/0xc0
> [   66.826296]  el0t_64_sync+0x1a4/0x1a8
> [   66.829946] ---[ end trace 0000000000000000 ]---
> 
> The pages for AUX area are organized as rb->aux_pages[] which alloced by
> kcalloc_node() later. The kcalloc() family guarantees the pages are
> physically contiguous (and virtually contiguous) with an order of
> MAX_ORDER - 1 at maximum.

This description is incorrect.  We need to distinguish two things:

AUX trace pages and 'rb->aux_pages' is pointer array which is used to
maintains these page.  Here, the kernel oops reports the error is not
for AUX trace pages but for failing to allocate the pointer array from
slab (or slub) area.

Furthermore, I believe the AUX trace pages are only mapped for VMA
(continuous virtual address), the kernel will defer to map to physical
pages (which means it's not necessarily continuous physical pages)
when handling data abort caused by accessing the pages.

When you specify the AUX buffer size to 4GiB, the kernel will convert it
to page numbers (page size is 4KiB, page number is = 4GiB / 4KiB = 1MiB).
Since aarch64's pointer type's length is 8 bytes, thus we need to
allocate the 8MiB buffer from slab/slub, unfortunately, 8MiB crosses the
limitation set by MAX_ORDER (4KiB ^ (MAX_ORDER - 1) = 4MiB), this is
why we receive the oops from __alloc_pages().

> So bail out early with -EINVAL if the request AUX area is out of bound,
> e.g.:
> 
>     #perf record -C 0 -m ,4G -e arm_spe_0// -- sleep 1
>     failed to mmap with 22 (Invalid argument)
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  kernel/events/core.c                     | 10 ++++++++++
>  tools/perf/Documentation/perf-record.txt |  3 ++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 435815d..83d4e29 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6404,6 +6404,16 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  			return -EINVAL;
>  
>  		nr_pages = vma_size / PAGE_SIZE;
> +		/*
> +		 * The pages for AUX area are organized as rb->aux_pages[]
> +		 * which alloced by kcalloc_node() later. The kcalloc() family
> +		 * guarantees the pages are physically contiguous (and
> +		 * virtually contiguous) with an order of MAX_ORDER - 1 at
> +		 * maximum MAX_ORDER. So bail out early if the request AUX area
> +		 * is out of bound.
> +		 */
> +		if (get_order(nr_pages * sizeof(void *)) >= MAX_ORDER)
> +			return -EINVAL;

From my view, now kernel has handled this case (I agree it might be
not directive for outputting error or warning info rather than oops).

If we really want this checking, I'd like to add it in rb_alloc_aux(),
since rb_alloc_aux() is the place for allocation the memory, thus it's
right place for the checking memory limitation.  And you might need to
consider the update the comments to avoid confusion.

I am not the best person for the decision, I'd like to leave it to perf
maintainers and wait for their thoughts.

Thanks,
Leo

>  		mutex_lock(&event->mmap_mutex);
>  		ret = -EINVAL;
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index ff815c2..a50a426 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -236,7 +236,8 @@ OPTIONS
>  	specification with appended unit character - B/K/M/G. The
>  	size is rounded up to have nearest pages power of two value.
>  	Also, by adding a comma, the number of mmap pages for AUX
> -	area tracing can be specified.
> +	area tracing can be specified. With MAX_ORDER set as 11, the
> +	maximum AUX area is limit to 2GB.
>  
>  -g::
>  	Enables call-graph (stack chain/backtrace) recording for both
> -- 
> 1.8.3.1
> 
