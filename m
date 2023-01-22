Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67667709F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjAVQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:33:33 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7DFF04
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:33:32 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id i12so7472617qvs.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vOk3uYZcgTwBo+UdwPSOR5TRv4+Ddg6DJyCWwBKpSKA=;
        b=QUorDSvmE+f0BgWAkK9VppJux0lAOyFf1GRqtSXEx+Uw8wPsl33B9JEgPWhvQE9sVK
         f4UJBN0T9eE9nw+uGAqwd7tsng4j1RMXUWUGAXsxRXdg++acIEzszyTn8N3pRSydT8rv
         0BNE/edflTmXFZqyck4352C3+i+LXNLpVc+bFLK7KT9teflUszEHZeO2+odbEq0qOePZ
         1qF108qqyjAX9D9huBKsX0mmMmK94GEqehRW8TTEs6xbd7XwNPRUhI5NlEybuLP/Jq9f
         6Od7unTPF/UQjfhddliunzBO0gxT4YDXfmB30vAdeSb+LGgGiL8e0SxIiZvT7Xgdi6XA
         fBLA==
X-Gm-Message-State: AFqh2kqPUaV9gf52VVFkcU6JVwn29kR3qy/yNIboopZFkzrcZJjohOvP
        aKg/5U9XrLv45jGUpYYMBGdAL6NPGmPTgQ==
X-Google-Smtp-Source: AMrXdXu85fV31t7t7xoIE2VXELYruKwUSYSd0PL5YnQMWlnSTP5xvc55BzrCsqXTKcSuHYcJDGD6xA==
X-Received: by 2002:a0c:9127:0:b0:535:3000:41ad with SMTP id q36-20020a0c9127000000b00535300041admr28325230qvq.4.1674405211406;
        Sun, 22 Jan 2023 08:33:31 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a268500b006e8f8ca8287sm25369677qkp.120.2023.01.22.08.33.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 08:33:30 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 129so8173705ybb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 08:33:30 -0800 (PST)
X-Received: by 2002:a25:d505:0:b0:7bf:d201:60cb with SMTP id
 r5-20020a25d505000000b007bfd20160cbmr1777981ybe.365.1674405210694; Sun, 22
 Jan 2023 08:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20220718105553.6529-1-gaoxin@cdjrlc.com>
In-Reply-To: <20220718105553.6529-1-gaoxin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 22 Jan 2023 17:33:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtD29w1Utw0VvAC1SrE47x-o+bOcp6=fOGsfWLQHBsUQ@mail.gmail.com>
Message-ID: <CAMuHMdWtD29w1Utw0VvAC1SrE47x-o+bOcp6=fOGsfWLQHBsUQ@mail.gmail.com>
Subject: Re: [PATCH] m68k:do not initialise statics to 0.
To:     gaoxin@cdjrlc.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Mon, Jul 18, 2022 at 12:56 PM Xin Gao <gaoxin@cdjrlc.com> wrote:
> Delete static variables initialized to 0.
>
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/q40/q40ints.c
> +++ b/arch/m68k/q40/q40ints.c
> @@ -201,8 +201,8 @@ static int ccleirq=60;    /* ISA dev IRQs*/
>  #define DEBUG_Q40INT
>  /*#define IP_USE_DISABLE *//* would be nice, but crashes ???? */
>
> -static int mext_disabled=0;  /* ext irq disabled by master chip? */
> -static int aliased_irq=0;  /* how many times inside handler ?*/
> +static int mext_disabled;  /* ext irq disabled by master chip? */
> +static int aliased_irq;  /* how many times inside handler ?*/
>
>
>  /* got interrupt, dispatch to ISA or keyboard/timer IRQs */

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.3 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
