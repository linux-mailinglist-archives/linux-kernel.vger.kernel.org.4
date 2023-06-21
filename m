Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6C737C43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFUHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjFUHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:34:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4909D;
        Wed, 21 Jun 2023 00:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F17E61493;
        Wed, 21 Jun 2023 07:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A4C433C0;
        Wed, 21 Jun 2023 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687332891;
        bh=oa7cHyl/wgzTNr7eiy1JrxQnqgppAVKyAkxSlwKm8sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1t7oC/65+XyZa5qZhD3yXkihC6vreLEB/FY+Z6VtD/+Gemh8qQirksNE4IYlZOGV
         /6sfkfYdUfKx+7qBJD3axxPopc7UBbDnIz9+mtwvhcHJyZxX7uQopX2HcgIvTZcjVT
         xuSGKrPzh9w7I3kvBS5ayvtDM+zHIG615Oq3u4PYPt4EQ9yOAa2SmP/g33bCGYldfg
         sI82g1PqXNW5nz/1RUKJDWqu4GgBsdFYTVixcDA2TYIUgx+PaARaLFwcQ9vf6oJUV8
         Y5Ijryg5EK00p/veZHF5bpJxsvRjzllqPcOiruM/rUYMdJ0J8R2nF5Cz19GIv3qaD4
         7Y3geRoySw0ow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBsMe-0005lF-UQ; Wed, 21 Jun 2023 09:34:53 +0200
Date:   Wed, 21 Jun 2023 09:34:52 +0200
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
Message-ID: <ZJKoHEi6A3I_APGI@hovoldconsulting.com>
References: <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
 <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
 <20230608175705.2ajrteztdeqdrkzg@synopsys.com>
 <ZILgW5CwfSlBxzNB@hovoldconsulting.com>
 <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609181602.ljxdchgzl7kzk73n@synopsys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

and sorry about the late reply. Was on holiday last week.

On Fri, Jun 09, 2023 at 06:16:13PM +0000, Thinh Nguyen wrote:
> On Fri, Jun 09, 2023, Johan Hovold wrote:
> > On Thu, Jun 08, 2023 at 05:57:23PM +0000, Thinh Nguyen wrote:
> > > On Thu, Jun 08, 2023, Krishna Kurapati PSSNV wrote:
> > > > On 6/8/2023 3:12 PM, Johan Hovold wrote:
> > > > > On Thu, Jun 08, 2023 at 01:21:02AM +0530, Krishna Kurapati PSSNV wrote:
> > > > > > On 6/7/2023 5:07 PM, Johan Hovold wrote:
> > > > > 
> > > > > > > So there at least two issues with this series:
> > > > > > > 
> > > > > > > 	1. accessing xhci registers from the dwc3 core
> > > > > > > 	2. accessing driver data of a child device
> > > > > > > 
> > > > > > > 1. The first part about accessing xhci registers goes against the clear
> > > > > > > separation between glue, core and xhci that Felipe tried to maintain.
> > > > > > > 
> > > > > > > I'm not entirely against doing this from the core driver before
> > > > > > > registering the xhci platform device as the registers are unmapped
> > > > > > > afterwards. But if this is to be allowed, then the implementation should
> > > > > > > be shared with xhci rather than copied verbatim.
> > > 
> > > The core will just be looking at the HW capability registers and
> > > accessing the ports capability. Our programming guide also listed the
> > > host capability registers in its documentation. We're not driving the
> > > xhci controller here. We're initializing some of the core configs base
> > > on its capability.
> > > 
> > > We're duplicating the logic here and not exactly doing it verbatim.
> > > Let's try not to share the whole xhci header where we should not have
> > > visibility over. Perhaps it makes sense in some other driver, but let's
> > > not do it here.
> > 
> > The patch series even copied the kernel doc verbatim. This is just not
> > the way things are supposed to be done upstream. We share defines and
> > implementations all the time, but we should not be making copies of
> > them.
> 
>  We had some fixes to the kernel doc as it's incorrect description.
>  Perhaps we can fully rewrite the kernel-doc if that what makes it
>  better.

No, this is an example of why you should not copy code (and docs)
around, for example, so you don't have to fix the same bug (or typo) in
multiple places.

> We can share define implementations if they are meant to be
>  shared. However, with the current way xhci header is implemented, it's
>  not meant to be shared with dwc3. You agreed that we are violating this
>  in some driver, but you're also insistent that we should not duplicate
>  the logic to avoid this violation. Perhaps I'm not a maintainer here
>  long enough to know some violation is better kept. If sharing the xhci
>  header is what it takes to get this through, then fine.

Just because no-one has used these outside of xhci today, doesn't mean
that you should copy the defines once they are needed outside that
driver.

And in fact, they are used outside of the xhci driver proper already
today, only that people took the lazy approach and shared the inline
helper for that.

> > > > > > > 
> > > > > > > The alternative that avoids this issue entirely could indeed be to
> > > > > > > simply count the number of PHYs described in DT as Rob initially
> > > > > > > suggested. Why would that not work?
> > > 
> > > See below.
> > > 
> > > > > > > 
> > > > > > The reason why I didn't want to read the Phy's from DT is explained in
> > > > > > [1]. I felt it makes the code unreadable and its very tricky to read the
> > > > > > phy's properly, so we decided we would initialize phy's for all ports
> > > > > > and if a phy is missing in DT, the corresponding member in
> > > > > > dwc->usbX_generic_phy[] would be NULL and any phy op on it would be a NOP.
> > > > > 
> > > > > That doesn't sound too convincing. Can't you just iterate over the PHYs
> > > > > described in DT and determine the maximum port number used for HS and
> > > > > SS?
> > > > > > Also as per Krzysztof suggestion on [2], we can add a compatible to read
> > > > > > number of phy's / ports present. This avoids accessing xhci members
> > > > > > atleast in driver core. But the layering violations would still be present.
> > > > > 
> > > > > Yes, but if the information is already available in DT it's better to use
> > > > > it rather than re-encode it in the driver.
> > 
> > > >   Are you suggesting that we just do something like
> > > > num_ports = max( highest usb2 portnum, highest usb3 port num)
> > > 
> > > Why do we want to do this? This makes num_ports ambiguous. Let's not
> > > sacrifice clarity for some lines of code.
> > 
> > This is not about lines of code, but avoiding the bad practice of
> > copying code around and, to some degree, maintaining the separation
> > between the glue, core, and xhci which Felipe (perhaps mistakingly) has
> > fought for.
> 
> We're talking about combining num_usb3_ports and num_usb2_ports here,
> what does that have to do with layer separation?

I mentioned this is as an alternative if you're are hell-bent on not
reusing the xhci register defines and parsing code.

> > If you just need to know how many PHYs you have in DT so that you can
> > iterate over that internal array, you can just look at the max index in
> > DT where the indexes are specified in the first place.
> > 
> > Don't get hung up on the current variable names, those can be renamed to
> > match the implementation. Call it max_ports or whatever.
> 
> It doesn't matter what variable name is given, it doesn't change the
> fact that this "num_ports" or "max_ports" obfuscated usb2 vs usb3 ports
> just for this specific implementation. So, don't do that.

Ok, then make sure you reuse the xhci implementation for that then.

> > > > If so, incase the usb2 phy of quad port controller is missing in DT, we
> > > > would still read num_usb2_ports as 4 but the usb2_generic_phy[1] would be
> > > > NULL and any phy ops would still be NOP. But we would be getting rid of
> > > > reading the xhci registers compeltely in core driver.
> > > > 
> > > > Thinh, Bjorn, can you also let us know your views on this.
> > > > 
> > > > 1. Read:
> > > >   num_usb3_ports = highest usb3 port index in DT
> > > >   num_usb2_ports = max( highest usb2 port index, num_usb3_ports)
> > > > 
> > > > 2. Read the same by parsing xhci registers as done in recent versions of
> > > > this series.
> > > 
> > > DT is not reliable to get this info. As noted, the DT may skip some
> > > ports and still be fine. However, the driver doesn't know which port
> > > reflects which port config index without the exact port count.
> > 
> > That's not correct. DT provides the port indexes already, for example:
> > 
> > 	phy-names = "usb2-port0", "usb3-port0",
> > 		    "usb2-port1", "usb3-port1",
> > 		    "usb2-port2",
> > 		    "usb2-port3";
> > 
> > So if you just need this to iterate over the PHYs all the information
> > needed is here.
> > 
> > If you need to access ports which do not have a PHY described in DT,
> > then this is not going to suffice, but I have not seen anyone claim that
> > that is needed yet.
> 
> Perhaps I misunderstand the conversation. However, there isn't a method
> that everyone's agree on yet regarding DT [*]. Perhaps this indicates it
> may not be the best approach. You can resume the conversation if you
> want to:
> 
> [*] https://lore.kernel.org/linux-usb/9671cade-1820-22e1-9db9-5c9836414908@quicinc.com/#t

This was the approach suggested by Rob, the DT maintainer, in that very
thread IIRC.

> > > More importantly, the host controller that lives on the PCI bus will not
> > > use DT. This can be useful for some re-configurations if the controller
> > > is a PCI device and that goes through the dwc3 code path.
> > 
> > Ok, this is a bit hand wavy, but if this ever turns out to be needed it
> > can also be implemented then.
> 
> What does hand wavy mean? We have case where it's useful outside of
> this, and it would be useful for PCI device too:
> 
> https://lore.kernel.org/linux-usb/20230517233218.rjfmvptrexgkpam3@synopsys.com/

Hand-wavy as in lacking detail which makes it hard to evaluate the
argument.

> > Or just generalise the xhci implementation for parsing these registers
> > and reuse that from the start. (As a bonus you'd shrink the kernel text
> > size by getting rid of that iffy inline implementation.)
> > 
> 
> I don't like the iffy inline function either. We changed that here. To
> rework the xhci header and define its global header seems a bit
> excessive just for dwc3 to get the port capability. Regardless, as I've
> said, if we _must_, perhaps we can just import xhci-ext-caps.h instead
> of the whole xhci.h.

No one said anything about importing the whole of xhci.h.

Johan
