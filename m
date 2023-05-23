Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9770E2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjEWRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEWRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:43:25 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F4497;
        Tue, 23 May 2023 10:43:22 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A5884341DB8;
        Tue, 23 May 2023 17:43:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B58933409B9;
        Tue, 23 May 2023 17:43:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1684863799; a=rsa-sha256;
        cv=none;
        b=7iXlCaJZwLsADCAwqN4BMRVb0gfTvlbBeEqieg0QFDl8oXONSXN0l5KBF/79E3u9Pht6+c
        2ULYecp5m59MvlX7HxjNznNWmoNpJh3HIJBMIaM0T418wg0P/AztDwayFTFvbpFgg6zB+1
        1Gq4cK8ssguPifREszuhGzvALOgvmCWHHGEIS8D6Auq/Vyre/bT1BHSBkZnRmQvJ7XI4bU
        rTg4+OKLbok4xIl+RXI8TQoX8RznKotKUVNhF8RZBDlpvBTSRXYhytWGiFNJ68uMCFH+F6
        TVrjH7JUgzGvAHw2WBET8/9IA68TF9WNhPymnu9n6eDBmr4wNYDT0KNJw9ucwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1684863799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=MUixsCnTrKx0pNrJfVPzobY9yvQ4aYxoFvtZUqz3UQ8=;
        b=w3oOIUCmyamBVKWbHEEuNr2WbtCcVovt++Mvxlky90hOUP0CXfzzS9ML/+0M9uUH84ACyS
        LNyM3XK0U4KMIUgCSdk19UxXWohqy0JKniQWvmFUvVXlI5dDeRPvb8eTlv9fWPnt1609LY
        D2nY5YhA6rc0DzKnfdS/6Ut/HW55OtF0aODX4JizdfHsh+L3fZ/7GgrdEnotySNvy+CBJK
        MdHtkATHjXT400Uk3RXcNkM87GnWVWGi430py8T/01wFJyK6lBP1tH7KiFntrx7vw8Nua3
        JaeYfsotJUs+LVD0gmqa0IgmMzv+T7reMc7ts29kwfWoKgJAAkSF+bXOz70Vzw==
ARC-Authentication-Results: i=1;
        rspamd-5cdf8fd7d9-r57sl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Shade: 47f59e286256eef8_1684863801436_2979447924
X-MC-Loop-Signature: 1684863801436:653701366
X-MC-Ingress-Time: 1684863801436
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.61 (trex/6.8.1);
        Tue, 23 May 2023 17:43:20 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4QQhVt6BtJz6m;
        Tue, 23 May 2023 10:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1684863799;
        bh=MUixsCnTrKx0pNrJfVPzobY9yvQ4aYxoFvtZUqz3UQ8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ZUqoPB7XiPvKQcnS8MaPCHgYujup1uC5y5IZGMl2mgJpNXMRBrBsIBtGpu6c6DCoU
         Do4Aqy4+2iQkjDRFL4XgB6EH087/1Eu9ChYpkxyKRUKkB/6FHuZem93HiN/kipkj5f
         nDmuaaq8dRYgWJ6UT2xQOUSijslJqyiH7B9t79EZTDZJ9U0CCTHQqIWFZwaawsgJqy
         0BtKmo6KguHNPwjAfvBL/yOT6ugEUre/57TQwvrvpzxlLNJWSM+LZA5U66bZP/KhqJ
         zu/4zP+cPxoEhoUFlmtqU5FV7ofdBNnvJo4PCwal2b4uUJ647HAAIWaGQGKfaKIRDy
         JpnFy/qTA3FlA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] cxl/mbox: Add background cmd handling machinery
Date:   Tue, 23 May 2023 10:09:27 -0700
Message-Id: <20230523170927.20685-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523170927.20685-1-dave@stgolabs.net>
References: <20230523170927.20685-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for handling background operations, as defined in
the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
can run in the background asynchronously (to the hardware).

The driver will deal with such commands synchronously, blocking all
other incoming commands for a specified period of time, allowing
time-slicing the command such that the caller can send incremental
requests to avoid monopolizing the driver/device. Any out of sync
(timeout) between the driver and hardware is just disregarded as
an invalid state until the next successful submission. Such timeouts
are considered a rare occurrence, either a real device problem or a
driver issue that needs to reduce the size of the background operation
to fit the timeout.

On devices where mbox interrupts are supported, this will still use
a poller that will wakeup in the specified wait intervals. The irq
handler will simply awake the blocked cmd, which is also safe vs a
task that is either waking (timing out) or already awoken. Similarly
any irq setup error during the probing falls back to polling, thus
avoids unnecessarily erroring out.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |  3 +-
 drivers/cxl/cxl.h       |  8 ++++
 drivers/cxl/cxlmem.h    |  7 ++++
 drivers/cxl/pci.c       | 89 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2c8dc7e2b84d..5993261e3e08 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -220,7 +220,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	if (rc)
 		return rc;
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
 		return cxl_mbox_cmd_rc2errno(mbox_cmd);
 
 	if (!out_size)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f93a28538962..ec69bda93aee 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -176,14 +176,22 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
+#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
+#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
 #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
 #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
 #define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
 #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..1d8e81c87c6a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/rcuwait.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -108,6 +109,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @poll_count: (input) Number of timeouts to attempt.
+ * @poll_interval_ms: (input) Time between mailbox background command polling
+ *                    interval timeouts.
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -123,6 +127,8 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	int poll_count;
+	int poll_interval_ms;
 	u16 return_code;
 };
 
@@ -331,6 +337,7 @@ struct cxl_dev_state {
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 
+	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 18b8f3ce680c..a78e40e6d0e0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -105,6 +105,26 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
 					 NULL, dev_id);
 }
 
+static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
+{
+	u64 reg;
+
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
+}
+
+static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
+{
+	struct cxl_dev_id *dev_id = id;
+	struct cxl_dev_state *cxlds = dev_id->cxlds;
+
+	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+	if (cxl_mbox_background_complete(cxlds))
+		rcuwait_wake_up(&cxlds->mbox_wait);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -198,6 +218,50 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
+	/*
+	 * Handle the background command in a synchronous manner.
+	 *
+	 * All other mailbox commands will serialize/queue on the mbox_mutex,
+	 * which we currently hold. Furthermore this also guarantees that
+	 * cxl_mbox_background_complete() checks are safe amongst each other,
+	 * in that no new bg operation can occur in between.
+	 *
+	 * Background operations are timesliced in accordance with the nature
+	 * of the command. In the event of timeout, the mailbox state is
+	 * indeterminate until the next successful command submission and the
+	 * driver can get back in sync with the hardware state.
+	 */
+	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
+		u64 bg_status_reg;
+		int i, timeout = mbox_cmd->poll_interval_ms;
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		for (i = 0; i < mbox_cmd->poll_count; i++) {
+			if (rcuwait_wait_event_timeout(&cxlds->mbox_wait,
+				       cxl_mbox_background_complete(cxlds),
+				       TASK_UNINTERRUPTIBLE,
+				       msecs_to_jiffies(timeout)) > 0)
+				break;
+		}
+
+		if (!cxl_mbox_background_complete(cxlds)) {
+			dev_err(dev, "timeout waiting for background (%d ms)\n",
+				timeout * mbox_cmd->poll_count);
+			return -ETIMEDOUT;
+		}
+
+		bg_status_reg = readq(cxlds->regs.mbox +
+				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+		mbox_cmd->return_code =
+			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
+				  bg_status_reg);
+		dev_dbg(dev,
+			"Mailbox background operation (0x%04x) completed\n",
+			mbox_cmd->opcode);
+	}
+
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
@@ -292,6 +356,31 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
+	rcuwait_init(&cxlds->mbox_wait);
+
+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
+		u32 ctrl;
+		int irq, msgnum;
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+		irq = pci_irq_vector(pdev, msgnum);
+		if (irq < 0)
+			goto mbox_poll;
+
+		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
+			goto mbox_poll;
+
+		/* enable background command mbox irq support */
+		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
+		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+
+		return 0;
+	}
+
+mbox_poll:
+	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 
-- 
2.40.1

