Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408D7688A05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjBBWtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjBBWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:49:03 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E06B038
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:49:02 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id a1so4202650ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1gNA4C4UihjneUIjcFqX08gIYJikAuQ32UbK2Pru/1I=;
        b=eXEV/h9ck3KRFOC0ByQf7K9dBgY69UZLz6azXFp3xsXycbPYGy4+XbeA+lIwQ8gFPz
         T8ZcTs1vb8v2RnQgTIvkWTEaL5b0+nBGUzd68TC7jljIiOutc1V3EwFUULs1pUFJ45AV
         CcKKJiSlBY8SLLL7SpFcwclCggdDLgDKxIMqc//u6FrzcrEQ/6G4O1Jt5JkBJfRGHDKd
         3UCUso5eZg15Xs4buGiqqGRtssbGFcpBEopEn05zq7B/YmjtqtcHiwweYToTp/W5cXl5
         px2m3nQ/kpbK6joPU/xzDE+g6KOaSKlC1Mr1eUtrXpLCO8jddY1iHOQxiak/G+NC1MIE
         ujkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gNA4C4UihjneUIjcFqX08gIYJikAuQ32UbK2Pru/1I=;
        b=t2TLXScJaJPNg4Q8rJC8A7NXGghVoJOfitOs4QWlY+G7WI5RTtvQnFPCUNOcIQ8Kmz
         l6gpep8XxrYmdjL3/IxEjeYEIV3kgx6xOYMwJqirBpXTUiicMTJKRap5pO/GL+DGayJf
         2GpQnVP0kEyTHCRRiuuiNLI4+2cQYWAHJgJL8Ayn76rYepjQj9xlNmIbsLmCvumwaYx8
         KjM68+YE1XOwjmplDR++ubyzrqGm7qBq7SHEjqyXr1zlUJ6LFWxKHJwn5Of4OE3oOKxL
         A0uUlBoWyZsqDU6c5f+QDRVm1luiQmVCYuWq8FxKKj9Zny0LDKPe1dLv9ixzCZSPUGXp
         /Y7w==
X-Gm-Message-State: AO0yUKXDZ+dc/A5mnPJp36VTZ6akey+uU1qf8pmsvzF0OD1Ta/h1mru5
        FFXZieMCcEZzkkKpHJpX5BQwpiy8TcgWNYhw8goZ
X-Google-Smtp-Source: AK7set8DpBR6h3vjqBWo+Zrt62eyBKF1nPb5+u0iZqS7mgjSxrSv1ddMq4XIo9cKGrMGhsBe38+jCvOh+DzpO2R2LHE=
X-Received: by 2002:a25:ace6:0:b0:84f:45b:b39c with SMTP id
 x38-20020a25ace6000000b0084f045bb39cmr652328ybd.49.1675378141857; Thu, 02 Feb
 2023 14:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20230202223653.never.473-kees@kernel.org>
In-Reply-To: <20230202223653.never.473-kees@kernel.org>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 2 Feb 2023 14:48:50 -0800
Message-ID: <CANDhNCpz+vCqXMDES+_cu8PuTi2c9jhcFqZ8TCVJimAOABjCrg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better reporting
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Thu, Feb 2, 2023 at 2:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> and actually report UBSAN traps with some specificity when building with
> CONFIG_UBSAN_TRAP. Before:
>
>   Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
>
> After:
>
>   Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP
>

This is really great ! When I brought up the opaque error messages
just a few hours ago, I didn't imagine you'd have a solution so
quickly!

I really appreciate your lightning fast effort here!

Really, thanks so much! I think this will have a big impact for folks
running into these new bug catchers.
-john
