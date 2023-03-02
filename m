Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D476A80ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCBLTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBLTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:19:37 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED781206E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:19:35 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id bx14so5910700uab.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UpoYsX/wcX1BKUpmOF97rT/5TG0r4tQZUsDLiVIcjh4=;
        b=LwDWn5Nt2IAkaWo9dUqFcLRfElg1ai2BCo3iFdJM2sQzjBPx5HoxsBdhTxg5hf3+Px
         j+97E+e944Mu+PJyA3RQ6Q/4HGim2Y+YeK3eHnvDVk4Hgkt8RME7t9LIg28bhB7jnSPF
         gHIcw59Hshb2Iv2LyESKJ7ecGjqVx+ExSRlr3uSiF1y2nJcjk/Om9YU8yJX/bRMxpga2
         lI8FBBSMt67hGup0AJFqcFoQKSO6FXZQhxDCvPqKjhx8sthvfzYQAcUiZK2AO9Mr5mjR
         dJclpeSLZSi5JnWEFzROHXVSECWixlvpFJaOq8iAJ372Tx3MB4nTaHaxD/dI2KIiMGoU
         NDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpoYsX/wcX1BKUpmOF97rT/5TG0r4tQZUsDLiVIcjh4=;
        b=e1DlTUwF4EHy8rMO+24MqWKOT8JzQKROZbThUNmgM/8Ga8cQG8/WW/rODj1QlqLJ+J
         8fcsQJQbJWXLJHZ8HpGIk6nKfPc4+OyPAWh7b8SzWyNwf1njJabBDTAUXB1ulsJbhosJ
         nUlPJqiygAMjEOAbd6PkkSNDHhlVA5M5SltvLISm/2BHpvDN9+/gsKUsCWLy23IrtxXy
         xPxf6RnVQXUWech6u1CWHRP9xvvk5DGTXA/C4ld2m4xBhf2nX9tUeT+b9CNM56VECER8
         IJ5BpZZVBRlXAJoGPGBFIpEvIBjY7U06N2Ei6Hoh0r7DBYAuaTtqyfKWp5i0Kp34PY4R
         6CGg==
X-Gm-Message-State: AO0yUKXBClcJLQcceTT/roQq0MXW6qlfO9+XvHSgjjSV0MpiTMvLNFc3
        AiPwp+3O2UNThx9yid/i4GUQHnQel2BadmAXrCqyeA==
X-Google-Smtp-Source: AK7set8pAGt3Pxj8EsVzgstq7VhTF8idjtE4IBSBO5saiDwLhWLaq6tv1oezXFrOWflpsWeWrNLIhpFj41mJrk5HIVA=
X-Received: by 2002:a05:6122:e0f:b0:406:8403:4e64 with SMTP id
 bk15-20020a0561220e0f00b0040684034e64mr5028140vkb.2.1677755975009; Thu, 02
 Mar 2023 03:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <20230301143933.2374658-3-glider@google.com>
In-Reply-To: <20230301143933.2374658-3-glider@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 2 Mar 2023 12:18:59 +0100
Message-ID: <CANpmjNMd6YA1FGaE2ePsHU4OvTz=-2yXxCOwPDyDpCFTD5ns2Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86: kmsan: use C versions of memset16/memset32/memset64
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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

On Wed, 1 Mar 2023 at 15:39, 'Alexander Potapenko' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> KMSAN must see as many memory accesses as possible to prevent false
> positive reports. Fall back to versions of
> memset16()/memset32()/memset64() implemented in lib/string.c instead of
> those written in assembly.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  arch/x86/include/asm/string_64.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> index 9be401d971a99..e9c736f4686f5 100644
> --- a/arch/x86/include/asm/string_64.h
> +++ b/arch/x86/include/asm/string_64.h
> @@ -22,6 +22,11 @@ extern void *__memcpy(void *to, const void *from, size_t len);
>  void *memset(void *s, int c, size_t n);
>  void *__memset(void *s, int c, size_t n);
>
> +/*
> + * KMSAN needs to instrument as much code as possible. Use C versions of
> + * memsetXX() from lib/string.c under KMSAN.
> + */
> +#if !defined(CONFIG_KMSAN)
>  #define __HAVE_ARCH_MEMSET16
>  static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
>  {
> @@ -57,6 +62,7 @@ static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
>                      : "memory");
>         return s;
>  }
> +#endif
>
>  #define __HAVE_ARCH_MEMMOVE
>  void *memmove(void *dest, const void *src, size_t count);
> --
> 2.39.2.722.g9855ee24e9-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230301143933.2374658-3-glider%40google.com.
