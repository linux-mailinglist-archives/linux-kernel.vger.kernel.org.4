Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AB873FFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjF0Pnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjF0Pnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B31708;
        Tue, 27 Jun 2023 08:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A2F7611D8;
        Tue, 27 Jun 2023 15:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87BFC433C0;
        Tue, 27 Jun 2023 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687880616;
        bh=0fBukbKw42+OuKPjJbx21dnFmVOG7Y0lihmjoL0ewuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTl8QjErWT1K1J87W8py6flm8zjHzWbeY1vmREGIGAr2nWVtmBRg7ZpIWDYiVeJAo
         /5X8XyvwK/Rakh9oQScdaPOLiFXFVQYAhNygfLGDIgJRe53GaBaddWG7sQmKwS+Y+p
         7brm146EPtVCmAerDaWHdq69W/62GmsGSTppb8xzWpz29KXXzXQ7gluAx9rsjtYCvj
         JV33Y8zwaZ1vNDo5G2a82hL1HzbHS77Ctq0EeLeQFzk4ZCuwT56gURx+W2prK6ZoKn
         3rcPazOkVo3e2Nczgtyk4qiEzka9CkIDjDI59YCX38ey/UwUr945E6aTbvvLFc/so5
         NkSrXOzmOSkKA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEAqs-0004FT-CZ; Tue, 27 Jun 2023 17:43:34 +0200
Date:   Tue, 27 Jun 2023 17:43:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZJsDpqttBYtbQ0yg@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIB1JEmLCw41v_4e@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Wed, Jun 07, 2023 at 02:16:37PM +0200, Johan Hovold wrote:
> On Sun, May 14, 2023 at 11:19:14AM +0530, Krishna Kurapati wrote:

> >  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
> >  {
> >  	u32 reg;
> > @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
> >  {
> >  	u32 val;
> >  	int i, ret;
> > +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
> >  
> >  	if (qcom->is_suspended)
> >  		return 0;
> >  
> > -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
> > -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> > -		dev_err(qcom->dev, "HS-PHY not in L2\n");
> > +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> > +		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
> > +		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
> > +			dev_err(qcom->dev, "HS-PHY%d not in L2\n", i);
> > +	}

> When testing this on the X13s I get:
> 
> 	dwc3-qcom a4f8800.usb: HS-PHY2 not in L2
> 
> for the third port, whose status registers always seems to return zero
> (e.g. as if we're checking the wrong register?):
> 
> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 0, pwr_event_stat = 38103c
> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 1, pwr_event_stat = 38103c
> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 2, pwr_event_stat = 00
> dwc3-qcom a4f8800.usb: dwc3_qcom_suspend - phy 3, pwr_event_stat = 140030
> 
> I verified that everything appears to work as expected on sa8295p-adp.
> 
> Do you have any idea of what may be causing this?

You never replied to this; do you have any idea why the status register
for the second port seemingly always read back as 0 on the X13s?

Johan
