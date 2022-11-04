Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37313619724
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiKDNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKDNKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:10:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2A42CDDA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:10:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSw-0000Yo-Sl; Fri, 04 Nov 2022 14:10:34 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSx-002HHl-3T; Fri, 04 Nov 2022 14:10:34 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oqwSv-004043-44; Fri, 04 Nov 2022 14:10:33 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] usb: gadget: u_ether: Do not make UDC parent of the net device
Date:   Fri,  4 Nov 2022 14:10:30 +0100
Message-Id: <20221104131031.850850-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221104131031.850850-1-s.hauer@pengutronix.de>
References: <20221104131031.850850-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDC is not a suitable parent of the net device as the UDC can
change or vanish during the lifecycle of the ethernet gadget. This
can be illustrated with the following:

mkdir -p /sys/kernel/config/usb_gadget/mygadget
cd /sys/kernel/config/usb_gadget/mygadget
mkdir -p configs/c.1/strings/0x409
echo "C1:Composite Device" > configs/c.1/strings/0x409/configuration
mkdir -p functions/ecm.usb0
ln -s functions/ecm.usb0 configs/c.1/
echo "dummy_udc.0" > UDC
rmmod dummy_hcd

The 'rmmod' removes the UDC from the just created gadget, leaving
the still existing net device with a no longer existing parent.

Accessing the ethernet device with commands like:

ip --details link show usb0

will result in a KASAN splat:

==================================================================
BUG: KASAN: use-after-free in if_nlmsg_size+0x3e8/0x528
Read of size 4 at addr c5c84754 by task ip/357

CPU: 3 PID: 357 Comm: ip Not tainted 6.1.0-rc3-00013-gd14953726b24-dirty #324
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
 unwind_backtrace from show_stack+0x10/0x14
 show_stack from dump_stack_lvl+0x58/0x70
 dump_stack_lvl from print_report+0x134/0x4d4
 print_report from kasan_report+0x78/0x10c
 kasan_report from if_nlmsg_size+0x3e8/0x528
 if_nlmsg_size from rtnl_getlink+0x2b4/0x4d0
 rtnl_getlink from rtnetlink_rcv_msg+0x1f4/0x674
 rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x1f8
 netlink_rcv_skb from netlink_unicast+0x294/0x478
 netlink_unicast from netlink_sendmsg+0x328/0x640
 netlink_sendmsg from ____sys_sendmsg+0x2a4/0x3b4
 ____sys_sendmsg from ___sys_sendmsg+0xc8/0x12c
 ___sys_sendmsg from sys_sendmsg+0xa0/0x120
 sys_sendmsg from ret_fast_syscall+0x0/0x1c

Solve this by not setting the parent of the ethernet device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/gadget/function/u_ether.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index e06022873df16..8f12f3f8f6eeb 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -798,7 +798,6 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 	net->max_mtu = GETHER_MAX_MTU_SIZE;
 
 	dev->gadget = g;
-	SET_NETDEV_DEV(net, &g->dev);
 	SET_NETDEV_DEVTYPE(net, &gadget_type);
 
 	status = register_netdev(net);
@@ -873,8 +872,6 @@ int gether_register_netdev(struct net_device *net)
 	struct usb_gadget *g;
 	int status;
 
-	if (!net->dev.parent)
-		return -EINVAL;
 	dev = netdev_priv(net);
 	g = dev->gadget;
 
@@ -905,7 +902,6 @@ void gether_set_gadget(struct net_device *net, struct usb_gadget *g)
 
 	dev = netdev_priv(net);
 	dev->gadget = g;
-	SET_NETDEV_DEV(net, &g->dev);
 }
 EXPORT_SYMBOL_GPL(gether_set_gadget);
 
-- 
2.30.2

