Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43E46D7832
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbjDEJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbjDEJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:28:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5459D0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 02:27:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l12so35480581wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 02:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680686873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nbxb6pOBobAspVURmZV5qw9xso4MEJwnKnyDKhuf9Zk=;
        b=OOAgHuCVOjJ1ff7sJbGp70M1TYsellJraMNNqALPTmQetFjYslPpiJGgMjg+i0Q1uS
         p2+UYnPbfi9udTNtUOZ1jUPDQS5kAR8sd5NrtSNm4GROMvpU3KxwMDb6zY7HadyoKZOs
         wlhWIyJoyqdmbeTXsjpsZxsjjxZjekgcVYAKGJ9qIZxDmUHTSpFscdwrCnBAS4qTTlUJ
         VGDcM+EW/dXt6zhL9ZhnH3lxniF8zlidAFd0DBk4lx046s7iVdcfNkhg0JIy6FKd6n0O
         wbVcBtv68/8QtEOlOGJaI19Yd0Bgs25xqhO2SN8TM/AhbQUVkZE96EFgn4hEbD0fi9Uh
         7GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbxb6pOBobAspVURmZV5qw9xso4MEJwnKnyDKhuf9Zk=;
        b=G+KX02GBYv6EFjR/6D4kA3eifBCFPQwGtN2ah3FoF3sUZXDEh/Gqwp77Mn9CoRHJbV
         xvggR7Qop3RAhTc+s3CXLQpabBITLWIroDoO/eDdOIr5Ps9AaJwRB3eC6tpybVhWbPi3
         o88aEXnHNMkkYz97MlxSw05+SDSLOiwsRnD5h02WvkK2pjGUvyiw9sXmQTuvnghvopaH
         bmF3SXwQpF45SHA5UgEfzxtV62Tr7cJr+25froV7zgpNgK3AAZBp+2MtGJFbYY/DwCYr
         a6tGf5tBNpDe4wgsy0JnjPctlzDZsE1qUCYO/4+N/2J7EQM1ybc6DSbfgIKMcy4c9y6e
         3AuQ==
X-Gm-Message-State: AAQBX9egvfCK0pkqw+0auaCnIodqpKj9/ARBXaSrR1zqC4OSEySQfBwZ
        stibbYu85d7VaZC5dKS84L5w8g==
X-Google-Smtp-Source: AKy350ZTLUZ8C5oWQIqlnzLbcauR0nQz5678A9ppDmkWQi4Z5mSQP5i3id5jdUI4YRVmSOACLzI+Aw==
X-Received: by 2002:a5d:5262:0:b0:2ce:a30d:f764 with SMTP id l2-20020a5d5262000000b002cea30df764mr3274578wrc.21.1680686873617;
        Wed, 05 Apr 2023 02:27:53 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b003edddae1068sm1606494wmb.9.2023.04.05.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 02:27:53 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:27:53 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Message-ID: <ucoak3m7tlroscd2txdsbx5kr67sjvp342msva6rz5xwedub4q@xjb5kfdigxf5>
References: <20230403071929.360911-1-jstephan@baylibre.com>
 <20230403071929.360911-3-jstephan@baylibre.com>
 <6c9c74ee-b9ed-815f-dd92-37eb4c8f802a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c9c74ee-b9ed-815f-dd92-37eb4c8f802a@linaro.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:51:50AM +0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 09:19, Julien Stephan wrote:
> > From: Phi-bang Nguyen <pnguyen@baylibre.com>
> >
> > This is a new driver that supports the MIPI CSI CD-PHY for mediatek
> > mt8365 soc
> >
> > Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > [Julien Stephan: use regmap]
> > [Julien Stephan: use GENMASK]
> > Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  .../bindings/phy/mediatek,csi-phy.yaml        |   9 +-
> >  MAINTAINERS                                   |   1 +
> >  drivers/phy/mediatek/Kconfig                  |   8 +
> >  drivers/phy/mediatek/Makefile                 |   2 +
> >  .../phy/mediatek/phy-mtk-mipi-csi-rx-reg.h    | 435 ++++++++++++++++++
> >  drivers/phy/mediatek/phy-mtk-mipi-csi.c       | 392 ++++++++++++++++
> >  6 files changed, 845 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-rx-reg.h
> >  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi.c
> >
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> > index c026e43f35fd..ad4ba1d93a68 100644
> > --- a/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,csi-phy.yaml
>
> NAK, bindings are always separate patches. It also does not make any
> sense - you just added it.
>
:( I messed up my rebase -i. This need to be moved and squashed with the
previous patch. I will fix it in v2. Thank you for reporting it

> > @@ -33,9 +33,14 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > -    phy@10011800 {
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      phy@11c10000 {
> >          compatible = "mediatek,mt8365-mipi-csi";
> > -        reg = <0 0x10011800 0 0x60>;
> > +        reg = <0 0x11c10000 0 0x4000>;
> >          #phy-cells = <1>;
> > +      };
> >      };
>
>
>
> k_mipi_dphy_of_match[] = {
> > +	{.compatible = "mediatek,mt8365-mipi-csi"},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_mipi_dphy_of_match);
> > +
> > +static struct platform_driver mipi_dphy_pdrv = {
> > +	.probe = mtk_mipi_dphy_probe,
> > +	.remove = mtk_mipi_dphy_remove,
> > +	.driver	= {
> > +		.name	= "mtk-mipi-csi",
> > +		.of_match_table = of_match_ptr(mtk_mipi_dphy_of_match),
>
> Drop of_match_ptr(). You should see W=1 warnings when compile testing.
>
I do not not see any warnings when trying to compile with W=1. Am I
missing something? I will drop it in v2 anyway

Best
Julien
>
> Best regards,
> Krzysztof
>
