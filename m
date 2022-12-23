Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD5655045
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbiLWMYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiLWMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:24:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E590F5AC
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671798201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1HwigiBXzR+33Qj15n947bgxDdgr8XCfr3PoMuFRgU=;
        b=OksW7+8JTlb57VYBNwUoh6Xkdr0peBpELtWsliRLGyDRMQG7mRkEWe0coqVhuQSwRnRga+
        kb+w/GO7AskebC55j9Qc5mLGpkiR2UuKlKH/iob+0w7dmYm9muTdKmYStnpZ4Jgt/DZ972
        QhzXHGv/Mg31v1hF9UV2ZUFriA0TwkA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-2-oAkneZtIMOetQwisBbJ3hg-1; Fri, 23 Dec 2022 07:22:17 -0500
X-MC-Unique: oAkneZtIMOetQwisBbJ3hg-1
Received: by mail-qk1-f197.google.com with SMTP id l16-20020a05620a28d000b00704af700820so3081803qkp.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HwigiBXzR+33Qj15n947bgxDdgr8XCfr3PoMuFRgU=;
        b=ier4vHrkK5AiqaJNn/dp8X88YMv7VSj0Eor+erigbmeKGI7wPqG11xB1ZVa5HGzMM4
         WW7j1NFTyjUowPvM+oVvZhxUShEg7yQpCKYUgN6b9ffd5GMmMxvADuwwMq/JzGQ23Mb5
         Pl00dMRS2H1tIx0+XWkJvxYy2x5u6pLSaZyLK5+iEGuprpgiPQcRmqn01TBOS2sPHlb7
         /o5cq7Q+n9pmOEgIgTeb2Ty6bmjd4NRNsHk4lYfYv+uIwF89D0w/ygSy5a7pLx0gDzpE
         P9HU2jp56nm3dwrPrbS6CpdUtIzoCNgRnrTkX1ugCXVtOIogYrA3eF8z9iBX//Xy4IRH
         T6Nw==
X-Gm-Message-State: AFqh2koQfNOMy2+h72oVSNmqJHb+Ca9Db+3+RWmoTMhHq8lHBVoXc3md
        iQM1VorxovO7x91y7d6mvYrxty+EKz6JZyiQbxzxLlGebz96lZ9CRdgjv+aP1Xe4IYLmF+MtHsP
        x1JnA5t+RrNzfjpiPLZftDocd
X-Received: by 2002:a05:622a:1a08:b0:3ab:6e0c:166b with SMTP id f8-20020a05622a1a0800b003ab6e0c166bmr4586396qtb.47.1671798137062;
        Fri, 23 Dec 2022 04:22:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtuy/cAgKKIkhssIauVBEFzgx+91czS0/pNhPTxFAecy61AF1+PjIa+q0FQV4Y++aFHwlCWHg==
X-Received: by 2002:a05:622a:1a08:b0:3ab:6e0c:166b with SMTP id f8-20020a05622a1a0800b003ab6e0c166bmr4586371qtb.47.1671798136823;
        Fri, 23 Dec 2022 04:22:16 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id q27-20020a37f71b000000b006cec8001bf4sm2119584qkj.26.2022.12.23.04.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 04:22:15 -0800 (PST)
Date:   Fri, 23 Dec 2022 07:22:14 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sc8280xp: add missing i2c nodes
Message-ID: <Y6WddnmaREQlt9gq@x1>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-5-bmasney@redhat.com>
 <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
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

On Fri, Dec 23, 2022 at 11:37:02AM +0100, Johan Hovold wrote:
> On Tue, Dec 20, 2022 at 02:28:51PM -0500, Brian Masney wrote:
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index f1111cd7f679..a502d4e19d98 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -813,6 +813,38 @@ qup2: geniqup@8c0000 {
> >  
> >  			status = "disabled";
> >  
> > +			i2c16: i2c@880000 {
> > +				compatible = "qcom,geni-i2c";
> > +				reg = <0 0x00880000 0 0x4000>;
> > +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> > +				clock-names = "se";
> > +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> 
> I'm aware that the two current i2c nodes has these two properties here
> in the middle, but would you mind moving '#address-cells' and
> '#size-cells' after 'reg' instead where I'd expect them to be?
> 
> Same for the spi patch.
> 
> I can clean up the existing two nodes (and binding example) unless you
> want to do it.

I'll clean up the existing nodes, qcom,i2c-geni-qcom.yaml, and
qcom,geni-se.yaml in my next version.

Brian

