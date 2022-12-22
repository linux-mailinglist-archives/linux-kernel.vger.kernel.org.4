Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FC6540F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbiLVMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiLVMWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:22:11 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511118B24
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:22:10 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w20so1832313ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/4Ai+7/9tsJEaKUGjCwWP2+aABMhRcTmi+u/34V2hQw=;
        b=nvZY/9YpTr6jdTc70zjaWMLJZUKjioAcdLd/4C8tX6ze7rKLdE852vscXOkFqjlaF9
         pLYIIy8ifrTQe4D2zsv5ltsg0oCwZ3z5qsDwuds5IV3RrFOB2/RiwXIBPYnPifCI3AEc
         VRT0rEkxIZBT9v4PExPhWXtNlfKkYqOqD222D4MRuvJYXjsS5JxNAK4W7oVZDeZoFeAs
         fx9jdR90hqF7s87xDjQCbnr/X+YNeLT6CywbuOVR1QuqtjKc3SpRtC9txaPtqdTqPGrL
         8gQBIQRaMrKKgy20xASCXrna+tkY3p2xP1uR+mV3O4VXBS+NkrPvAp4LVsDIM9QnMW+y
         c7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Ai+7/9tsJEaKUGjCwWP2+aABMhRcTmi+u/34V2hQw=;
        b=El0wpjstlzdgUnu8tddJb79sf0VTPD6Z1KYWoXc/xa2QTNb86yVMUm2N/GgKeIDIR2
         mZ2kdR/wfPa3Ig+d5xNxTjFCvE1ud+UsRzhxp4AuWPAMvdt+zEPS9j3fXuvH+3S6kUwn
         kpZ+QE6NSTAGFCYxidNuCXVIe6NmwX3MJBjGWkptigNkQzO9zrpQ2QWFXozhQCkakHRb
         bStckTqdSq8SkBpDopvhr2SB9fk6KRwrUd1a9BdNC+E3BDPpL79+AUrCCWcBD8BIS0Fz
         qkWfSeQkO7RQ96BSnuq/o2kUCXj6SFqBl2isJhQaKu8k4GmTgewBwRgyZPtyZp6lEsst
         331w==
X-Gm-Message-State: AFqh2krZWl5nvvUTirg2dWZ6+AATFuT1icPilnQJf75sFiKEW84/sGTO
        H3cKSfBB/a+NmFxlOkWAkAk=
X-Google-Smtp-Source: AMrXdXsYS0wAj3OWoSeexDWjyc/7PlVD9Fr/gxFxH6GG3j+D09BnjecoB8a4irEUWi+h3ICNtoWfYg==
X-Received: by 2002:a17:902:9043:b0:189:bc50:b93b with SMTP id w3-20020a170902904300b00189bc50b93bmr4937485plz.3.1671711729735;
        Thu, 22 Dec 2022 04:22:09 -0800 (PST)
Received: from mail.google.com ([103.135.102.144])
        by smtp.gmail.com with ESMTPSA id b8-20020a1709027e0800b00189a7fbfd44sm378005plm.211.2022.12.22.04.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 04:22:09 -0800 (PST)
Date:   Thu, 22 Dec 2022 20:22:07 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org, changbin.du@intel.com,
        zong.li@sifive.com, rostedt@goodmis.org, boqun.feng@gmail.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH V2] riscv: patch: Fixup lockdep warning in stop_machine
Message-ID: <20221222122207.3ycdew6azfg6cqwy@mail.google.com>
References: <20221120101049.2078117-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120101049.2078117-1-guoren@kernel.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 05:10:49AM -0500, guoren@kernel.org wrote:
> From: Changbin Du <changbin.du@gmail.com>
> 
> The task of ftrace_arch_code_modify(_post)_prepare() caller is
> stop_machine, whose caller and work thread are different tasks. The
> lockdep checker needs the same task context, or it's wrong. That means
> it's a bug here to use lockdep_assert_held because we don't guarantee
> the same task context.
> 
> kernel/locking/lockdep.c:
> int __lock_is_held(const struct lockdep_map *lock, int read)
> {
>         struct task_struct *curr = current;
>         int i;
> 
>         for (i = 0; i < curr->lockdep_depth; i++) {
> 			^^^^^^^^^^^^^^^^^^^
>                 struct held_lock *hlock = curr->held_locks + i;
> 					  ^^^^^^^^^^^^^^^^
>                 if (match_held_lock(hlock, lock)) {
>                         if (read == -1 || !!hlock->read == read)
>                                 return LOCK_STATE_HELD;
> 
> The __lock_is_held depends on current held_locks records; if
> stop_machine makes the checker runing on another task, that's wrong.
> 
> Here is the log:
> [   15.761523] ------------[ cut here ]------------
> [   15.762125] WARNING: CPU: 0 PID: 15 at arch/riscv/kernel/patch.c:63 patch_insn_write+0x72/0x364
> [   15.763258] Modules linked in:
> [   15.764154] CPU: 0 PID: 15 Comm: migration/0 Not tainted 6.1.0-rc1-00014-g66924be85884-dirty #377
> [   15.765339] Hardware name: riscv-virtio,qemu (DT)
> [   15.765985] Stopper: multi_cpu_stop+0x0/0x192 <- stop_cpus.constprop.0+0x90/0xe2
> [   15.766711] epc : patch_insn_write+0x72/0x364
> [   15.767011]  ra : patch_insn_write+0x70/0x364
> [   15.767276] epc : ffffffff8000721e ra : ffffffff8000721c sp : ff2000000067bca0
> [   15.767622]  gp : ffffffff81603f90 tp : ff60000002432a00 t0 : 7300000000000000
> [   15.767919]  t1 : 0000000000000000 t2 : 73695f6b636f6c5f s0 : ff2000000067bcf0
> [   15.768238]  s1 : 0000000000000008 a0 : 0000000000000000 a1 : 0000000000000000
> [   15.768537]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
> [   15.768837]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
> [   15.769139]  s2 : ffffffff80009faa s3 : ff2000000067bd10 s4 : ffffffffffffffff
> [   15.769447]  s5 : 0000000000000001 s6 : 0000000000000001 s7 : 0000000000000003
> [   15.769740]  s8 : 0000000000000002 s9 : 0000000000000004 s10: 0000000000000003
> [   15.770027]  s11: 0000000000000002 t3 : 0000000000000000 t4 : ffffffff819af097
> [   15.770323]  t5 : ffffffff819af098 t6 : ff2000000067ba28
> [   15.770574] status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
> [   15.771102] [<ffffffff80007520>] patch_text_nosync+0x10/0x3a
> [   15.771421] [<ffffffff80009c66>] ftrace_update_ftrace_func+0x74/0x10a
> [   15.771704] [<ffffffff800fa17e>] ftrace_modify_all_code+0xb0/0x16c
> [   15.771958] [<ffffffff800fa24c>] __ftrace_modify_code+0x12/0x1c
> [   15.772196] [<ffffffff800e110e>] multi_cpu_stop+0x14a/0x192
> [   15.772454] [<ffffffff800e0a34>] cpu_stopper_thread+0x96/0x14c
> [   15.772699] [<ffffffff8003f4ea>] smpboot_thread_fn+0xf8/0x1cc
> [   15.772945] [<ffffffff8003ac9c>] kthread+0xe2/0xf8
> [   15.773160] [<ffffffff80003e98>] ret_from_exception+0x0/0x14
> [   15.773471] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 0ff7c3b33127 ("riscv: Use text_mutex instead of patch_lock")
> Cc: Changbin Du <changbin.du@gmail.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Zong Li <zong.li@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> ---
> Changes in v2:
>  - Rewrite commit log with lockdep explanation [Guo Ren]
>  - Rebase on v6.1 [Guo Ren]
> 
> v1:
> https://lore.kernel.org/linux-riscv/20210417023532.354714-1-changbin.du@gmail.com/
> ---
>  arch/riscv/kernel/patch.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 765004b60513..8619706f8dfd 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -55,13 +55,6 @@ static int patch_insn_write(void *addr, const void *insn, size_t len)
>  	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
>  	int ret;
>  
> -	/*
> -	 * Before reaching here, it was expected to lock the text_mutex
> -	 * already, so we don't need to give another lock here and could
> -	 * ensure that it was safe between each cores.
> -	 */
> -	lockdep_assert_held(&text_mutex);
> -
>  	if (across_pages)
>  		patch_map(addr + len, FIX_TEXT_POKE1);
>  
> -- 
> 2.36.1
> 

Signed-off-by: Changbin Du <changbin.du@gmail.com>

Thanks!
