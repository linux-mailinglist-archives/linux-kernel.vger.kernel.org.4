Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23156541F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbiLVNd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiLVNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:33:11 -0500
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEAD15706
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:33:09 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2A27F1F8F4;
        Thu, 22 Dec 2022 14:33:07 +0100 (CET)
Date:   Thu, 22 Dec 2022 14:33:05 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <20221222133305.txcla3kk6lrqk7sc@SoMainline.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
 <20221222101611.nwt5arux2hcvvtvf@SoMainline.org>
 <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff48e91-3cdc-a052-9573-3c4271f88e5a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-22 11:36:16, Krzysztof Kozlowski wrote:
> On 22/12/2022 11:16, Marijn Suijten wrote:
> > Is this missing a cc to linux-arm-msm?
> 
> No, it is not (or maybe but then fix MAINTAINERS). The policy is to use
> get_maintainers.pl to CC people.

Yes, that is the question: is it in MANTAINERS and if not, why not?

> > On 2022-12-22 10:23:55, Krzysztof Kozlowski wrote:
> >> Disallow clocks for variants other than:
> >> 1. SMMUs with platform-specific compatibles which list explicit clocks
> >>    and clock-names,
> >> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
> >>    variable clocks on different implementations.
> >>
> >> This requires such variants with platform-specific compatible, to
> >> explicitly list the clocks or omit them, making the binding more
> >> constraint.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > 
> > But...
> > 
> >> ---
> >>
> >> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
> >>  1 file changed, 28 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index 895ec8418465..0d88395e43ad 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -367,6 +367,34 @@ allOf:
> >>              - description: interface clock required to access smmu's registers
> >>                  through the TCU's programming interface.
> >>  
> >> +  # Disallow clocks for all other platforms with specific compatibles
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - cavium,smmu-v2
> >> +              - marvell,ap806-smmu-500
> >> +              - nvidia,smmu-500
> >> +              - qcom,qcm2290-smmu-500
> >> +              - qcom,qdu1000-smmu-500
> >> +              - qcom,sc7180-smmu-500
> > 
> > Hmm, sc7280 has two SMMUs.  The one for Adreno has clocks and a PD, the
> 
> sc7280 is not here, so what is the mistake you see?

sc7280 has two IOMMU nodes.  One with clocks (should not be in this
list), the other doesn't have clocks (should be in this list).

How do you want to address that?

> > one for APPS has neither.  Same story on sm8[12]50.  Aren't those going
> > to trip up the other `if` that requires clocks in both scenarios?
> 
> They are not here either, so what is the error?

Ditto.

> > Note that the Adreno SMMUs have (or will get when we/Konrad submit
> > support for it) the "qcom,adreno-smmu" compatible to distinguish them.

- Marijn
