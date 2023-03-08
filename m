Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE4B6B0043
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCHHyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCHHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:54:33 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8B72725
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:54:32 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id d7so14661568vsj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678262071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZROicEC9TU/Yf4zsBSpQ6SvtM6o02kLYOlQBx2ObDKY=;
        b=Lxu8zAqsY0AynkWFOSRHoMFMeCI3QuSBx6BmqyF7/NPrR3CwyXAS15Qje/VHAS04X9
         9wI0rtWpbyn2NDxXishzXOzdNPXJ7vb9UBJgn1O3fUbQMoeSrk7zYZ2+jbvTfgxWHBZO
         smt5lA6zW9+NL7JiwAMEbL5o9W5hG/lD5sW7JNihhyqZmPvQ7E8nmRgDheW36QiCHuOL
         6RCUbeC9wblpVXYI+99XwiVZjvkWTteM+MqEj2SlVtUD5okt6NNAz5+oN82MnAKgQav5
         TTBTpXZO16L2vXfi7NGaGLPms1xi0sKwn/09/lG47Hh/xxvsGk3eA+lw/IWTDqjGPP7o
         MPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678262071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZROicEC9TU/Yf4zsBSpQ6SvtM6o02kLYOlQBx2ObDKY=;
        b=XSAh1k48HXC+0J9HlHw2RENfGjjUAZ6p0jR1W/c5aSU1p9k77Jzm25XXNOI9XmlD7y
         vycXCk2x4EToas/R9ILLi8OqRN6Smv9a1PGQtcTto4turMUWz95I7bvp9lbOnzu2BneH
         DHYdDF3SGpve/HYmNjbqd1eKhBlv1Hxw2LJcAEHxmmcyNTzuAOc8eaG4GKQNQDOCAksH
         Zgah5o4u3hqy5ZUUDwxvI0XKmgYo/fJwOfGj95NDD5mZqVanie/fYC4MKNWhWtKYiuKA
         nH1psq9wDJfBhJCZ1pTWe99ZG2jHsPZtXq8bKbCON5U2rjIRChwIEZ51Nb+abkoV9rjd
         4Rqw==
X-Gm-Message-State: AO0yUKUBTy9l3bCaZm5jT+ylgW2xdwXjh8zxK9tw8in0QpRL/bPcGaM8
        Twh0pRDJFp/s7FISuxIxRx12T5k3Ormjh159kqEadklm5ooSuxBVvvA=
X-Google-Smtp-Source: AK7set8cHOZpUtbKPw+4I21EoyXeWnGHo8a12mWiIPX0auShufUPiWOXz8lyzEIK7F08yUn/gok5kxTBSXmxVa06nZs=
X-Received: by 2002:a05:6102:e43:b0:412:565:7f7a with SMTP id
 p3-20020a0561020e4300b0041205657f7amr11660339vst.4.1678262071318; Tue, 07 Mar
 2023 23:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20230308022057.151078-1-haibo.li@mediatek.com>
In-Reply-To: <20230308022057.151078-1-haibo.li@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Mar 2023 08:53:55 +0100
Message-ID: <CANpmjNMj3JX6d=HS=CNzxZPZcJZWfz0G5wKmJjfGb_N525NNLw@mail.gmail.com>
Subject: Re: [PATCH] kcsan:fix alignment_fault when read unaligned
 instrumented memory
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 at 03:21, 'Haibo Li' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> After enable kcsan on arm64+linux-5.15,it reports alignment_fault
> when access unaligned address.

Is this KCSAN's fault or the fault of the code being instrumented?
I.e. if you disable KCSAN, is there still an alignment fault reported?

Because as-is, I don't understand how the instrumentation alone will
cause an alignment fault, because for every normal memory access there
is a corresponding instrumented access - therefore, that'd suggest
that the real access was also unaligned. Note that the compiler
inserts instrumentation _before_ the actual access, so if there's a
problem, that problem will manifest inside KCSAN.

Can you provide more information about what's going on (type of
access, size of access, etc.)?

> Here is the oops log:
> "
> Trying to unpack rootfs image as initramfs.....
> Unable to handle kernel paging request at virtual address
>   ffffff802a0d8d7171
> Mem abort info:o:
>   ESR = 0x9600002121
>   EC = 0x25: DABT (current EL), IL = 32 bitsts
>   SET = 0, FnV = 0 0
>   EA = 0, S1PTW = 0 0
>   FSC = 0x21: alignment fault
> Data abort info:o:
>   ISV = 0, ISS = 0x0000002121
>   CM = 0, WnR = 0 0
> swapper pgtable: 4k pages, 39-bit VAs, pgdp=000000002835200000
> [ffffff802a0d8d71] pgd=180000005fbf9003, p4d=180000005fbf9003,
> pud=180000005fbf9003, pmd=180000005fbe8003, pte=006800002a0d8707
> Internal error: Oops: 96000021 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 2 PID: 45 Comm: kworker/u8:2 Not tainted
>   5.15.78-android13-8-g63561175bbda-dirty #1
> ...
> pc : kcsan_setup_watchpoint+0x26c/0x6bc
> lr : kcsan_setup_watchpoint+0x88/0x6bc
> sp : ffffffc00ab4b7f0
> x29: ffffffc00ab4b800 x28: ffffff80294fe588 x27: 0000000000000001
> x26: 0000000000000019 x25: 0000000000000001 x24: ffffff80294fdb80
> x23: 0000000000000000 x22: ffffffc00a70fb68 x21: ffffff802a0d8d71
> x20: 0000000000000002 x19: 0000000000000000 x18: ffffffc00a9bd060
> x17: 0000000000000001 x16: 0000000000000000 x15: ffffffc00a59f000
> x14: 0000000000000001 x13: 0000000000000000 x12: ffffffc00a70faa0
> x11: 00000000aaaaaaab x10: 0000000000000054 x9 : ffffffc00839adf8
> x8 : ffffffc009b4cf00 x7 : 0000000000000000 x6 : 0000000000000007
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc00a70fb70
> x2 : 0005ff802a0d8d71 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  kcsan_setup_watchpoint+0x26c/0x6bc
>  __tsan_read2+0x1f0/0x234
>  inflate_fast+0x498/0x750

^^ is it possible that an access in "inflate_fast" is unaligned?

>  zlib_inflate+0x1304/0x2384
>  __gunzip+0x3a0/0x45c
>  gunzip+0x20/0x30
>  unpack_to_rootfs+0x2a8/0x3fc
>  do_populate_rootfs+0xe8/0x11c
>  async_run_entry_fn+0x58/0x1bc
>  process_one_work+0x3ec/0x738
>  worker_thread+0x4c4/0x838
>  kthread+0x20c/0x258
>  ret_from_fork+0x10/0x20
> Code: b8bfc2a8 2a0803f7 14000007 d503249f (78bfc2a8) )
> ---[ end trace 613a943cb0a572b6 ]-----
> "
>
> After checking linux 6.3-rc1 on QEMU arm64,it still has the possibility
> to read unaligned address in read_instrumented_memory(qemu can not
> emulate alignment fault)
>
> To fix alignment fault and read the value of instrumented memory
> more effective,bypass the unaligned access in read_instrumented_memory.
>
> Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> ---
>  kernel/kcsan/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 54d077e1a2dc..88e75d7d85d2 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -337,6 +337,11 @@ static void delay_access(int type)
>   */
>  static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
>  {
> +       bool aligned_read = (size == 1) || IS_ALIGNED((unsigned long)ptr, size);

(size==1) check is redundant because IS_ALIGNED(.., 1) should always
return true.

And this will also penalize other architectures which can do unaligned
accesses. So this check probably wants to be guarded by
"IS_ENABLED(CONFIG_ARM64)" or something.

> +       if (!aligned_read)
> +               return 0;
> +
>         switch (size) {
>         case 1:  return READ_ONCE(*(const u8 *)ptr);
>         case 2:  return READ_ONCE(*(const u16 *)ptr);
