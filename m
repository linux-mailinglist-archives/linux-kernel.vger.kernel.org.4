Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95A569050A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBIKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjBIKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:38:13 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BD85DC07;
        Thu,  9 Feb 2023 02:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675939028; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAhPtJ4vBWAnEr416NpnDhVYXkvFOP9NCU+AdWdC5yw=;
        b=uitw+P655/VjMhm309vorYf/mLfx1izhcUPvaN2m0pIa/0hrrb8MpM/MDCo76CJl6wlBjY
        kMxbWPx8f8T3GgRb+6iuhdrROPAM6D5peRpAATm4l2h0zZx3dFcBS82b8Bm70CAAaoj7zd
        nR22X27Aj5NB46mJtsGKrJmsaaXcLZE=
Message-ID: <6d618e518de06854727f26de950404f02ec61c64.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Thu, 09 Feb 2023 10:37:05 +0000
In-Reply-To: <20230209101807.GO10447@pengutronix.de>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
         <20221104131031.850850-2-s.hauer@pengutronix.de>
         <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
         <20230209101807.GO10447@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

Le jeudi 09 f=C3=A9vrier 2023 =C3=A0 11:18 +0100, Sascha Hauer a =C3=A9crit=
=C2=A0:
> Hi Paul,
>=20
> On Wed, Feb 01, 2023 at 01:32:51PM +0000, Paul Cercueil wrote:
> > Hi Sascha, Greg,
> >=20
> > I have a breakage in 6.2-rc* that I eventually bisected to this
> > commit,
> > on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
> > configured through gadgetfs.
> >=20
> > When plugging the board to my PC, the USB network interface is
> > recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
> > reverted on v6.2-rc5, everything works fine.
>=20
> I don't have this hardware available. I just tried with a i.MX
> hardware
> and it works as expected. I have no idea where the jz4740 musb could
> behave differently.
>=20
> Here's exactly what I did:
>=20
> mkdir -p /sys/kernel/config/usb_gadget/mygadget
> cd /sys/kernel/config/usb_gadget/mygadget
> mkdir -p configs/c.1/strings/0x409
> echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
> mkdir -p functions/ecm.usb0
> ln -s functions/ecm.usb0 configs/c.1/
> echo "ci_hdrc.0" > UDC
>=20
> Did you do something differently apart from the "ci_hdrc.0" of
> course?

Nothing very different, no.

I do:

cd /sys/kernel/config/usb_gadget
mkdir mtp \
  mtp/strings/0x409 \
  mtp/configs/c.1 \
  mtp/configs/c.1/strings/0x409 \
  mtp/functions/ffs.mtp \
  mtp/functions/ecm.net \
  mtp/functions/rndis.net

echo 0x80 > mtp/configs/c.1/bmAttributes
echo 500 > mtp/configs/c.1/MaxPower

echo 0x049f > mtp/idVendor
echo 0x505a > mtp/idProduct
echo cdc > mtp/configs/c.1/strings/0x409/configuration
ln -s mtp/functions/ecm.net mtp/configs/c.1/ecm.net

echo ci_hdrc.0 > mtp/UDC

> BTW when you say 'NO-CARRIER' is it on the PC side, board side, or
> both?

PC side. I don't know what it says on the board side, I can't
telnet/SSH.

> It would be great if we could sort this out, but if not I am fine
> with
> reverting this patch. I guess this topic will come back to my desk
> sooner or later then

Considering that the clock is ticking, let's revert it for now; that
will give me some time to debug the issue, and then we can work on a
revised patch.

Cheers,
-Paul
