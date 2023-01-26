Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651FB67C8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjAZKsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjAZKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:47:53 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD416DB03
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674730040;
  x=1706266040;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=DTva1Ssx8kQR67UOp6qZggMijTqQjiAsgHXYRC030jE=;
  b=I2ZWaQOk6bU/Nd6BCT8j80XcRToccrvCql6EwOOBt1+2+z7rkk6Cdii/
   ry+4LCLBnk4Nb0MCmmosUHDta7VDCt7cpjKv4H3tSWY0lTq/gLjZcKSA3
   szilsBq3DXxTbpNKwiO9AT4I8DqbEohvJH0fuJ+jhtrmHXSfnXCzZaGp8
   81Xw0JkAzmp+q8cgMEi3fxtTklJxC7z5bfcN4DZ6+fZgw+NzqQVYJWktY
   MqLOvr36mFU7njXC2jpbV/bf8K0x0wtzfc/VC88zsZsE57jMjexn2qQDp
   1k/1S5M2l5jbbg4gpFRvcEyzpY9YNUJRq5TS8qszLQgAQQ0H6JE39vZJS
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 26 Jan 2023 11:47:10 +0100
Subject: [PATCH] um-virt-pci: Make max delay configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230126-uml-pci-delay-v1-1-015ed7e93ef2@axis.com>
X-B4-Tracking: v=1; b=H4sIAC1a0mMC/x2NwQqDMBAFf0X27EKMVLC/UnrYxKcuaBoSLS3iv
 zf2OAPDHJSRFJnu1UEJb836CgWauiI/S5jAOhQma2xrGtvxvi4cvfKARb5spff9rTWA66g0TjL
 YJQl+vqptjZeNCaN+/pfH8zx/c6Z7+nUAAAA=
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a hard coded maximum time for which the driver busy-loops
waiting for a response from the virtio device.  This default time may be
too short for some systems, so make it a module parameter so that it can
be set via the kernel command line.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/drivers/virt-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..33183f6f9f2a 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -54,7 +54,8 @@ static struct irq_domain *um_pci_inner_domain;
 static struct irq_domain *um_pci_msi_domain;
 static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
 
-#define UM_VIRT_PCI_MAXDELAY 40000
+static unsigned int um_pci_max_delay_us = 40000;
+module_param_named(max_delay_us, um_pci_max_delay_us, uint, 0644);
 
 struct um_pci_message_buffer {
 	struct virtio_pcidev_msg hdr;
@@ -155,7 +156,7 @@ static int um_pci_send_cmd(struct um_pci_device *dev,
 			kfree(completed);
 
 		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
-			      ++delay_count > UM_VIRT_PCI_MAXDELAY,
+			      ++delay_count > um_pci_max_delay_us,
 			      "um virt-pci delay: %d", delay_count)) {
 			ret = -EIO;
 			break;

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230126-uml-pci-delay-2a9c9530eeb6

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

