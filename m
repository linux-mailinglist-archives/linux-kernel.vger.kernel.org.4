Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D78A65CFD2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjADJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239196AbjADJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:36:57 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD813D7B;
        Wed,  4 Jan 2023 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672825006; x=1704361006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsO1CZD+vUD12bKyw7wW0FNLGseH7jcJ3bw7kLzGUSQ=;
  b=VNK4dQ8/N0MZ/zWZWsvUNv51Boni+6NdrVF7XnRRg6Prv5z8megvVr5/
   UmIBM9cSb4h4Q1DcJuDDLL2uiUYZutw1BTra1jBIWgJMFVcHUhOHRe17a
   0SxMYBfcVFDx+nJ7cGMrtW3GFomZpztv28WofhFcl9eNSkChtze+9757X
   KZMnis8KbtAN5rE5/UiRoBCldkUvCJEHs1qbQ39WnrF6Xt28Pv1WG3DGX
   VaCmi8G1Epg9HsCQsgQC0FfTbKLgyuD0Uye3zedgxZPcxobn0cVJ1Y6ky
   AFE/mpC28hJJWJSsoN78QWb0KiExcFwP6QRB7WGDQTvL2gOcN+lGLHQsp
   g==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28236837"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Jan 2023 10:36:44 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 04 Jan 2023 10:36:44 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 04 Jan 2023 10:36:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672825004; x=1704361004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsO1CZD+vUD12bKyw7wW0FNLGseH7jcJ3bw7kLzGUSQ=;
  b=gn0saoMwQtXJXxzx5B9uwfhdvQQjCgddU79p4wnAJ+N9I7HtNKxhDku8
   /8Wv+TdQ8imM8hiNkf5HfD025TY90sNf9cMVTKj4dLgfvrlWqDYUBx2ho
   TTbA7ZOIdP0K7ITPEoA2Or0pUSiIwfZDxpfwDOQeBDF+5wyptSVZHIziE
   dlbTdH5AylVkG4bS0ugVTz54nJaG1nc3y15gEpuK5uQsCrk9BaaPz/dTk
   8IKDkUuITIf8QkY9RlTKhkf2w/BwALF21UFBF7glUs5xNDnbyr8WpUEp6
   JGC4TbbP/8D3drshxBpFMtrGtIIXrSS4bb3E1DgzGG30Y+o0W01CnV7fb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,299,1665439200"; 
   d="scan'208";a="28236836"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Jan 2023 10:36:44 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1E958280056;
        Wed,  4 Jan 2023 10:36:44 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v1 03/11] arm64: dts: amlogic: Used onboard usb hub reset on odroid c2
Date:   Wed, 04 Jan 2023 10:36:41 +0100
Message-ID: <2188024.ZfL8zNpBrT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com> <CANAwSgTS+j_oRrckwmi60afX6-D=OP0oy05m3eQga_gEZJJ_mg@mail.gmail.com> <CANAwSgTc=uGyZ0H_-ZckYoKztMB--DRfx7apBtP9zAbAU1XTvA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Januar 2023, 09:13:21 CET schrieb Anand Moon:
> Hi Martin,
> 
> On Wed, 28 Dec 2022 at 20:14, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Martin,
> > 
> > On Wed, 28 Dec 2022 at 18:21, Martin Blumenstingl
> > 
> > <martin.blumenstingl@googlemail.com> wrote:
> > > Hi Anand,
> > 
> > Thanks for your review comments.
> > 
> > > thank you for working on this topic!
> > > 
> > > On Wed, Dec 28, 2022 at 11:05 AM Anand Moon <linux.amoon@gmail.com>
> > > wrote:
> > > [...]
> > > 
> > > > +       usb {
> > > > +               dr_mode = "host";
> > > > +               #address-cells = <1>;
> > > > +               #size-cells = <0>;
> > > > +
> > > > +               hub@1 {
> > > > +                       /* Genesys Logic GL852G-OHG usb hub */
> > > > +                       compatible = "genesys,usb5e3,610";
> > > > +                       reg = <1>;
> > > > +                       vdd-supply = <&usb_otg_pwr>;
> > > > +                       reset-gpio = <&gpio_ao GPIOAO_4
> > > > GPIO_ACTIVE_LOW>;
> > > > +               };
> > > > +       };
> > > 
> > > My understanding is that the hub@1 node should be part of the
> > > corresponding USB controller node, not a new node.
> > > In this case hub@1 should go into the existing &usb1 node. That way we
> > > describe the way the hardware is set up (meaning: hub@1 is connected
> > > to &usb1).
> > 
> > Ok, I will move this code under &usb0 and &usb1 nodes.
> > 
> > onboard_usb_hub module just assists in usb hub reset.
> > so these changes are meant to replace the gpio-hog.
> > 
> > $ dmesg | grep onboard
> > [    5.405558] usbcore: registered new device driver onboard-usb-hub
> > [    6.383428] onboard-usb-hub 1-1: reset high-speed USB device number
> > 2 using dwc2
> > 
> > Here is the boot log of the odroid c2 [0] https://pastebin.com/PFy5waPb
> 
> Moving the usb hub into usb subnode usb0 or usb1 does not work
> on Odroid n2 and c4, we have a combo phys of usb 2.0 and usb 3.0
> so the onboard usb hub reset does not get initialized until both the PHY
> and USB nodes are brought up by the drivers.
> 
> # On Odroid n2 has a combo hub
> alarm@odroid-n2:~$ lsusb -tv
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     ID 1d6b:0003 Linux Foundation 3.0 root hub
> 
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
> 
>         ID 05e3:0620 Genesys Logic, Inc. GL3523 Hub
> 
>         |__ Port 1: Dev 5, If 0, Class=Mass Storage, Driver=usb-storage,
>         |5000M
> 
>             ID 174c:5106 ASMedia Technology Inc. ASM1051 SATA 3Gb/s bridge
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
>     ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> 
>         ID 05e3:0610 Genesys Logic, Inc. Hub
> 
>         |__ Port 2: Dev 4, If 0, Class=Vendor Specific Class,
> 
> Driver=ax88179_178a, 480M
>             ID 0b95:1790 ASIX Electronics Corp. AX88179 Gigabit Ethernet
> 
> # Odroid C4 also has a combo hub
> 
> alarm@odroid-c4:~$ lsusb -tv
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
>     ID 1d6b:0003 Linux Foundation 3.0 root hub
> 
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
> 
>         ID 2109:0817 VIA Labs, Inc.
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/2p, 480M
>     ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
>     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> 
>         ID 2109:2817 VIA Labs, Inc.
> 
> So I will continue to work with this usb hub node to do a proper reset
> of the USB hub.

If your USB hub does both USB2.0 and USB3.0 you need to add both devices in DT 
and reference them using 'peer-hub'property. See ca69b6c78d5d ("arm64: dts: 
tqma8mpql: add support for 2nd USB (host) interface") for a reference.

Best regards,
Alexander

> > > In case hub@1 is not detected within &usb1 then you maym need something
> > > like [0] (not tested for your use-case).
> > > If that helps: feel free to include that patch in your series.
> > 
> > Thanks, will check if this is needed in this case. As of now it just
> > reinitializes the hub.
> > 
> > > Best regards,
> > > Martin
> > > 
> > > 
> > > [0]
> > > https://github.com/xdarklight/linux/commit/d8b96e5bc9c20ab2585194e0e595
> > > 80c3b062c431> 
> > Thanks
> > -Anand
> 
> Thanks
> -Anand
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel




