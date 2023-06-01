Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79739719418
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFAHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFAHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46744199;
        Thu,  1 Jun 2023 00:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1AE9641D7;
        Thu,  1 Jun 2023 07:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45096C433EF;
        Thu,  1 Jun 2023 07:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685604235;
        bh=7Ahpma7m+aL2Tqeq3b72EtMTZeoblB97/8MM1nyA+Zc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KblWVf9Nhbcu7LdVRXBrP1A3MLYP71rym58QiGivazm78WrViVsbF9r8rDObujTiU
         osnaJMqjk3d8eeV/GAmTqyZqyBqhVkicib4qetc1QOwVLfA+QzQolRbQsCG8anfEuv
         5eaLHgCme/9Pj7S/azs+lEIm3xO67l5KJIAxgN8nePMZ04ToXoh/AlGnCocnBxEZSu
         hQ+1gikz+T+rwVpOWwmrSFY5CcRx5d+eSpJiyP9fFYtV1MyCpJlfkC7tYKE7/PSVDr
         1V/K+11RoNvKJoIs3NK+/vpDol87x5lqyzeQBJdLLlpq2b6g2INPeuhNaRlj8kyjhq
         gzdD4Ef8SIrbg==
Date:   Thu, 1 Jun 2023 12:53:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] dt-bindings: interconnect: split SC8180x to own
 schema
Message-ID: <ZHhHhk/4BX53R1p/@matsya>
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-4-vkoul@kernel.org>
 <25e3ed2f-d691-1a80-e2ba-6c7413b7261a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25e3ed2f-d691-1a80-e2ba-6c7413b7261a@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-23, 10:22, Krzysztof Kozlowski wrote:
> On 30/05/2023 18:24, Vinod Koul wrote:
> > SC8180x comes with interconnects with missing IO address space and
> > variable number of clocks, so split it from common file for easier
> > maintenance and to fix warnings like:
> > 
> > sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../bindings/interconnect/qcom,rpmh.yaml      | 11 -----
> >  .../interconnect/qcom,sc8180x-rpmh.yaml       | 49 +++++++++++++++++++
> >  2 files changed, 49 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > index 4d93ad415e0b..5cbc3be49e99 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> > @@ -39,17 +39,6 @@ properties:
> >        - qcom,sc7180-npu-noc
> >        - qcom,sc7180-qup-virt
> >        - qcom,sc7180-system-noc
> > -      - qcom,sc8180x-aggre1-noc
> > -      - qcom,sc8180x-aggre2-noc
> > -      - qcom,sc8180x-camnoc-virt
> > -      - qcom,sc8180x-compute-noc
> > -      - qcom,sc8180x-config-noc
> > -      - qcom,sc8180x-dc-noc
> > -      - qcom,sc8180x-gem-noc
> > -      - qcom,sc8180x-mc-virt
> > -      - qcom,sc8180x-mmss-noc
> > -      - qcom,sc8180x-qup-virt
> > -      - qcom,sc8180x-system-noc
> >        - qcom,sdm670-aggre1-noc
> >        - qcom,sdm670-aggre2-noc
> >        - qcom,sdm670-config-noc
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> > new file mode 100644
> > index 000000000000..b182c2c5addc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interconnect/qcom,sc8180x-rpmh.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm RPMh Network-On-Chip Interconnect on SC8180X
> > +
> > +maintainers:
> > +  - Bjorn Andersson <andersson@kernel.org>
> > +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> > +
> > +description: |
> > +  RPMh interconnect providers support system bandwidth requirements through
> > +  RPMh hardware accelerators known as Bus Clock Manager (BCM).
> > +
> > +  See also:: include/dt-bindings/interconnect/qcom,sc8180x.h
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sc8180x-aggre1-noc
> > +      - qcom,sc8180x-aggre2-noc
> > +      - qcom,sc8180x-camnoc-virt
> > +      - qcom,sc8180x-compute-noc
> > +      - qcom,sc8180x-config-noc
> > +      - qcom,sc8180x-dc-noc
> > +      - qcom,sc8180x-gem-noc
> > +      - qcom,sc8180x-ipa-virt
> > +      - qcom,sc8180x-mc-virt
> > +      - qcom,sc8180x-mmss-noc
> > +      - qcom,sc8180x-qup-virt
> > +      - qcom,sc8180x-system-noc
> > +
> > +required:
> > +  - compatible
> > +
> > +allOf:
> > +  - $ref: qcom,rpmh-common.yaml#
> 
> This should be based on sc7280. You need reg for some of the entries.

Yes missed reg part here.

Question is should it be added sc7280 or have a different file, I think
doing former is better

> 
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    interconnect-0 {
> 
> Just "interconnect"

Nope. We have multiple virtual nodes here so interconnect-N would
need to be done

-- 
~Vinod
