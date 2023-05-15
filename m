Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A663703096
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbjEOOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:52:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043211706
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:52:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f450815d02so41001585e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684162326; x=1686754326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6PGsaxxe+r0/tgEPfoiZneEqJdU4NADxCmDaQhFL68=;
        b=QBUPDu0mnTKpIi/wGbo9UgpiCqziYGcMj3hQWPNefHgGAfqJ8lVJErWsufoP7gVWl/
         MuKN4tEX1pZzLr340OCucG7rs4ehSVdPZ56+kGhAkPSHTFEanh+UOGRKxl0frSuERoQi
         znFDPcNKbBBfN9G+5GNepJLzQ0wZAO8nLN1JBJsH87VkOTZzGqNF3dV7QfkvbFQbWwzC
         8JItnIfYJ0m+YlLGiaXwATFgD5y70Nki5rbnME2c/ITNCpP6jTEfV2/BTzQHtJXbr5Ix
         ZLYZvkgxPg66jjZAKiLqfZ7H0BYHkg7RRJ+3Kpz8v/kkce6/YnkPjUmtUNTBVfQ11JjK
         kiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162326; x=1686754326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6PGsaxxe+r0/tgEPfoiZneEqJdU4NADxCmDaQhFL68=;
        b=A1PzToNhgArTq+00rw0/5CLFUpc4GQm4RS2aqZlF4zc1Vp1Hd6iuZPG7QXv30Xiw+J
         kMohWSXe3ccR8+woh/XbB6N4Ue+ODeBjy7v4gj3iRtHW9NXwji3GS6916EJ27GSjCxIO
         BMawZDESLtlgqXKxGBJdupqBFStOIEJPxDPTc7LWh81IUK0ePgomgZFGMvMDNFBMYmNO
         X4aIcXbeEJz2n82k7TRlnnA2wiD7ME/N0k01uulda/oRJDk1hZ8MNgrngMciKNK/KqXo
         DIvQxj+U2VVwfyYcg6uU7cOAnt0OOH3HWLZOKgOlor04LihUYrPNyf/zdmpxzO6/TMEj
         M0wg==
X-Gm-Message-State: AC+VfDy7mXumQjzxsdube5SCuuBXXWPZ2+jDwoNzNo1JGN2v5e+rIfco
        KMIArRHCSPM4D4prELB/Ad4skg==
X-Google-Smtp-Source: ACHHUZ5PnVTE8/BjOvD4cpmnU1SfNcpaeP+ththsz81R4NjZ9b8l1B6aIXxY1tdG8cXWxh3+7kD4ow==
X-Received: by 2002:a1c:f310:0:b0:3f1:74bd:bc22 with SMTP id q16-20020a1cf310000000b003f174bdbc22mr22887492wmq.6.1684162326437;
        Mon, 15 May 2023 07:52:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003f4e47c6504sm14774860wmg.21.2023.05.15.07.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:52:05 -0700 (PDT)
Date:   Mon, 15 May 2023 16:52:05 +0200
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
Message-ID: <jx2ndeoli3ozjiydygwclrpqmwftgf2gv4kfr6dyclf2cyh4hk@fnhvqeef5w4f>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-3-jstephan@baylibre.com>
 <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
 <ynrvqt24hjgng25r2xa3hxj35cvgotx7sdfrbqfjcvj3foegmr@4lqhen5yu6fh>
 <85500bcc-c5e8-8ce2-edea-233de86c2d35@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85500bcc-c5e8-8ce2-edea-233de86c2d35@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 04:22:38PM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/05/23 15:36, Julien Stephan ha scritto:
> > On Mon, May 15, 2023 at 02:22:52PM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 15/05/23 11:05, Julien Stephan ha scritto:
> >   ..snip..
> > > > +	port->is_cdphy = of_property_read_bool(dev->of_node, "mediatek,is_cdphy");
> > >
> > > This driver doesn't support C-PHY mode, so you either add support for that, or in
> > > my opinion you should simply refuse to probe it, as it is *dysfunctional* for the
> > > unsupported case (and might even introduce unstabilities).
> > >
> > > 	/* At the moment, only D-PHY mode is supported */
> > > 	if (!port->is_cdphy)
> > > 		return -EINVAL;
> > >
> > > Also, please don't use underscores for devicetree properties: "mediatek,is-cdphy"
> > > is fine.
> > >
> > Hi Angelo,
> > You are right this driver does not support C-PHY mode, but some of the
> > PHYs themselves support BOTH C-PHY AND D-PHY. The idea of `is_cdphy` variable
> > is to know if the CSI port supports BOTH C-PHY AND D-PHY or only DPHY.
> > For example mt8365 has 2 PHYs: CSI0 and CSI1. CSI1 support only D-PHY,
> > while CSI0 can be configured in C-PHY or D-PHY. Registers for CD-PHY and
> > D-PHY are almost identical, except that CD-PHY compatible has some extra
> > bitfields to configure properly the mode and the lanes (because supporting
> > trios for CD-PHY).
> > If C-PHY support is eventually added into the driver, I think we will need
> > another variable such as `mode` to know the mode. I was also thinking
> > of adding a phy argument to determine if the mode is C-PHY or D-PHY.
> >
> > So here, I don't want to stop the probe if `is_cdphy` variable is set to
> > true. Does it make sense ?
> >
>
> Comments in the code convinced me that the other PHYs providing only C or D PHY
> support weren't compatible at all with this driver.
>
> I got it now - but at this point can you please add a comment in the code actually
> clarifying that this driver supports both PHYs providing *only* D-PHY and ones
> providing selectable C-or-D PHY?
>
> That clarified, it would not make sense to stop probing if it's not a CDPHY because
> as you said there might be a D-only PHY that would be actually supported here.
>
> Regards,
> Angelo
>
>
Ok, I will add a comment in the code to make it more clear.

Regards
Julien
