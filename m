Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903106EE918
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjDYUeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjDYUeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF031444D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682454815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5tdSr0yUH0NfUrSmIfXDBJS+fKv28jR9I4BQNRViKk=;
        b=fqSH9qzU0Y7AzSmyVGY+y/5TBqv4iUefrudNtqV1eBpWNgRaEy+Nqb7DRRWnEGOhXemkCf
        o7u0v2La7LeMmjY6rJn3pjbgaz+OQt9vRsIziCDObHLE8TZlpLiy30wCVd4r9Twn/UKbru
        Tbntqw1oPLUoLIQOvk4R2K7lKnI1XDs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-_VkDNZrjM6WPt1kIzT1i7Q-1; Tue, 25 Apr 2023 16:33:34 -0400
X-MC-Unique: _VkDNZrjM6WPt1kIzT1i7Q-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5469ab1632eso4459313eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682454813; x=1685046813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5tdSr0yUH0NfUrSmIfXDBJS+fKv28jR9I4BQNRViKk=;
        b=YhH3wjLT6Oq2f2MLBgHITosVWeVYiZIRqWDDYlSd8z5UxgYgslAhB69iQMIOLMQNmC
         RhO+n+uBj1Pmbr39zR8MNc8Z80lWqmSXz8Rl3eh3O6RMj45B9sKhUaIrzEJWUrpl2RZD
         SXoOCsI1JFZjmg9oUA5hy1+58Erz+IoCy3Vwtm1jWjVkwcQiQeoIVZ9qjyAAPzXBG6nx
         ypU9E+UyZapYTc1jQjq/jeYB50xmUZ+/DVB4W82fTzitU84oj+JuuRgpTK6o1464vu38
         VkqG/5eDrIBB9fc9pFB9VBt+d/3tcWCK6rALXEmnQnM3qQZv69KvvrUhCF5Q/VGNCooa
         +rdQ==
X-Gm-Message-State: AAQBX9eBWWtS37ewjPIZnFQPZuOC9yoQ1mEDgUoQ3eI4SBbGuysc8nA8
        MjaX62HPWT0EwzSHzQghY9j6L977JsGq5oo4fD9UjHi1W9V7+CMapLrGqdT0TNK91xPE75lMFQ8
        dzQIunvpsmPAkkcZ2bPW6D69I
X-Received: by 2002:a05:6808:1885:b0:38e:4a25:2125 with SMTP id bi5-20020a056808188500b0038e4a252125mr10743325oib.18.1682454813588;
        Tue, 25 Apr 2023 13:33:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350bV2wSHJIhY5qS6dBbjNydN6E9nxfDFfxEa+5HJvmGjHUeuCswJpaJeLjx3DBjNrKQVTWLfUA==
X-Received: by 2002:a05:6808:1885:b0:38e:4a25:2125 with SMTP id bi5-20020a056808188500b0038e4a252125mr10743275oib.18.1682454811825;
        Tue, 25 Apr 2023 13:33:31 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id g3-20020a056870c38300b0018456166c7asm5908752oao.39.2023.04.25.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:33:31 -0700 (PDT)
Date:   Tue, 25 Apr 2023 15:33:28 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v6 6/8] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <20230425203328.hrz5dw7f2vsbbbgk@halaney-x13s>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-7-quic_kriskura@quicinc.com>
 <20230414154527.vsjtgtfsd5kc7vww@halaney-x13s>
 <333ce700-8ca2-e230-3b5a-a95e4c021e45@quicinc.com>
 <28a58bf9-5ad8-4084-11d6-cd1b0d3a2998@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28a58bf9-5ad8-4084-11d6-cd1b0d3a2998@quicinc.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 09:38:44PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 4/16/2023 12:34 AM, Krishna Kurapati PSSNV wrote:
> > 
> > 
> > On 4/14/2023 9:15 PM, Andrew Halaney wrote:
> > > On Wed, Apr 05, 2023 at 06:27:57PM +0530, Krishna Kurapati wrote:
> > > > Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> > > > IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> > > > platforms.
> > > > 
> > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > ---
> > > > Link to v5: https://lore.kernel.org/all/20230310163420.7582-7-quic_kriskura@quicinc.com/
> > > > 
> > > >   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 58 ++++++++++++++++++++++++++
> > > >   1 file changed, 58 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > index 42bfa9fa5b96..7b81f2b0449d 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > > > @@ -3108,6 +3108,64 @@ usb_1_role_switch: endpoint {
> > > >               };
> > > >           };
> > > > +        usb_2: usb@a4f8800 {
> > > > +            compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
> > > > +            reg = <0 0x0a4f8800 0 0x400>;
> > > > +            #address-cells = <2>;
> > > > +            #size-cells = <2>;
> > > > +            ranges;
> > > > +
> > > > +            clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
> > > > +                 <&gcc GCC_USB30_MP_MASTER_CLK>,
> > > > +                 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
> > > > +                 <&gcc GCC_USB30_MP_SLEEP_CLK>,
> > > > +                 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> > > > +                 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> > > > +                 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> > > > +                 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> > > > +                 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> > > > +            clock-names = "cfg_noc", "core", "iface", "sleep",
> > > > "mock_utmi",
> > > > +                      "noc_aggr", "noc_aggr_north",
> > > > "noc_aggr_south", "noc_sys";
> > > > +
> > > > +            assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> > > > +                      <&gcc GCC_USB30_MP_MASTER_CLK>;
> > > > +            assigned-clock-rates = <19200000>, <200000000>;
> > > > +
> > > > +            interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> > > > +                        <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> > > > +                        <&pdc 16 IRQ_TYPE_LEVEL_HIGH>;
> > > > +
> > > > +            interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
> > > > +                        "ss_phy_irq";
> > > > +
> > > 
> > > This is breaking the current schema (with the full series applied),
> > > I am not sure if a pwr_event IRQ exists or but it maybe necessary to
> > > modify qcom,dwc3.yaml in order to explain hardware if it doesn't exist:
> > > 
> > > (dtschema) ahalaney@halaney-x13s ~/git/linux-next
> > > (git)-[718f2024524f] % make CHECK_DTBS=y
> > > DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml qcom/sa8540p-ride.dtb                                                                                  
> > > :(
> > >    LINT    Documentation/devicetree/bindings
> > >    CHKDT   Documentation/devicetree/bindings/processed-schema.json
> > >    SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> > >    DTC_CHK arch/arm64/boot/dts/qcom/sa8540p-ride.dtb
> > > /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:0: 'pwr_event' was expected
> > >     From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:1: 'dp_hs_phy_irq' was expected
> > >     From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names:2: 'dm_hs_phy_irq' was expected
> > >     From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupt-names: ['dp_hs_phy_irq', 'dm_hs_phy_irq', 'ss_phy_irq'] is too short
> > >     From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > /home/ahalaney/git/linux-next/arch/arm64/boot/dts/qcom/sa8540p-ride.dtb: usb@a4f8800: interrupts-extended: [[99, 127, 1], [99, 126, 1], [99, 16, 4]] is too short
> > >     From schema: /home/ahalaney/git/linux-next/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> > > make CHECK_DTBS=y DT_SCHEMA_FILES=/usb/qcom,dwc3.yaml
> > > qcom/sa8540p-ride.dtb  22.61s user 0.54s system 99% cpu 23.172 total
> > > (dtschema) ahalaney@halaney-x13s ~/git/linux-next (git)-[718f2024524f] %
> > > 
> > > Thanks,
> > > Andrew
> > > 
> > 
> > Hi Andrew,
> > 
> >   Thanks for pointing it out. Let me check and get back on the
> > pwr_event_irq.
> > 
> > Probably I might have missed it 😅. If so, will make sure to add it in
> > next version.
> > 
> > Regards,
> > Krishna,
> 
> 
> Hi Andrew, Johan,
> 
>   I was looking at the pwr_event_irq interrupts for Multiport controller and
> see that there are two of them as per HW specs. All targets till date have
> only 1 pwr_event_irq required.
> 
> The reason I thought I missed pwr_event_irq in my patches is because in
> downstream this is a required IRQ for all targets, so I was under assumption
> that we need it for upstream targets as well. But upstream qcom driver
> doesn't have support for this IRQ yet. And this has been made a required one
> only for SC8280 [1]/[2].
> 
> Probably we can proceed in one of the following ways:
> 1. Remove pwr_event_irq in both bindings and DT as driver support is not
> present currently.
> 2. Update the bindings for SC8280 to include an optional secondary
> pwr_event_irq for multiport controller.
> 
> I would prefer option-1 as removing them would be better because they are
> not being used. Please let me know your thoughts on this.
> 
> [1]:
> https://lore.kernel.org/all/20220713131340.29401-2-johan+linaro@kernel.org/
> [2]:
> https://lore.kernel.org/all/20220713131340.29401-6-johan+linaro@kernel.org/
> 

Personally, I prefer option 2 since the IRQ does exist technically
(although it isn't currently used), I like it being described... it
makes the dt-binding a more complete description of the hardware.

I am unsure of the rules wrt dt-bindings and usage in drivers, but I
always like to view it as "this is a description of the hardware", and
the driver bit is just nice to have to ensure that whoever is adding the
binding is actually describing things sufficiently.

You could probably add a new compatible string for the multiport
sc8280xp IP as well, and make the second IRQ non-optional in dt-binding
evaluation? That seems more inline with reality, the regular IP has 1
pwr_event_irq, multiport on this platform has 2, they behave slightly
differently and thus they deserve their own string to match on despite
being on the same platform.

Please note, I'm just a contributor -- I would not be surprised to find
out that my view is not aligned with what maintainers here think, but
that's my interpretation of things!

Hope that helps,
Andrew

