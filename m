Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35866DBB31
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDHNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDHNeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:34:07 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D965A8;
        Sat,  8 Apr 2023 06:34:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso3477190pjm.3;
        Sat, 08 Apr 2023 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680960846; x=1683552846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyQY5EFUm+oQMesR6aVIRRhcDec6E2nGI6W5UYRsXSs=;
        b=ACsczob6+Zj9VJNd8W0MjSjXmpT20vh+NRPKiqTNj6cgIW87UzTCMX6CGm9yWoiHBN
         W9bb2BsO96ebkcADtVOLsF0Qh1VZNMTEoNt4f4uPpE0Ume4KIOH9W9jHzV2KH2J9SiCR
         pNSQlM0DMcAlIzYIwMYkmYoTUgC5q5TpoqNhqF4YaxWHgKglqFoAUj8qdtux6Tn37hV0
         aCJ5SEvvygbRUnExV9pzcIe+ydOBW1y2eZJuIeBumqEsDozMCm1asoNeJfF4P8wRm4uD
         DABOyfIDz9Ltjh70Z3S8WS8w9HLVVJXSiT2O7GCpKDEmBtSxTYpo7vhV1FetX8z1s6w2
         +F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680960846; x=1683552846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyQY5EFUm+oQMesR6aVIRRhcDec6E2nGI6W5UYRsXSs=;
        b=fRuQHUYQwJoREn33XAAzrVhTBKYpu9W/CA/NBevWhyh/GFw3xl7wy8WytF10zwHfJ9
         pya6T8+UH+nvTKyGyTv1Hnw2ggzhKEZj2ouxoPEef7yWmXqnoIRu4LbE0p5QfPgWwbh1
         jS74Q+oeP7iQjZI2HU3gfzom3nPp0+46QuxbaWF3VM87QigTlrR+EG85+6vXt5w4TnGr
         AinB91QrWLpgYLSKDv8UaK6rD88O9kZYGFJjB8OjPzKf6H+UlQhKlhBHLmygZgvoS/EF
         sYJ+g5QfTnjOYwXOXIDgeogUtfXroR46bt7VOIsbEWANG3hcCUgIqfwB+PiIX9w4U2EO
         lH2A==
X-Gm-Message-State: AAQBX9e3TiOhvhfBBzVTu6oq2G214dk1MX8js8V4jEFJ2n+eYQCWz0Vp
        h1dSm/+CDZ8scWsvFNtHd0U=
X-Google-Smtp-Source: AKy350bR9OTn16qgrkz2ptRgrXX5AS1GfuKZBw3fasuBZM/babZFjXRMWG+hrwuGyBx7fm8KIagfzQ==
X-Received: by 2002:a17:90a:cb91:b0:23f:a674:dc0b with SMTP id a17-20020a17090acb9100b0023fa674dc0bmr2828696pju.15.1680960846427;
        Sat, 08 Apr 2023 06:34:06 -0700 (PDT)
Received: from Gentoo (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b00198f36a8941sm1532285plo.221.2023.04.08.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 06:34:05 -0700 (PDT)
Date:   Sat, 8 Apr 2023 21:33:56 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add
 mdss and dsi panel
Message-ID: <ZDFtRNN9koAB0Anw@Gentoo>
References: <20230323005925.23179-1-lujianhua000@gmail.com>
 <20230323005925.23179-2-lujianhua000@gmail.com>
 <0a5729a8-9fd8-a084-3932-cf8ebf00860b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a5729a8-9fd8-a084-3932-cf8ebf00860b@linaro.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 08, 2023 at 03:04:52PM +0200, Krzysztof Kozlowski wrote:
> On 23/03/2023 01:59, Jianhua Lu wrote:
> > Add nodes for BOE NT36523 panel found in xiaomi-elish. This panel
> > is a dual dsi mode panel and the dsi phy type is cphy.
> > 
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> > ---
> > Changes in v2:
> >   - Include missing <dt-bindings/phy/phy.h> for phy-type property.
> > 
> > Changes in v3:
> >   - Sort include header.
> >   - Move qcom,sync-dual-dsi to the front of qcom,master-dsi 
> >   - Add newline before subnode.
> > 
> >  .../boot/dts/qcom/sm8250-xiaomi-elish-boe.dts |  5 ++
> >  .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 75 +++++++++++++++++++
> >  2 files changed, 80 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> > index bd9ad109daf9..8b2ae39950ff 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> > +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
> > @@ -11,3 +11,8 @@ / {
> >  	model = "Xiaomi Mi Pad 5 Pro (BOE)";
> >  	compatible = "xiaomi,elish", "qcom,sm8250";
> >  };
> > +
> > +&display_panel {
> > +	compatible = "xiaomi,elish-boe-nt36523";
> 
> If you add new bindings and new nodes using these - in this case this
> panel - please test it. This is why we have DT schema, so you can verify
> your DTS. Sending DTS which is entirely different than the bindings you
> sent, is adding quite an effort for us later to fix it.

I apologize for this. I will test it before sending patches next time.
> 
> Best regards,
> Krzysztof
> 
