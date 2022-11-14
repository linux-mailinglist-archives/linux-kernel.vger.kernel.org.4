Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E781628742
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiKNRio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiKNRi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:38:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBF39D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:38:24 -0800 (PST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4N9xNp5ns1z4xYn;
        Tue, 15 Nov 2022 04:38:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N9xNm1mqGz4xG5;
        Tue, 15 Nov 2022 04:38:15 +1100 (AEDT)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     Amit Shah <amit@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2] virtio_console: Introduce an ID allocator for virtual console numbers
Date:   Mon, 14 Nov 2022 18:38:11 +0100
Message-Id: <20221114173811.1977367-1-clg@kaod.org>
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

Replace the next_vtermno global with an ID allocator and start the
allocation at 1 as it is today. Also recycle IDs when a console port
is removed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/char/virtio_console.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9fa3c76a267f..c1e2f3d138c7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/splice.h>
 #include <linux/pagemap.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/poll.h>
@@ -48,22 +49,11 @@ struct ports_driver_data {
 	/* List of all the devices we're handling */
 	struct list_head portdevs;
 
-	/*
-	 * This is used to keep track of the number of hvc consoles
-	 * spawned by this driver.  This number is given as the first
-	 * argument to hvc_alloc().  To correctly map an initial
-	 * console spawned via hvc_instantiate to the console being
-	 * hooked up via hvc_alloc, we need to pass the same vtermno.
-	 *
-	 * We also just assume the first console being initialised was
-	 * the first one that got used as the initial console.
-	 */
-	unsigned int next_vtermno;
-
 	/* All the console devices handled by this driver */
 	struct list_head consoles;
 };
-static struct ports_driver_data pdrvdata = { .next_vtermno = 1};
+
+static struct ports_driver_data pdrvdata;
 
 static DEFINE_SPINLOCK(pdrvdata_lock);
 static DECLARE_COMPLETION(early_console_added);
@@ -89,6 +79,8 @@ struct console {
 	u32 vtermno;
 };
 
+static DEFINE_IDA(vtermno_ida);
+
 struct port_buffer {
 	char *buf;
 
@@ -1244,8 +1236,11 @@ static int init_port_console(struct port *port)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->cons.vtermno = pdrvdata.next_vtermno;
+	ret = ida_alloc_range(&vtermno_ida, 1, ~0, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
 
+	port->cons.vtermno = ret;
 	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(port->cons.hvc)) {
 		ret = PTR_ERR(port->cons.hvc);
@@ -1255,7 +1250,6 @@ static int init_port_console(struct port *port)
 		return ret;
 	}
 	spin_lock_irq(&pdrvdata_lock);
-	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 	port->guest_connected = true;
@@ -1532,6 +1526,7 @@ static void unplug_port(struct port *port)
 		list_del(&port->cons.list);
 		spin_unlock_irq(&pdrvdata_lock);
 		hvc_remove(port->cons.hvc);
+		ida_free(&vtermno_ida, port->cons.vtermno);
 	}
 
 	remove_port_data(port);
-- 
2.38.1

