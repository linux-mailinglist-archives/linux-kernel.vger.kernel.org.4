Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF78704991
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjEPJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEPJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:42:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBCA3A9D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:42:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so75135715e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 02:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684230119; x=1686822119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHdslW5e1QTcIDouIG+in/KkFSBqX+6yDdC3nU0nD/A=;
        b=t8BcB2NCIb19w3SWPpkqhYIgvE9sdfHSmIZbU28lV542GDLl7qxk1cZLXBrp0t9ucX
         CnCZglQvK2XA0ux0BlPEoi+5LYoebRQDQBeO5i6xasJN1bIGrYgQyc6ucqqeI4d3+9EH
         Nq5C1K7PTu0wCIwcWBAuXRnugKfdywJQhknLyo0GmsVsqCDIL0kBR7b1cm0OS+OiB6Mz
         cP+d1TB2BAkgefOYquy8lXZ1zspXBnRMgFF79aorT7yztRbhod/6r7tob9FFG8IgpWia
         V7+cME6K0gyqmw3KTFZsu5rZbgPM+6XryZwJU7OJMgDovzXXpMqqZb7SzkMENoy2reVT
         ABfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684230119; x=1686822119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHdslW5e1QTcIDouIG+in/KkFSBqX+6yDdC3nU0nD/A=;
        b=ZM9F/Q5Uj5hHQT5FqSXgly/V6RlcZAKRjr9JAl5oTtDw0yKuuCImZoaPog5uGpofKl
         1536gb0oWW4jj/a3OOaMTBfabjkJELRVHSSEt88v0MfJ88b0sW1eKy63xPZOREleiht7
         oK3k6z+OAKuzqV+53RerEfIUJHo3Kopz6HD7T9n6B3rVQ9JACetg+AyvjZFR9rOTZfXD
         wOd9mpQOb8nlGcHC8GbYCOSwdzTY2CGXAbY9amnWgNOXa+nXZAxjZuEhTZUbyQVVvclB
         3luGpbr4vDogyp3CH+EI9cH+a7qx4Jay55XPVxGCL3X3EhokTOx5CKRXGXMYqLbe4tzr
         9s+g==
X-Gm-Message-State: AC+VfDy7C44c0oso2WfwP8oXA8lGI2hqNOTeNdK9Cva5EJ4f+iZcHY7u
        03+WbSHOGpAFyZ9aZQkqQUVUbQ==
X-Google-Smtp-Source: ACHHUZ5jidpKUY9Gm2VWn+jw+Iklv4TIxan5q8PXSPngdCXx1jC/S9Fy0dMRPoa9hf0zox3WjEZ34g==
X-Received: by 2002:a7b:c7d7:0:b0:3f4:286f:1d99 with SMTP id z23-20020a7bc7d7000000b003f4286f1d99mr17672826wmk.32.1684230119308;
        Tue, 16 May 2023 02:41:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f50e29bce3sm1637127wmz.48.2023.05.16.02.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 02:41:58 -0700 (PDT)
Date:   Tue, 16 May 2023 11:41:57 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh@kernel.org, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org,
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
Message-ID: <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-2-jstephan@baylibre.com>
 <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:07:47AM +0200, Krzysztof Kozlowski wrote:
> On 15/05/2023 11:05, Julien Stephan wrote:
> > From: Florian Sylvestre <fsylvestre@baylibre.com>
> >
> > This adds the bindings, for the MIPI CD-PHY module v 0.5 embedded in
> > some Mediatek soc, such as the mt8365
> >
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> What are the changes? IOW: changelog here or in cover letter.
>
Hi Krzysztof,
I added a changelog in the cover letter, but I will try to be more
descritpive next time. Changes from v1 are mainly style issues fixed
(mostly from your first review)

> Subject: you have some multiple spaces.
>
> Subject: drop driver. Bindings are not for drivers.
>
> > ---
> >  .../phy/mediatek,phy-mipi-csi-0-5.yaml        | 62 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> > new file mode 100644
> > index 000000000000..5aa8c0b41cdf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,phy-mipi-csi-0-5.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-Only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/mediatek,phy-mipi-csi-0-5.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> > +
> > +maintainers:
> > +  - Julien Stephan <jstephan@baylibre.com>
> > +  - Andy Hsieh <andy.hsieh@mediatek.com>
> > +
> > +description:
> > +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> > +  receivers. The number of PHYs depends on the SoC model.
> > +  Depending on the soc model, each PHYs can support CDPHY or DPHY only
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,phy-mipi-csi-0-5
>
> SoC based compatibles. 0-5 is odd.
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#phy-cells':
> > +    const: 0
> > +
> > +  mediatek,is_cdphy:
>
> No underscores in node names.
>
> > +    description:
> > +      Specify if the current phy support CDPHY configuration
>
> Why this cannot be implied from compatible? Add specific compatibles.
>
>
This cannot be implied by compatible because the number of phys depends
on the soc and each phy can be either D-PHY only or CD-PHY capable.
For example mt8365 has 2 phy: CSI0 and CSI1. CSI1 is DPHY only and CSI0 is CD-PHY

Regards,
Julien
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#phy-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      mipi_rx_csi0: mipi_rx_csi0@11c10000 {
>
> No underscores in node names. How this is v2?
>
> > +        compatible = "mediatek,phy-mipi-csi-0-5";
> > +        reg = <0 0x11C10000 0 0x2000>;
> > +        status = "okay";
>
> Drop
>
> > +        mediatek,is_cdphy;
> > +        #phy-cells = <0>;
> > +      };
> > +
> > +      mipi_rx_csi1: mipi-rx-csi1@11c12000 {
> > +        compatible = "mediatek,phy-mipi-csi-0-5";
> > +        reg = <0 0x11C12000 0 0x2000>;
> > +        status = "disabled";
>
> ???
>
>
> Best regards,
> Krzysztof
>
