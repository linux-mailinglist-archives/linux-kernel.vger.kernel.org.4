Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54D6462DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLGUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiLGUwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:52:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C238324B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:51:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i19-20020a253b13000000b0070358cca7f7so6306981yba.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5mynKz5oCR+Be228hwbU8PAPBPy+Q/WCZLZqKob1ZyY=;
        b=K9Bw0uYC5EINGJ0SvI1INZ2sag4QfyGThlbB2Zt3HAHUnI+Oa7hKjMuD8YLFZ7rSre
         8Vfp81jZdch4auKOIS1u61VnYeDU7NnBqrKxpgE+pUgzGyPwVy6OytACzzxNXvbpfbWJ
         t9+5kaM+8VllcO/yeRnmvOBDMglyHW0TOwz3ri938gHynFPisQ6u2r+twv7wQzDtSqJx
         UR/lZaYU1G3QIRVxzg4B2jVXa2QRXpjCS7mGEfd/1VJ/VtQbcBNdfz/IOxJCZF8TGI7G
         oOTDv9EBJnYNEcFFJtCBETYRP6vvcZqsLaGhnXCQvaBevfeHIrM+nrmF/lxC5WW6H4LK
         SBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mynKz5oCR+Be228hwbU8PAPBPy+Q/WCZLZqKob1ZyY=;
        b=oRTkmzNvcmFwr4npQzC/np9TM7VEtWYVsp56aqMySM66Rzboqkl1BDtjXWKMInO33Y
         kydjk0eTYE1U15afoNdheyuu5I9BYU3Xlqz8rhXWw9zSI8j5Iti0cUAqBMCZq4JnyzG4
         qUlZIxwlOf/y0qs4kktPNnPXcOYPGHXOMjhBWtq2qvYqg/zMbP7Uxs8mtZGAZOM16nYa
         ed5+jODZB4WaX6Gnnt78q342ygJkY1I3zXU8kBp5X9r4BKTBC1Ux2eE3qCcTRptJAaGO
         QP6QYXx+ke7D3bbWNykfMDga5l+Tnwv38aZ1qz4f/2YXQ6nbLNSqfuLlbrkvUFjWX6VI
         KPpQ==
X-Gm-Message-State: ANoB5pmtKoPYW5bHsigEtR0Z55phVBae6OyBrJYUdwdnOSICknz1VUYy
        fVhkzuVrwH2PIWVmLS6e6tlY4DEwwl4v/KqA
X-Google-Smtp-Source: AA0mqf7cPlRUzlr+/Oy6wGESiWoB3+7782KRnmnJvA592PmfJn3Lznx+GeaN1wDU+VAVXlItkUO0yYI9mFFPX61a
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a25:248d:0:b0:6f1:29d9:44ba with SMTP
 id k135-20020a25248d000000b006f129d944bamr61196926ybk.632.1670446276466; Wed,
 07 Dec 2022 12:51:16 -0800 (PST)
Date:   Wed,  7 Dec 2022 15:50:59 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207205059.3848851-1-zenghuchen@google.com>
Subject: [PATCH] I3C: export SETDASA method
From:   Jack Chen <zenghuchen@google.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because not all I3C drivers have the hot-join feature ready, and
especially not all I3C devices support hot-join feature, exporting
SETDASA method could be useful. With this function, the I3C controller
could perform a DAA to I3C devices when users decide to turn these I3C
devices off and on again during run-time.

Tested: This change has been tested with turnning off an I3C device and
turning on it again during run-time. The device driver calls SETDASA
method to perform DAA to the device. And communication between I3C
controller and device is set up again correctly.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/i3c/device.c       | 20 ++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 19 +++++++++++++++++++
 include/linux/i3c/device.h |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index e92d3e9a52bd..9762630b917e 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -50,6 +50,26 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
 
+/**
+ * i3c_device_do_setdasa() - do I3C dynamic address assignement with
+ *                           static address
+ *
+ * @dev: device with which the DAA should be done
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_setdasa(struct i3c_device *dev)
+{
+	int ret;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	ret = i3c_dev_setdasa_locked(dev->desc);
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_setdasa);
+
 /**
  * i3c_device_get_info() - get I3C device information
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 86b7b44cfca2..908a807badaf 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -15,6 +15,7 @@ extern struct bus_type i3c_bus_type;
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
 
+int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
 int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 				 struct i3c_priv_xfer *xfers,
 				 int nxfers);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 351c81a929a6..d7e6f6c99aea 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2708,6 +2708,25 @@ int i3c_master_unregister(struct i3c_master_controller *master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_unregister);
 
+int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master;
+
+	if (!dev)
+		return -ENOENT;
+
+	master = i3c_dev_get_master(dev);
+	if (!master)
+		return -EINVAL;
+
+	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
+		!dev->boardinfo->static_addr)
+		return -EINVAL;
+
+	return i3c_master_setdasa_locked(master, dev->info.static_addr,
+						dev->boardinfo->init_dyn_addr);
+}
+
 int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 				 struct i3c_priv_xfer *xfers,
 				 int nxfers)
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 8242e13e7b0b..90b6e0f7d29f 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -293,6 +293,8 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
 			     int nxfers);
 
+int i3c_device_do_setdasa(struct i3c_device *dev);
+
 void i3c_device_get_info(struct i3c_device *dev, struct i3c_device_info *info);
 
 struct i3c_ibi_payload {
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

