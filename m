Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57C7158DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjE3Il3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjE3IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:41:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED7CE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:41:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f61530506aso43933705e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685436064; x=1688028064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFTo/TdSXcdAD7s8nzeXWfL6YJOnEyi31YyJRsIFKlo=;
        b=r2xfxhW64Ll1CyRP6MfeCDcNIMIXdddwYAdtbH2OfwHbGOT/lhZ2wfgID9hiZzX5Bf
         1M6AWKQQYlcxw6tXQCcPHCQfXaxqVg6MeY95/haHQNIWlmq9+tXPKBEDNjrGQnmqgfth
         0We9/MTHj5qdu/k23xJc479aNo8IPg236+nSTTpRs05OTT0lhZjLk9VLPIa6QVkh6WrX
         RFi4pnTu165MjX+TTTmfXvIBxyv6X2SjlKqhabUKjfpTOeLyEhGfbiP+lVeP1m5VHWNe
         wYJkRR1IObAbs2MEgwavEgx6XisSrUVQngxHEeisCPkjJosN0ukNs0GZJMCoR7GKBXN8
         F7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436064; x=1688028064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFTo/TdSXcdAD7s8nzeXWfL6YJOnEyi31YyJRsIFKlo=;
        b=Gsw2KR7sS0Fcpaa4muO7sg6p6CytxeW0zQgvvf02KLkKDLacD3yWGxSsesZFZWH9li
         tp0H4GLyNT3AwUII+VvAqpvte7sixUG7LAU9rYYlFK/7Np/DW31eWw0dIRnB0uV3AbWz
         EvZ/uxOgkB6u16GbJgY2ijUJ89wY8NxSOPY8MMFPNsx+inqGM8X6WT9FYDrIKsP9YEWj
         iLkOKzai1nXtFMv1jkasdMx5dZU5uIMTdmYvVHycKLOTfCci/MO04kfcBG0V53kZPWRU
         LAFQkpCflxi2XGk9Qk7Eb2dVEEuB0W5xHDDvLR3IEYOMS4ieUhPc4FAqwh2nU4Q1jITj
         ozRw==
X-Gm-Message-State: AC+VfDyF85cHeXMFVMdYTxGCLVT+MXM7rXISV/ln4q+4fGFiGxRJ8oZJ
        hxSTMm1WHKDBD4oNVO2LRH6Txzl3KYhlCY1OzJuD7w==
X-Google-Smtp-Source: ACHHUZ4vG/LQni91NCpNrlukURcnew0lSoO3a8mNyD3bA1VPBxEGe7E3dqh7TspLDpK5fYqFe6thArjxwoR5aHTbHFw=
X-Received: by 2002:a1c:7712:0:b0:3f6:44e:9d8 with SMTP id t18-20020a1c7712000000b003f6044e09d8mr1087598wmi.22.1685436063826;
 Tue, 30 May 2023 01:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230530083911.1104336-1-glider@google.com>
In-Reply-To: <20230530083911.1104336-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 May 2023 10:40:26 +0200
Message-ID: <CAG_fn=U67cq4502h2G8kms8r6e=13tn8Ta+QWhA8N6cK-PFyaA@mail.gmail.com>
Subject: Re: [PATCH v2] string: use __builtin_memcpy() in strlcpy/strlcat
To:     glider@google.com, andy@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        ndesaulniers@google.com, nathan@kernel.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 30, 2023 at 10:39=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> lib/string.c is built with -ffreestanding, which prevents the compiler
> from replacing certain functions with calls to their library versions.
>
> On the other hand, this also prevents Clang and GCC from instrumenting
> calls to memcpy() when building with KASAN, KCSAN or KMSAN:
>  - KASAN normally replaces memcpy() with __asan_memcpy() with the
>    additional cc-param,asan-kernel-mem-intrinsic-prefix=3D1;
>  - KCSAN and KMSAN replace memcpy() with __tsan_memcpy() and
>    __msan_memcpy() by default.
>
> To let the tools catch memory accesses from strlcpy/strlcat, replace
> the calls to memcpy() with __builtin_memcpy(), which KASAN, KCSAN and
> KMSAN are able to replace even in -ffreestanding mode.
>
> This preserves the behavior in normal builds (__builtin_memcpy() ends up
> being replaced with memcpy()), and does not introduce new instrumentation
> in unwanted places, as strlcpy/strlcat are already instrumented.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Link: https://lore.kernel.org/all/20230224085942.1791837-1-elver@google.c=
om/

Sorry, missed a "Reviewed-by: Marco Elver <elver@google.com>" from the
previous thread:
https://lore.kernel.org/lkml/CAG_fn=3DUzQ-jnQrxzvLE6EV37zSVCOGPmsVTxyfp1wXz=
Bir4vAg@mail.gmail.com/T/


> Acked-by: Kees Cook <keescook@chromium.org>
