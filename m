Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7206C5BBDA1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiIRLhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIRLh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8356025298
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA7F614B5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 11:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5DC433D7;
        Sun, 18 Sep 2022 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663501046;
        bh=a1rhwG/KVYoHx1I71R+b5DEVK2Fmq5YN3QgVwyNWcrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eD3lbG6cC//aFWLZasA3FGfLCbPY4vYMefP45AQXB/+EJ9rzSxwL4NswcWZ786AKb
         VJB/Ihv6vfI8gL9p1/p84tCMy2gjRpfGhQnQO73ItYmhiHwy9tv6UBRDU00HtjaUM7
         LjIX3j9mjn1gOOIXtCzffqQbEP6oQOCGtz9JWpiPMDvP5begJ2+lvMubtEpGBdc7Ac
         aeH8qNnLAgKq+8brt55zHvCoV6+2J9v0KtutQUgrn+xtCtNAkRnpQc9aC8SsO+0gVf
         VGyqLvQ2NJ/5tOM7hKsH7Ovn2GywSqTvB/fJ51ZxQcJjr8n8IbW4COxcPnhhoMfVmr
         VUGsaBEukAZIQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 4/7] habanalabs: rename error info structure
Date:   Sun, 18 Sep 2022 14:37:14 +0300
Message-Id: <20220918113717.2637094-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220918113717.2637094-1-ogabbay@kernel.org>
References: <20220918113717.2637094-1-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

As a preparation for adding more errors to it,
change to more suitable name.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  6 ++--
 drivers/misc/habanalabs/common/habanalabs.h   | 12 +++----
 .../misc/habanalabs/common/habanalabs_drv.c   |  6 ++--
 .../misc/habanalabs/common/habanalabs_ioctl.c | 30 +++++++++---------
 drivers/misc/habanalabs/gaudi/gaudi.c         | 31 ++++++++++---------
 5 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 746b688d34cf..fbe5003191bf 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -826,10 +826,10 @@ static void cs_timedout(struct work_struct *work)
 	}
 
 	/* Save only the first CS timeout parameters */
-	rc = atomic_cmpxchg(&hdev->last_error.cs_timeout.write_enable, 1, 0);
+	rc = atomic_cmpxchg(&hdev->captured_err_info.cs_timeout.write_enable, 1, 0);
 	if (rc) {
-		hdev->last_error.cs_timeout.timestamp = ktime_get();
-		hdev->last_error.cs_timeout.seq = cs->sequence;
+		hdev->captured_err_info.cs_timeout.timestamp = ktime_get();
+		hdev->captured_err_info.cs_timeout.seq = cs->sequence;
 
 		event_mask = device_reset ? (HL_NOTIFIER_EVENT_CS_TIMEOUT |
 				HL_NOTIFIER_EVENT_DEVICE_RESET) : HL_NOTIFIER_EVENT_CS_TIMEOUT;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f2910ac7aa22..259eebdc2f1b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2981,12 +2981,12 @@ struct undefined_opcode_info {
 };
 
 /**
- * struct last_error_session_info - info about last session errors occurred.
- * @cs_timeout: CS timeout error last information.
- * @razwi: razwi last information.
+ * struct hl_error_info - holds information collected during an error.
+ * @cs_timeout: CS timeout error information.
+ * @razwi: razwi information.
  * @undef_opcode: undefined opcode information
  */
-struct last_error_session_info {
+struct hl_error_info {
 	struct cs_timeout_info		cs_timeout;
 	struct razwi_info		razwi;
 	struct undefined_opcode_info	undef_opcode;
@@ -3111,7 +3111,7 @@ struct hl_reset_info {
  * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @multi_cs_completion: array of multi-CS completion.
  * @clk_throttling: holds information about current/previous clock throttling events
- * @last_error: holds information about last session in which CS timeout or razwi error occurred.
+ * @captured_err_info: holds information about errors.
  * @reset_info: holds current device reset information.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @fw_major_version: major version of current loaded preboot.
@@ -3286,7 +3286,7 @@ struct hl_device {
 	struct multi_cs_completion	multi_cs_completion[
 							MULTI_CS_MAX_USER_CTX];
 	struct hl_clk_throttle		clk_throttling;
-	struct last_error_session_info	last_error;
+	struct hl_error_info		captured_err_info;
 
 	struct hl_reset_info		reset_info;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index c60d6dab7aa7..73ae6f64d3ba 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -211,9 +211,9 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
-	atomic_set(&hdev->last_error.cs_timeout.write_enable, 1);
-	atomic_set(&hdev->last_error.razwi.write_enable, 1);
-	hdev->last_error.undef_opcode.write_enable = true;
+	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
+	atomic_set(&hdev->captured_err_info.razwi.write_enable, 1);
+	hdev->captured_err_info.undef_opcode.write_enable = true;
 
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index c7bd000750c8..ab0be082f3a6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -593,8 +593,8 @@ static int cs_timeout_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.seq = hdev->last_error.cs_timeout.seq;
-	info.timestamp = ktime_to_ns(hdev->last_error.cs_timeout.timestamp);
+	info.seq = hdev->captured_err_info.cs_timeout.seq;
+	info.timestamp = ktime_to_ns(hdev->captured_err_info.cs_timeout.timestamp);
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
@@ -609,12 +609,12 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.timestamp = ktime_to_ns(hdev->last_error.razwi.timestamp);
-	info.addr = hdev->last_error.razwi.addr;
-	info.engine_id_1 = hdev->last_error.razwi.engine_id_1;
-	info.engine_id_2 = hdev->last_error.razwi.engine_id_2;
-	info.no_engine_id = hdev->last_error.razwi.non_engine_initiator;
-	info.error_type = hdev->last_error.razwi.type;
+	info.timestamp = ktime_to_ns(hdev->captured_err_info.razwi.timestamp);
+	info.addr = hdev->captured_err_info.razwi.addr;
+	info.engine_id_1 = hdev->captured_err_info.razwi.engine_id_1;
+	info.engine_id_2 = hdev->captured_err_info.razwi.engine_id_2;
+	info.no_engine_id = hdev->captured_err_info.razwi.non_engine_initiator;
+	info.error_type = hdev->captured_err_info.razwi.type;
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
@@ -629,13 +629,13 @@ static int undefined_opcode_info(struct hl_fpriv *hpriv, struct hl_info_args *ar
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	info.timestamp = ktime_to_ns(hdev->last_error.undef_opcode.timestamp);
-	info.engine_id = hdev->last_error.undef_opcode.engine_id;
-	info.cq_addr = hdev->last_error.undef_opcode.cq_addr;
-	info.cq_size = hdev->last_error.undef_opcode.cq_size;
-	info.stream_id = hdev->last_error.undef_opcode.stream_id;
-	info.cb_addr_streams_len = hdev->last_error.undef_opcode.cb_addr_streams_len;
-	memcpy(info.cb_addr_streams, hdev->last_error.undef_opcode.cb_addr_streams,
+	info.timestamp = ktime_to_ns(hdev->captured_err_info.undef_opcode.timestamp);
+	info.engine_id = hdev->captured_err_info.undef_opcode.engine_id;
+	info.cq_addr = hdev->captured_err_info.undef_opcode.cq_addr;
+	info.cq_size = hdev->captured_err_info.undef_opcode.cq_size;
+	info.stream_id = hdev->captured_err_info.undef_opcode.stream_id;
+	info.cb_addr_streams_len = hdev->captured_err_info.undef_opcode.cb_addr_streams_len;
+	memcpy(info.cb_addr_streams, hdev->captured_err_info.undef_opcode.cb_addr_streams,
 			sizeof(info.cb_addr_streams));
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 48ff3b103b9f..f81a141b4741 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6894,9 +6894,9 @@ static void gaudi_handle_sw_config_stream_data(struct hl_device *hdev, u32 strea
 							stream, cq_ptr, size);
 
 	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
-		hdev->last_error.undef_opcode.cq_addr = cq_ptr;
-		hdev->last_error.undef_opcode.cq_size = size;
-		hdev->last_error.undef_opcode.stream_id = stream;
+		hdev->captured_err_info.undef_opcode.cq_addr = cq_ptr;
+		hdev->captured_err_info.undef_opcode.cq_size = size;
+		hdev->captured_err_info.undef_opcode.stream_id = stream;
 	}
 }
 
@@ -6962,7 +6962,7 @@ static void gaudi_handle_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
 	}
 
 	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
-		struct undefined_opcode_info *undef_opcode = &hdev->last_error.undef_opcode;
+		struct undefined_opcode_info *undef_opcode = &hdev->captured_err_info.undef_opcode;
 		u32 arr_idx = undef_opcode->cb_addr_streams_len;
 
 		if (arr_idx == 0) {
@@ -7046,11 +7046,11 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 		}
 		/* check for undefined opcode */
 		if (glbl_sts_val & TPC0_QM_GLBL_STS1_CP_UNDEF_CMD_ERR_MASK &&
-				hdev->last_error.undef_opcode.write_enable) {
-			memset(&hdev->last_error.undef_opcode, 0,
-						sizeof(hdev->last_error.undef_opcode));
+				hdev->captured_err_info.undef_opcode.write_enable) {
+			memset(&hdev->captured_err_info.undef_opcode, 0,
+						sizeof(hdev->captured_err_info.undef_opcode));
 
-			hdev->last_error.undef_opcode.write_enable = false;
+			hdev->captured_err_info.undef_opcode.write_enable = false;
 			*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
 		}
 
@@ -7332,18 +7332,19 @@ static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, &razwi_type);
 
 		/* In case it's the first razwi, save its parameters*/
-		rc = atomic_cmpxchg(&hdev->last_error.razwi.write_enable, 1, 0);
+		rc = atomic_cmpxchg(&hdev->captured_err_info.razwi.write_enable, 1, 0);
 		if (rc) {
-			hdev->last_error.razwi.timestamp = ktime_get();
-			hdev->last_error.razwi.addr = razwi_addr;
-			hdev->last_error.razwi.engine_id_1 = engine_id_1;
-			hdev->last_error.razwi.engine_id_2 = engine_id_2;
+			hdev->captured_err_info.razwi.timestamp = ktime_get();
+			hdev->captured_err_info.razwi.addr = razwi_addr;
+			hdev->captured_err_info.razwi.engine_id_1 = engine_id_1;
+			hdev->captured_err_info.razwi.engine_id_2 = engine_id_2;
 			/*
 			 * If first engine id holds non valid value the razwi initiator
 			 * does not have engine id
 			 */
-			hdev->last_error.razwi.non_engine_initiator = (engine_id_1 == U16_MAX);
-			hdev->last_error.razwi.type = razwi_type;
+			hdev->captured_err_info.razwi.non_engine_initiator =
+									(engine_id_1 == U16_MAX);
+			hdev->captured_err_info.razwi.type = razwi_type;
 
 		}
 	}
-- 
2.25.1

