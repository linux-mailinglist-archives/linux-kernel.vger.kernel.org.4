Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E120704945
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjEPJa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:30:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A310F8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:30:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f42c865534so79223965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684229419; x=1686821419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bo1b/bEqOS6KDD6qflz0mFStzeeE7aur/bUdV5C/8NA=;
        b=vRap7UvFpv5ghKGfHsGU8Sx21psojIcztLgVIfwXWJknaFex0YDfYeBt8QdLUe6Gkb
         EG8UOIkceBXE/IjJcromhmhBBpTrow4u9OeNW6CAeY3KRZ0bFKuLVdpeY8nmc+myHUdO
         QhWgL+NzdeSPH23J+bAgDCGqdpH9wbSG5pqBuhWPpuqDrIYLKuRV8gn3+IdCXRGtPLeQ
         AjSm8pJWYkjp47srU3RKptYEqRNguW1H8a3RokeO9ozq+kjRsQBor8Gk7+nk3ni92ger
         /HYUENYA8FPWMde5Tv1gEz0Zud3qfusXGXJv1yXRj322ED7prIUFViaYje9qN9wwEY2a
         XwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684229419; x=1686821419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo1b/bEqOS6KDD6qflz0mFStzeeE7aur/bUdV5C/8NA=;
        b=cIW2JhfdA07eb3eKNBk5kS0R9H2HNMHsUUBCBCVE9IqFTjrCgWGdZTY+ebrSx9cI6L
         ESngpp+X6ilazqVUPS/K42hI/+ww7XoYD6YbtbSpFt8WbNrRDqXtZRaY0lwhp+kSH145
         +zViQFBoeUcwHiE4KRDoNTHbUgPnZLNIcAS1CWz/XmOQcwk1frWDEyouD5c5AO3SDYlc
         Pog1/yFQ72+dQC6kkqgPwuj96OPSmDvkXzgtWX+Wjm+I5FoPrcIT81FU0zMZz5CSv1mn
         GnFHGBGV3/5Z/508CIIHx9yPinzdOQPiugH/LFwy6jVNMYeYwVvFScriQTYNEqfoVbvO
         SoXw==
X-Gm-Message-State: AC+VfDxhmQSSNzEs4PV22AKdu55LfgcDAvrHCkrutdDI6HWNiIgrf8sq
        tlHUNwwAb9c8KYsi0Ds0Pcf9Zg==
X-Google-Smtp-Source: ACHHUZ7VHIunoibF7bQd4takm4fdk7SjKWAPNooKGJ2N2GmNNWqcstqBa8aSFOHr6/KgX4SlBiDTqQ==
X-Received: by 2002:adf:f2c3:0:b0:305:fbfb:c7d7 with SMTP id d3-20020adff2c3000000b00305fbfbc7d7mr29019988wrp.44.1684229419563;
        Tue, 16 May 2023 02:30:19 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6704000000b002e5ff05765esm1928076wru.73.2023.05.16.02.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:30:18 -0700 (PDT)
Date:   Tue, 16 May 2023 11:30:17 +0200
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
Message-ID: <shthzc3zekvm2mrcch6vexsq5djpoxwupvdmmovhrz2ack3wxx@s4ptfhq7iwvi>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-3-jstephan@baylibre.com>
 <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
 <b2nk4jw2hpy4ndoq4cojazkn6h3tra2zjffhiswb7aqryabf7q@mkbtzhzcbivv>
 <54e6923c-729a-49de-8395-fbd0b8443aa8@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e6923c-729a-49de-8395-fbd0b8443aa8@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 04:32:42PM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/05/23 16:07, Julien Stephan ha scritto:
> > On Mon, May 15, 2023 at 02:22:52PM +0200, AngeloGioacchino Del Regno wrote:
> > > > +#define CSIxB_OFFSET		0x1000
> > >
> > > What if we grab two (or three?) iospaces from devicetree?
> > >
> > > - base (global)
> > > - csi_a
> > > - csi_b
> > >
> > > That would make it possible to maybe eventually extend this driver to more
> > > versions (older or newer) of the CSI PHY IP without putting fixes offsets
> > > inside of platform data structures and such.
> > >
> > Hi Angelo,
> > The register bank of the CSI port is divided into 2:
> > * from base address to base + 0x1000 (port A)
> > * from base + 0x1000 to base +0x2000 (port B)
> > Some CSI port can be configured in 4D1C mode (4 data + 1 clock) using
> > the whole register bank from base to base + 0x2000 or in 2D1C mode (2 data +
> > 1 clock) and use either port A or port B.
> >
> > For example  mt8365 has CSI0 that can be used either in 4D1C mode or in
> > 2 * 2D1C and CSI1 which can use only 4D1C mode
> >
> > 2D1C mode can not be tested and is not implemented in the driver so
> > I guess adding csi_a and csi_b reg value may be confusing?
> >
> > What do you think?
>
> Ok so we're talking about two data lanes per CSI port... it may still be
> beneficial to split the two register regions as
>
> reg-names = "csi-a", "csi-b"; (whoops, I actually used underscores before,
>                                and that was a mistake, sorry!)
>
> ....but that would be actually good only if we are expecting to get a CSI
> PHY in the future with four data lanes per port.
>
> If you do *not* expect at all such a CSI PHY, or you do *not* expect such
> a PHY to ever be compatible with this driver (read as: if you expect such
> a PHY to be literally completely different from this one), then it would
> not change much to have the registers split in two.
>
> Another case in which it would make sense is if we were to get a PHY that
> provides more than two CSI ports: in that case, we'd avoid platform data
> machinery to check the number of actual ports in the IP, as we would be
> just checking how many register regions we were given from the devicetree,
> meaning that if we got "csi-a", "csi-b", "csi-c", "csi-d", we have four
> ports.
>
> Besides, another thing to think about is... yes you cannot test nor implement
> 2D1C mode in your submission, but this doesn't mean that others won't ever be
> interested in this and that other people won't be actually implementing that;
> Providing them with the right initial driver structure will surely make things
> easier, encouraging other people from the community to spend their precious
> time on the topic.
>
Hi Angelo,
Ok, I see your point, but for future potential upgrade to support A/B
ports I was thinking of something else: adding independent nodes for csixA
and csixB such as:

csi0_rx: phy@11c10000 {
  reg = <0 0x11C10000 0 0x2000>;
  mediatek,mode = <4D1c>;
  ...
};

csi0a_rx: phy@11c10000 {
  reg = <0 0x11C10000 0 0x1000>;
  mediatek,mode = <2D1c>;
  ...
};
csi0b_rx: phy@11c11000 {
  reg = <0 0x11C11000 0 0x1000>;
  mediatek,mode = <2D1c>;
  ...
};

giving the correct register range. One thing I did not mention is that if
csi0_rx is used csi0a_rx and csi0b_rx cannot be used (they share same
physical lanes as csio_rx), but csi0a_rx and csi0b_rx can be used simultaneously.
So platform device will enable only the node(s) it needs and enabling
csi0_rx and csioa/b_rx will fail because they share the same register
region and map will fail and it does not have any sense because you
either have a camera using the whole port or sub port but you cannot have
both plugged in. What do you think about it?

> > > > +#define CSIxB_OFFSET		0x1000
Maybe moving this declaration in phy-mtk-mipi-csi-0-5-rx-reg.h would be
better?

Regards,
Julien
> Regards,
> Angelo
>
