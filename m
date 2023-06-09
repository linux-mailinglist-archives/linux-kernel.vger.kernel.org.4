Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7F7292DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbjFIIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjFIITy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633DB4234;
        Fri,  9 Jun 2023 01:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921AE6549C;
        Fri,  9 Jun 2023 08:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE57C433A8;
        Fri,  9 Jun 2023 08:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298689;
        bh=NrjQIUnAcAa6zkkpseMDzbBJiWLYR3nYu0kw41iy4WM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEshqVAXBpDk3PMv85TN6NgbaE7YJLZWSwSq4Pm17YI5V2i80/0TKP5X9a0ZzhCG3
         MUajmy4yhtEl0vEX+ExVzF1Y+wd5o5CLbO8b/ZNdcPtobfUozJsHVQ0CWzTHW6q5SA
         v+6hEEHDh8koM/5JAecqXPVl1/6BWHWnLmacaH8ix7t9nvO6CVHjhQo/rJePduNThC
         DgHYzQvoRtrpbGXd4n1rkFNcyON7UOVR0/P+KhtBOscM7cPnUUtdVDhjg4DPT2mXR1
         gK7ZlVcDuI4+ljLyvK0ObuM7m6GkPXR/VSEgFlUX13RJED9vEodrueZ0ou59ZDcNrz
         qJqAFldBc4UQQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7XKN-0005Sc-LP; Fri, 09 Jun 2023 10:18:36 +0200
Date:   Fri, 9 Jun 2023 10:18:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Message-ID: <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
References: <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:57:23PM +0000, Thinh Nguyen wrote:
> On Thu, Jun 08, 2023, Krishna Kurapati PSSNV wrote:
> > On 6/8/2023 3:12 PM, Johan Hovold wrote:
> > > On Thu, Jun 08, 2023 at 01:21:02AM +0530, Krishna Kurapati PSSNV wrote:
> > > > On 6/7/2023 5:07 PM, Johan Hovold wrote:
> > > 
> > > > > So there at least two issues with this series:
> > > > > 
> > > > > 	1. accessing xhci registers from the dwc3 core
> > > > > 	2. accessing driver data of a child device
> > > > > 
> > > > > 1. The first part about accessing xhci registers goes against the clear
> > > > > separation between glue, core and xhci that Felipe tried to maintain.
> > > > > 
> > > > > I'm not entirely against doing this from the core driver before
> > > > > registering the xhci platform device as the registers are unmapped
> > > > > afterwards. But if this is to be allowed, then the implementation should
> > > > > be shared with xhci rather than copied verbatim.
> 
> The core will just be looking at the HW capability registers and
> accessing the ports capability. Our programming guide also listed the
> host capability registers in its documentation. We're not driving the
> xhci controller here. We're initializing some of the core configs base
> on its capability.
> 
> We're duplicating the logic here and not exactly doing it verbatim.
> Let's try not to share the whole xhci header where we should not have
> visibility over. Perhaps it makes sense in some other driver, but let's
> not do it here.

The patch series even copied the kernel doc verbatim. This is just not
the way things are supposed to be done upstream. We share defines and
implementations all the time, but we should not be making copies of
them.

> > > > > 
> > > > > The alternative that avoids this issue entirely could indeed be to
> > > > > simply count the number of PHYs described in DT as Rob initially
> > > > > suggested. Why would that not work?
> 
> See below.
> 
> > > > > 
> > > > The reason why I didn't want to read the Phy's from DT is explained in
> > > > [1]. I felt it makes the code unreadable and its very tricky to read the
> > > > phy's properly, so we decided we would initialize phy's for all ports
> > > > and if a phy is missing in DT, the corresponding member in
> > > > dwc->usbX_generic_phy[] would be NULL and any phy op on it would be a NOP.
> > > 
> > > That doesn't sound too convincing. Can't you just iterate over the PHYs
> > > described in DT and determine the maximum port number used for HS and
> > > SS?
> > > > Also as per Krzysztof suggestion on [2], we can add a compatible to read
> > > > number of phy's / ports present. This avoids accessing xhci members
> > > > atleast in driver core. But the layering violations would still be present.
> > > 
> > > Yes, but if the information is already available in DT it's better to use
> > > it rather than re-encode it in the driver.

> >   Are you suggesting that we just do something like
> > num_ports = max( highest usb2 portnum, highest usb3 port num)
> 
> Why do we want to do this? This makes num_ports ambiguous. Let's not
> sacrifice clarity for some lines of code.

This is not about lines of code, but avoiding the bad practice of
copying code around and, to some degree, maintaining the separation
between the glue, core, and xhci which Felipe (perhaps mistakingly) has
fought for.

If you just need to know how many PHYs you have in DT so that you can
iterate over that internal array, you can just look at the max index in
DT where the indexes are specified in the first place.

Don't get hung up on the current variable names, those can be renamed to
match the implementation. Call it max_ports or whatever.

> > If so, incase the usb2 phy of quad port controller is missing in DT, we
> > would still read num_usb2_ports as 4 but the usb2_generic_phy[1] would be
> > NULL and any phy ops would still be NOP. But we would be getting rid of
> > reading the xhci registers compeltely in core driver.
> > 
> > Thinh, Bjorn, can you also let us know your views on this.
> > 
> > 1. Read:
> >   num_usb3_ports = highest usb3 port index in DT
> >   num_usb2_ports = max( highest usb2 port index, num_usb3_ports)
> > 
> > 2. Read the same by parsing xhci registers as done in recent versions of
> > this series.
> 
> DT is not reliable to get this info. As noted, the DT may skip some
> ports and still be fine. However, the driver doesn't know which port
> reflects which port config index without the exact port count.

That's not correct. DT provides the port indexes already, for example:

	phy-names = "usb2-port0", "usb3-port0",
		    "usb2-port1", "usb3-port1",
		    "usb2-port2",
		    "usb2-port3";

So if you just need this to iterate over the PHYs all the information
needed is here.

If you need to access ports which do not have a PHY described in DT,
then this is not going to suffice, but I have not seen anyone claim that
that is needed yet.
 
> More importantly, the host controller that lives on the PCI bus will not
> use DT. This can be useful for some re-configurations if the controller
> is a PCI device and that goes through the dwc3 code path.

Ok, this is a bit hand wavy, but if this ever turns out to be needed it
can also be implemented then.

Or just generalise the xhci implementation for parsing these registers
and reuse that from the start. (As a bonus you'd shrink the kernel text
size by getting rid of that iffy inline implementation.)

Johan
