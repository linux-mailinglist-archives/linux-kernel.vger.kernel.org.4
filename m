Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F60D618350
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKCPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiKCPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:55:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F41277B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667490949; x=1699026949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GSng2hGG6jHOCi+5AN55mKC5fLajgoO92GOMSvYwTY=;
  b=BbGS9mkosjrFR8WeQAojk9gh6Fs2pTDuacx5yydFA724a7P40OOFuUmL
   mtkQB3v5XUK05TOL/kLDWcwqDPJwqSSTBu0TIpoKh/qQB1HQD+InLhddb
   65suleUDtb8nQ0sX/Yvzgsd9fXcpaq8i9ZUQ0+1CYHTnSPRlIQWHxLw3u
   w6d6ZJt2u9FfHfkc3cf2zR+TxdjF5u8l86fl62l4r1LlnueIrhZkRZx0U
   WSbqVr9bpgSKxAyU2RaGiKVvykRZnlrJkTBe7rB+6zkfx8AIvVaKE/1KA
   +mU2Hs+p2K6Er9B3xM1dj5zW5pDh7Ks6r7IkC7e0p9xiGLO9u1b88TZn2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336419482"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="336419482"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:55:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="629390301"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="629390301"
Received: from sannilnx.jer.intel.com ([10.12.26.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 08:55:46 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mei: add timeout to send
Date:   Thu,  3 Nov 2022 17:55:34 +0200
Message-Id: <20221103155534.1966589-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When driver wakes up the firmware from the low power stand,
it is sending a memory ready message.
The send is done via synchronous/blocking function to ensure
that firmware is in ready state. However firmware might be
in unstable state and send might be block forever.
To address this issue a timeout is added to blocking write command on
the internal bus.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 19 +++++++++++--------
 drivers/misc/mei/bus.c       |  9 +++++----
 drivers/misc/mei/client.c    | 21 +++++++++++++++++----
 drivers/misc/mei/client.h    |  2 +-
 drivers/misc/mei/main.c      |  2 +-
 drivers/misc/mei/mei_dev.h   |  2 +-
 6 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 71fbf0bc8453..3174cad8a5cc 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -128,7 +128,7 @@ static int mei_osver(struct mei_cl_device *cldev)
 	os_ver = (struct mei_os_ver *)fwcaps->data;
 	os_ver->os_type = OSTYPE_LINUX;
 
-	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
+	return __mei_cl_send(cldev->cl, buf, size, 0, mode, 0);
 }
 
 #define MKHI_FWVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
@@ -149,7 +149,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
 
 	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
-			    MEI_CL_IO_TX_BLOCKING);
+			    MEI_CL_IO_TX_BLOCKING, 0);
 	if (ret < 0) {
 		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
 		return ret;
@@ -188,17 +188,19 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	return ret;
 }
 
+#define GFX_MEMORY_READY_TIMEOUT 200
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
+	return __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0, mode, GFX_MEMORY_READY_TIMEOUT);
 }
 
 static void mei_mkhi_fix(struct mei_cl_device *cldev)
@@ -263,12 +265,13 @@ static void mei_gsc_mkhi_fix_ver(struct mei_cl_device *cldev)
 
 	if (cldev->bus->pxp_mode == MEI_DEV_PXP_INIT) {
 		ret = mei_gfx_memory_ready(cldev);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(&cldev->dev, "memory ready command failed %d\n", ret);
-		else
+		} else {
 			dev_dbg(&cldev->dev, "memory ready command sent\n");
+			cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
+		}
 		/* we go to reset after that */
-		cldev->bus->pxp_mode = MEI_DEV_PXP_SETUP;
 		goto out;
 	}
 
@@ -374,7 +377,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	WARN_ON(mutex_is_locked(&bus->device_lock));
 
 	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), 0,
-			    MEI_CL_IO_TX_BLOCKING);
+			    MEI_CL_IO_TX_BLOCKING, 0);
 	if (ret < 0) {
 		dev_err(bus->dev, "Could not send IF version cmd\n");
 		return ret;
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 1fbe127ff633..136b45192904 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -29,11 +29,12 @@
  * @length: buffer length
  * @vtag: virtual tag
  * @mode: sending mode
+ * @timeout: send timeout for blocking writes, 0 for infinite timeout
  *
  * Return: written size bytes or < 0 on error
  */
 ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
-		      unsigned int mode)
+		      unsigned int mode, unsigned long timeout)
 {
 	struct mei_device *bus;
 	struct mei_cl_cb *cb;
@@ -108,7 +109,7 @@ ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		cb->buf.size = 0;
 	}
 
-	rets = mei_cl_write(cl, cb);
+	rets = mei_cl_write(cl, cb, timeout);
 
 	if (mode & MEI_CL_IO_SGL && rets == 0)
 		rets = length;
@@ -254,7 +255,7 @@ ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
 {
 	struct mei_cl *cl = cldev->cl;
 
-	return __mei_cl_send(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING);
+	return __mei_cl_send(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING, 0);
 }
 EXPORT_SYMBOL_GPL(mei_cldev_send_vtag);
 
@@ -924,7 +925,7 @@ ssize_t mei_cldev_send_gsc_command(struct mei_cl_device *cldev,
 	}
 
 	/* send the message to GSC */
-	ret = __mei_cl_send(cl, (u8 *)ext_hdr, buf_sz, 0, MEI_CL_IO_SGL);
+	ret = __mei_cl_send(cl, (u8 *)ext_hdr, buf_sz, 0, MEI_CL_IO_SGL, 0);
 	if (ret < 0) {
 		dev_err(bus->dev, "__mei_cl_send failed, returned %zd\n", ret);
 		goto end;
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 6c8b71ae32c8..68f2e23b8ae5 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1954,10 +1954,11 @@ int mei_cl_irq_write(struct mei_cl *cl, struct mei_cl_cb *cb,
  *
  * @cl: host client
  * @cb: write callback with filled data
+ * @timeout: send timeout for blocking writes, 0 for infinite timeout
  *
  * Return: number of bytes sent on success, <0 on failure.
  */
-ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
+ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long timeout)
 {
 	struct mei_device *dev;
 	struct mei_msg_data *buf;
@@ -2081,9 +2082,21 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	if (blocking && cl->writing_state != MEI_WRITE_COMPLETE) {
 
 		mutex_unlock(&dev->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
-				cl->writing_state == MEI_WRITE_COMPLETE ||
-				(!mei_cl_is_connected(cl)));
+		if (timeout) {
+			rets = wait_event_interruptible_timeout(cl->tx_wait,
+					cl->writing_state == MEI_WRITE_COMPLETE ||
+					(!mei_cl_is_connected(cl)),
+					msecs_to_jiffies(timeout));
+			if (rets == 0)
+				rets = -ETIME;
+			if (rets > 0)
+				rets = 0;
+		} else {
+			rets = wait_event_interruptible(cl->tx_wait,
+					cl->writing_state == MEI_WRITE_COMPLETE ||
+					(!mei_cl_is_connected(cl)));
+		}
+
 		mutex_lock(&dev->device_lock);
 		/* wait_event_interruptible returns -ERESTARTSYS */
 		if (rets) {
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
index 930887e7e38d..311c6a34aeb8 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -383,7 +383,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 		goto out;
 	}
 
-	rets = mei_cl_write(cl, cb);
+	rets = mei_cl_write(cl, cb, 0);
 out:
 	mutex_unlock(&dev->device_lock);
 	return rets;
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 8d8018428d9d..799ea95e2bb8 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -378,7 +378,7 @@ struct mei_hw_ops {
 void mei_cl_bus_rescan_work(struct work_struct *work);
 void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
 ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
-		      unsigned int mode);
+		      unsigned int mode, unsigned long timeout);
 ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 		      unsigned int mode, unsigned long timeout);
 bool mei_cl_bus_rx_event(struct mei_cl *cl);
-- 
2.34.1

