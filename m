Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48A3686701
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjBANdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBANdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:33:37 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6010412;
        Wed,  1 Feb 2023 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1675258373; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekmClS7nTGX31KzfVxip55KouM9uMZZwUeKntzKmDvQ=;
        b=ounog+gqxhjVFTUY7ZMoX88T95wAGahsxRbXDOjd/zBZcEYLJ30t1DSdWAqCyHNgc/wjbx
        EJ0WnkOKJgc16zyP0QPww01cJmuvGG4kAQJr3K+hnBnPCN59Rj8bNizy2Ap9PGpaqgBFqO
        LJU21W33aXDJ2sxFxmPbYX0NE1YJoSw=
Message-ID: <f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the
 net device
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Wed, 01 Feb 2023 13:32:51 +0000
In-Reply-To: <20221104131031.850850-2-s.hauer@pengutronix.de>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
         <20221104131031.850850-2-s.hauer@pengutronix.de>
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

Hi Sascha, Greg,

I have a breakage in 6.2-rc* that I eventually bisected to this commit,
on a Ingenic SoC (using the jz4740 musb driver) with ECM or RNDIS
configured through gadgetfs.

When plugging the board to my PC, the USB network interface is
recognized, but 'ip link' sees it as 'NO-CARRIER'. With this commit
reverted on v6.2-rc5, everything works fine.

Cheers,
-Paul

Le vendredi 04 novembre 2022 =C3=A0 14:10 +0100, Sascha Hauer a =C3=A9crit=
=C2=A0:
> The UDC is not a suitable parent of the net device as the UDC can
> change or vanish during the lifecycle of the ethernet gadget. This
> can be illustrated with the following:
>=20
> mkdir -p /sys/kernel/config/usb_gadget/mygadget
> cd /sys/kernel/config/usb_gadget/mygadget
> mkdir -p configs/c.1/strings/0x409
> echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
> mkdir -p functions/ecm.usb0
> ln -s functions/ecm.usb0 configs/c.1/
> echo "dummy_udc.0" > UDC
> rmmod dummy_hcd
>=20
> The 'rmmod' removes the UDC from the just created gadget, leaving
> the still existing net device with a no longer existing parent.
>=20
> Accessing the ethernet device with commands like:
>=20
> ip --details link show usb0
>=20
> will result in a KASAN splat:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in if_nlmsg_size+0x3e8/0x528
> Read of size 4 at addr c5c84754 by task ip/357
>=20
> CPU: 3 PID: 357 Comm: ip Not tainted 6.1.0-rc3-00013-gd14953726b24-
> dirty #324
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> =C2=A0unwind_backtrace from show_stack+0x10/0x14
> =C2=A0show_stack from dump_stack_lvl+0x58/0x70
> =C2=A0dump_stack_lvl from print_report+0x134/0x4d4
> =C2=A0print_report from kasan_report+0x78/0x10c
> =C2=A0kasan_report from if_nlmsg_size+0x3e8/0x528
> =C2=A0if_nlmsg_size from rtnl_getlink+0x2b4/0x4d0
> =C2=A0rtnl_getlink from rtnetlink_rcv_msg+0x1f4/0x674
> =C2=A0rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x1f8
> =C2=A0netlink_rcv_skb from netlink_unicast+0x294/0x478
> =C2=A0netlink_unicast from netlink_sendmsg+0x328/0x640
> =C2=A0netlink_sendmsg from ____sys_sendmsg+0x2a4/0x3b4
> =C2=A0____sys_sendmsg from ___sys_sendmsg+0xc8/0x12c
> =C2=A0___sys_sendmsg from sys_sendmsg+0xa0/0x120
> =C2=A0sys_sendmsg from ret_fast_syscall+0x0/0x1c
>=20
> Solve this by not setting the parent of the ethernet device.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =C2=A0drivers/usb/gadget/function/u_ether.c | 4 ----
> =C2=A01 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/function/u_ether.c
> b/drivers/usb/gadget/function/u_ether.c
> index e06022873df16..8f12f3f8f6eeb 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -798,7 +798,6 @@ struct eth_dev *gether_setup_name(struct
> usb_gadget *g,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0net->max_mtu =3D GETHER_M=
AX_MTU_SIZE;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->gadget =3D g;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_NETDEV_DEV(net, &g->dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_NETDEV_DEVTYPE(net, &=
gadget_type);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D register_netde=
v(net);
> @@ -873,8 +872,6 @@ int gether_register_netdev(struct net_device
> *net)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct usb_gadget *g;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!net->dev.parent)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D netdev_priv(net);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0g =3D dev->gadget;
> =C2=A0
> @@ -905,7 +902,6 @@ void gether_set_gadget(struct net_device *net,
> struct usb_gadget *g)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev =3D netdev_priv(net);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->gadget =3D g;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0SET_NETDEV_DEV(net, &g->dev);
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(gether_set_gadget);
> =C2=A0

