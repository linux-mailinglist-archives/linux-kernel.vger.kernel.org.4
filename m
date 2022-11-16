Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5909E62BE91
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiKPMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiKPMsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:48:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5B18B0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668602887; x=1700138887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtjJY8WUHA0UfMfzWojcbNghwS6nz/adrzvmlpTi4tI=;
  b=a9aosJ69Z4eX5sXO2PKrP/S97W2/C/np1pcXCw/ODq0l2mBXmS2pGoko
   IXPu4BZin1HaYchrpYZmvCwS0IzIq/AtsECwzJmstvtGNkv8m/o/Yc7rw
   EglAbOFwk4GtsdfrREnFoxi5OQm2VavGjEqVwTtuBpy3tOB1y6iR8Ve0X
   SseVTIKo1n3UxZESrmk0qsInJoNKqJ5ak0Y2fxGp5+0y7Z1i6FcQc7ek5
   WHDO2IQU/Y8P6Sj8ifVEnK7sshdgas6uHiHB+ArPreXPkCtHUH7GwiAwT
   qqqWCQzpDNLK2n+GAZ59YgB03KxQcWLBDIzoWA+SXjLCOcVJBxj462UGp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292240422"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="292240422"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:48:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="633618116"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="633618116"
Received: from sannilnx.jer.intel.com ([10.12.26.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 04:47:49 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mei: add timeout to send
Date:   Wed, 16 Nov 2022 14:47:34 +0200
Message-Id: <20221116124735.2493847-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116124735.2493847-1-alexander.usyskin@intel.com>
References: <20221116124735.2493847-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When driver wakes up the firmware from the low power state,
it is sending a memory ready message.
The send is done via synchronous/blocking function to ensure
that firmware is in ready state. However, in case of firmware
undergoing reset send might be block forever.
To address this issue a timeout is added to blocking
write command on the internal bus.

Introduce the __mei_cl_send_timeout function to use instead of
__mei_cl_send in cases where timeout is required.
The mei_cl_write has only two callers and there is no need to split
it into two functions.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c |  7 +++++--
 drivers/misc/mei/bus.c       | 22 +++++++++++++++++++++-
 drivers/misc/mei/client.c    | 20 ++++++++++++++++----
 drivers/misc/mei/client.h    |  2 +-
 drivers/misc/mei/main.c      |  2 +-
 drivers/misc/mei/mei_dev.h   |  2 ++
 6 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 71fbf0bc8453..90023c34666e 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -188,17 +188,20 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	return ret;
 }
 
+#define GFX_MEMORY_READY_TIMEOUT 200 /* timeout in milliseconds */
+
 static int mei_gfx_memory_ready(struct mei_cl_device *cldev)
 {
 	struct mkhi_gfx_mem_ready req = {0};
-	unsigned int mode = MEI_CL_IO_TX_INTERNAL;
+	unsigned int mode = MEI_CL_IO_TX_INTERNAL | MEI_CL_IO_TX_BLOCKING;
 
 	req.hdr.group_id = MKHI_GROUP_ID_GFX;
 	req.hdr.command = MKHI_GFX_MEMORY_READY_CMD_REQ;
 	req.flags = MKHI_GFX_MEM_READY_PXP_ALLOWED;
 
 	dev_dbg(&cldev->dev, "Sending memory ready command\n");
-	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode);
+	return __mei_cl_send_timeout(cldev->cl, (u8 *)&req, sizeof(req), 0,
+				     mode, GFX_MEMORY_READY_TIMEOUT);
 }
 
 static void mei_mkhi_fix(struct mei_cl_device *cldev)
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 1fbe127ff633..4a08b624910a 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -34,6 +34,26 @@
  */
 ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode)
+{
+	return __mei_cl_send_timeout(cl, buf, length, vtag, mode, MAX_SCHEDULE_TIMEOUT);
+}
+
+/**
+ * __mei_cl_send_timeout - internal client send (write)
+ *
+ * @cl: host client
+ * @buf: buffer to send
+ * @length: buffer length
+ * @vtag: virtual tag
+ * @mode: sending mode
+ * @timeout: send timeout in milliseconds.
+ *           effective only for blocking writes: the MEI_CL_IO_TX_BLOCKING mode bit is set.
+ *           set timeout to the MAX_SCHEDULE_TIMEOUT to maixum allowed wait.
+ *
+ * Return: written size bytes or < 0 on error
+ */
+ssize_t __mei_cl_send_timeout(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
+			      unsigned int mode, unsigned long timeout)
 {
 	struct mei_device *bus;
 	struct mei_cl_cb *cb;
@@ -108,7 +128,7 @@ ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		cb->buf.size = 0;
 	}
 
-	rets = mei_cl_write(cl, cb);
+	rets = mei_cl_write(cl, cb, timeout);
 
 	if (mode & MEI_CL_IO_SGL && rets == 0)
 		rets = length;
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 6c8b71ae32c8..9ddb854b8155 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1954,10 +1954,13 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
  *
  * @cl: host client
  * @cb: write callback with filled data
+ * @timeout: send timeout in milliseconds.
+ *           effective only for blocking writes: the cb->blocking is set.
+ *           set timeout to the MAX_SCHEDULE_TIMEOUT to maixum allowed wait.
  *
  * Return: number of bytes sent on success, <0 on failure.
  */
-ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
+ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long timeout)
 {
 	struct mei_device *dev;
 	struct mei_msg_data *buf;
@@ -2081,11 +2084,20 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	if (blocking && cl->writing_state != MEI_WRITE_COMPLETE) {
 
 		mutex_unlock(&dev->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
-				cl->writing_state == MEI_WRITE_COMPLETE ||
-				(!mei_cl_is_connected(cl)));
+		rets = wait_event_interruptible_timeout(cl->tx_wait,
+							cl->writing_state == MEI_WRITE_COMPLETE ||
+							(!mei_cl_is_connected(cl)),
+							msecs_to_jiffies(timeout));
 		mutex_lock(&dev->device_lock);
+		/* clean all queue on timeout as something fatal happened */
+		if (rets == 0) {
+			rets = -ETIME;
+			mei_io_tx_list_free_cl(&dev->write_list, cl, NULL);
+			mei_io_tx_list_free_cl(&dev->write_waiting_list, cl, NULL);
+		}
 		/* wait_event_interruptible returns -ERESTARTSYS */
+		if (rets > 0)
+			rets = 0;
 		if (rets) {
 			if (signal_pending(current))
 				rets = -EINTR;
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index 418056fb1489..9052860bcfe0 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -246,7 +246,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 int mei_cl_irq_connect(struct mei_cl *cl, struct mei_cl_cb *cb,
 		       struct list_head *cmpl_list);
 int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp);
-ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb);
+ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long timeout);
 int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
 		     struct list_head *cmpl_list);
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 930887e7e38d..632d4ae21e46 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -383,7 +383,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 		goto out;
 	}
 
-	rets = mei_cl_write(cl, cb);
+	rets = mei_cl_write(cl, cb, MAX_SCHEDULE_TIMEOUT);
 out:
 	mutex_unlock(&dev->device_lock);
 	return rets;
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 8d8018428d9d..996b70a988be 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -379,6 +379,8 @@ void mei_cl_bus_rescan_work(struct work_struct *work);
 void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
 ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode);
+ssize_t __mei_cl_send_timeout(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
+			      unsigned int mode, unsigned long timeout);
 ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 		      unsigned int mode, unsigned long timeout);
 bool mei_cl_bus_rx_event(struct mei_cl *cl);
-- 
2.34.1

