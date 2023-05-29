Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3D7714765
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjE2Jq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjE2JqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:46:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F39D11B;
        Mon, 29 May 2023 02:46:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126255106133.24.openmobile.ne.jp [126.255.106.133])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2C872836;
        Mon, 29 May 2023 11:45:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685353546;
        bh=TT/snRJLAoOn4RVjC28Kh1xo1OqyvjswybFySU26Hp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tabb/LkBabZ6GaiVejXq/7SGPpIv2C0P/IaVHGvrEAat4HXnDHOjIU+VBuhqB8PB9
         o0wNH+QE8BEWT7+1LBrcd0HbrxMj3DULePbjDoXAiahAaknOcS6V8hjPvCIpcG0Jz1
         2JN1CR48M2fRbya6FEVJkWIYljT0ECVitCsoYtOo=
Date:   Mon, 29 May 2023 12:46:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Message-ID: <20230529094607.GN25984@pendragon.ideasonboard.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
 <20230529061714.GA25984@pendragon.ideasonboard.com>
 <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <86bki3cxm2.wl-maz@kernel.org>
 <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59227E69FF1DE67327BDEF77864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 09:39:50AM +0000, Biju Das wrote:
> > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > {modprobe,bind} error
> > 
> > On Mon, 29 May 2023 09:42:34 +0100, Biju Das wrote:
> > >
> > > > Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > > > {modprobe,bind} error
> > > >
> > > > On Fri, May 26, 2023 at 03:36:15PM +0100, Biju Das wrote:
> > > > > Currently {modprobe, bind} after {rmmod, unbind} results in probe failure.
> > > > >
> > > > > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > > > > 00000004 (85070400.usb3drd)
> > > > > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> > > > >
> > > > > Fix this issue by replacing "parent dev"->"dev" as the irq
> > > > > resource is managed by this driver.
> > > >
> > > > If the dev pointer passed to devm_request_irq() is not the correct
> > > > one, how does it work the first time the driver is loaded ?
> > >
> > > + Marc/ Kernel.org to give some feedback on this issue
> > >
> > > I believe there may be a bug in the genirq (kernel/irq) driver.
> > > first time it works ok. Maybe this driver is caching on unload with
> > > null value and comparing with actual one (irq 22) during reload??
> > >
> > > Maybe genirq expert can comment what went wrong here??
> > 
> > You get shouted at because you are registering an interrupt handler for
> > the same IRQ twice,
> 
> This not true. It is registering only one IRQ, but with parent device handle.

It uses devm_request_irq() with the parent device, so the interrupt
handler won't be unregistered when the usb3-peri device is unbound. The
next probe will register the same interrupt handler a second time. This
has nothing to do with genirq, it's related to devm_*.

> > and the interrupt is not configured with the SHARED
> > flag.
> 
> I haven't added SHARED flag as there is only one IRQ registration.
> 
>  If, as I understand it, you only have a single device using this
> > interrupt, then it means your driver is not freeing its interrupt on
> > unload.
> 
> You mean devm_request_irq(ddata->dev..)  doesn't free the resource as
> we have unloaded only child device rather than parent.
> 
> But while parent is active, why genirq is giving error during reload?
> It should show same behaviour like initial probe.
> 
> > And that's probably because the device object used when requesting the
> > interrupt isn't the one you load/unload, as indicated by the message.
> > On the first load of "usb3peri", you register an interrupt with
> > "usb3drd" as the requester device. You then unload "usb3peri", which of
> > course has no effect whatsoever on the interrupt.
> > 
> > You could simply have done a "cat /proc/interrupt" and see that
> > interrupt was still there after unload.
> 
> Yes, interrupt still there after unload.
> 
> With devm_request_irq(ddata->dev..), after unload
> =================================================
> 
> root@rzv2m:~# cat /proc/interrupts | grep usb
>  22:          0     GICv2 274 Level     85070400.usb3drd
>  28:          0     GICv2 278 Level     85070000.usb3peri
> root@rzv2m:~# lsmod
> Module                  Size  Used by
> hd3ss3220              12288  0
> typec                  73728  1 hd3ss3220
> renesas_usb3           32768  1
> i2c_rzv2m              12288  0
> crct10dif_ce           12288  1
> ipv6                  450560  16
> root@rzv2m:~# rmmod hd3ss3220
> root@rzv2m:~# rmmod renesas_usb3
> root@rzv2m:~# cat /proc/interrupts | grep usb
>  22:          0     GICv2 274 Level     85070400.usb3drd
> root@rzv2m:~#
> 
> With devm_request_irq(&pdev->dev..), after unload
> ================================================
> 
> root@rzv2m:~# cat /proc/interrupts | grep usb
>  22:          0     GICv2 274 Level     85070400.usb3drd
>  28:          0     GICv2 278 Level     85070000.usb3peri
> root@rzv2m:~# lsmod
> Module                  Size  Used by
> hd3ss3220              12288  0
> typec                  73728  1 hd3ss3220
> renesas_usb3           32768  1
> crct10dif_ce           12288  1
> i2c_rzv2m              12288  0
> ipv6                  450560  16
> root@rzv2m:~# rmmod hd3ss3220
> root@rzv2m:~# rmmod renesas_usb3
> root@rzv2m:~# cat /proc/interrupts | grep usb
> root@rzv2m:~#
> 
> > So the only bug here is in the handling of the interrupt request. And
> > that bug firmly lies in your code. My "expert" advise is to debug the
> > problem rather than suspecting some random failure modes.
> 
> With devm_request_irq(&pdev->dev..) the above issue is fixed.
> 
> Or
> 
> the correct way is passing SHARED flag with devm_request_irq(ddata ->dev..), 
> as the resource is owned by the parent??

No you shouldn't pass the SHARED flag. This patch is a step in the right
direction, but the proper fix would be to register the interrupt handler
in the usb3drd driver.

-- 
Regards,

Laurent Pinchart
