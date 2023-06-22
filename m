Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0573A0C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjFVMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFVMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:23:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F01D19A1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:23:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b8acefeso52992235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687436622; x=1690028622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZTvColTzRsoYYuXx98QVc9rgM+Sp5furEz7cmDxQqk=;
        b=FrdrBAh1oY9rhtVQjUyUaFAaGqRpbvPQjKnSFRgHkGPfttcKiwR+y/3oj436ntxKTD
         akF4OCyeqLPrY7j5rbRe2fiEkXmNPxKauFkmwgwqZeMjpiF5n5YJqff1Q6TZhOOVLufZ
         JepgQ/bIl1KkLeJWfzYlgsMk4BvnDZqp6fC1hLEVn4+8SKF94e+LSm3LhepY8fUQRc7q
         lGUC/S/Nj1OHp766ZJBxQxTdF5Nf/uRZ7jhrKyPyiVlH0u1Z3LWflIhvxkuZdqxJJYXe
         8qMkkWX2jB9wG1MEBKsvnOlSsV/eYQNUlxHECwjqMJiWC+/gTV4X0NyH70KlVJKfTDCG
         aepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687436622; x=1690028622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZTvColTzRsoYYuXx98QVc9rgM+Sp5furEz7cmDxQqk=;
        b=lg6rH+RrpmmexX5mMFfr0avcgqbSQwPJo6V0CITIkPSLN9viafBwQq2x/+rtHAxOoH
         p/BehrE4EAwzuBNRvHxG8i4sr2MuipsOC8aYJX0yZqR6hAhynom/fEl4GPqFlJc8UQOn
         0qb3ZUDKPgtzFgXDRl75HTgnIhND18gWwefoW26LunlC3gc8jDBkf1CMHuGwaaXfOW7T
         Ms6M0BrDjgFF6tXsLwHGnDi03PgrN0glnVwsOcqrxdLSUGVVupFpZaB8bddaChOvS+aB
         5nYMZoyyRcSPSpPcgKVQv9DH3oiwylbo75uVGsMiZBpJUZOCqsXgEZmdJicqRO/mwzlM
         VS/Q==
X-Gm-Message-State: AC+VfDy2wVdJV7U3BVsi1YsyFUu3x8j6g+BCsn/T77Kh4hmpK2SvxSl/
        w1fY69/SfJCANir4Y6V3gn9m8w==
X-Google-Smtp-Source: ACHHUZ49yPhRB3Bsa6UwNftE5A3qbasCqFJ2m3h6OWnmPw2gcLquyHRYJ35Gq1sHi5pE0z7HxWfdwg==
X-Received: by 2002:a1c:7209:0:b0:3f9:a10:10d0 with SMTP id n9-20020a1c7209000000b003f90a1010d0mr10666150wmc.17.1687436621924;
        Thu, 22 Jun 2023 05:23:41 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c25-20020a7bc859000000b003f90ab2fff9sm7600746wml.9.2023.06.22.05.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 05:23:41 -0700 (PDT)
Date:   Thu, 22 Jun 2023 14:23:39 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Message-ID: <20230622122339.6tkajdcenj5r3vdm@blmsp>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jun 21, 2023 at 03:00:39PM +0200, Krzysztof Kozlowski wrote:
> On 21/06/2023 14:31, Markus Schneider-Pargmann wrote:
> > Hi Krzysztof,
> > 
> > On Wed, Jun 21, 2023 at 12:28:34PM +0200, Krzysztof Kozlowski wrote:
> >> On 21/06/2023 11:31, Markus Schneider-Pargmann wrote:
> >>> tcan4552 and tcan4553 do not have wake or state pins, so they are
> >>> currently not compatible with the generic driver. The generic driver
> >>> uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
> >>> are not defined. These functions use register bits that are not
> >>> available in tcan4552/4553.
> >>>
> >>> This patch adds support by introducing version information to reflect if
> >>> the chip has wake and state pins. Also the version is now checked.
> >>>
> >>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> >>> ---
> >>>  drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
> >>>  1 file changed, 104 insertions(+), 24 deletions(-)
> >>>
> >>> diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> >>> index fb9375fa20ec..756acd122075 100644
> >>> --- a/drivers/net/can/m_can/tcan4x5x-core.c
> >>> +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> >>> @@ -7,6 +7,7 @@
> >>>  #define TCAN4X5X_EXT_CLK_DEF 40000000
> >>>  
> >>>  #define TCAN4X5X_DEV_ID1 0x00
> >>> +#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
> >>>  #define TCAN4X5X_DEV_ID2 0x04
> >>>  #define TCAN4X5X_REV 0x08
> >>>  #define TCAN4X5X_STATUS 0x0C
> >>> @@ -103,6 +104,13 @@
> >>>  #define TCAN4X5X_WD_3_S_TIMER BIT(29)
> >>>  #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
> >>>  
> >>> +struct tcan4x5x_version_info {
> >>> +	u32 id2_register;
> >>> +
> >>> +	bool has_wake_pin;
> >>> +	bool has_state_pin;
> >>> +};
> >>> +
> >>>  static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
> >>>  {
> >>>  	return container_of(cdev, struct tcan4x5x_priv, cdev);
> >>> @@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
> >>>  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> >>>  }
> >>>  
> >>> -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
> >>> +static const struct tcan4x5x_version_info tcan4x5x_generic;
> >>> +static const struct of_device_id tcan4x5x_of_match[];
> >>> +
> >>> +static const struct tcan4x5x_version_info
> >>> +*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
> >>> +{
> >>> +	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
> >>> +		const struct tcan4x5x_version_info *vinfo =
> >>> +			tcan4x5x_of_match[i].data;
> >>> +		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
> >>> +			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
> >>> +				 tcan4x5x_of_match[i].compatible);
> >>> +			return vinfo;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return &tcan4x5x_generic;
> >>
> >> I don't understand what do you want to achieve here. Kernel job is not
> >> to validate DTB, so if DTB says you have 4552, there is no need to
> >> double check. On the other hand, you have Id register so entire idea of
> >> custom compatibles can be dropped and instead you should detect the
> >> variant based on the ID.
> > 
> > I can read the ID register but tcan4552 and 4553 do not have two
> > devicetree properties that tcan4550 has, namely state and wake gpios.
> 
> Does not matter, you don't use OF matching to then differentiate
> handling of GPIOs to then read the register. You first read registers,
> so everything is auto-detectable.
> 
> > See v1 discussion about that [1].
> 
> Yeah, but your code is different, although maybe we just misunderstood
> each other. You wrote that you cannot use the GPIOs, so I assumed you
> need to know the variant before using the GPIOs. Then you need
> compatibles. It's not the case here. You can read the variant and based
> on this skip entirely GPIOs as they are entirely missing.

The version information is always readable for that chip, regardless of
state and wake GPIOs as far as I know. So yes it is possible to setup
the GPIOs based on the content of the ID register.

I personally would prefer separate compatibles. The binding
documentation needs to address that wake and state GPIOs are not
available for tcan4552/4553. I think having compatibles that are for
these chips would make sense then. However this is my opinion, you are
the maintainer.

Best,
Markus

> 
> > 
> > In v1 Marc pointed out that mcp251xfd is using an autodetection and warn
> > mechanism which I implemented here as well. [2]
> 
> But why? Just read the ID and detect the variant based on this. Your DT
> still can have separate compatibles followed by fallback, that's not a
> problem.
> 
> 
> Best regards,
> Krzysztof
> 
