Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956F967579D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjATOn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjATOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA05D05F9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674225633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9nhE1NTwmfnVWve8AVaEOn2Xi0Qdr1U6uub8XxZ9tg=;
        b=Wmnkhd6zmZ2F4OPXTY4JwDCp7kqEgysKSdwrJoadcmUHbCYWoDZZjoAqehhldAfXffTKY5
        8d7xVQWmFFdbM/E800kd3i6l3pM/X/0FWAuezB65Xt1D48IWsAQQ7hfqgHI65lua04imzj
        FHO1/lMFHXcsNDtJtKsbTjUQWRTx0kE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-RCXY-B3cPN2Fei7DUaPk0Q-1; Fri, 20 Jan 2023 09:37:22 -0500
X-MC-Unique: RCXY-B3cPN2Fei7DUaPk0Q-1
Received: by mail-ot1-f71.google.com with SMTP id a4-20020a9d5c84000000b00686ab49309fso497978oti.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9nhE1NTwmfnVWve8AVaEOn2Xi0Qdr1U6uub8XxZ9tg=;
        b=FYp+UTTht7XFVItJTX5XwmfXlbz7HUav5QuJ76ELqoF7xUVe/KHE2UC9SKQKzFNxEq
         5dOVNAEi5Uj40UohbUsz5GTxBMLEskTOgj+8jUj9McSEMFM7wbcWp15OvA216OrEiSwr
         uVL9zrAI2DP1ZWW0Q+oC9N5fO6cV1wM+Se9HY8DqkwwCwe+3b2KEgghfOXRwm1Kxpisc
         WCNeC7CWRZ10RJHqz+EC0BBNeWZrCQaFK+JqqTj2sOXfFpJwD8beHboj+zhLAMIAS3n2
         XY3nR+QBLagiDdZI2Ja+OHnDfdQvy/2q2tyonYz4oBHJMJV9Y1U575lw9NsYui/IhPLW
         RdQQ==
X-Gm-Message-State: AFqh2krASXkeRVW2RMQo3JoMGV2G6iCXATWq8dE1sFBNmVPhT9NAsShk
        aPK0YTxryDljYqPjKMvxq8fCMdRQZcJMHm4quFQD5rY8o95PI/F6HagwHEsqgxrCwC/B5fd6fDT
        PzYmwQyc9mcQsJw+nTorweOAP
X-Received: by 2002:a05:6870:670b:b0:15e:ee5d:8696 with SMTP id gb11-20020a056870670b00b0015eee5d8696mr8538133oab.54.1674225441691;
        Fri, 20 Jan 2023 06:37:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvmxHEs7IOvDmv8B1cEtpfFCbjcPfnzN4JydFfzpBKL4PxeXf4/AeFJ0ZIFP0QhuQtGCobjzQ==
X-Received: by 2002:a05:6870:670b:b0:15e:ee5d:8696 with SMTP id gb11-20020a056870670b00b0015eee5d8696mr8538105oab.54.1674225441379;
        Fri, 20 Jan 2023 06:37:21 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id t17-20020a056871055100b001447602267esm21583208oal.41.2023.01.20.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:37:20 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:37:17 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
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
        quic_shazhuss@quicinc.com
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Message-ID: <20230120143717.ikbcb6x7wl4yy5d7@halaney-x13s>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119220942.ja5gbo3t3fl63gpy@halaney-x13s>
 <8f32c2e5-2743-1017-6a33-4849021c5287@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f32c2e5-2743-1017-6a33-4849021c5287@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 07:25:57AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 1/20/2023 3:39 AM, Andrew Halaney wrote:
> > On Sun, Jan 15, 2023 at 05:11:43PM +0530, Krishna Kurapati wrote:
> > > Currently the DWC3 driver supports only single port controller
> > > which requires at most one HS and one SS PHY.
> > > 
> > > But the DWC3 USB controller can be connected to multiple ports and
> > > each port can have their own PHYs. Each port of the multiport
> > > controller can either be HS+SS capable or HS only capable
> > > Proper quantification of them is required to modify GUSB2PHYCFG
> > > and GUSB3PIPECTL registers appropriately.
> > > 
> > > Add support for detecting, obtaining and configuring phy's supported
> > > by a multiport controller and limit the max number of ports
> > > supported to 4.
> > > 
> > > Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > >   drivers/usb/dwc3/core.c | 304 +++++++++++++++++++++++++++++-----------
> > >   drivers/usb/dwc3/core.h |  15 +-
> > >   drivers/usb/dwc3/drd.c  |  14 +-
> > >   3 files changed, 244 insertions(+), 89 deletions(-)
> > > 
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 476b63618511..7e0a9a598dfd 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > 
> > <snip>
> > 
> > > @@ -1575,6 +1690,21 @@ static void dwc3_get_properties(struct dwc3 *dwc)
> > >   	dwc->dis_split_quirk = device_property_read_bool(dev,
> > >   				"snps,dis-split-quirk");
> > > +
> > > +	/*
> > > +	 * If no mulitport properties are defined, default
> > > +	 * the port count to '1'.
> > > +	 */
> > > +	ret = device_property_read_u32(dev, "num-ports",
> > > +				&dwc->num_ports);
> > > +	if (ret)
> > > +		dwc->num_ports = 1;
> > > +
> > > +	ret = device_property_read_u32(dev, "num-ss-ports",
> > > +				&dwc->num_ss_ports);
> > > +	if (ret)
> > > +		dwc->num_ss_ports = 1;
> > 
> > By using this DT property instead of using the number of each phy type you
> > find you can get into situations where you're writing DWC3_GUSB2PHYCFG, etc,
> > when there's no phy to go along with it.
> > 
> Hi Andrew,
> 
>  Thanks for the review. Yes, this decoupling is still there and its fine I
> believe.
> 
> > I ran into this when testing on sa8540p-ride, which only uses one of the
> > ports on the multiport controller. I didn't enable the other phys (not
> > sure if that was smart or not) and overrode phy-names/phys, but did not
> > override num-ports/num-ss-ports, which resulted in that. Nothing bad
> > happened on a quick test.. but I thought I'd highlight that as another
> > downside of decoupling this value from the number of phys you grab.
> > 
> If we do not override phy-names or num-ports/num-ss-ports info in DT, they
> are just defaulted to '1' and as per the current logic only port-1 registers
> must be configured. Isn't that the case happening ?
> 

In my dts I'm inheriting from the sc8280xp.dtsi usb_2 phandle you've created!
So unless I override them I get this from your sc8280xp.dtsi:

+                       usb_2_dwc3: usb@a400000 {
+                               compatible = "snps,dwc3";
+                               reg = <0 0x0a400000 0 0xcd00>;
+                               interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+                               iommus = <&apps_smmu 0x800 0x0>;
+                               num-ports = <4>;
+                               num-ss-ports = <2>;
+                               phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
+                                       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
+                                       <&usb_2_hsphy2>,
+                                       <&usb_2_hsphy3>;
+                               phy-names = "usb2-phy_port0", "usb3-phy_port0",
+                                               "usb2-phy_port1", "usb3-phy_port1",
+                                               "usb2-phy_port2",
+                                               "usb2-phy_port3";
+                       };

Since this board only uses one port of the multiport controller, I
redefined phys/phy-names to indicate that. I figured that was more
desireable than enabling unnecessary phys. Without overriding
num-ports/num-ss-ports all the for loops in this patch would act like
the values were 4 and 2 respectively, writing to DWC3_GUSB2PHYCFG
multiple times etc as well as look for the multiport phy-names and fail
to actually get any phys. Hope that makes sense!

> > Here's a patch enabling sa8540p-ride, I'd love if you'd add it to the
> > series (probably needs clean up after review, and will definitely need
> > alteration after you update the dt-binding again). If not I'll continue
> > to test/review so please CC me!:
> > 
> > 
> Sure, I can add this patch (probably will add the other phy's too) during
> the final submission.

I don't have a great understanding of the mapping of the phys to
physical connections (as well as what registers like DWC3_GUSB2PHYCFG do),
so if it makes more sense to enable all the relevant SoC phys, write
those registers in the DWC3 IP, etc, and only use one of the actual
board outputs then feel free. I think this is a good example of "what if
a board designer only uses a single port of the multiport IP" imo.

> 
> >  From dcb27d07f079194ebd7efe1c9bec64da78beb290 Mon Sep 17 00:00:00 2001
> > From: Andrew Halaney <ahalaney@redhat.com>
> > Date: Thu, 19 Jan 2023 14:53:38 -0600
> > Subject: [PATCH] arm64: dts: qcom: sa8540p-ride: Enable usb_2
> > Content-type: text/plain
> > 
> > There is now support for the multiport USB controller this uses
> > so enable it.
> > 
> > The board only has a single port hooked up (despite it being wired up to
> > the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> > which by default on boot is selected to mux properly. Grab the gpio
> > controlling that and ensure it stays in the right position so USB 2.0
> > continues to be routed from the external port to the SoC.
> > 
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> >   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 24 +++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > index 97957f3baa64..56d4f43faa1e 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > @@ -246,6 +246,21 @@ &usb_0_qmpphy {
> >   	status = "okay";
> >   };
> > +&usb_2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&usb2_en_state>;
> > +
> > +	status = "okay";
> > +};
> > +
> > +&usb_2_dwc3 {
> > +	dr_mode = "host";
> > +	num-ports = <1>;
> > +	num-ss-ports = <1>;
> 
> More over, if this is a multiport controller and you are using only port-1,
> it is as good as a single port controller I believe and the normal DT
> convention must work. Adding these properties as "1" is not required as the
> driver logic defaults them to "1" if they are not found.

See above comment about inheriting from sc8280xp.dtsi and needing to
override their values.

> 
> Just to add a point here (as I was not clear in DT Binding description, My
> bad), the num-ports and num-ss-ports must indicate the HS/SS Phys present on
> HW whether they are used in DT or not. Just to cover all cases which user
> can use [1].
> 
> []1:
> https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/

Ok, if you're going with that approach of "must indicate the HS/SS Phys
present on HW whether they are used in the DT or not" (/me assumes DT
here means on the board and not an incorrect coding of the DT) then I
suppose I should not have overridden anything but phys/phy-names to
indicate that I'm only using the first port (and used the multiport
phy-names convention). It looks like in that link you also mention that
it is ok to write to DWC3_GUSB2PHYCFG and friends even if the phy isn't
defined, which was my concern and reasoning above for overriding
num-ports/num-ss-ports.

Thanks,
Andrew

> 
> Regards,
> Krishna,
> 
> > +	phy-names = "usb2-phy", "usb3-phy";
> > +	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> > +};
> > +
> >   &usb_2_hsphy0 {
> >   	vdda-pll-supply = <&vreg_l5a>;
> >   	vdda18-supply = <&vreg_l7g>;
> > @@ -313,4 +328,13 @@ wake-pins {
> >   			bias-pull-up;
> >   		};
> >   	};
> > +
> > +	usb2_en_state: usb2-en-state {
> > +		/* TS3USB221A USB2.0 mux select */
> > +		pins = "gpio24";
> > +		function = "gpio";
> > +		drive-strength = <2>;
> > +		bias-disable;
> > +		output-low;
> > +	};
> >   };
> 

