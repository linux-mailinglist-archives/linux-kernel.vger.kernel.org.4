Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD7D6E3FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDQGUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjDQGUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:20:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AE82D60
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8b766322bso10918641fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681712419; x=1684304419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3NatNGb5e+iqumoFVlbvQ8U1eNJKPVDAG264xnsFNU=;
        b=P2f2mN3WmvoZDFCOzqduAsa5jpjgUbX23RAlO/VgCpwZeGHE+mbKSjMOlpBcZOgJ3p
         1EjFsBoZdOQbkNt8qn0JeGMSZcos23nNoJ10oNVmGyG/r9JDK5yBHEe84WnJPBBP4fMC
         bDQxkMDA+HcygxqZiONqIamhifBV7Yd5KyandZRRmoZuj04zGOpluvuRmGfGRjdel5oo
         9RCAQJJDVmxHZQRwpoRBRRK48l0hPSe7AfoFmpFwvp4g5pmrMRuMFM2fTB5BRjQL/zXN
         oHwU3oLiaFHwm4oLRo3ncCITWoARQ5dUbaL6GMn7zEsOJa66iWZxaWWESMKXao9N5eU7
         c1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712419; x=1684304419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3NatNGb5e+iqumoFVlbvQ8U1eNJKPVDAG264xnsFNU=;
        b=jCE6wB5Mwkj1KcXgHVrwblOW8wQ45wa5jXRMIHKTrMpeu3/bTUyfJFjGd5uYITjJ1/
         V7dDxi5fydJMVA3S2YC8X+JfvdiO/ZK2YsCPEko04eCKNl0GRpx513KEFDxYyCqkGi3A
         ZMuows2z1T3Fq/8AiyzF5Hs5r3z6KuEBoQC/KZF+6Qwc4KqYc/zH4QjpFnhfI8jETNIU
         nMUMiTWR/yJUIFdI7FiUoQsRpD0gc5oWRlbDYTVsOxiVhxsLngyUftVm3Y6OzVxNCUdY
         8nquraPDZ9dF6vrAk2UVXRhcHtA+UROsZKnx11E6Rit+g92dw+b17H06vhe5M+2AHKQ8
         fd2w==
X-Gm-Message-State: AAQBX9cFlM6UJUCoIr0P7zOQ197vFmTNkh3r7j6zed3KDflzfjhvib6v
        137aTW1QpaMspnxkhoSDn4JAfcK6eGnALqwaKAfflw==
X-Google-Smtp-Source: AKy350YPJbWHC8k0J5m5z90YTK7o7vRZktXr8/e5VA+rJ1sszfvSc/YoDyf78eXNMauwwlZf8qXsvEHOMftWP75OszQ=
X-Received: by 2002:a19:c502:0:b0:4ec:89d6:9b71 with SMTP id
 w2-20020a19c502000000b004ec89d69b71mr1721559lfe.6.1681712418760; Sun, 16 Apr
 2023 23:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230417051556epcas2p25b57d681bfae498b30ff33f0a96033d6@epcas2p2.samsung.com>
 <20230417051637.103964-1-hy50.seo@samsung.com>
In-Reply-To: <20230417051637.103964-1-hy50.seo@samsung.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 Apr 2023 08:20:05 +0200
Message-ID: <CACT4Y+YnbfUdh5G6cXX2goP2VFfCx=Mr=_ZXAyGyLTHV1EqXwA@mail.gmail.com>
Subject: Re: [PATCH v1] lib/stackdepot: limit nr_entries size
To:     SEO HOYOUNG <hy50.seo@samsung.com>
Cc:     andreyknvl@gmail.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        vbabka@suse.cz, edumazet@google.com, longman@redhat.com,
        surenb@google.com, elver@google.com, glider@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 at 07:16, SEO HOYOUNG <hy50.seo@samsung.com> wrote:
>
> While using the MCQ feature of UFS, dump stack was detected very deeply.
> If this continues to happen, depot_alloc_stack() will continue to exceed
> STACK_ALLOC_SIZE and STACK_ALLOC_MAX_SLABS, eventually resulting
> in the warning "Stack depot reached limit capacity".
>
> So want to limit the size of entries stored in it.
> 25 is a test value, and we found that in a normal case,
> the depth of the stack does not exceed 25.
>
> [ 2479.383395]I[0:launcher-loader: 1719] Stack depot reached limit capacity
> [ 2479.383538]I[0:launcher-loader: 1719] WARNING: CPU: 0 PID: 1719 at lib/stackdepot.c:129 __stack_depot_save+0x464/0x46c
> [ 2479.385693]I[0:launcher-loader: 1719] pstate: 624000c5 (nZCv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [ 2479.385724]I[0:launcher-loader: 1719] pc : __stack_depot_save+0x464/0x46c
> [ 2479.385751]I[0:launcher-loader: 1719] lr : __stack_depot_save+0x460/0x46c
> [ 2479.385774]I[0:launcher-loader: 1719] sp : ffffffc0080073c0
> [ 2479.385793]I[0:launcher-loader: 1719] x29: ffffffc0080073e0 x28: ffffffd00b78a000 x27: 0000000000000000
> [ 2479.385839]I[0:launcher-loader: 1719] x26: 000000000004d1dd x25: ffffff891474f000 x24: 00000000ca64d1dd
> [ 2479.385882]I[0:launcher-loader: 1719] x23: 0000000000000200 x22: 0000000000000220 x21: 0000000000000040
> [ 2479.385925]I[0:launcher-loader: 1719] x20: ffffffc008007440 x19: 0000000000000000 x18: 0000000000000000
> [ 2479.385969]I[0:launcher-loader: 1719] x17: 2065726568207475 x16: 000000000000005e x15: 2d2d2d2d2d2d2d20
> [ 2479.386013]I[0:launcher-loader: 1719] x14: 5d39313731203a72 x13: 00000000002f6b30 x12: 00000000002f6af8
> [ 2479.386057]I[0:launcher-loader: 1719] x11: 00000000ffffffff x10: ffffffb90aacf000 x9 : e8a74a6c16008800
> [ 2479.386101]I[0:launcher-loader: 1719] x8 : e8a74a6c16008800 x7 : 00000000002f6b30 x6 : 00000000002f6af8
> [ 2479.386145]I[0:launcher-loader: 1719] x5 : ffffffc0080070c8 x4 : ffffffd00b192380 x3 : ffffffd0092b313c
> [ 2479.386189]I[0:launcher-loader: 1719] x2 : 0000000000000001 x1 : 0000000000000004 x0 : 0000000000000022
> [ 2479.386231]I[0:launcher-loader: 1719] Call trace:
> [ 2479.386248]I[0:launcher-loader: 1719]  __stack_depot_save+0x464/0x46c
> [ 2479.386273]I[0:launcher-loader: 1719]  kasan_save_stack+0x58/0x70
> [ 2479.386303]I[0:launcher-loader: 1719]  save_stack_info+0x34/0x138
> [ 2479.386331]I[0:launcher-loader: 1719]  kasan_save_free_info+0x18/0x24
> [ 2479.386358]I[0:launcher-loader: 1719]  ____kasan_slab_free+0x16c/0x170
> [ 2479.386385]I[0:launcher-loader: 1719]  __kasan_slab_free+0x10/0x20
> [ 2479.386410]I[0:launcher-loader: 1719]  kmem_cache_free+0x238/0x53c
> [ 2479.386435]I[0:launcher-loader: 1719]  mempool_free_slab+0x1c/0x28
> [ 2479.386460]I[0:launcher-loader: 1719]  mempool_free+0x7c/0x1a0
> [ 2479.386484]I[0:launcher-loader: 1719]  bvec_free+0x34/0x80
> [ 2479.386514]I[0:launcher-loader: 1719]  bio_free+0x60/0x98
> [ 2479.386540]I[0:launcher-loader: 1719]  bio_put+0x50/0x21c
> [ 2479.386567]I[0:launcher-loader: 1719]  f2fs_write_end_io+0x4ac/0x4d0
> [ 2479.386594]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
> [ 2479.386622]I[0:launcher-loader: 1719]  __dm_io_complete+0x324/0x37c
> [ 2479.386650]I[0:launcher-loader: 1719]  dm_io_dec_pending+0x60/0xa4
> [ 2479.386676]I[0:launcher-loader: 1719]  clone_endio+0xf8/0x2f0
> [ 2479.386700]I[0:launcher-loader: 1719]  bio_endio+0x2dc/0x300
> [ 2479.386727]I[0:launcher-loader: 1719]  blk_update_request+0x258/0x63c
> [ 2479.386754]I[0:launcher-loader: 1719]  scsi_end_request+0x50/0x304
> [ 2479.386782]I[0:launcher-loader: 1719]  scsi_io_completion+0x88/0x160
> [ 2479.386808]I[0:launcher-loader: 1719]  scsi_finish_command+0x17c/0x194
> [ 2479.386833]I[0:launcher-loader: 1719]  scsi_complete+0xcc/0x158
> [ 2479.386859]I[0:launcher-loader: 1719]  blk_mq_complete_request+0x4c/0x5c
> [ 2479.386885]I[0:launcher-loader: 1719]  scsi_done_internal+0xf4/0x1e0
> [ 2479.386910]I[0:launcher-loader: 1719]  scsi_done+0x14/0x20
> [ 2479.386935]I[0:launcher-loader: 1719]  ufshcd_compl_one_cqe+0x578/0x71c
> [ 2479.386963]I[0:launcher-loader: 1719]  ufshcd_mcq_poll_cqe_nolock+0xc8/0x150
> [ 2479.386991]I[0:launcher-loader: 1719]  ufshcd_intr+0x868/0xc0c
> [ 2479.387017]I[0:launcher-loader: 1719]  __handle_irq_event_percpu+0xd0/0x348
> [ 2479.387044]I[0:launcher-loader: 1719]  handle_irq_event_percpu+0x24/0x74
> [ 2479.387068]I[0:launcher-loader: 1719]  handle_irq_event+0x74/0xe0
> [ 2479.387091]I[0:launcher-loader: 1719]  handle_fasteoi_irq+0x174/0x240
> [ 2479.387118]I[0:launcher-loader: 1719]  handle_irq_desc+0x7c/0x2c0
> [ 2479.387147]I[0:launcher-loader: 1719]  generic_handle_domain_irq+0x1c/0x28
> [ 2479.387174]I[0:launcher-loader: 1719]  gic_handle_irq+0x64/0x158
> [ 2479.387204]I[0:launcher-loader: 1719]  call_on_irq_stack+0x2c/0x54
> [ 2479.387231]I[0:launcher-loader: 1719]  do_interrupt_handler+0x70/0xa0
> [ 2479.387258]I[0:launcher-loader: 1719]  el1_interrupt+0x34/0x68
> [ 2479.387283]I[0:launcher-loader: 1719]  el1h_64_irq_handler+0x18/0x24
> [ 2479.387308]I[0:launcher-loader: 1719]  el1h_64_irq+0x68/0x6c
> [ 2479.387332]I[0:launcher-loader: 1719]  blk_attempt_bio_merge+0x8/0x170
> [ 2479.387356]I[0:launcher-loader: 1719]  blk_mq_attempt_bio_merge+0x78/0x98
> [ 2479.387383]I[0:launcher-loader: 1719]  blk_mq_submit_bio+0x324/0xa40
> [ 2479.387409]I[0:launcher-loader: 1719]  __submit_bio+0x104/0x138
> [ 2479.387436]I[0:launcher-loader: 1719]  submit_bio_noacct_nocheck+0x1d0/0x4a0
> [ 2479.387462]I[0:launcher-loader: 1719]  submit_bio_noacct+0x618/0x804
> [ 2479.387487]I[0:launcher-loader: 1719]  submit_bio+0x164/0x180
> [ 2479.387511]I[0:launcher-loader: 1719]  f2fs_submit_read_bio+0xe4/0x1c4
> [ 2479.387537]I[0:launcher-loader: 1719]  f2fs_mpage_readpages+0x888/0xa4c
> [ 2479.387563]I[0:launcher-loader: 1719]  f2fs_readahead+0xd4/0x19c
> [ 2479.387587]I[0:launcher-loader: 1719]  read_pages+0xb0/0x4ac
> [ 2479.387614]I[0:launcher-loader: 1719]  page_cache_ra_unbounded+0x238/0x288
> [ 2479.387642]I[0:launcher-loader: 1719]  do_page_cache_ra+0x60/0x6c
> [ 2479.387669]I[0:launcher-loader: 1719]  page_cache_ra_order+0x318/0x364
> [ 2479.387695]I[0:launcher-loader: 1719]  ondemand_readahead+0x30c/0x3d8
> [ 2479.387722]I[0:launcher-loader: 1719]  page_cache_sync_ra+0xb4/0xc8
> [ 2479.387749]I[0:launcher-loader: 1719]  filemap_read+0x268/0xd24
> [ 2479.387777]I[0:launcher-loader: 1719]  f2fs_file_read_iter+0x1a0/0x62c
> [ 2479.387806]I[0:launcher-loader: 1719]  vfs_read+0x258/0x34c
> [ 2479.387831]I[0:launcher-loader: 1719]  ksys_pread64+0x8c/0xd0
> [ 2479.387857]I[0:launcher-loader: 1719]  __arm64_sys_pread64+0x48/0x54
> [ 2479.387881]I[0:launcher-loader: 1719]  invoke_syscall+0x58/0x158
> [ 2479.387909]I[0:launcher-loader: 1719]  el0_svc_common+0xf0/0x134
> [ 2479.387935]I[0:launcher-loader: 1719]  do_el0_svc+0x44/0x114
> [ 2479.387961]I[0:launcher-loader: 1719]  el0_svc+0x2c/0x80
> [ 2479.387985]I[0:launcher-loader: 1719]  el0t_64_sync_handler+0x48/0x114
> [ 2479.388010]I[0:launcher-loader: 1719]  el0t_64_sync+0x190/0x194
> [ 2479.388038]I[0:launcher-loader: 1719] Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> ---
>  lib/stackdepot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 2f5aa851834e..f158729598a6 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -43,6 +43,7 @@
>  #define DEPOT_MAX_POOLS \
>         (((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
>          (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
> +#define DEPO_MAX_DEPTH 25
>
>  /* Compact structure that stores a reference to a stack. */
>  union handle_parts {
> @@ -375,7 +376,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>          * filter_irq_stacks() to simplify all callers' use of stack depot.
>          */
>         nr_entries = filter_irq_stacks(entries, nr_entries);
> -
> +       nr_entries = nr_entries > DEPO_MAX_DEPTH ? DEPO_MAX_DEPTH : nr_entries;
>         if (unlikely(nr_entries == 0) || stack_depot_disabled)
>                 goto fast_exit;

Hi SEO,

The stack overflow errors are related to total number of stacks rather
than size of a single stack.

filter_irq_stacks() is somehow not working in your case. It's supposed
to strip stacks somewhere around el1_interrupt (on interrupt entry),
but it's failing to do it.
As a result you are getting an effectively infinite amount of random
stacks saved.

 You need to debug why filter_irq_stacks() is failing in your case and
fix that instead.
