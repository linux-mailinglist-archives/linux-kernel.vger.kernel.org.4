Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB56967AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjBNPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjBNPLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:11:22 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999CF29179;
        Tue, 14 Feb 2023 07:11:18 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-169ba826189so19395750fac.2;
        Tue, 14 Feb 2023 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxu3jE7N/iL6WfPhUjHcSLNPgEyoB+SMx0AFEuwGGXU=;
        b=J9NafX/cZyjbjrgBEEcVLnJioGheeJqhkQw1b4fZfmqV0Zu4V2vgQR5z4oVdLpyKor
         feTMPr2tORxJlBlYTC2UvQHs1oP9frQxllDMIZ9rStYonCPpi7TkL7wHdZKCkO/F9yTw
         KP8tu3WPSpg3MTPMgMVAwhtE8sHwPNwBqVOnC3hHP0MOGMow9ORUXAE64JZhD7Dj8RKf
         unHNEZvS2jUzsRsKA0LHgcJWJNU0qDP4KEPT7obgtVRrMfI+4KOZXjLtRG4UzmCaHpjT
         A+NYu09ZmQ7zOF17SxYoyfkGtVbxInedk7CF5dZPUlo7qNaj8wiX79dVgg+3GOpwPuLQ
         KERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxu3jE7N/iL6WfPhUjHcSLNPgEyoB+SMx0AFEuwGGXU=;
        b=3lu+3ZHTuPXOcQM677fXOvKEGq+cNjMBuOBLWCns7gAKW68SqTDz9NWweMc+G9IVn9
         Al2xbGZ6kln2XoZ79PurM3OKbsVwdiT8SVy9uFfo6i4ixPWwf7NCYkgxb32xw6W9Qypt
         EJySTptOiNgdKZ0R1fds68vAdJer4Ltfo26+j8Zapk0FPap1Y+BgZbuCvwZwkgpx7Lj1
         VKGSv7NuEDB1a0nuJcDxjHBRb1qDSzvi8IIlWPqLXOgUWfC78EcOHumnyFWKVtryz6W6
         j8TFRefpLSTMj35HQGlLCitrl3oAFv06q/z+xsATys+6pRdSHPXWuURj1juOSKi4U5Q1
         fs3A==
X-Gm-Message-State: AO0yUKUQ/lLYoapmBU8JvEC7L38mbM8iwu5u24awu7Hrf8vYgvT9tqpG
        zlMX/yLSkN2ze8GpPev3GiqB5yq7UCY=
X-Google-Smtp-Source: AK7set8R1sV9sIFX36pPUUMmZSybci3tPH5EWb/MJG/46Rnk2xPjyDnONvrR0Q+388YbwfX6iKe5pw==
X-Received: by 2002:a05:6870:ac2a:b0:163:595e:3655 with SMTP id kw42-20020a056870ac2a00b00163595e3655mr1184680oab.12.1676387477835;
        Tue, 14 Feb 2023 07:11:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1-20020a9d74c1000000b006864816ecd9sm6445597otl.59.2023.02.14.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:11:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 14 Feb 2023 07:11:16 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v7 3/5] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
Message-ID: <20230214151116.GC742354@roeck-us.net>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-4-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214103936.1061078-4-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:39:34AM +0100, Sergio Paracuellos wrote:
> To allow to access system controller registers from watchdog driver code
> add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
> operations in driver code.
> 
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index ac818fd721ae..3d16beb77440 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -73,6 +73,7 @@ sysc: syscon@0 {
>  		wdt: watchdog@100 {
>  			compatible = "mediatek,mt7621-wdt";
>  			reg = <0x100 0x100>;
> +			mediatek,sysctl = <&sysc>;
>  		};
>  
>  		gpio: gpio@600 {
> -- 
> 2.25.1
> 
