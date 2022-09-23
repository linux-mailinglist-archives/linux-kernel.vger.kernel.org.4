Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DDC5E7337
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIWFBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIWFBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:01:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC104126B40
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:01:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id e205so9492910iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HMVZ1lwOJCLVbYNzzct5sNRec80hO1ckcKYy2gqDUlM=;
        b=NPbw5nRcmye5tq9DIy/JwtnEO4oxit+H7REmMuML2VjDxOu5jtTQ/MuPbNrv5yzzIg
         G61crUAIQzjP/r++rlF+atGdjX3mClEgPHoVSZvixGIni8H01aDk+v4H7VQIkuD80x/g
         381BSjNBM9o5k9BrSAsB5tkVNOxFdqMtDEz/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HMVZ1lwOJCLVbYNzzct5sNRec80hO1ckcKYy2gqDUlM=;
        b=FNBmJPNhgT7WxHhn3oL0YTHS1+r1EFiaNaxQI8YTOvJEBGqXyMFLJciJsQ828jE7ss
         eDfnRfe/TjHYiLqTVYUMe7oy01YexkG7ZN2G9A20lSdhoQ40qzd8DMzCUwVViPfA8CBX
         Bf/IPQlV0cy2LrbwdiOJDftvmZvOGcoatuYprdkl1Jd+309Qq+izhiG/V512ieTcA5Ih
         JziHWABtYOpDbH3+OvFMvoEYVzdpjcfLh80MLptp8pgLbXDeRn8N7Om5jZSwZSiQlwYu
         9a9DZNM6Xly1KBPfCqKiE6WxexRJcPIMooVT4y8MxUMUvCnk9n2CWbcAY4n5steOrvOz
         wLnQ==
X-Gm-Message-State: ACrzQf2m0IdVKa6ei/WjgfhOSPmuzr3YHpqlZXu+QoZ5CSu3jrIBBHKD
        KwhHoWuXKPHAD7+fiCT7cuO1O1on/1Ybphga0w+TSg==
X-Google-Smtp-Source: AMsMyM7f2wtSwdoackW4p1ZhanMCS9kURJNifJ2gAM/g2cunGvEVOuy3g/PvlVcUQ7Wn/teWpn4BqUB0Ar5OtB+mcd8=
X-Received: by 2002:a05:6602:2e08:b0:6a1:30d1:7ca7 with SMTP id
 o8-20020a0566022e0800b006a130d17ca7mr3343820iow.45.1663909301652; Thu, 22 Sep
 2022 22:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org> <20220922053145.944786-1-denik@chromium.org>
 <87h70zk83g.wl-maz@kernel.org>
In-Reply-To: <87h70zk83g.wl-maz@kernel.org>
From:   Denis Nikitin <denik@chromium.org>
Date:   Thu, 22 Sep 2022 22:01:29 -0700
Message-ID: <CADDJ8CW0QgHtp1rwk=ZqrcuWZ4_L8KQh26VaEfcBQS0Tx9+ZYg@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: nvhe: Fix build with profile optimization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Sep 22, 2022 at 3:38 AM Marc Zyngier <maz@kernel.org> wrote:
>
> I was really hoping that you'd just drop the flags from the CFLAGS
> instead of removing the generated section. Something like:
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index b5c5119c7396..e5b2d43925b4 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -88,7 +88,7 @@ quiet_cmd_hypcopy = HYPCOPY $@
>
>  # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
>  # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
> -KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI) -fprofile-sample-use, $(KBUILD_CFLAGS))
>
>  # KVM nVHE code is run at a different exception code with a different map, so
>  # compiler instrumentation that inserts callbacks or checks into the code may

Sorry, I moved on with a different approach and didn't explain the rationale.

Like you mentioned before, the flag `-fprofile-sample-use` does not appear
in the kernel. And it looks confusing when the flag is disabled or filtered out
here. This was the first reason.

The root cause of the build failure wasn't the compiler profile guided
optimization but the extra metadata in SHT_REL section which llvm injected
into kvm_nvhe.tmp.o for further link optimization.
If we remove the .llvm.call-graph-profile section we fix the build and avoid
potential problems with relocations optimized by the linker. The profile
guided optimization will still be applied by the compiler.

Let me know what you think about it.

>
> However, I even failed to reproduce your problem using LLVM 14 as
> packaged by Debian (if that matters, I'm using an arm64 build
> machine). I build the kernel with:
>
> $ make LLVM=1 KCFLAGS=-fprofile-sample-use -j8 vmlinux
>
> and the offending object only contains the following sections:
>
> arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o:     file format elf64-littleaarch64
>
> Sections:
> Idx Name          Size      VMA               LMA               File off  Algn
>   0 .hyp.idmap.text 00000ae4  0000000000000000  0000000000000000  00000800  2**11
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>   1 .hyp.text     0000e988  0000000000000000  0000000000000000  00001800  2**11
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
>   2 .hyp.data..ro_after_init 00000820  0000000000000000  0000000000000000  00010188  2**3
>                   CONTENTS, ALLOC, LOAD, DATA
>   3 .hyp.rodata   00002e70  0000000000000000  0000000000000000  000109a8  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   4 .hyp.data..percpu 00001ee0  0000000000000000  0000000000000000  00013820  2**4
>                   CONTENTS, ALLOC, LOAD, DATA
>   5 .hyp.bss      00001158  0000000000000000  0000000000000000  00015700  2**3
>                   ALLOC
>   6 .comment      0000001f  0000000000000000  0000000000000000  00017830  2**0
>                   CONTENTS, READONLY
>   7 .llvm_addrsig 000000b8  0000000000000000  0000000000000000  0001784f  2**0
>                   CONTENTS, READONLY, EXCLUDE
>   8 .altinstructions 00001284  0000000000000000  0000000000000000  00015700  2**0
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>   9 __jump_table  00000960  0000000000000000  0000000000000000  00016988  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  10 __bug_table   0000051c  0000000000000000  0000000000000000  000172e8  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  11 __kvm_ex_table 00000028  0000000000000000  0000000000000000  00017808  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
>  12 .note.GNU-stack 00000000  0000000000000000  0000000000000000  00027370  2**0
>                   CONTENTS, READONLY
>
> So what am I missing to trigger this issue? Does it rely on something
> like PGO, which is not upstream yet? A bit of handholding would be
> much appreciated.

Right, it relies on the PGO profile.
On ChromeOS we collect the sample PGO profile from Arm devices with
enabled CoreSight/ETM. You can find more details on ETM at
https://www.kernel.org/doc/Documentation/trace/coresight/coresight.rst.

https://github.com/Linaro/OpenCSD/blob/master/decoder/tests/auto-fdo/autofdo.md
contains information about the pipeline of collecting, processing, and applying
the profile.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Denis
