Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC7B64B524
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLMM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbiLMM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:27:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AC1E735
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670934428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q3HIhNOWOlqyZAfVIJSyvE8UbxGSHbYQ4wflm8IvR0o=;
        b=he198UO9Ok5pUSSSGHUNUZJvgz5TFFk6fDFG3Zy6mYB6wvnvw8p2bno0tUaLClNxmiLoi0
        xj8r2KZ7k1lTFxmVazQFaHso5FcuiPT1TkEih1vGtM+w/mJ8+1hkeAUH2rcFlETIfoF4GY
        6qEMBmkTFFWBPrC28S+zLh4m4rBXmPI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-553-ilw5--TAMNijOeSANzjBgg-1; Tue, 13 Dec 2022 07:27:04 -0500
X-MC-Unique: ilw5--TAMNijOeSANzjBgg-1
Received: by mail-qk1-f198.google.com with SMTP id i4-20020a05620a248400b006febc1651bbso17357949qkn.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3HIhNOWOlqyZAfVIJSyvE8UbxGSHbYQ4wflm8IvR0o=;
        b=7TYpXvC6YPqiLDJsR3RFdx7xWxArseGYNSvNln55zBAhiwpg6uERV1iy9axgXSAP8l
         CgYk5lcW51h3dy2NurdoihERhiIyea61vFGED++9YR1vLgm7hlegCA7R62HldvQj3OlI
         FNSqw1C6Ki0AN9NS6rKNxlTs5H+T9pcb3EdrMK55wfQzQ+3spzOuZIUiczGvZW8ArZBC
         FvFJBsSIbsUasEGPKK8QBMwtte9ExEee07b5l1X9GXpFuhxZ/moxwi9BR+ubtI6k38yw
         ta8FVLOa4hCl8aQRmixcYTTcQgXUroG+mAfZD5d19tct3slJdZx260gkCvH6t16VsRto
         q1ug==
X-Gm-Message-State: ANoB5plE90vJzo9ma4ITlJRLmgZMdmWJtkROylm9BXaiyyHT2k9X0C0O
        73nabD2uvVu9nnanqC9p1lt9dltsmP3fb9B+jWuRuMioLj2t7v9mb/ys9To90YMVXEl6zDXD43M
        LAeRgbA+1MfC+jdXZuT9fxLkG
X-Received: by 2002:ac8:741a:0:b0:3a8:fdf:8ff8 with SMTP id p26-20020ac8741a000000b003a80fdf8ff8mr15934049qtq.36.1670934423556;
        Tue, 13 Dec 2022 04:27:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+MstVDv+MVwOl3qYohtomZj+xhx442a30ITmyito1dcoQdgvNwGbqhscVMKBykL5Rk6Ee/Q==
X-Received: by 2002:ac8:741a:0:b0:3a8:fdf:8ff8 with SMTP id p26-20020ac8741a000000b003a80fdf8ff8mr15934030qtq.36.1670934423278;
        Tue, 13 Dec 2022 04:27:03 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t14-20020ac865ce000000b003a6a7a20575sm7415774qto.73.2022.12.13.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:27:02 -0800 (PST)
Date:   Tue, 13 Dec 2022 07:27:01 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>,
        Mark Brown <broonie@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com,
        linux-spi@vger.kernel.org,
        Javier Martinez Canillas <fmartine@redhat.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Message-ID: <Y5hvlX35nr8xQKEd@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark Brown and linux-spi list

On Tue, Dec 13, 2022 at 12:46:18PM +0530, Shazad Hussain wrote:
> On 12/12/2022 11:53 PM, Brian Masney wrote:
> > Add the missing nodes for the spi buses that's present on this SoC.
> > 
> > This work was derived from various patches that Qualcomm delivered
> > to Red Hat in a downstream kernel.
> > 
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 384 +++++++++++++++++++++++++
> >   1 file changed, 384 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 392a1509f0be..b50db09feae2 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -829,6 +829,22 @@ qup2_i2c16: i2c@880000 {
> >   				status = "disabled";
> >   			};
> > +			qup2_spi16: spi@880000 {
> > +				compatible = "qcom,geni-spi";
> > +				reg = <0 0x00880000 0 0x4000>;
> > +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> > +				clock-names = "se";
> > +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> > +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> > +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> > +				interconnect-names = "qup-core", "qup-config", "qup-memory";
> > +				spi-max-frequency = <50000000>;
> 
> This is device property not host and same applicable for all below spi
> nodes.
> Also FYI let's enable below SPI for Qdrive usecases once spidev compatible
> name is confirmed.
> SE9  0x00A84000
> SE22 0x00898000

I talked to Javier Martinez Canillas yesterday about the spidev driver
and I think I now have a better understanding of what we need to do.
Quick background for Mark. For this automotive program, Qualcomm will be
delivering to Red Hat and our customers parts of the media stack in
userspace. This will be closed source, proprietary code that parts of it
will need to interface with SPI.

We can't add a generic qcom,spidev compatible to the spidev driver since
this is just a software abstraction. Instead, each type of device will
need to have it's own compatible that uniquely describes the type of
device. So you might have a compatible like qcom,spi-video-codec. There
will need to be a DT binding added that describes the hardware. I suspect
that a SPI device can simply be added to trivial-devices.yaml. Once the
DT binding is accepted, the compatible can be added to the spidev.c
driver. If an in-kernel driver is written in the future, then the 
compatible can be moved from spidev to the new driver.

Mark: Is my understanding above correct? If so, will it be a problem to
get a compatible added to spidev.c if the corresponding userspace code is
closed source and proprietary?

Brian

