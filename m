Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176F6E38A7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDPNcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:32:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88B11BD4;
        Sun, 16 Apr 2023 06:31:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dx24so13427171ejb.11;
        Sun, 16 Apr 2023 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681651918; x=1684243918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JdNGYn7ATErhvA1sUBmn8DjGAPLnDdtrFLVnGWMoc4=;
        b=CKDBa6gKS+JJAQOxB3ElN/nd9k2MKyzH1GLlWozxzcaJR2dJ3bKuGYKnmi1mMLGXCS
         FrZXfuBtPgf5E7G65C1gDgKxLCcfBeOBvPzgG9lH3V6BkNTT/PaUdJpY3v2kneykuk9s
         KaP56hDIiccMScOjuAlY3WlIQsCoYZmEx0gkgbl+PoQY5rNZIKMYHVvZUiaDGJzPsIU+
         fat7UlrKFKPmunxWauMHMHXNliZziRKEVDlPwRMKxaEuk+Zc+5HGhqslxzYm3cjTTCQe
         WwWQSWd5ngHpamlDBhVvdeksdtOuoaeluI+8CPsJ2xI1Kt4qLC/5fHUI9zJDhrdYb7dZ
         2KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681651918; x=1684243918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JdNGYn7ATErhvA1sUBmn8DjGAPLnDdtrFLVnGWMoc4=;
        b=SsWS+JR8tmqa+ZZtfdKIQR7ozMH/r7aRbxgAmiXq2yNvaHHY2wp3QyCgxPCwceundr
         8USFcKFdtMciJVwcigMcXcS2eRoB1kCqdUIyJY9wa/BbVtdvGh9qi74oev680KT9DMyW
         xQqeCh/8sf+WqPFSQhTlatQ8RfCT6Yca77b2wi79//Zuy0o4SSORnxMW/qfuKFbpZ3Qd
         994OCn93iapz+zX+E4IaTYkLeq3SSV2GPRfAvTPayeAh03s3WhekpL7+VT/4IY/v6pZZ
         MfzvBvCmLMv8V3+EI89I5q07jROEfFtPknHmvbBZuBuyGK2rDMrLz2jSuGjuYUlNSTjV
         W2cA==
X-Gm-Message-State: AAQBX9e85t2Q1H585yxFvfQ3WptDhNsMIql17SmpTOswqiw0QKNnFNuN
        LWDvTB76BXRHQZQQBNz679U=
X-Google-Smtp-Source: AKy350agXy7aE/aJS4jJ15TKpLErwEJZj78+qOwH9nVYLbGTOcJD/smUnMqrvq5muFXhioghT0nC7w==
X-Received: by 2002:a17:906:30c3:b0:94e:e1c7:31b4 with SMTP id b3-20020a17090630c300b0094ee1c731b4mr4474093ejb.48.1681651918086;
        Sun, 16 Apr 2023 06:31:58 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b0094f62a3197asm560513ejb.202.2023.04.16.06.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:31:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org, jonas@kwiboo.se, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: h3: beelink-x2: Disable DW-HDMI CEC
Date:   Sun, 16 Apr 2023 15:31:56 +0200
Message-ID: <2675247.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230416132531.GA28551@pendragon.ideasonboard.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
 <20230415104613.61224-4-jernej.skrabec@gmail.com>
 <20230416132531.GA28551@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 16. april 2023 ob 15:25:31 CEST je Laurent Pinchart napisal(a):
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Sat, Apr 15, 2023 at 12:46:13PM +0200, Jernej Skrabec wrote:
> > Beelink X2 uses software implementation of CEC even though DW-HDMI has
> > working hardware implementation.
> 
> Why ? The reason should be explained in the commit message.

Maybe I should reword this differently. It uses software implementation through 
GPIO pin. Dedicated DW-HDMI CEC pin is left unconnected.

Best regards,
Jernej 

> 
> > Disable unused DW-HDMI CEC.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts index
> > a6d38ecee141..38f40d69e5c5 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> > @@ -150,6 +150,7 @@ &emac {
> > 
> >  };
> >  
> >  &hdmi {
> > 
> > +	snps,disable-cec;
> > 
> >  	status = "okay";
> >  
> >  };




