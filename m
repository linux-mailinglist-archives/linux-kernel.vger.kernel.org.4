Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBF64DA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiLOLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiLOLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:31:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B01DDCB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:31:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65C05B81B77
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D55EC433D2;
        Thu, 15 Dec 2022 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671103898;
        bh=v0s3LLvZ9IJbXiTr3VwrCN4Nf7ipq2eRFuEUQxHnyv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kTrzNwdWdzlx/CPLq6gO8tPmJOB4ZG9Kuwc843zWUZfuHVX4S4V/FcmtV2Dm7R7aQ
         W71xfxe0wZSgwo09ImUK4/N0Lc4/i+fJrpxiPeFpDYIMwUyIUds/PpdT5a2QDbHJtk
         Uh8thuEG9i5uPa7gJPPUnhAPQAKkFzhdvNMJzAFL3hUGglLZAZy3ItB92bgorjmdE1
         0rlISPGGM/QUbfo1kOxEiWNX1+SBJeq8sLBauTHPT5JSci89AjcJjxotwG1tuPZu3g
         uApvKTTu7CJJU1Um1BWhJJrHffEyGIZcxi6woCU8aKvNR3uXpw0iWC0Jj6Nf4PIDS/
         xfqLwc0pxmbxg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 2/3] habanalabs: support receiving ascii message from preboot f/w
Date:   Thu, 15 Dec 2022 13:31:30 +0200
Message-Id: <20221215113131.2276739-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215113131.2276739-1-ogabbay@kernel.org>
References: <20221215113131.2276739-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tal Cohen <talcohen@habana.ai>

An Ascii message that is sent from preboot towards the driver
will indicate the specific error that occurred on the f/w.
This commit supports that message and parse the ascii string
in order to print it into the kernel log

The commit also changes the way the descriptor struct is declared.
While its size increased (it now above 1024 bytes), it will be
allocated by using kmalloc instead of stack declaration.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 74 +++++++++++++++----
 .../habanalabs/include/common/hl_boot_if.h    | 19 +++++
 2 files changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ee4d1c5ca527..a8911e15d937 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1915,7 +1915,7 @@ static int hl_fw_dynamic_validate_memory_bound(struct hl_device *hdev,
  *
  * @hdev: pointer to the habanalabs device structure
  * @fw_loader: managing structure for loading device's FW
- * @fw_desc: the descriptor form FW
+ * @fw_desc: the descriptor from FW
  *
  * @return 0 on success, otherwise non-zero error code
  */
@@ -2007,6 +2007,43 @@ static int hl_fw_dynamic_validate_response(struct hl_device *hdev,
 	return rc;
 }
 
+/*
+ * hl_fw_dynamic_read_descriptor_msg - read and show the ascii msg that sent by fw
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_desc: the descriptor from FW
+ */
+static void hl_fw_dynamic_read_descriptor_msg(struct hl_device *hdev,
+					struct lkd_fw_comms_desc *fw_desc)
+{
+	int i;
+	char *msg;
+
+	for (i = 0 ; i < LKD_FW_ASCII_MSG_MAX ; i++) {
+		if (!fw_desc->ascii_msg[i].valid)
+			return;
+
+		/* force NULL termination */
+		msg = fw_desc->ascii_msg[i].msg;
+		msg[LKD_FW_ASCII_MSG_MAX_LEN - 1] = '\0';
+
+		switch (fw_desc->ascii_msg[i].msg_lvl) {
+		case LKD_FW_ASCII_MSG_ERR:
+			dev_err(hdev->dev, "fw: %s", fw_desc->ascii_msg[i].msg);
+			break;
+		case LKD_FW_ASCII_MSG_WRN:
+			dev_warn(hdev->dev, "fw: %s", fw_desc->ascii_msg[i].msg);
+			break;
+		case LKD_FW_ASCII_MSG_INF:
+			dev_info(hdev->dev, "fw: %s", fw_desc->ascii_msg[i].msg);
+			break;
+		default:
+			dev_dbg(hdev->dev, "fw: %s", fw_desc->ascii_msg[i].msg);
+			break;
+		}
+	}
+}
+
 /**
  * hl_fw_dynamic_read_and_validate_descriptor - read and validate FW descriptor
  *
@@ -2071,6 +2108,10 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 
 	rc = hl_fw_dynamic_validate_descriptor(hdev, fw_loader,
 					(struct lkd_fw_comms_desc *) temp_fw_desc);
+
+	if (!rc)
+		hl_fw_dynamic_read_descriptor_msg(hdev, temp_fw_desc);
+
 	vfree(temp_fw_desc);
 
 	return rc;
@@ -2491,51 +2532,54 @@ static void hl_fw_linux_update_state(struct hl_device *hdev,
 static int hl_fw_dynamic_send_msg(struct hl_device *hdev,
 		struct fw_load_mgr *fw_loader, u8 msg_type, void *data)
 {
-	struct lkd_msg_comms msg;
+	struct lkd_msg_comms *msg;
 	int rc;
 
-	memset(&msg, 0, sizeof(msg));
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
 	/* create message to be sent */
-	msg.header.type = msg_type;
-	msg.header.size = cpu_to_le16(sizeof(struct comms_msg_header));
-	msg.header.magic = cpu_to_le32(HL_COMMS_MSG_MAGIC);
+	msg->header.type = msg_type;
+	msg->header.size = cpu_to_le16(sizeof(struct comms_msg_header));
+	msg->header.magic = cpu_to_le32(HL_COMMS_MSG_MAGIC);
 
 	switch (msg_type) {
 	case HL_COMMS_RESET_CAUSE_TYPE:
-		msg.reset_cause = *(__u8 *) data;
+		msg->reset_cause = *(__u8 *) data;
 		break;
 
 	default:
 		dev_err(hdev->dev,
 			"Send COMMS message - invalid message type %u\n",
 			msg_type);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader,
 			sizeof(struct lkd_msg_comms));
 	if (rc)
-		return rc;
+		goto out;
 
 	/* copy message to space allocated by FW */
-	rc = hl_fw_dynamic_copy_msg(hdev, &msg, fw_loader);
+	rc = hl_fw_dynamic_copy_msg(hdev, msg, fw_loader);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_DATA_RDY,
 						0, true,
 						fw_loader->cpu_timeout);
 	if (rc)
-		return rc;
+		goto out;
 
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_EXEC,
 						0, true,
 						fw_loader->cpu_timeout);
-	if (rc)
-		return rc;
 
-	return 0;
+out:
+	kfree(msg);
+	return rc;
 }
 
 /**
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index fe034111360e..370e62d0a96a 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -523,6 +523,23 @@ struct comms_msg_header {
 	__u8 reserved[4];	/* pad to 64 bit */
 };
 
+enum lkd_fw_ascii_msg_lvls {
+	LKD_FW_ASCII_MSG_ERR = 0,
+	LKD_FW_ASCII_MSG_WRN = 1,
+	LKD_FW_ASCII_MSG_INF = 2,
+	LKD_FW_ASCII_MSG_DBG = 3,
+};
+
+#define LKD_FW_ASCII_MSG_MAX_LEN	128
+#define LKD_FW_ASCII_MSG_MAX		4	/* consider ABI when changing */
+
+struct lkd_fw_ascii_msg {
+	__u8 valid;
+	__u8 msg_lvl;
+	__u8 reserved[6];
+	char msg[LKD_FW_ASCII_MSG_MAX_LEN];
+};
+
 /* this is the main FW descriptor - consider ABI when changing */
 struct lkd_fw_comms_desc {
 	struct comms_desc_header header;
@@ -533,6 +550,7 @@ struct lkd_fw_comms_desc {
 	char reserved0[VERSION_MAX_LEN];
 	__le64 img_addr;	/* address for next FW component load */
 	struct lkd_fw_binning_info binning_info;
+	struct lkd_fw_ascii_msg ascii_msg[LKD_FW_ASCII_MSG_MAX];
 };
 
 enum comms_reset_cause {
@@ -558,6 +576,7 @@ struct lkd_fw_comms_msg {
 			/* address for next FW component load */
 			__le64 img_addr;
 			struct lkd_fw_binning_info binning_info;
+			struct lkd_fw_ascii_msg ascii_msg[LKD_FW_ASCII_MSG_MAX];
 		};
 		struct {
 			__u8 reset_cause;
-- 
2.25.1

