Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85F568871B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjBBSvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBBSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:51:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261940DF;
        Thu,  2 Feb 2023 10:51:44 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so2100264pjp.0;
        Thu, 02 Feb 2023 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bhsb2fuNBYHSupvvVBEu0/2p/VPgtQRHARS0fdgrQw=;
        b=fl54cRpow83IgMccmr8VLx+5n6ALA6aKE7LvaqSpcL0YwJW0bFklnlB8hQXu4VcTVW
         gItWqrnMYNO9QNdUxMVUI9EoAZl8tr2NveBRgvf1gserVwkApBhu/ayywcdjYpxZjmDO
         eZf+eHZqzLO8do22o3NrXU6v1b5PyZ/cRs67oe9g7uE5GG8Rffuydw/rAUj02Wb/KGP8
         LyPt47y9yJJo1CgIrwXb0JCh+A2tAfXvVZoEsydT7QlQBQWzUJ01tsKMi9vrhxFWm6vj
         LqPt7IVfX7KGWOUL6HE/SbP3ZepXr/sbBWF2NPAbAFWZ5hrZznIFjCjL1GyGtDcS3W70
         NE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bhsb2fuNBYHSupvvVBEu0/2p/VPgtQRHARS0fdgrQw=;
        b=PvMCytJgB2K3/Z3t13s3J1WgtJoycfKmabseU1YAU6s4Y/LLvMVgZL88XwGC/dwR8g
         fw42W3U6OvR75j6mXn8EWxlBzDtSyr00Rdmx1bDtGT7+stKEnzVs8JhrfVjQnkqY4HSh
         Seuf+kcaHtIvPKaxznByRSnyXPb2g20QYCX/3hBetyKhOvI2PZxT7m5XHAwOlhXMcTQt
         h5rZpswhO+MJhkMdnoEs7U9jKKSWd8zonZW6YPc0IX06gQPO7DtecU39AkSww1jd9pRX
         r3uL3dLn5c+nIDDXEph/ySet5A4c5e/XyZyer6/IFP7Tbc3byawaskrmZ3buKnmY+9yX
         4uiQ==
X-Gm-Message-State: AO0yUKUnWKS53BrchkVYq9n+Zk3RSVm3XKiP7KoTP01VnvFyKo5be8KQ
        DoWpCyPUeHB0Wvy6S9OmHjXrSlraLY4=
X-Google-Smtp-Source: AK7set/wqo5Bc3GMCe1/MUkp7nQGbr3XI+EomgafXQ2z1Flem72j6vha4fXv9v355t8kF+fn2LG8bQ==
X-Received: by 2002:a17:90b:3a86:b0:22c:9782:e718 with SMTP id om6-20020a17090b3a8600b0022c9782e718mr7623682pjb.0.1675363903802;
        Thu, 02 Feb 2023 10:51:43 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6b75:4990:9ed8:d8dc])
        by smtp.gmail.com with ESMTPSA id fw2-20020a17090b128200b0022c01ab2899sm176362pjb.49.2023.02.02.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:51:43 -0800 (PST)
Date:   Thu, 2 Feb 2023 10:51:39 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: stihxxx-b2120: fix polarity of reset line
 of tsin0 port
Message-ID: <Y9wGO0Q//TIKwTTE@google.com>
References: <YzcSqZdpNbdINp4Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzcSqZdpNbdINp4Q@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 09:00:41AM -0700, Dmitry Torokhov wrote:
> According to c8sectpfe driver code we first drive reset line low and
> then high to reset the port, therefore the reset line is supposed to
> be annotated as "active low". This will be important when we convert
> the driver to gpiod API.
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Gentle ping on this one...

> 
> v2: fixed typo in the subject, added Patrice's reviewed-by
> 
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 2aa94605d3d4..d52a7aaa1074 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -178,7 +178,7 @@ tsin0: port {
>  				tsin-num = <0>;
>  				serial-not-parallel;
>  				i2c-bus = <&ssc2>;
> -				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
> +				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
>  				dvb-card = <STV0367_TDA18212_NIMA_1>;
>  			};
>  		};
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
> 
> -- 
> Dmitry

-- 
Dmitry
