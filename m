Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6216BB524
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCONtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjCONs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:48:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAD09E309
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:48:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so2042550pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678888104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RohM7g63YzmsEtzZiKZg0oSdjOmQlTEZe9G6sSdZJOs=;
        b=pr93/7EIkBZHtJ/3EpdL6o/7gjj2Yixz0EyCbU7yO9l5bYNjsEDOJumFdRDjJ3+6O/
         xsN/GzTavGiYZjssQe8oGrDlvDrQWogR0IU4VaWqpG6O9mG1aC7Pv6XN/26a1LvjQ4CA
         sDG9MEaQmVDn8KDuhUvKYvofaO/8ggoLFQQoIHBtsKbGUVzynSjPlr8tgPmN6Mv7Uz70
         fdCn3FZ4LMdOTLHAsh3owTp0EajQ7e9TQlvTdNpj9mJ4D661SWWWwsAhX7nG56wcVibG
         RcgqCqUA7KxA9oEUOtwbXjKQa6Is4dj0uibkzQlRjUW0Zy3Tu8pYq16HWliiw4rE6B0u
         PU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RohM7g63YzmsEtzZiKZg0oSdjOmQlTEZe9G6sSdZJOs=;
        b=U24MUGNHXme7LeznjVb9qZ6Ooqi1F/UzVpV1VzhGEXPdA3uV7fqAzvWp7pOji406wN
         dN9sJetyzXt0XaHdlfFVLmeQd/qTR7vSOM5+InEpCO2j/1CWEvj4FuHj248tFq7m8QTu
         OYVu2t0uAyAXH5LKE+Qd1FCdlAdZibD8zMdOewXpoc0/8kOl7rz/2LAX0OipdiZUFmWH
         0jhyIAtHdGmOrIe1U58KBlqQttODD5Zo7YXQGBbv7pnbXxoZVQKiPFrQdpAx68VJxDJI
         xSEx3JyyCSx9Y23MfILvhKJA2Y1iNnme+6cZok/4BYtfsoN44XHRw4RDM27rmdxPHcxh
         Rh5Q==
X-Gm-Message-State: AO0yUKWMdm5T2Kmrkho1pgR8qD6FYmB6KZzSuvUl7tShNxTZWzbFE0Fi
        NxOpQTt/46PGTs1QKmRgh/+w
X-Google-Smtp-Source: AK7set+/sZVJgTWXQ3bBaMNuMjzjypYC1DIqXC4Hs4szGWBLOsqrl2YZU/bmePzufYzgNZ0W2tzrLQ==
X-Received: by 2002:a05:6a20:8428:b0:d6:26a3:98d with SMTP id c40-20020a056a20842800b000d626a3098dmr2781816pzd.46.1678888102898;
        Wed, 15 Mar 2023 06:48:22 -0700 (PDT)
Received: from thinkpad ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id bn10-20020a056a00324a00b005a7bd10bb2asm3575850pfb.79.2023.03.15.06.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:48:22 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:18:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: msm: Add bindings for multi
 channel DDR in LLCC
Message-ID: <20230315134814.GA98488@thinkpad>
References: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
 <20230313124040.9463-3-quic_kbajaj@quicinc.com>
 <2b3e39b9-ea70-db9b-89f7-09054df363c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b3e39b9-ea70-db9b-89f7-09054df363c3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:41:21AM +0100, Krzysztof Kozlowski wrote:
> On 13/03/2023 13:40, Komal Bajaj wrote:
> > Add description for additional nodes needed to support
> > mulitple channel DDR configurations in LLCC.
> > 
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> 
> +Cc Mani,
> 

Thanks, Krzysztof!

> This will conflict with:
> https://lore.kernel.org/all/20230314080443.64635-3-manivannan.sadhasivam@linaro.org/
> 
> Please rebase on top of Mani's patches (assuming they are not
> conflicting in principle)
> 
> > ---
> >  Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > index 38efcad56dbd..9a4a76caf490 100644
> > --- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
> > @@ -37,15 +37,24 @@ properties:
> >      items:
> 
> minItems: 2
> 
> >        - description: LLCC base register region
> >        - description: LLCC broadcast base register region
> > +      - description: Feature register to decide which LLCC configuration
> > +                     to use, this is optional
> >  
> >    reg-names:
> 
> minItems: 2
> 
> >      items:
> >        - const: llcc_base
> >        - const: llcc_broadcast_base
> > +      - const: multi_channel_register

Is this the actual register region or a specific register offset? We generally
try to pass the base address of the region along with the size and use the
offset inside the driver to access any specific registers.

Thanks,
Mani

> >  
> >    interrupts:
> >      maxItems: 1
> >  
> > +  multi-ch-bit-off:
> > +    items:
> > +      - description: Specifies the offset in bits into the multi_channel_register
> > +                     and the number of bits used to decide which LLCC configuration
> > +                     to use
> 
> There are here few issues.
> First, I don't fully understand the property. What is an LLCC
> configuration? Like some fused values?
> 
> Second, don't make it a register specific, it will not scale easily to
> any new version of this interface. Although how this should look like
> depends on what is it.
> 
> Third, you need vendor prefix and type (unless this is a generic
> property, but does not look like). Then "items" is probably wrong. Line
> break after "description: "
> 
> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
