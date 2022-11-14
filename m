Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3220627717
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiKNIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiKNIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:08:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B719C08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:08:04 -0800 (PST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4N9hkm3Vtjz4xZ3;
        Mon, 14 Nov 2022 19:08:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9hkk1Yjdz4xYV;
        Mon, 14 Nov 2022 19:07:57 +1100 (AEDT)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] virtio_console: Use an atomic to allocate virtual console numbers
Date:   Mon, 14 Nov 2022 09:07:52 +0100
Message-Id: <20221114080752.1900699-1-clg@kaod.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a virtio console port is initialized, it is registered as an hvc
console using a virtual console number. If a KVM guest is started with
multiple virtio console devices, the same vtermno (or virtual console
number) can be used to allocate different hvc consoles, which leads to
various communication problems later on.

This is also reported in debugfs :

  # grep vtermno /sys/kernel/debug/virtio-ports/*
  /sys/kernel/debug/virtio-ports/vport1p1:console_vtermno: 1
  /sys/kernel/debug/virtio-ports/vport2p1:console_vtermno: 1
  /sys/kernel/debug/virtio-ports/vport3p1:console_vtermno: 2
  /sys/kernel/debug/virtio-ports/vport4p1:console_vtermno: 3

Fix the issue with an atomic variable and start the first console
number at 1 as it is today.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/char/virtio_console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9fa3c76a267f..253574f41e57 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -58,12 +58,13 @@ struct ports_driver_data {
 	 * We also just assume the first console being initialised was
 	 * the first one that got used as the initial console.
 	 */
-	unsigned int next_vtermno;
+	atomic_t next_vtermno;
 
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
-static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
+
+static struct ports_driver_data pdrvdata = { .next_vtermno = ATOMIC_INIT(0) };
 
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
@@ -1244,7 +1245,7 @@ static int init_port_console(struct port *port)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->cons.vtermno = pdrvdata.next_vtermno;
+	port->cons.vtermno = atomic_inc_return(&pdrvdata.next_vtermno);
 
 	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->cons.hvc)) {
@@ -1255,7 +1256,6 @@ static int init_port_console(struct port *port)
 		return ret;
 	}
 	spin_lock_irq(&pdrvdata_lock);
-	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
-- 
2.38.1

