Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DC86C5344
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVSIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:08:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4FE35B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:07:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so76340856edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679508477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLJGX0EKaIlJsuACNrfuO/cWmg0IaxiAqenjCNIMQu4=;
        b=jRc0LFEPITCXyTrYtjY+Vxc0xOA0oaaarsqE5+prkZNRPaRDgE8LAZgwIgCnNpLX9r
         XNZdVQxgP4sbnLd6Busbw4b4S0Sgv0LVYd52KIGsS3CrtYUrcLYYoiR9ytckWsItgZrl
         ZEwldT5V2jDqW3cM8uD2JVocaUHOj7mRYcx1OhU/6j8nq0smegufptLGY7XLX8GliTkK
         thr6eJOZXejhSM4670XLP2ybgZF1pkYQwajlk5WFPtzNNwnaZ1l6MLCK7KxCn7aJUxsG
         1zbiasX4jsTOkgYFVJ/rbmCBSpbZehYD8cbzEq35D0S9keOcdYr26ZsoDknYlZ+KgNvm
         MGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLJGX0EKaIlJsuACNrfuO/cWmg0IaxiAqenjCNIMQu4=;
        b=3VnVPyfkQv/ZWakJ7y7vLeVCJJ5dLLWMbuiCxv84KR6sefTM65YMWLCy8BPocLyw4b
         kV/cBTIQ2IKW+9zYW8Oavip/qTB93kfTg597AiQOyiGu7d4Y30FNuAx77WG1brZqXVPj
         R21/Mgm4GV0sDAgsCKti4FiZ6az0kaHEUsaYl14NsRpA2N9Oa/VB417dwayE2qq4rtwC
         qHE++CBaZ7wPoR/3GZ8hdmCWVNWHRzmCWkf22EsSKaJBYYHbLgDByKj37AG6weXFqanE
         OGqump8BcGgBQacFbP+CvxG8ul1oG87HPqGkmNCjRSLadXnbq5Ndf8qyGxXjdGBsfQcD
         a1Ng==
X-Gm-Message-State: AO0yUKWeW1z+BhSnzItuM34d3zPeIZ4+rtmkdlBdvYmV6i6jNvaGxn+n
        LezEi4tkvsJ/YBZ+pQzGm8Gf5I6L1p3OA5jc8O42Nw==
X-Google-Smtp-Source: AK7set8LI9fhWubF8PlGsr43UU27W0crfQjy6c7y2MVN12s1F9ZSrkanywh1cM640fuS5lWW9uQmH0mxRKFdAFJo5yk=
X-Received: by 2002:a17:906:3e4b:b0:8dd:70a:3a76 with SMTP id
 t11-20020a1709063e4b00b008dd070a3a76mr3882882eji.11.1679508477484; Wed, 22
 Mar 2023 11:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679456900.git.jpoimboe@kernel.org> <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
In-Reply-To: <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 22 Mar 2023 11:07:21 -0700
Message-ID: <CABCJKuf5hsddHpnON5q9LpAXr-8s=5dL0iTpRD-hFzcBynB+Gw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] arm64/static_call: Fix static call CFI violations
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:00=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On arm64, with CONFIG_CFI_CLANG, it's trivial to trigger CFI violations
> by running "perf record -e sched:sched_switch -a":
>
>   CFI failure at perf_misc_flags+0x34/0x70 (target: __static_call_return0=
+0x0/0xc; expected type: 0x837de525)
>   WARNING: CPU: 3 PID: 32 at perf_misc_flags+0x34/0x70
>   CPU: 3 PID: 32 Comm: ksoftirqd/3 Kdump: loaded Tainted: P              =
     6.3.0-rc2 #8
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   pstate: 904000c5 (NzcV daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>   pc : perf_misc_flags+0x34/0x70
>   lr : perf_event_output_forward+0x74/0xf0
>   sp : ffff80000a98b970
>   x29: ffff80000a98b970 x28: ffff00077bd34d00 x27: ffff8000097d2d00
>   x26: fffffbffeff6a360 x25: ffff800009835a30 x24: ffff0000c2e8dca0
>   x23: 0000000000000000 x22: 0000000000000080 x21: ffff00077bd31610
>   x20: ffff0000c2e8dca0 x19: ffff00077bd31610 x18: ffff800008cd52f0
>   x17: 00000000837de525 x16: 0000000072923c8f x15: 000000000000b67e
>   x14: 000000000178797d x13: 0000000000000004 x12: 0000000070b5b3a8
>   x11: 0000000000000015 x10: 0000000000000048 x9 : ffff80000829e2b4
>   x8 : ffff80000829c6f0 x7 : 0000000000000000 x6 : 0000000000000000
>   x5 : fffffbffeff6a340 x4 : ffff00077bd31610 x3 : ffff00077bd31610
>   x2 : ffff800009833400 x1 : 0000000000000000 x0 : ffff00077bd31610
>   Call trace:
>    perf_misc_flags+0x34/0x70
>    perf_event_output_forward+0x74/0xf0
>    __perf_event_overflow+0x12c/0x1e8
>    perf_swevent_event+0x98/0x1a0
>    perf_tp_event+0x140/0x558
>    perf_trace_run_bpf_submit+0x88/0xc8
>    perf_trace_sched_switch+0x160/0x19c
>    __schedule+0xabc/0x153c
>    dynamic_cond_resched+0x48/0x68
>    run_ksoftirqd+0x3c/0x138
>    smpboot_thread_fn+0x26c/0x2f8
>    kthread+0x108/0x1c4
>    ret_from_fork+0x10/0x20
>
> The problem is that the __perf_guest_state() static call does an
> indirect branch to __static_call_return0(), which isn't CFI-compliant.
>
> Fix that by generating custom CFI-compliant ret0 functions for each
> defined static key.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig                            |  4 ++
>  arch/arm64/include/asm/static_call.h    | 29 +++++++++++
>  include/linux/static_call.h             | 64 +++++++++++++++++++++----
>  include/linux/static_call_types.h       |  4 ++
>  kernel/Makefile                         |  2 +-
>  kernel/static_call.c                    |  2 +-
>  tools/include/linux/static_call_types.h |  4 ++
>  7 files changed, 97 insertions(+), 12 deletions(-)
>  create mode 100644 arch/arm64/include/asm/static_call.h
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index e3511afbb7f2..8800fe80a0f9 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1348,6 +1348,10 @@ config HAVE_STATIC_CALL_INLINE
>         depends on HAVE_STATIC_CALL
>         select OBJTOOL
>
> +config CFI_WITHOUT_STATIC_CALL
> +       def_bool y
> +       depends on CFI_CLANG && !HAVE_STATIC_CALL
> +
>  config HAVE_PREEMPT_DYNAMIC
>         bool
>
> diff --git a/arch/arm64/include/asm/static_call.h b/arch/arm64/include/as=
m/static_call.h
> new file mode 100644
> index 000000000000..b3489cac7742
> --- /dev/null
> +++ b/arch/arm64/include/asm/static_call.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_STATIC_CALL_H
> +#define _ASM_ARM64_STATIC_CALL_H
> +
> +/*
> + * Make a dummy reference to a function pointer in C to force the compil=
er to
> + * emit a __kcfi_typeid_ symbol for asm to use.
> + */
> +#define GEN_CFI_SYM(func)                                              \
> +       static typeof(func) __used __section(".discard.cfi") *__UNIQUE_ID=
(cfi) =3D func

Couldn't we just use __ADDRESSABLE instead of adding a separate macro?
The type of the variable shouldn't matter here, as long as we take the
address of func.

Sami
