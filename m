Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627A6907D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBILyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBILxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:53:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EBC68ACE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:41:06 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pQ5IV-0005sb-MX; Thu, 09 Feb 2023 12:41:03 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pQ5IV-0008Ep-Bi; Thu, 09 Feb 2023 12:41:03 +0100
Date:   Thu, 9 Feb 2023 12:41:03 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
Message-ID: <20230209114103.GQ10447@pengutronix.de>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
 <20221104131031.850850-2-s.hauer@pengutronix.de>
 <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
 <20230209101807.GO10447@pengutronix.de>
 <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:37:05AM +0000, Paul Cercueil wrote:
> Hi Sascha,
> 
> Le jeudi 09 février 2023 à 11:18 +0100, Sascha Hauer a écrit :
> > Hi Paul,
> > 
> > On Wed, Feb 01, 2023 at 01:32:51PM +0000, Paul Cercueil wrote:
> > > Hi Sascha, Greg,
> > > 
> > > I have a breakage in 6.2-rc* that I eventually bisected to this
> > > commit,
> > > on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
> > > configured through gadgetfs.
> > > 
> > > When plugging the board to my PC, the USB network interface is
> > > recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
> > > reverted on v6.2-rc5, everything works fine.
> > 
> > I don't have this hardware available. I just tried with a i.MX
> > hardware
> > and it works as expected. I have no idea where the jz4740 musb could
> > behave differently.
> > 
> > Here's exactly what I did:
> > 
> > mkdir -p /sys/kernel/config/usb_gadget/mygadget
> > cd /sys/kernel/config/usb_gadget/mygadget
> > mkdir -p configs/c.1/strings/0x409
> > echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
> > mkdir -p functions/ecm.usb0
> > ln -s functions/ecm.usb0 configs/c.1/
> > echo "ci_hdrc.0" > UDC
> > 
> > Did you do something differently apart from the "ci_hdrc.0" of
> > course?
> 
> Nothing very different, no.
> 
> I do:
> 
> cd /sys/kernel/config/usb_gadget
> mkdir mtp \
>   mtp/strings/0x409 \
>   mtp/configs/c.1 \
>   mtp/configs/c.1/strings/0x409 \
>   mtp/functions/ffs.mtp \
>   mtp/functions/ecm.net \
>   mtp/functions/rndis.net
> 
> echo 0x80 > mtp/configs/c.1/bmAttributes
> echo 500 > mtp/configs/c.1/MaxPower
> 
> echo 0x049f > mtp/idVendor
> echo 0x505a > mtp/idProduct
> echo cdc > mtp/configs/c.1/strings/0x409/configuration
> ln -s mtp/functions/ecm.net mtp/configs/c.1/ecm.net
> 
> echo ci_hdrc.0 > mtp/UDC
> 
> > BTW when you say 'NO-CARRIER' is it on the PC side, board side, or
> > both?
> 
> PC side. I don't know what it says on the board side, I can't
> telnet/SSH.

I just checked on the host side: With or without my patch I get
NO-CARRIER on the host. I have to do a 'ip link set usb0 up' on
the device side, with that I get a <BROADCAST,MULTICAST,UP,LOWER_UP>
on the host side.

Could it be that my patch breaks something on the device side that
prevents the device from bringing the link up?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
