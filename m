Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47F566174B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjAHRUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjAHRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:20:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AFBB1CA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:20:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C59B80B7E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 17:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78666C433D2;
        Sun,  8 Jan 2023 17:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673198445;
        bh=ja76YEUsEvGweZliqe3OCEgGXzW76IJYhhPAWKsPF+c=;
        h=From:To:Cc:Subject:Date:From;
        b=mPXaZnXEtCfGtLZOVGvtw0/ZpL/QPCfV4yyjAmFT9cGpT6CWiUwB++2OiSDAayOlr
         A67gn4GoN46olKBJZt/G/zKoUkcqGrzi2ImHk/V4wUZ9IE5g0LMsekWy/rdY9VJctp
         HDnY/rX2at5cH6e81y7hbIdzLvTHvJ/cKsT6hncSsS/IL+AshR3qXJdvq+lSvltNiD
         YThiNYoyOF8UILUMv+Ogi0QTvQeWDHfuZlXUcSNs/B5k83R65sfQ7A5pWVajS1zRpf
         j5YaEGT4LYrYJhf1oYY4kn2/nTGvMUpj5KaOySH3GXHRoaajvDIRDpRYCZ/WCmet5t
         QIU/GztPNQ62Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 1/7] habanalabs: protect access to dynamic mem 'user_mappings'
Date:   Sun,  8 Jan 2023 19:20:34 +0200
Message-Id: <20230108172040.3991204-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Koby Elbaz <kelbaz@habana.ai>

When HL_INFO_USER_MAPPINGS IOCTL is called, we copy_to_user from
a dynamically allocated memory - 'user_mappings'.
Since freeing/allocating it happens in runtime (upon a page fault),
it not unlikely to access it even before being initially allocated
(i.e., accessing a NULL pointer).

The solution is to simply mark the spot when the err info has been
collected, and that way to know whether err info (either page fault
or RAZWI) is available to be read.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c      |  4 +++
 drivers/accel/habanalabs/common/habanalabs.h  |  4 +++
 .../accel/habanalabs/common/habanalabs_drv.c  |  2 ++
 .../habanalabs/common/habanalabs_ioctl.c      | 36 ++++++++++++-------
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index e1b5a2c34986..6a05ab3fda23 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2441,6 +2441,8 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 	memcpy(&razwi_info->razwi.engine_id[0], &engine_id[0],
 			num_of_engines * sizeof(u16));
 	razwi_info->razwi.flags = flags;
+
+	razwi_info->razwi_info_available = true;
 }
 
 void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
@@ -2526,6 +2528,8 @@ void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is
 	pgf_info->page_fault.addr = addr;
 	pgf_info->page_fault.engine_id = eng_id;
 	hl_capture_user_mappings(hdev, is_pmmu);
+
+	pgf_info->page_fault_info_available = true;
 }
 
 void hl_handle_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu,
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index e578645acba9..cd474422163d 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2984,12 +2984,14 @@ struct undefined_opcode_info {
  *                       Since we're looking for the page-fault's root cause,
  *                       we don't care of the others that might follow it-
  *                       so once changed to 1, it will remain that way.
+ * @page_fault_info_available: indicates that a page fault info is now available.
  */
 struct page_fault_info {
 	struct hl_page_fault_info	page_fault;
 	struct hl_user_mapping		*user_mappings;
 	u64				num_of_user_mappings;
 	atomic_t			page_fault_detected;
+	bool				page_fault_info_available;
 };
 
 /**
@@ -3000,10 +3002,12 @@ struct page_fault_info {
  *                  Since we're looking for the RAZWI's root cause,
  *                  we don't care of the others that might follow it-
  *                  so once changed to 1, it will remain that way.
+ * @razwi_info_available: indicates that a RAZWI info is now available.
  */
 struct razwi_info {
 	struct hl_info_razwi_event	razwi;
 	atomic_t			razwi_detected;
+	bool				razwi_info_available;
 };
 
 /**
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index d7fe0af33bca..03dae57dc838 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -225,6 +225,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	atomic_set(&hdev->captured_err_info.razwi_info.razwi_detected, 0);
 	atomic_set(&hdev->captured_err_info.page_fault_info.page_fault_detected, 0);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
+	hdev->captured_err_info.razwi_info.razwi_info_available = false;
+	hdev->captured_err_info.page_fault_info.page_fault_info_available = false;
 
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 949d38527160..72493bf94ba3 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -607,16 +607,20 @@ static int cs_timeout_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 
 static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_info_razwi_event *info = &hdev->captured_err_info.razwi_info.razwi;
-	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct razwi_info *razwi_info;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	return copy_to_user(out, info, min_t(size_t, max_size, sizeof(struct hl_info_razwi_event)))
-				? -EFAULT : 0;
+	razwi_info = &hdev->captured_err_info.razwi_info;
+	if (!razwi_info->razwi_info_available)
+		return 0;
+
+	return copy_to_user(out, &razwi_info->razwi,
+			min_t(size_t, max_size, sizeof(struct hl_info_razwi_event))) ? -EFAULT : 0;
 }
 
 static int undefined_opcode_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
@@ -786,16 +790,20 @@ static int engine_status_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 
 static int page_fault_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_page_fault_info *info = &hdev->captured_err_info.page_fault_info.page_fault;
-	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct page_fault_info *pgf_info;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	return copy_to_user(out, info, min_t(size_t, max_size, sizeof(struct hl_page_fault_info)))
-				? -EFAULT : 0;
+	pgf_info = &hdev->captured_err_info.page_fault_info;
+	if (!pgf_info->page_fault_info_available)
+		return 0;
+
+	return copy_to_user(out, &pgf_info->page_fault,
+			min_t(size_t, max_size, sizeof(struct hl_page_fault_info))) ? -EFAULT : 0;
 }
 
 static int user_mappings_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
@@ -806,18 +814,20 @@ static int user_mappings_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	struct page_fault_info *pgf_info;
 	u64 actual_size;
 
-	pgf_info = &hdev->captured_err_info.page_fault_info;
-	args->array_size = pgf_info->num_of_user_mappings;
-
 	if (!out)
 		return -EINVAL;
 
+	pgf_info = &hdev->captured_err_info.page_fault_info;
+	if (!pgf_info->page_fault_info_available)
+		return 0;
+
+	args->array_size = pgf_info->num_of_user_mappings;
+
 	actual_size = pgf_info->num_of_user_mappings * sizeof(struct hl_user_mapping);
 	if (user_buf_size < actual_size)
 		return -ENOMEM;
 
-	return copy_to_user(out, pgf_info->user_mappings, min_t(size_t, user_buf_size, actual_size))
-				? -EFAULT : 0;
+	return copy_to_user(out, pgf_info->user_mappings, actual_size) ? -EFAULT : 0;
 }
 
 static int send_fw_generic_request(struct hl_device *hdev, struct hl_info_args *info_args)
-- 
2.25.1

