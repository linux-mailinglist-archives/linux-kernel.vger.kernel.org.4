Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A645D69328F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBKQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBKQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:44:45 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4AC1E1FA;
        Sat, 11 Feb 2023 08:44:42 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 52B06100002;
        Sat, 11 Feb 2023 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676133881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+0DC+ETxm+24yPbZcgcwTKulTh6wEH0nAaak4Rv5+s=;
        b=geR+dOxyvNCD8U3nIQqUf9YODnmp6BJmOOwyPFXZL6w260h+RbQ4kVyeKwoHc0XPzZT3h5
        sYF48Ix3xTygNLn72UC/y8PPBm/1rhfyZw2l23g+2V4p5WVhh+/P5PDOwz+VrHyk4Wj2CK
        sSWpdg2R6HEVyyKEIv1bDAhCXoDAEnLVpwm4oJE60ZTglsQoEsgObXLd5jAI7q/4YmZXT4
        Lq4sXQ7sFn12X3pPtvU0sFdCi22q1X0OPO58+F33n3ntBvZscNEkGIBMk1RzVBKtVlMTcb
        jsU+5uZ7w3RUmpsAzx8QZzc6pSenTAbHncuSwUallZ0C5ZuVwcJ+jqx6Vn7gWw==
Date:   Sat, 11 Feb 2023 17:44:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y+fF94EOkUuMq9Fc@mail.local>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <Y+bJqIpgZ0fbzL2b@mail.local>
 <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+dQXlABqc/uzIXc@hovoldconsulting.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 09:22:54+0100, Johan Hovold wrote:
> On Fri, Feb 10, 2023 at 11:48:08PM +0100, Alexandre Belloni wrote:
> > On 02/02/2023 16:54:42+0100, Johan Hovold wrote:
> > > On many Qualcomm platforms the PMIC RTC control and time registers are
> > > read-only so that the RTC time can not be updated. Instead an offset
> > > needs be stored in some machine-specific non-volatile memory, which a
> > > driver can take into account.
> > > 
> > > Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> > > from the Unix epoch so that the RTC time can be updated on such
> > > platforms.
> > > 
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml     | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > > index 21c8ea08ff0a..b95a69cc9ae0 100644
> > > --- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> > > @@ -40,6 +40,16 @@ properties:
> > >      description:
> > >        Indicates that the setting of RTC time is allowed by the host CPU.
> > >  
> > > +  nvmem-cells:
> > > +    items:
> > > +      - description:
> > > +          four-byte nvmem cell holding a little-endian offset from the Unix
> > > +          epoch representing the time when the RTC timer was last reset
> > > +
> > > +  nvmem-cell-names:
> > > +    items:
> > > +      - const: offset
> > > +
> > >    wakeup-source: true
> > 
> > The patch doesn't apply because this part of the context is not
> > upstream. Can you rebase?
> 
> Ah, sorry about that. That's because of commit 51b3802e7960
> ("dt-bindings: rtc: qcom-pm8xxx: allow 'wakeup-source' property") which
> is now in Linus's tree (and your rtc-fixes branch).
> 
> Do you still want me to rebase or do you prefer to handle the conflict
> some other way?

Ah yes, my bad, I'll merge rtc-fixes in rtc-next before applying


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
