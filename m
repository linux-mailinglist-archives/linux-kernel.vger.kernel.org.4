Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2426B0389
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCHJ6R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Mar 2023 04:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCHJ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:58:10 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A352B60E;
        Wed,  8 Mar 2023 01:58:08 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id bo10so10715152qvb.12;
        Wed, 08 Mar 2023 01:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678269487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tenmK7UqFMmxK8HdH+j4A3EbtAfm6VYOyD+pHnFrgGw=;
        b=C2qDpPU+Vl/eeWLForek4eBtIYqqb5wxtGBEa6RvfCEmDOBlI6oiwkCrC6QbCGhZOI
         MNr33fgm4jj+Lip7hV9rh9mzDSF2j2AkwOKyh1EeQJaW3ylO0BZmJSoTK6GT3OHE2PVB
         UbPsfWBycIAzVr8Lqz8qKP5cacFr/T7bm+h7pES2dtpxPNbBDST2W2Y2JbzNEtu37uw+
         KcFDVbZ/Y/R3UPEVLbCdql8jDQ1HkTHMyqlipVm2jub/Vcp7UUOJE9+2yXP6VvM8zEB1
         9pbNj37FLr25/55StJnDxMR3FpFd1hv+/xlFHFwAEj5M1jBXbX8ZhyTPxeYVeerT2vc3
         p+Tg==
X-Gm-Message-State: AO0yUKUnC0gZ5j8JAQsJTzpkdjsRR08e4Nyf3V4ZSe/27s3k8E9b9+M1
        MnPeuDYEF216u7mdA7TKKVISckKOniQLFmlt
X-Google-Smtp-Source: AK7set+TGop96qBsqSx1Q4OmBCm5tQPL5VhdTLY5Of8ET3UupU6a5HT7RJrSNDzREdPBage867lFwg==
X-Received: by 2002:a05:6214:21ee:b0:56e:af8a:a872 with SMTP id p14-20020a05621421ee00b0056eaf8aa872mr25798570qvj.11.1678269487250;
        Wed, 08 Mar 2023 01:58:07 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id i23-20020a05620a145700b00739e7e10b71sm10962007qkl.114.2023.03.08.01.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 01:58:06 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id 82so14042025ybn.6;
        Wed, 08 Mar 2023 01:58:06 -0800 (PST)
X-Received: by 2002:a5b:c4e:0:b0:9f2:a1ba:6908 with SMTP id
 d14-20020a5b0c4e000000b009f2a1ba6908mr8495733ybr.12.1678269486343; Wed, 08
 Mar 2023 01:58:06 -0800 (PST)
MIME-Version: 1.0
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com> <20230307105645.5285-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230307105645.5285-6-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Mar 2023 10:57:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXr=WGTEOnAhckPW4B1WUoRZUokkRjEZXjsU+Qr-y60iQ@mail.gmail.com>
Message-ID: <CAMuHMdXr=WGTEOnAhckPW4B1WUoRZUokkRjEZXjsU+Qr-y60iQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] soc: renesas: remove r8a77950 arch
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Tue, Mar 7, 2023 at 11:57 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> R-Car H3 ES1.* was only available to an internal development group and
> needed a lot of quirks and workarounds. These become a maintenance
> burden now, so our development group decided to remove upstream support
> and disable booting for this SoC. Public users only have ES2 onwards.
>
> Remove the architecture which describes H3 ES1.*.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> ---
>  arch/arm64/configs/defconfig      | 1 -
>  drivers/soc/renesas/Kconfig       | 7 -------
>  drivers/soc/renesas/renesas-soc.c | 2 +-

I will split this in two patches (defconfig and drivers/soc)...

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -330,7 +330,7 @@ static const struct of_device_id renesas_socs[] __initconst = {
>  #ifdef CONFIG_ARCH_R8A7794
>         { .compatible = "renesas,r8a7794",      .data = &soc_rcar_e2 },
>  #endif
> -#if defined(CONFIG_ARCH_R8A77950) || defined(CONFIG_ARCH_R8A77951)
> +#if defined(CONFIG_ARCH_R8A77951)
>         { .compatible = "renesas,r8a7795",      .data = &soc_rcar_h3 },

... and merge this with the section below ...

>  #endif
>  #ifdef CONFIG_ARCH_R8A77951

... while queuing in renesas-devel for v6.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
