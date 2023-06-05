Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C991272214B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjFEIof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjFEIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:44:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CACDF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:44:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so3621840f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685954663; x=1688546663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrfUcOIoh78ZG5yS7R23juCUyPfE+5HsrCyM0YNurn4=;
        b=IgSNkde0F2plrIXJephmlvFxedbx7tHM/IirdYyN8pIDo1/xuMRvfD3003V3SWGHl8
         Xze9Y//QtV5Ftzj9fe4SKQCZtkWTeyO92TffXIgoNk/f0UTaEOLtvzh0OKVOfviV2ZDz
         kaVgp5xNaUfGdZgx0+4PlUx5MlzbexzibYxSjDjpapVblsms1sKsRFLZRK2bdIb27J7i
         H2fo5fxIYxiaQg/Oubg67FQ9i6jDMbwv4rC77dQ4G84nkEJ7alXmS0jKXSsLjo/AOmNJ
         jnqpRhceRR89MCqgmvivmJ9Top5sIb3qzgDkyZzDvZIWBVvD85ieWL8lkmwaHMAQ3/pr
         P5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685954663; x=1688546663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrfUcOIoh78ZG5yS7R23juCUyPfE+5HsrCyM0YNurn4=;
        b=a+4fPyq5CJvD4hl6S9KHIQMQWMaUCrcVK9Bu3oqPzmyyFiUptdfuWiC9cYPswfX+IY
         nIEEBg/UlA9jOOLfvpaUgeg8rmYXaKptU/FZmpUQ638grUL0g2cay0R+yHftrT7tMJI2
         hiQXj3paj7gZpV7MtFgzzOhTKWU5FHG9Vye60VHkVwReIplowLkcBJfvTOaKIpqu0qEB
         iBVITGKbXmXBb0GAAChV0cORJsWTcFqA2jwFrO7lrkaoyF7kCVSjv1A8sESPbrYVOPLr
         SnZN8trll60tBvUAW8qjj+lTepdIdIkP4eCA0Lg3pLlg/MA/Z3R67j5CN9GHddTT3ztq
         RHnw==
X-Gm-Message-State: AC+VfDxZlhM6tIMvNiDCzXrHMBFFkW5dNY3gR255HUlG0/z7NAWSYmP0
        /z2e0N90wZU3WbaqmV09AyBRxA==
X-Google-Smtp-Source: ACHHUZ5lrv51N2yyyZvduWpzWmbtXLAxBQh2VfWJZNp02Pt1G+uTkEUIrAQWOBc93DFyD+N73N+83w==
X-Received: by 2002:adf:f986:0:b0:2ff:6906:7169 with SMTP id f6-20020adff986000000b002ff69067169mr5341675wrr.68.1685954663499;
        Mon, 05 Jun 2023 01:44:23 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d458c000000b00307acec258esm9107444wrq.3.2023.06.05.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:44:22 -0700 (PDT)
Date:   Mon, 5 Jun 2023 10:44:22 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Message-ID: <totyr5bsupdv6y6muvndnhywbw5fl5kezoxie2hyz4g53yi34m@6geccwkjvupc>
References: <20230515090551.1251389-2-jstephan@baylibre.com>
 <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
 <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
 <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
 <7h353w2oug.fsf@baylibre.com>
 <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
 <7hwn18yndq.fsf@baylibre.com>
 <c63ebd7e-8658-9cdd-4fc4-ade9c94dfa64@linaro.org>
 <7hcz2snpnw.fsf@baylibre.com>
 <10074d67-394b-3ddb-8bd1-fc051bdb7f79@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10074d67-394b-3ddb-8bd1-fc051bdb7f79@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:53:31AM +0200, Krzysztof Kozlowski wrote:
> On 22/05/2023 21:15, Kevin Hilman wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> >
> >> On 16/05/2023 23:31, Kevin Hilman wrote:
> >>
> >>>> Third is to use versioned IP blocks.
> >>>>
> >>>> The second case also would work, if it is applicable to you (you really
> >>>> have fallback matching all devices). Third solution depends on your
> >>>> versioning and Rob expressed dislike about it many times.
> >>>>
> >>>> We had many discussions on mailing lists, thus simplifying the review -
> >>>> I recommend the first choice. For a better recommendation you should say
> >>>> a bit more about the block in different SoCs.
> >>>
> >>> I'll try to say a bit more about the PHY block, but in fact, it's not
> >>> just about differences between SoCs. On the same SoC, 2 different PHYs
> >>> may have different features/capabilities.
> >>>
> >>> For example, on MT8365, There are 2 PHYs: CSI0 and CSI1.  CSI0 can
> >>> function as a C-PHY or a D-PHY, but CSI1 can only function as D-PHY
> >>> (used as the example in the binding patch[1].)  On another related SoC,
> >>> there are 3 PHYs, where CSI0 is C-D but CSI1 & CSI2 are only D.
> >>>
> >>> So that's why it seems (at least to me) that while we need SoC
> >>> compatible, it's not enough.  We also need properties to describe
> >>> PHY-specific features (e.g. C-D PHY)
> >>
> >> I recall the same or very similar case... It bugs me now, but
> >> unfortunately I cannot find it.
> >>
> >>>
> >>> Of course, we could rely only on SoC-specific compatibles describe this.
> >>> But then driver will need an SoC-specific table with the number of PHYs
> >>> and per-PHY features for each SoC encoded in the driver.  Since the
> >>> driver otherwise doesn't (and shouldn't, IMHO) need to know how many
> >>> PHYs are on each SoC, I suggested to Julien that perhaps the additional
> >>> propery was the better solution.
> >>
> >> Phys were modeled as separate device instances, so you would need
> >> difference in compatible to figure out which phy is it.
> >>
> >> Other way could be to create device for all phys and use phy-cells=1.
> >> Whether it makes sense, depends on the actual datasheet - maybe the
> >> split phy per device is artificial? There is one PHY block with two
> >> address ranges for each PHY - CSI0 and CSI1 - but it is actually one
> >> block? You should carefully check this because once design is chosen,
> >> you won't be able to go back to other and it might be a problem (e.g.
> >> there is some top-level block for powering on all CSI instances).
> >
> > We're pretty sure these are multiple instances of the IP block as they
> > can operate completely independently.
> >
> >>>
> >>> To me it seems redundant to have the driver encode PHYs-per-SoC info,
> >>> when the per-SoC DT is going to have the same info, so my suggestion was
> >>> to simplify the driver and have this kind of hardware description in the
> >>> DT, and keep the driver simple, but we are definitely open to learning
> >>> the "right way" of doing this.
> >>
> >> The property then is reasonable. It should not be bool, though, because
> >> it does not scale. There can be next block which supports only D-PHY on
> >> CSI0 and C-PHY on CSI1? Maybe some enum or list, depending on possible
> >> configurations.
> >
> > OK, looks like include/dt-bindings/phy/phy.y already has
> >
> >   #define PHY_TYPE_DPHY		10
> >   #define PHY_TYPE_CPHY		11
> >
> > we'll add a PHY_TYPE_CDPHY and use that.   Sound reasonable?
>
> Yes. Currently it is usually used as phy-cells argument (after the phy
> number/lane/ID), but cdns,phy-type and intel,phy-mode use it directly as
> property in provider. In both cases they have a bit different meaning
> than yours. You want to list all supported modes or narrow/restrict
> them. Maybe hisilicon,fixed-mode fits your purpose?
>

Hi Krzysztof,

Thanks for the suggestion, using something like hisilicon,fixed-node
looks like a good fit.
With mediatek,fixed-node, by default CSI node will be considered as
CD-PHY capable (unless the fixed-mode property is set.) so I won't need
anymore the new define PHY_TYPE_CDPHY introduced in v3.

Also introducing mediatek,fixed-mode suggests that PHYs not declaring
the fixed mode property support mode selection, so I suggest to add a
phy argument (#phy-cells = <1>) to select the mode (D or C mode).
Exactly what is done by the hsilicon driver.

How does that sound to you?

Best,
Julien
> Best regards,
> Krzysztof
>
