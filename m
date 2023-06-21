Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4589E7383DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjFUMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjFUMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:32:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CF219A6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:32:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9c532fa45so3977045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687350720; x=1689942720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzmtLOP7oc0tzQzkG240IPHIjmF5+AVL1tQJX0AniZE=;
        b=t0MfzdapmYbvx4BeFguQWa3HWQjpRz+5fQYExp1X3ihFsm+dRN6suYDI00ZJ4rB8qn
         X/iYsYk9AMmd36uyii2GYuUks47TPm3k3mAX6GbfUjGV840CvGvNOe1/0IiLBe3Eb5fO
         kA7nArvXSjMpdkGwYUdekfSymBqHatorZ8gO8oq23K9Ihjm0ZoWtGESJNuNPydCOmTat
         mGOfUKLUrKpmyRmI/IZW9noSw6waJUsxg/fxB9OEmm97NIdXNolw8S7NjKyZow8guHls
         Bko5Nq9aJn9OZiqcJHZUFDroBcZxe0/08Byti6/wpsCc6buTfpKYBh5LyEIksIFHjC50
         Uluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350720; x=1689942720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzmtLOP7oc0tzQzkG240IPHIjmF5+AVL1tQJX0AniZE=;
        b=iRIOj/vhqT0g/4Y8GSQhTy6DjbCQZ9j8jC3L1EDih8EzTSNvEpt3TdhJIux8mNPgt8
         eDV6X6mZcJ+uLFVn7Ug5BIfw84vrv++jswkTGYdbaaapD4xmrG09Hmfg+Cbz8a9+VGsx
         nZealsKfc2U01B1aOErFhJUj0irnaO+/zeZ5GUUzDc+NR5cLHUKMe7+Y3mN6IRYNy48r
         19MBoixQedZ6bKaRbe2iHSWKMvFIXQGM1bCdv2FQglFl2v2MrLdG2onA+BHU1yv9VOlV
         o8LjJ+Nfxgg1sGWSJqSXQstdbPZrL9QKERa628xsh/0atSsi3EvVTmYVACursAbFNH2z
         tqgg==
X-Gm-Message-State: AC+VfDy/gVHjBywuXB8sqJLza+LP9iRuOG1L9XrNnulVKS1vgY97Opfw
        Ukhh9VN1e6yjyYjclUDuaInKXh244Pu/wPMnlythTg==
X-Google-Smtp-Source: ACHHUZ4Vt/DXBCbpC79d+F7Gxz4ssIFP+pZFUveEp3RHBDcx3TTeI+y2mnOP8Y9byDYF7iDjiKlBvg==
X-Received: by 2002:a05:600c:3799:b0:3f9:b540:862d with SMTP id o25-20020a05600c379900b003f9b540862dmr4300764wmr.28.1687350720552;
        Wed, 21 Jun 2023 05:32:00 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id j2-20020adfe502000000b002ca864b807csm4518345wrm.0.2023.06.21.05.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:32:00 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:31:58 +0200
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
Message-ID: <20230621123158.fd3pd6i7aefawobf@blmsp>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jun 21, 2023 at 12:28:34PM +0200, Krzysztof Kozlowski wrote:
> On 21/06/2023 11:31, Markus Schneider-Pargmann wrote:
> > tcan4552 and tcan4553 do not have wake or state pins, so they are
> > currently not compatible with the generic driver. The generic driver
> > uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
> > are not defined. These functions use register bits that are not
> > available in tcan4552/4553.
> > 
> > This patch adds support by introducing version information to reflect if
> > the chip has wake and state pins. Also the version is now checked.
> > 
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
> >  1 file changed, 104 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
> > index fb9375fa20ec..756acd122075 100644
> > --- a/drivers/net/can/m_can/tcan4x5x-core.c
> > +++ b/drivers/net/can/m_can/tcan4x5x-core.c
> > @@ -7,6 +7,7 @@
> >  #define TCAN4X5X_EXT_CLK_DEF 40000000
> >  
> >  #define TCAN4X5X_DEV_ID1 0x00
> > +#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
> >  #define TCAN4X5X_DEV_ID2 0x04
> >  #define TCAN4X5X_REV 0x08
> >  #define TCAN4X5X_STATUS 0x0C
> > @@ -103,6 +104,13 @@
> >  #define TCAN4X5X_WD_3_S_TIMER BIT(29)
> >  #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
> >  
> > +struct tcan4x5x_version_info {
> > +	u32 id2_register;
> > +
> > +	bool has_wake_pin;
> > +	bool has_state_pin;
> > +};
> > +
> >  static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
> >  {
> >  	return container_of(cdev, struct tcan4x5x_priv, cdev);
> > @@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
> >  				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
> >  }
> >  
> > -static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
> > +static const struct tcan4x5x_version_info tcan4x5x_generic;
> > +static const struct of_device_id tcan4x5x_of_match[];
> > +
> > +static const struct tcan4x5x_version_info
> > +*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
> > +{
> > +	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
> > +		const struct tcan4x5x_version_info *vinfo =
> > +			tcan4x5x_of_match[i].data;
> > +		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
> > +			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
> > +				 tcan4x5x_of_match[i].compatible);
> > +			return vinfo;
> > +		}
> > +	}
> > +
> > +	return &tcan4x5x_generic;
> 
> I don't understand what do you want to achieve here. Kernel job is not
> to validate DTB, so if DTB says you have 4552, there is no need to
> double check. On the other hand, you have Id register so entire idea of
> custom compatibles can be dropped and instead you should detect the
> variant based on the ID.

I can read the ID register but tcan4552 and 4553 do not have two
devicetree properties that tcan4550 has, namely state and wake gpios.
See v1 discussion about that [1].

In v1 Marc pointed out that mcp251xfd is using an autodetection and warn
mechanism which I implemented here as well. [2]

Best,
Markus


[1] https://lore.kernel.org/lkml/5f9fe7fb-9483-7dee-82c8-bd6564abcaab@linaro.org/
[2] https://lore.kernel.org/lkml/20230315112905.qutggrdnpsttbase@pengutronix.de/
