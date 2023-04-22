Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949166EB6F6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDVDJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDVDJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:09:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC02212F;
        Fri, 21 Apr 2023 20:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682132976; x=1713668976;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LTlRRMSqF5DU6nGDLrBROJM9XGy7cXA5Nrsr4Ge27ew=;
  b=eScnhzHijZzZoI93w0Xgwb3tNmGlz012acroowVidvUZZ1oPHEA+to0J
   cTwaao8XSbWAB6t+UHdrabObTJwBNTkMyYO+VBlC+RvHHpyZ6V6+cRd9L
   x3v+PgrTmIeMfKQi59ljDfdjkh32EOyBqiOsIoPXv8zTRe5wYE+JD4QY3
   UkWTrc3SzPIlgHoEmOoJlPfKpz199a6f8mL0NSzpLb/Yt+/k2Ntp3BNFH
   JS8DJYxitoZv2jSQd6RltLamVEqlVlj6jJF04DF0R93KGdM2Eaimin75B
   6/0F8I7A0J2+CcO+zeFL137QEhJ0ZRJtbn4aDKz79f9DWEggLcHvZV+XK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343609059"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343609059"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757092267"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757092267"
Received: from jwostman-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.111.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:34 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Fri, 21 Apr 2023 21:09:26 -0600
Subject: [PATCH 2/4] cxl/mbox: Add background cmd handling machinery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-vv-fw_update-v1-2-22468747d72f@intel.com>
References: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
In-Reply-To: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=8846;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=V2jFSgzPQztiTOuyMj+lsrNslCmjQy7Vmlps32819Hw=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCnO/m+PfNnudniGTu2xOVujuLKmbdwgsK25latQasXhx
 pT75woVO0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRU+EMv9k+GPs4fcj6bvhB
 RHDWsYK6RdHt33+t8GsLuRE8P/fE7XxGhmtSEk+fLjrw/ePc3V4fZrtdXCVgPU93a6SBrNQX/j8
 yd1gB
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

This adds support for handling background operations, as defined in
the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
can run in the background asynchronously (to the hardware).

The driver will deal with such commands synchronously, blocking all
other incoming commands for a specified period of time, allowing
time-slicing the command such that the caller can send incremental
requests to avoid monopolizing the driver/device. This approach
makes the code simpler, where any out of sync (timeout) between the
driver and hardware is just disregarded as an invalid state until
the next successful submission.

On devices where mbox interrupts are supported, this will still use
a poller that will wakeup in the specified wait intervals. The irq
handler will simply awake a blocked cmd, which is also safe vs a
task that is either waking (timing out) or already awoken. Similarly
any irq setup error during the probing falls back to polling, thus
avoids unnecessarily erroring out.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20230421092321.12741-2-dave@stgolabs.net
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/cxl/cxl.h       |   7 ++++
 drivers/cxl/cxlmem.h    |   5 +++
 drivers/cxl/core/mbox.c |   3 +-
 drivers/cxl/pci.c       | 104 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..72731a896f58 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
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
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 090acebba4fa..8c3302fc7738 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @poll_count: (input)  Number of timeouts to attempt.
+ * @poll_interval: (input) Number of ms between mailbox background command
+ *                 polling intervals timeouts.
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	int poll_count;
+	int poll_interval;
 	u16 return_code;
 };
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..4b0c7564d350 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -181,7 +181,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	if (rc)
 		return rc;
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
 		return cxl_mbox_cmd_rc2errno(mbox_cmd);
 
 	if (!out_size)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 39b829a29f6c..aa1bb74a52a1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -51,6 +51,7 @@
 static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
+static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
 
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
@@ -85,6 +86,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
 			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
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
+	struct cxl_dev_state *cxlds = id;
+
+	/* spurious or raced with hw? */
+	if (!cxl_mbox_background_complete(cxlds)) {
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		dev_warn(&pdev->dev,
+			 "Mailbox background operation IRQ but incomplete\n");
+		goto done;
+	}
+
+	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+	wake_up(&mbox_wait);
+done:
+	return IRQ_HANDLED;
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
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
+		int i;
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		for (i = 0; i < mbox_cmd->poll_count; i++) {
+			int ret = wait_event_interruptible_timeout(
+				mbox_wait, cxl_mbox_background_complete(cxlds),
+				msecs_to_jiffies(mbox_cmd->poll_interval));
+			if (ret > 0)
+				break;
+
+			/* interrupted by a signal */
+			if (ret < 0)
+				return ret;
+		}
+
+		if (!cxl_mbox_background_complete(cxlds)) {
+			u64 md_status =
+				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
+				    "background timeout");
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
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
@@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	unsigned long timeout;
 	u64 md_status;
+	int rc, irq;
 
 	timeout = jiffies + mbox_ready_timeout * HZ;
 	do {
@@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		irq = pci_irq_vector(pdev,
+			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
+		if (irq < 0)
+			goto mbox_poll;
+
+		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
+				      IRQF_SHARED, "mailbox", cxlds);
+		if (rc)
+			goto mbox_poll;
+
+		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
+		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+
+		return 0;
+	}
+
+mbox_poll:
+	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 

-- 
2.40.0

