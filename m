Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123FB66B035
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjAOJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjAOJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:48:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6EFB46D;
        Sun, 15 Jan 2023 01:48:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id kt14so2840813ejc.3;
        Sun, 15 Jan 2023 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U91tZ1pcL+C5oCwSnm2ekb7b6jfm6xqHe6fUGsu0ktM=;
        b=nnDDnTlzHuKvIuOwtJ8+Uq5p94FYTsvGa/hjrDCWnj4igFQ/+5OMt9b+0VuOvJTSsF
         i7+CnSb7s3qDZ5PosseVVS+xilrMjkv66/dEb67/IwDMbVkd7NyGVdjB24XPEYyqnQ7G
         poVHSWf4P6kv4bpOGH+YVXZjL11kNMKRdc7WZptXhqg+Hqbc4efIfYqaywEeLmjDywSG
         dO0O1tWss+0Xi1jD3BdkpFUgRn/dHyE6iZY+36C0mjvBQPFYXt+LmoC08/DDGLnFNO5T
         uG1aFnm6Ik/Ma6VQ0kYR0VA6lJ3U2SM0Q/bUtuAyB73YzxZQDViaE1Ew7hh8tTSW93J2
         si4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U91tZ1pcL+C5oCwSnm2ekb7b6jfm6xqHe6fUGsu0ktM=;
        b=l6ZFY79aRg/zP+A+RWuiBPSTJQJiLnFh+oNMMRKGpmjq8RGCQbs0YLMEORHsJHRaUX
         Xh9mrpvVLY2lr401BLcgTI16Ij7ukWSZfBINcqWQwoEql+xpmN5a3LzQhizxpZAjocON
         aNWErxB3UHdEfKOT/fpZXrNusJDP7nB9PKt1n61jnnD3tyAWW9pugYUICqUwl7dGlciN
         h/LAwhkcXgE9dIuI4vOwHqYzS/caEQ0PvtfaLSMdIBmOwrrL/TiadmELWvkjugtGYFq0
         dkpIXnxIFyf0vYTwhvmaEXmn8RjSZv3Tr+2C/wGQ9ngORFuAcEXmTy00IlrPRVGfCSMn
         oIXg==
X-Gm-Message-State: AFqh2koS/P+yiJKF5ynS8uwkZ/QiZlrl/VHVN+XcCrMLLEGLYrFJFlGx
        o3VP4lPbvt7Xyb8uD0aLJ+BAUxopwLegDoNcrws=
X-Google-Smtp-Source: AMrXdXut/jQfPnLAZ0P8wTjeVheBJGzDy1oXd+fLbIjFFvMb2cO1l1wWanUjf0idLIAT+L4AoNQ/GeLj+GyV7h2w9sI=
X-Received: by 2002:a17:906:d217:b0:7c1:8a0b:f915 with SMTP id
 w23-20020a170906d21700b007c18a0bf915mr6150975ejz.42.1673776096219; Sun, 15
 Jan 2023 01:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-3-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-3-davidgow@google.com>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Sun, 15 Jan 2023 10:47:39 +0100
Message-ID: <CAA76j91Kn62Rqs9843njNSmuvb2XEyNLnC996Bmmz1obTbCX9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: arch/um: Disable FP/SIMD instruction to match x86
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2022 at 05:49, David Gow <davidgow@google.com> wrote:
>
> The kernel disables all SSE and similar FP/SIMD instructions on
> x86-based architectures (partly because we shouldn't be using floats in
> the kernel, and partly to avoid the need for stack alignment, see:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D53383 )
>
> UML does not do the same thing, which isn't in itself a problem, but
> does add to the list of differences between UML and "normal" x86 builds.
>
> In addition, there was a crash bug with LLVM < 15 / rustc < 1.65 when
> building with SSE, so disabling it fixes rust builds with earlier
> compiler versions, see:
> https://github.com/Rust-for-Linux/linux/pull/881
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  arch/x86/Makefile.um | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index b3c1ae084180..d2e95d1d4db7 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -1,6 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  core-y +=3D arch/x86/crypto/
>
> +#
> +# Disable SSE and other FP/SIMD instructions to match normal x86
> +#
> +KBUILD_CFLAGS +=3D -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> +KBUILD_RUSTFLAGS +=3D -Ctarget-feature=3D-sse,-sse2,-sse3,-ssse3,-sse4.1=
,-sse4.2,-avx,-avx2
> +
>  ifeq ($(CONFIG_X86_32),y)
>  START :=3D 0x8048000
>
> --
> 2.39.0.314.g84b9a713c41-goog
>

Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
