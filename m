Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67968706C49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjEQPK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjEQPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6AA5D4;
        Wed, 17 May 2023 08:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A1A60FBD;
        Wed, 17 May 2023 15:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE0C433EF;
        Wed, 17 May 2023 15:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684336238;
        bh=Ny0LoiDv3bdptEg6qSZYN06fzaz93keaVkr7dslnSLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjrUez/4cBi2daN/lwRZUVJr2uMICn2TiWwRJKY5GVljwxRJOtPmsMt6z2oSfhDDc
         Y7RwIrQi3vSr6HeQjOf4WI+hDofp6G4GK7v7A3NtM9jpr9qKtqUjUbl7UPV/I76NJ5
         Sa0bdeTErhYfHu7YdrPjpP7dzFT9ozbHgkDBuMpbjmT5Sr5VbUUP04Qu0lXHs9R4zh
         IhgpGJd+v+zIHLhCMnrzGT4MDkq3rNDnZkTqGmnXqiI82k0+LCYUDakvZKOz2OdisR
         4XEPouomRWHk9Irbh7o/AGGGwNbXx/JHMW977iXccU/BTP7tV6BAIDzEvDM06yKhI1
         Cyc3s/ZLhGWSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pzInW-0005qx-Fz; Wed, 17 May 2023 17:10:39 +0200
Date:   Wed, 17 May 2023 17:10:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
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
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZGTubmBViN9rTiZC@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <ZGSDr08h3Go1Dk8C@hovoldconsulting.com>
 <82a8c414-bfa8-5066-fb68-1ac117b76c4e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a8c414-bfa8-5066-fb68-1ac117b76c4e@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 05:51:45PM +0530, Krishna Kurapati PSSNV wrote:
> On 5/17/2023 1:05 PM, Johan Hovold wrote:

> >>>> +	temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
> >>>> +	if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + dwc->num_usb2_ports)) {
> >>>> +		dev_err(dwc->dev,
> >>>> +			"Mismatched reported MAXPORTS (%d)\n", HCS_MAX_PORTS(temp));
> >>>> +		ret = -EINVAL;
> >>>> +		goto unmap_reg;
> >>>> +	}
> >>>
> >>> Not sure this is needed either.
> >>>
> >>> Could this risk regressing platforms which does not have currently have
> >>> all PHYs described in DT?
> >>>
> >> No, it doesn't. AFAIK, this only tells how many ports are present as per
> >> the core consultant configuration of the device. I tried to explain what
> >> would happen incase phy's are not present in DT in [2] & [3].
> > 
> > Right, whether the PHYs are described in DT is not directly related to
> > this.
> > 
> > As long as HCS_MAX_PORTS by definition (assumption) is always
> > (dwc->num_usb3_ports + dwc->num_usb2_ports) any such machines would
> > continue to work.
> > 
> > But if you want to catch machines where this assumption does not hold,
> > you could also end up regressing machines which have so far been working
> > despite these numbers not adding up.
> > 
> > That may be acceptable, but I'm still not sure what the value of this
> > check is (e.g. as xhci core will handle basic sanity checks like usb2 +
> > usb3 <= max_ports).

>    Thanks for the review comments. Ideally the HCC_PARAMS1 must indicate 
> total number of ports supported. If not then I believe the core 
> consultant configuration is wrong.
> 
> According to the spec:
> 
> "The MaxPorts value in the HCSPARAMS1 register defines the number of
> Port Register Sets (e.g. PORTSC, PORTPMSC, and PORTLI register sets)."
> 
> So shouldn't the (usb2+usb3 ports be equal to MaxPorts to ensure each 
> port properly accesses the respective PortSC etc., ?

Sure, that's what is expected, but why do you need to add a check for
this in the glue driver all of a sudden? Your series does not seem to
rely on this. This is the xHCI driver's business (as is parsing these
registers in the first place, really).

Johan
