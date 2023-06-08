Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD89E727BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjFHJmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjFHJmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ECC213C;
        Thu,  8 Jun 2023 02:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68D6964B73;
        Thu,  8 Jun 2023 09:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8720C433EF;
        Thu,  8 Jun 2023 09:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217324;
        bh=m8N40M4lIXVobIW+tOavlfsHEn5dzitNcBam5qP1h2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7yrqaFrL/wQWiYIteDiSB6N77X98ODTHEx2BFKkgYBsHSw3EZixZCnQnxSqJQUMG
         gRZ/oC/XTcdFTDrvEVoAefB51KMidW+pUdLgC6MmO9CbpH1NvMMFhN6SZaNSsFERvI
         Ytzu24a4mkPa05AyaDzgkjbzklIMAT6TYDO12TBrLNTN8cPUr2Vu9CD9h+cIxsM9dl
         PJtvBkIy9BRpnDpa68EQbJ/EW36hXDxhluEi7XeG+nZ/koLCHBXbtUA/vJbgkkH6pF
         dGzxdsTxqhon4S7wMYU9E8i8uRiJWY0gE7yJ3+eEUc2Dks/kxYSxFC9ET7jooTk4RJ
         0wLe044d+cMJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7CA1-00049R-5m; Thu, 08 Jun 2023 11:42:29 +0200
Date:   Thu, 8 Jun 2023 11:42:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
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
Message-ID: <ZIGihYS5EacISEFm@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 01:21:02AM +0530, Krishna Kurapati PSSNV wrote:
> On 6/7/2023 5:07 PM, Johan Hovold wrote:

> > So there at least two issues with this series:
> > 
> > 	1. accessing xhci registers from the dwc3 core
> > 	2. accessing driver data of a child device
> > 
> > 1. The first part about accessing xhci registers goes against the clear
> > separation between glue, core and xhci that Felipe tried to maintain.
> > 
> > I'm not entirely against doing this from the core driver before
> > registering the xhci platform device as the registers are unmapped
> > afterwards. But if this is to be allowed, then the implementation should
> > be shared with xhci rather than copied verbatim.
> > 
> > The alternative that avoids this issue entirely could indeed be to
> > simply count the number of PHYs described in DT as Rob initially
> > suggested. Why would that not work?
> > 
> The reason why I didn't want to read the Phy's from DT is explained in 
> [1]. I felt it makes the code unreadable and its very tricky to read the 
> phy's properly, so we decided we would initialize phy's for all ports 
> and if a phy is missing in DT, the corresponding member in 
> dwc->usbX_generic_phy[] would be NULL and any phy op on it would be a NOP.

That doesn't sound too convincing. Can't you just iterate over the PHYs
described in DT and determine the maximum port number used for HS and
SS?
 
> Also as per Krzysztof suggestion on [2], we can add a compatible to read 
> number of phy's / ports present. This avoids accessing xhci members 
> atleast in driver core. But the layering violations would still be present.

Yes, but if the information is already available in DT it's better to use
it rather than re-encode it in the driver.
 
> > 2. The driver is already accessing driver data of the child device so
> > arguably your series is not really making things much worse than they
> > already are.
> > 
> > I've just sent a couple of fixes to address some of the symptoms of
> > this layering violation here:
> > 
> > 	https://lore.kernel.org/lkml/20230607100540.31045-1-johan+linaro@kernel.org/
> >
> 
>   As you pointed out offline to me that using xhci event notifiers I 
> mentioned on [3], if it is not acceptable to use them as notifications 
> to check whether we are in host mode, I believe the only way would be to 
> use the patches you pushed in.

I still think we'll end up using callbacks from the xhci/core into the
glue driver, but dedicated ones rather than using usb_register_notify().

The fixes I posted can work as a stop-gap solution until then.

> > Getting this fixed properly is going to take a bit of work, and
> > depending on how your multiport wake up implementation is going to look
> > like, adding support for multiport controllers may not make this much
> > harder to address.
> > 
> > So perhaps we can indeed merge support for multiport and then get back
> > to cleaning this up.
> So, you are referring to use the patches you pushed today as a partial 
> way to cleanup layering violations and merge multiport on top of it ? If 
> so, I am fine with it. I can rebase my changes on top of them.

Right. A bit depending on how your wakeup implementation looks like, it
seems we can merge multiport support and then address the layering
issues which are already present in the driver.

> [1]: 
> https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/
> [2]: 
> https://lore.kernel.org/all/ca729f62-672e-d3de-4069-e2205c97e7d8@linaro.org/
> [3]: 
> https://lore.kernel.org/all/37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com/

Johan
