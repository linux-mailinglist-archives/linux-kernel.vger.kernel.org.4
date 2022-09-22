Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55C85E67A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiIVPyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIVPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:54:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5FF8C1F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:54:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so1628127wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iYg1FzmqdVObBIGDrpXK8/12CqSCWXQixjeTyrRH2G0=;
        b=U7d/4vDIwSQRsJWGFVcpBJeAOdN+sAQbKSb2o3nU1ltmtMKJJVczpUw7YYI8Rp74sL
         JQcG/1ES6hfniQSgvRaC72caMaBHZL38ZnNycbQzppt7QHkRPD8wgJoQsxAdPpDlo+3T
         zUwdSISD/mv3037nwO3v+J98i5U7ZLMI2lD3PgRYiZrYcLHaV9pj2NTnkMUHO5r0LSv+
         2rjoEs1vnqJzFjONPC18v2wuGjyGYDAd2G1QCgmgKFMKhCiIkVS9BXiYvky8OSOVqGgf
         rlyIMYqPpaKgrPtzTRMOFX4ZaRhOU/sKH3nQrbmM/H/CfaA1iTI2Ob6iy9qn8VXs0DSS
         /16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iYg1FzmqdVObBIGDrpXK8/12CqSCWXQixjeTyrRH2G0=;
        b=mxqVD872YIWZ0y7mYfI20sb5ICdNqNuFUX77NHRUx4b6oOQ5/kwLqKEm9ulm7srl/0
         Oeuv0mTb2eYku/ysrxaXkp3lgzNIiLng1q9dCF7MgnxLSfd4OhYQmgw3X3Wcq/RB883o
         wUuz/yZG8VYcCXOfq1vK78LCNIHOlZEQwNmF2MdKp6IVdbkHMj2C0sTRerNUJoRQwFoZ
         AdHcZY6MWbISuANZZsiMGY28eQ6qmPewwea4ccnmydhLgs1zwbOKYJicwyGt2iwGIXu5
         humFd4OQeqbFYdhgK80xHV+8Wlpsnb4TmbGVcGKS6skvdHKGJFkz3glyh/Vlv1HcJcga
         C5XA==
X-Gm-Message-State: ACrzQf2iiM3H+L/QfWozK1jbJoZB+T/7vs8FPoX2ISuhivkXbbPAoWEc
        oI+D0bBivltjLb/ACOCiSNc/aw==
X-Google-Smtp-Source: AMsMyM5Mx5ZdCtIHnwDfOXcEuZUtP46bEwkTkCYte68YDHl4EU5xMMSzyd1IY3MjD8FrepyHgbOsow==
X-Received: by 2002:a05:600c:1da8:b0:3b4:8fd6:5132 with SMTP id p40-20020a05600c1da800b003b48fd65132mr2877306wms.99.1663862053559;
        Thu, 22 Sep 2022 08:54:13 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c510200b003a540fef440sm6961727wms.1.2022.09.22.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:54:13 -0700 (PDT)
Date:   Thu, 22 Sep 2022 16:54:09 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio,pci-iommu to DT
 schema
Message-ID: <YyyFISBBUgeAOocY@myrica>
References: <20220916132229.1908841-1-jean-philippe@linaro.org>
 <6f692ece-b3ac-4115-370a-3c5e255dd0f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f692ece-b3ac-4115-370a-3c5e255dd0f8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 10:23:06AM +0100, Krzysztof Kozlowski wrote:
> > +required:
> 
> Also: compatible
> 
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie0 {
> 
> Node name: pcie
> 
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> 
> device_type and then you will see a bunch of warnings.

Right, I think I wanted to avoid pulling the whole PCIe baggage because it
requires a lot of properties that aren't relevant to the example. But
having tried it it's not too bad, and it ensures we validate the child
node.

Thanks,
Jean

> 
> > +        /*
> > +         * The IOMMU manages all functions in this PCI domain except
> > +         * itself. Omit BDF 00:01.0.
> > +         */
> > +        iommu-map = <0x0 &iommu0 0x0 0x8
> > +                     0x9 &iommu0 0x9 0xfff7>;
> > +
> > +        /* The IOMMU programming interface uses slot 00:01.0 */
> > +        iommu0: iommu@1,0 {
> > +            compatible = "pci1af4,1057";
> > +            reg = <0x800 0 0 0 0>;
> > +            #iommu-cells = <1>;
> > +        };
> > +    };
> > +
> > +    pcie1 {
> 
> Node name: pcie (so probably you will need unit address and reg)
> 
> > +        /*
> > +         * The IOMMU also manages all functions from this domain,
> > +         * with endpoint IDs 0x10000 - 0x1ffff
> > +         */
> > +        iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> > +    };
> > +
> > +    ethernet {
> > +        /* The IOMMU manages this platform device with endpoint ID 0x20000 */
> > +        iommus = <&iommu0 0x20000>;
> > +    };
> > +
> > +...
> 
> 
> Best regards,
> Krzysztof
