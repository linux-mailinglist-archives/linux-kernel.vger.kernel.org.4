Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB05702E64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242116AbjEONhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbjEONhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:37:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C41BC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:37:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-306dbad5182so8388798f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684157819; x=1686749819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siTWifPxX1aManif72YDrV0r+hmOKzstfDGYR/mGvqU=;
        b=rLHZSu5M7RzoKDhFsx1ys87yhSCrDbWTxAgMMuBUgps5wawJ0qQvajd4EV/blhJUvk
         mf5SlkcbLuA8LQevhATGAuZ6wjKw0sknNT/LGwNU5+EfeNKDoO8I3NjrWVIy5NChlcuS
         9Lbiuf195fFKr6LR39RnmNs01s5xd/KUVGZRE+n9trEW2NK2OXJLc8KoU7wDZGa/G9Pb
         psPo42k4wG7g5mczy7duZj9mXmPUeOu5pmaTEENyjhV176o+wMZ/TH9J18i8HfN+rxZp
         Dw1w6WJ9FPpJIGhAiNvGnIB0JqtPz4Ue8rpbx4/nqbRZUXbxK29X0s5Ea9XMNHS67GoL
         bPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157819; x=1686749819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siTWifPxX1aManif72YDrV0r+hmOKzstfDGYR/mGvqU=;
        b=eoDq/5AjtllbYT9egUPqgpDxYCAcVl6kO7I+vBe+IqJ9t7kWmgWsESxobDhVgeXRrB
         enYPiVaXqXo3D46sWRP7nEt9jLndPhcEWqXDEpMi2btnacRqUGsSYAVj3Y0YrfQfVzLv
         w0w7SUedu+X09r6toivTPRyob9NwQfPNSGjHhVkDVMoBWtxarIQnbj8ylLYKmpqw4wh1
         XyRPno4UjE8GvrEWbCaEqI/p0Vd2wK70IdSSljNPDA1PxfwcGSmfPi7zjw4zNtwm18eF
         hgFJ259J1diIu+dq0phcCXRAoQ/FcZhY9voJO9L5TFvdrrpmm60PH8P6zTzu5pKNu+Xb
         zPEA==
X-Gm-Message-State: AC+VfDyhc23cRzmYMG8Q32MDskC4E6K4BHAG1Qy5A4J8QoE+lJZRYO1D
        4YZr030eUap7caP7Q7RVhbz6FQ==
X-Google-Smtp-Source: ACHHUZ4Rdql4HTts8WmrVYcQw4kCaOVth/28CmVLcDZlzwc9HN6Pxehp2ST/CdMixqBydRN1GYH6FQ==
X-Received: by 2002:a5d:4b91:0:b0:306:2a1a:d265 with SMTP id b17-20020a5d4b91000000b003062a1ad265mr23135895wrt.58.1684157818781;
        Mon, 15 May 2023 06:36:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600018c300b002fe96f0b3acsm32786586wrq.63.2023.05.15.06.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:36:58 -0700 (PDT)
Date:   Mon, 15 May 2023 15:36:57 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Message-ID: <ynrvqt24hjgng25r2xa3hxj35cvgotx7sdfrbqfjcvj3foegmr@4lqhen5yu6fh>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-3-jstephan@baylibre.com>
 <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:22:52PM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/05/23 11:05, Julien Stephan ha scritto:
 ..snip..
> > +	port->is_cdphy = of_property_read_bool(dev->of_node, "mediatek,is_cdphy");
>
> This driver doesn't support C-PHY mode, so you either add support for that, or in
> my opinion you should simply refuse to probe it, as it is *dysfunctional* for the
> unsupported case (and might even introduce unstabilities).
>
> 	/* At the moment, only D-PHY mode is supported */
> 	if (!port->is_cdphy)
> 		return -EINVAL;
>
> Also, please don't use underscores for devicetree properties: "mediatek,is-cdphy"
> is fine.
>
Hi Angelo,
You are right this driver does not support C-PHY mode, but some of the
PHYs themselves support BOTH C-PHY AND D-PHY. The idea of `is_cdphy` variable
is to know if the CSI port supports BOTH C-PHY AND D-PHY or only DPHY.
For example mt8365 has 2 PHYs: CSI0 and CSI1. CSI1 support only D-PHY,
while CSI0 can be configured in C-PHY or D-PHY. Registers for CD-PHY and
D-PHY are almost identical, except that CD-PHY compatible has some extra
bitfields to configure properly the mode and the lanes (because supporting
trios for CD-PHY).
If C-PHY support is eventually added into the driver, I think we will need
another variable such as `mode` to know the mode. I was also thinking
of adding a phy argument to determine if the mode is C-PHY or D-PHY.

So here, I don't want to stop the probe if `is_cdphy` variable is set to
true. Does it make sense ?

Regards
Julien

.. snip..
> > +
> > +	phy = devm_phy_create(dev, NULL, &mtk_dphy_ops);
> > +	if (IS_ERR(phy)) {
> > +		dev_err(dev, "Failed to create PHY: %ld\n", PTR_ERR(phy));
> > +		return PTR_ERR(phy);
> > +	}
>
> Regards,
> Angelo
>
