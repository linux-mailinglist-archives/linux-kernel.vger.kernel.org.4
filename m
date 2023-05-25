Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2C711A49
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjEYWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEYWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:45:07 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFB9E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:45:01 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-561bcd35117so3745217b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685054701; x=1687646701;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr4PzYVvcFu5HRS+oUxUsdXhS9HU/i14IGA9kInV6TU=;
        b=TjYjn6KmCyyJoAwue8HvkMTmfxRDWJmcG7ZWa2chlQXhANNAMx3kHaK351lIiAi+uY
         vFFSUg8DiT7CdeXRGnrHCVXgLTnx8tkMOzpr5+TilY0wRHNjGkNLnmvsjyuUDrTqtUI/
         RG5grrCzluZapGlbCT3mM6N1154bwAnoJEy4RLT/99t2w/zb4rVnhnC7nIu+boxKICfs
         vryo9pRudQRKchESj5rFv0xLwTV76PzVVLzTMKB6PRmMuwV4K/qZql1Yu7rfEYJQNQUK
         Kk3m2ZGaHDh4pIO45OUhc2gN2+wRG4l6W3dASY6XMmMoxC1GGvHnrruNoYZFbTuwVYHZ
         ea9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685054701; x=1687646701;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr4PzYVvcFu5HRS+oUxUsdXhS9HU/i14IGA9kInV6TU=;
        b=KkZPtRXFnPB1LdgngjWxZv+BD91Kv1abAKkG5/LtHwtThHxVhCk0mNO7C8DfMs7FjI
         rawjSAOSVuGVgUm33owYJqqxmQA89Qwp6NR/sEUbRHag/Ic/Jx3qOBM48l9bUqAkg1oi
         nvRVNjeSxwYIkcqJ60DuVkb9xqBd+OfXmEAeS1u0662I7l8wM/ezLNNY5j27H5uWdFrl
         0M6wP+ESVxE3a5UNtU8A+RxM+UYe6dK+49iLM5VwRfQZbQKUBrrAZ2VLaG7TiiKavi3S
         XEd/18hp0RfnhDWiFPw2xcT9kjinqhDNVrv+8LAU2ZWafdnp3+yfAHzEOC2LM3BYwoew
         /Y/A==
X-Gm-Message-State: AC+VfDzZ4G0Kcb4Y01u/x5z0Pae3OaiShhLFG3kShogZGRsPia71yc7R
        0+0Hvng8uk8Y7uQC8IznN8EXxw==
X-Google-Smtp-Source: ACHHUZ7PWCnU65QmVAHZO/udLtMlEKOZXpL3ccFnkwF15Ous02mDtojdRLGZ24kcfmtChFQBDV0BqQ==
X-Received: by 2002:a0d:d4d5:0:b0:565:8c16:a0e1 with SMTP id w204-20020a0dd4d5000000b005658c16a0e1mr53112ywd.13.1685054700797;
        Thu, 25 May 2023 15:45:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i22-20020a0ddf16000000b00556aa81f615sm716151ywe.68.2023.05.25.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:45:00 -0700 (PDT)
Date:   Thu, 25 May 2023 15:44:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Tu Jinjiang <tujinjiang@huawei.com>
cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH] mm: shmem: Fix UAF bug in shmem_show_options()
In-Reply-To: <20230525031640.593733-1-tujinjiang@huawei.com>
Message-ID: <489cb23-7860-feb8-1b58-3586db1be3@google.com>
References: <20230525031640.593733-1-tujinjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 25 May 2023, Tu Jinjiang wrote:

> shmem_show_options() uses sbinfo->mpol without adding it's refcnt. This
> may lead to race with replacement of the mpol by remount. The execution
> sequence is as follows.
> 
>        CPU0                                   CPU1
> shmem_show_options()                        shmem_reconfigure()
>     shmem_show_mpol(seq, sbinfo->mpol)          mpol = sbinfo->mpol
>                                                 mpol_put(mpol)
>         mpol->mode
> 
> The KASAN report is as follows.
> 
> BUG: KASAN: slab-use-after-free in shmem_show_options+0x21b/0x340
> Read of size 2 at addr ffff888124324004 by task mount/2388
> 
> CPU: 2 PID: 2388 Comm: mount Not tainted 6.4.0-rc3-00017-g9d646009f65d-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x37/0x50
>  print_report+0xd0/0x620
>  ? shmem_show_options+0x21b/0x340
>  ? __virt_addr_valid+0xf4/0x180
>  ? shmem_show_options+0x21b/0x340
>  kasan_report+0xb8/0xe0
>  ? shmem_show_options+0x21b/0x340
>  shmem_show_options+0x21b/0x340
>  ? __pfx_shmem_show_options+0x10/0x10
>  ? strchr+0x2c/0x50
>  ? strlen+0x23/0x40
>  ? seq_puts+0x7d/0x90
>  show_vfsmnt+0x1e6/0x260
>  ? __pfx_show_vfsmnt+0x10/0x10
>  ? __kasan_kmalloc+0x7f/0x90
>  seq_read_iter+0x57a/0x740
>  vfs_read+0x2e2/0x4a0
>  ? __pfx_vfs_read+0x10/0x10
>  ? down_write_killable+0xb8/0x140
>  ? __pfx_down_write_killable+0x10/0x10
>  ? __fget_light+0xa9/0x1e0
>  ? up_write+0x3f/0x80
>  ksys_read+0xb8/0x150
>  ? __pfx_ksys_read+0x10/0x10
>  ? fpregs_assert_state_consistent+0x55/0x60
>  ? exit_to_user_mode_prepare+0x2d/0x120
>  do_syscall_64+0x3c/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
>  </TASK>
> 
> Allocated by task 2387:
>  kasan_save_stack+0x22/0x50
>  kasan_set_track+0x25/0x30
>  __kasan_slab_alloc+0x59/0x70
>  kmem_cache_alloc+0xdd/0x220
>  mpol_new+0x83/0x150
>  mpol_parse_str+0x280/0x4a0
>  shmem_parse_one+0x364/0x520
>  vfs_parse_fs_param+0xf8/0x1a0
>  vfs_parse_fs_string+0xc9/0x130
>  shmem_parse_options+0xb2/0x110
>  path_mount+0x597/0xdf0
>  do_mount+0xcd/0xf0
>  __x64_sys_mount+0xbd/0x100
>  do_syscall_64+0x3c/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> Freed by task 2389:
>  kasan_save_stack+0x22/0x50
>  kasan_set_track+0x25/0x30
>  kasan_save_free_info+0x2e/0x50
>  __kasan_slab_free+0x10e/0x1a0
>  kmem_cache_free+0x9c/0x350
>  shmem_reconfigure+0x278/0x370
>  reconfigure_super+0x383/0x450
>  path_mount+0xcc5/0xdf0
>  do_mount+0xcd/0xf0
>  __x64_sys_mount+0xbd/0x100
>  do_syscall_64+0x3c/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The buggy address belongs to the object at ffff888124324000
>  which belongs to the cache numa_policy of size 32
> The buggy address is located 4 bytes inside of
>  freed 32-byte region [ffff888124324000, ffff888124324020)
> ==================================================================
> 
> To fix the bug, shmem_get_sbmpol() / mpol_put() needs to be called
> before / after shmem_show_mpol() call.
> 
> Signed-off-by: Tu Jinjiang <tujinjiang@huawei.com>

Thank you -
Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/shmem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e40a08c5c6d7..5e54ab5f61f2 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3726,6 +3726,7 @@ static int shmem_reconfigure(struct fs_context *fc)
>  static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>  {
>  	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
> +	struct mempolicy *mpol;
>  
>  	if (sbinfo->max_blocks != shmem_default_max_blocks())
>  		seq_printf(seq, ",size=%luk",
> @@ -3768,7 +3769,9 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
>  	if (sbinfo->huge)
>  		seq_printf(seq, ",huge=%s", shmem_format_huge(sbinfo->huge));
>  #endif
> -	shmem_show_mpol(seq, sbinfo->mpol);
> +	mpol = shmem_get_sbmpol(sbinfo);
> +	shmem_show_mpol(seq, mpol);
> +	mpol_put(mpol);
>  	if (sbinfo->noswap)
>  		seq_printf(seq, ",noswap");
>  	return 0;
> -- 
> 2.25.1
