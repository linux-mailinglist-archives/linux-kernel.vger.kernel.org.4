Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC93698F99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBPJTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBPJTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:19:19 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA01D913;
        Thu, 16 Feb 2023 01:19:16 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pSaPz-0007OX-0D;
        Thu, 16 Feb 2023 10:19:07 +0100
Date:   Thu, 16 Feb 2023 09:19:01 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mingming Su <Mingming.Su@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: rng: Add MediaTek MT7981 TRNG
Message-ID: <Y+31BSUGVbiOSFxs@makrotopia.org>
References: <89865515728cb937b6591160ad9c30b4bcc8dd41.1676467500.git.daniel@makrotopia.org>
 <c750e786ad0f529d2ae63c8f766d3c294808ff53.1676467500.git.daniel@makrotopia.org>
 <5341d0fa-1415-b711-30f0-f0a867af0bc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5341d0fa-1415-b711-30f0-f0a867af0bc4@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:14:33AM +0100, Krzysztof Kozlowski wrote:
> On 15/02/2023 14:27, Daniel Golle wrote:
> > Add documentation to describe the MediaTek true random number generator
> > which is provided by ARM TrustedFirmware-A of the MT7981.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  .../bindings/rng/mediatek,mt7981-rng.yaml     | 39 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rng/mediatek,mt7981-rng.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rng/mediatek,mt7981-rng.yaml b/Documentation/devicetree/bindings/rng/mediatek,mt7981-rng.yaml
> > new file mode 100644
> > index 000000000000..d577d60538d8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rng/mediatek,mt7981-rng.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rng/mediatek,mt7981-rng.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek Random number generator (v2/SMC)
> > +
> > +maintainers:
> > +  - Daniel Golle <daniel@makrotopia.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^rng$"
> 
> 1. We don't enforce it in device bindings, so drop it.

Ack.

> 2. It's not even correct. You have reg.

No, there isn't any reg, as this driver does not access a MMIO mapped
resource but rather uses Secure Monitor Call interface to access the
TRNG via ARM TrustedFirmware-A.

> 
> 
> > +
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7981-rng
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: rng
> 
> Drop clock-names and rely on index.

Will drop, reg, clocks and clock-names, that slipped in from the
document I used as template for this one. The driver uses neither of
those.

> 
> > +
> > +required:
> > +  - compatible
> 
> and reg?
> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    rng {
> > +      compatible = "mediatek,mt7981-rng";
> > +    };
> 
> Best regards,
> Krzysztof
> 
> 
