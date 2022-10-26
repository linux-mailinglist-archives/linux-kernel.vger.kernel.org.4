Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E674060EA22
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiJZURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiJZURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:17:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB35412790E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:17:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w29so3769143qtv.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwFPxGxPfVVpNpjuRcsPri9IbxTzSGaVNATnsuh89zE=;
        b=E/BwIPo6nQhc+q+igGJ2p3j48Siqll4xzQwvYXktwnme/8uNEuKpx0qEP6YsvVIDTF
         lcR76/wync2XxNHLTQQ67yEJ3Lizgtfv9ud3YsQuTvOlaCnPJt78eNM9laZYlniNgM5f
         xJhoJzaQ4lQoZkQdOXr38Lag4775HXVLOydkopV4r67/pt4MzU+kbbe6IbG05rTgAG5T
         1jaO6M0fIoppLroyQtei94jBHl/L+QCY9GLdLT92e8Ulnoh3FIP6bEmm+GKiUB90aOum
         nhXsl79usbGTPYYKu3Mg/x1Y7iJG7yGLX+CL7JlHMBAsM3C6nlg296MlJvYRbgcY4mIV
         0bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwFPxGxPfVVpNpjuRcsPri9IbxTzSGaVNATnsuh89zE=;
        b=sXA3dEmBIMoYVdnBbi+JM0FKT+wpe23+/aX+wl/lLaRZEmMxjp1q7btDtvS10kNm/G
         YSblmUA7X2448EG3tVaw6D0NKj1VLn4KwEx/hx6iBvpJ7490D63Lc5WxYqJDrzLJ42p5
         NK+D+goGx9x0+o/FLg0As1ONp9Lk0B2u42adyCYwFF9qWLBOQz4hPOLJMwnInwbzyLR9
         xgmNAgTwLJlDnuKslyGIf+W9ZHIL7am1XXKbaL27mAm6Oehyiel3vlafT5ly+XCgkbL0
         9sSo/AMnCJtOykyIjNHKMNvuQZEa6EnHpoBLhREPzM3V0AUK6FToYW4Cr6zZq0RZOiDy
         7rmA==
X-Gm-Message-State: ACrzQf1RKTubLAmUp7C1DqzbkrHUNWCKglGj15wgHpJwTlO6eNNBhQLS
        hHsgTh6I/oaGcUMvYtM2XDnD/Q==
X-Google-Smtp-Source: AMsMyM5pMxY4O29rvMBzRYtt7Ly8gGBDt0f6mfdm0pumler1SteY6CKQSiRMCMXiBqKnnjnMREfSgw==
X-Received: by 2002:a05:622a:cf:b0:39c:f2a5:7374 with SMTP id p15-20020a05622a00cf00b0039cf2a57374mr37262969qtw.600.1666815462933;
        Wed, 26 Oct 2022 13:17:42 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id m8-20020a05620a290800b006ce40fbb8f6sm4603413qkp.21.2022.10.26.13.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 13:17:42 -0700 (PDT)
Message-ID: <9314a458-0fd9-c645-bb55-5f28b961ea5f@linaro.org>
Date:   Wed, 26 Oct 2022 16:17:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] ARM: nspire: Use syscon-reboot to handle restart
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221026161302.5319-1-afd@ti.com>
 <20221026161302.5319-2-afd@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026161302.5319-2-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 12:13, Andrew Davis wrote:
> Writing this bit can be handled by the syscon-reboot driver. Add the
> info to DT and remove the machine_desc version.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/nspire.dtsi |  7 +++++++

DTS cannot go with code.

Additionally, this breaks people's filtering as there is no "dts" prefix
in the subject.

>  arch/arm/mach-nspire/Kconfig  |  2 ++
>  arch/arm/mach-nspire/mmio.h   |  3 ---
>  arch/arm/mach-nspire/nspire.c | 10 ----------
>  4 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
> index bb240e6a3a6f..6357b803521e 100644
> --- a/arch/arm/boot/dts/nspire.dtsi
> +++ b/arch/arm/boot/dts/nspire.dtsi
> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>  			};
>  
>  			misc: misc@900a0000 {
> +				compatible = "syscon", "simple-mfd";

These are not allowed on their own (need specific compatible) and you
should have warnings when running dtbs_check.

Best regards,
Krzysztof

