Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E000665756
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbjAKJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238265AbjAKJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:23:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5E55B5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:23:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 864E061B09
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A93EC433EF;
        Wed, 11 Jan 2023 09:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673429019;
        bh=dTTaAik2iuROvGKutaqmebDbgw2ZXRTF7C33HqtfJ2E=;
        h=From:To:Cc:Subject:Date:From;
        b=0cvF9nRKxg/erANAcIIfvfCMNOF7QkL+8j3RhNN6wszbTKwT//RVssP+T6Ma4lR0V
         VimaMflxdYshNGxbtfq5C8+hFOrSxzJ8gGIi+4wTx+WYY5KHagfgQnhWHU53NhVyJn
         nTW+Q2ZzEXD9azwLT/qRAfT6+TsAGmolHsRlupNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 1/2] driver core: bus.h: document bus notifiers better
Date:   Wed, 11 Jan 2023 10:23:30 +0100
Message-Id: <20230111092331.3946745-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3468; i=gregkh@linuxfoundation.org; h=from:subject; bh=dTTaAik2iuROvGKutaqmebDbgw2ZXRTF7C33HqtfJ2E=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn7GgRPLTyz49ltU3Eund72hJ/7+vnfxU/On7B/xRnLMCU9 5+tZHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARlkKG2ex+S89l18YtUeT73sD/Oe DspEyJLwzzA5IVoi6+eXVrm6lT6bT6O1K29Ts9AQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus notifier values are not documented all that well, so clean this
up and make a real enumerated type for them and document them much
better.  When doing this, remove the hex values and just rely on the
enumerated type instead as that is all that is needed.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: - fix up the documentation to be proper kernel-doc format thanks to
      Randy.
    - Remove the values entirely now that this is an enumerated type,
      they are not needed.

v2: - move the values to decimal from hex as pointed out by Rafael.

 include/linux/device/bus.h | 42 +++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d529f644e92b..7b4a48b5159b 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -257,21 +257,35 @@ extern int bus_register_notifier(struct bus_type *bus,
 extern int bus_unregister_notifier(struct bus_type *bus,
 				   struct notifier_block *nb);
 
-/* All 4 notifers below get called with the target struct device *
- * as an argument. Note that those functions are likely to be called
- * with the device lock held in the core, so be careful.
+/**
+ * enum bus_notifier_event - Bus Notifier events that have happened
+ * @BUS_NOTIFY_ADD_DEVICE: device is added to this bus
+ * @BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
+ * @BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
+ * @BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
+ * @BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
+ * @BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
+ * @BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
+ * @BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
+ *
+ * These are the value passed to a bus notifier when a specific event happens.
+ *
+ * Note that bus notifiers are likely to be called with the device lock already
+ * held by the driver core, so be careful in any notifier callback as to what
+ * you do with the device structure.
+ *
+ * All bus notifiers are called with the target struct device * as an argument.
  */
-#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
-#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
-#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
-#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
-						      bound */
-#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
-#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
-						      unbound */
-#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
-						      from the device */
-#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
+enum bus_notifier_event {
+	BUS_NOTIFY_ADD_DEVICE,
+	BUS_NOTIFY_DEL_DEVICE,
+	BUS_NOTIFY_REMOVED_DEVICE,
+	BUS_NOTIFY_BIND_DRIVER,
+	BUS_NOTIFY_BOUND_DRIVER,
+	BUS_NOTIFY_UNBIND_DRIVER,
+	BUS_NOTIFY_UNBOUND_DRIVER,
+	BUS_NOTIFY_DRIVER_NOT_BOUND,
+};
 
 extern struct kset *bus_get_kset(struct bus_type *bus);
 
-- 
2.39.0

