Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED18869D477
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjBTUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBTUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:10:27 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8ED1F4AC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:10:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg37-20020a05600c3ca500b003e21e018039so2721535wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9CBXqz5Ym6vyKdYB/UcZABuHubzocvDFl1/6+aRGTU=;
        b=Ip9paFpl6CVybhOZXCupqpnDcguBljmABnOUP73mVxYqpP6Jq3V+3J3KfDf2VdP2u4
         /epbDB4GhTlDBSPLK/1Ng6PPJ3k4c8MPA/mvPhyMiPD0pK1xLxllykKdHNARsgWcrhrp
         T48mUQ8SuUh5NfBFzeLhLlObbDmvmBqcSqy8bexYf2EDrJxB4+E/Us7NNWD6UQnWB8DO
         w1aqMkRilpmKd0ahPO5rEYPrPVLkSVG1rN4jLgVym1svqJGumVsfLpEYYQb1et5C607I
         ghdbaaFG31NMT9nCScHJHLddvoHraFT99FWVoXzAtrsOasTZ7d8K96GGzegtODDCdMBc
         /bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9CBXqz5Ym6vyKdYB/UcZABuHubzocvDFl1/6+aRGTU=;
        b=bJpwFP/NJz1wFgPay5MNqrCIM69Cu/HdKl6r0CIsjgv9FcYZWRIb4iFXXNVzwpL7BH
         6RQts+bEGXIPlZILssp/Mc70s8S3xp3bYSrKI6Wnal27qk2Mo6pNkTsOA8zVYx0UAxUc
         7it+fSYC/HXi1Wy+wHa+M9N+aKjvMm5xUFKFnvBn+oJtlwMGEQrRKnIaNac2nw9eWQyK
         LxG5YM2N31bczIM7gvkkPt0jzhMjD9TD1X44NE7uDtXlPlZ1DuQgttR3GGWnoqiTyJV5
         klbdkcwYWCT2TvgiumsLiJp+jG0m1t7c+7zPMrJvoMh0yxq2R7SqbMhd/nBjZUHjGifj
         K79w==
X-Gm-Message-State: AO0yUKUw9DHpxiuFoa2IyPWSMDV0nQkgYI1dsBKPCYwGu2oQD1DqsVvu
        nCOqx5n7dIFpnMmBRXO8P3QSdg==
X-Google-Smtp-Source: AK7set9o9hcBk+G3Tqr5Nkg+e2vlF9zQ3Wr5OIKk5DsSQPAxZy/Zd7AkwhlX4VeT6HeBWiDhEe4vBw==
X-Received: by 2002:a05:600c:1e12:b0:3df:9858:c033 with SMTP id ay18-20020a05600c1e1200b003df9858c033mr1564082wmb.8.1676923824413;
        Mon, 20 Feb 2023 12:10:24 -0800 (PST)
Received: from blmsp ([2001:4090:a247:8056:be7d:83e:a6a5:4659])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b003e2232d0960sm2954068wmo.23.2023.02.20.12.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 12:10:23 -0800 (PST)
Date:   Mon, 20 Feb 2023 21:10:23 +0100
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH 1/8] dt-bindings: power: Add MT8365 power domains
Message-ID: <20230220201023.ozy6ogdumhf35nwm@blmsp>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-2-msp@baylibre.com>
 <6f6f1be3-358d-d062-31e1-c307dca56907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f6f1be3-358d-d062-31e1-c307dca56907@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Fri, Feb 03, 2023 at 01:31:58PM +0100, Matthias Brugger wrote:
> 
> 
> On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > Add power domains dt-bindings for MT8365.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> > 
> > Notes:
> >      Changes in v4:
> >      - Add infracfg_nao as it is used by mt8365
> >      Changes in v3:
> >      - Renamed mt8365-power.h to mediatek,mt8365-power.h
> >      Changes in v2:
> >      - Made include/dt-bindings/power/mt8365-power.h dual-license.
> > 
> >   .../power/mediatek,power-controller.yaml      |  6 ++++++
> >   .../dt-bindings/power/mediatek,mt8365-power.h | 19 +++++++++++++++++++
> >   2 files changed, 25 insertions(+)
> >   create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 605ec7ab5f63..a496c43cfa16 100644
> > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -30,6 +30,7 @@ properties:
> >         - mediatek,mt8186-power-controller
> >         - mediatek,mt8192-power-controller
> >         - mediatek,mt8195-power-controller
> > +      - mediatek,mt8365-power-controller
> >     '#power-domain-cells':
> >       const: 1
> > @@ -86,6 +87,7 @@ $defs:
> >                 "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
> >                 "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
> >                 "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
> > +              "include/dt-bindings/power/mediatek,mt8365-power.h" - for MT8365 type power domain.
> >           maxItems: 1
> >         clocks:
> > @@ -113,6 +115,10 @@ $defs:
> >           $ref: /schemas/types.yaml#/definitions/phandle
> >           description: phandle to the device containing the INFRACFG register range.
> > +      mediatek,infracfg-nao:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: phandle to the device containing the INFRACFG-NAO register range.
> > +
> 
> 
> Hm, so we have mediatek,mt8365-infracfg defined in mt8365-sys-clock. Also
> the description talks about infracfg_ao. You now introduce INFRACFG-NAO. Is
> that just another system clock block, or is this covered with the
> mediatek,mt8365-infracfg binding?
> 
> We would need to clean that up.

Looking through the datasheet I don't see any clock related registers
for infracfg-nao. So I don't think it is another system clock block. It
seems to be a lot of status registers and debug registers, but not all
of them. It really doesn't seem to have a specific topic here. So from
my point of view it is just a syscon block. Should I add a
mediatek,mt8365-infracfg-nao compatible to the syscon binding
documentation?

Thanks,
Markus

> 
> Regards,
> Matthias
> 
> >         mediatek,smi:
> >           $ref: /schemas/types.yaml#/definitions/phandle
> >           description: phandle to the device containing the SMI register range.
> > diff --git a/include/dt-bindings/power/mediatek,mt8365-power.h b/include/dt-bindings/power/mediatek,mt8365-power.h
> > new file mode 100644
> > index 000000000000..e6cfd0ec7871
> > --- /dev/null
> > +++ b/include/dt-bindings/power/mediatek,mt8365-power.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + * Copyright (c) 2022 MediaTek Inc.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_POWER_MT8365_POWER_H
> > +#define _DT_BINDINGS_POWER_MT8365_POWER_H
> > +
> > +#define MT8365_POWER_DOMAIN_MM		0
> > +#define MT8365_POWER_DOMAIN_CONN	1
> > +#define MT8365_POWER_DOMAIN_MFG		2
> > +#define MT8365_POWER_DOMAIN_AUDIO	3
> > +#define MT8365_POWER_DOMAIN_CAM		4
> > +#define MT8365_POWER_DOMAIN_DSP		5
> > +#define MT8365_POWER_DOMAIN_VDEC	6
> > +#define MT8365_POWER_DOMAIN_VENC	7
> > +#define MT8365_POWER_DOMAIN_APU		8
> > +
> > +#endif /* _DT_BINDINGS_POWER_MT8365_POWER_H */
