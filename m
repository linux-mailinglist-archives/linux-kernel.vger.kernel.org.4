Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC37073C6F5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 07:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjFXFfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 01:35:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824021BF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:35:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so1514e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687584906; x=1690176906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=unxnCCJRCGrLNc6DK9W9SYp6CzMnpymgA+tJ26E5z4c=;
        b=zoPKyonEhRanEEwlo+h8+8Z8VRfqp1l6ONyly/Jeg40dr4nnrFRY0rCyCuX8t+B/6I
         OV/oMJ7VBNL1xEANXaDAm/XgPA7U/DCxttNq13cr3tIy78k9Dm1UmAtXUY0f+ib3OF1/
         zUw5knm1BQr3x5/PP+gFeYXjNTCapZhVJz33Sn6Ux+EbifEnlp9BclirjVvHertYZoSN
         PMU+M3ydOHl9qk4ZKQsmJ04nIrOWjZ1Aa8tU+/NdHMkpT9XBJChYmgWzR91z9YODjqEZ
         vxE+9cEeVlUgXxmD+iUcFBzwV80cyQs7/UJqyLRPBf4YN03MDRAkACIRIgAJbSOVjP8x
         L5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687584906; x=1690176906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unxnCCJRCGrLNc6DK9W9SYp6CzMnpymgA+tJ26E5z4c=;
        b=l3a2Sqh5cZHphUNKl/mSjJ2cwPDSDvWV/RgQKM6cyJ4ZTPpzpZpuEvnj7R0liJAtPS
         o840RON2DYQ0oZSbGrE/WDT3SwXYntud1fNyD6P2K8IsK/R6e+xazOrWkXPIscInQkXL
         1dQnazAoMsYVii8in8p15wSWgfRG6IdO00HohKUPfH6NLzROph6iNqGb10YhQa/+FiRe
         pKc/cDXWP/mvK01QAWIPpsbI4iOVsuJ+7nq4Gps/oG3NnH7M67BGuLYNvex+cKgejiXU
         Szaf4hDr+8I3NT1zkUot2Jg5YRuNdfyyz0qRrjqoN35XtsPV6RdNX8zT8cMgr5af7UHe
         YGyw==
X-Gm-Message-State: AC+VfDwSE6r48Dm1ajdY8dkKu7HSpYMFe1bb8zSNYnKeWC3tMuh1MG7z
        N9/NCii2nvCrDR2tDqAGairDyJOVkKrwyNh2d02YlQ==
X-Google-Smtp-Source: ACHHUZ4ojDUlNlceCFt6jQy142S4bZfLuwkTRRSpILzz1gubQeWsasHU6g2lTN35oFzz28Lu0C/XMPqy4fQcg/S4zIo=
X-Received: by 2002:ac2:43d5:0:b0:4f7:5f7d:2f9b with SMTP id
 u21-20020ac243d5000000b004f75f7d2f9bmr12852lfl.1.1687584905392; Fri, 23 Jun
 2023 22:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230623211457.102544-1-Julia.Lawall@inria.fr> <20230623211457.102544-18-Julia.Lawall@inria.fr>
In-Reply-To: <20230623211457.102544-18-Julia.Lawall@inria.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 24 Jun 2023 07:34:52 +0200
Message-ID: <CACT4Y+ayUeSpdmkec3pCna1kVSd1QTgBYLAb3zNJJ-7wcDHGdQ@mail.gmail.com>
Subject: Re: [PATCH 17/26] kcov: use array_size
To:     Julia.Lawall@inria.fr
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Fri, 23 Jun 2023 at 23:15, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Use array_size to protect against multiplication overflows.
>
> The changes were done using the following Coccinelle semantic patch:
>
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/kcov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 84c717337df0..631444760644 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -900,7 +900,7 @@ void kcov_remote_start(u64 handle)
>         /* Can only happen when in_task(). */
>         if (!area) {
>                 local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
> -               area = vmalloc(size * sizeof(unsigned long));
> +               area = vmalloc(array_size(size, sizeof(unsigned long)));
>                 if (!area) {
>                         kcov_put(kcov);
>                         return;
>
