Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0D657FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiL1QIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiL1QHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFABC07
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2EA5B81719
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947D1C433D2;
        Wed, 28 Dec 2022 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243664;
        bh=Ey7EejD2YEUPzDNAQGFtoWOxYhHILhowfjkPoVz1y3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOm6Yg3UY4nWBQsxhR0UpPHHfMqzZXG450E5PTkTkQBKk85hM8S0k1UyGmAf7Jh47
         17gFbNwMb4jQJZAp9Uf/6jvZ1GzSDruw9KbV1XzeVGWbPyCz2yrkoUFa8svAcOENn6
         nlupBso2whYnDurwYtXPgmcQ/NfaCI/u5GIqYNqRi130fA4GdmmjuReuQApdNu2dW4
         rAm+q4v/tX8IkLTIqGLwmKGkJawel27cqT4uwYaTGAE/QDT1hudhCaqniiwauTrbTR
         VOVtKQfNimq2v9b2APzKVB/MWnoN8JEEmk034wzOGQkYpqRc8nzCQHGaF1c/FAexJk
         R1W2x2tIiLXkA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 9/9] habanalabs: refactor razwi/page-fault information structures
Date:   Wed, 28 Dec 2022 18:07:23 +0200
Message-Id: <20221228160723.387-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
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

This refactor makes the code clearer and the new variables' names
better describe their roles.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c      | 28 +++++++-----
 drivers/accel/habanalabs/common/habanalabs.h  | 44 ++++++++++++-------
 .../accel/habanalabs/common/habanalabs_drv.c  |  4 +-
 .../habanalabs/common/habanalabs_ioctl.c      |  6 +--
 4 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fe3540ed60d7..e1b5a2c34986 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2362,7 +2362,7 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_mmu_fini(hdev);
 
-	vfree(hdev->captured_err_info.pgf_info.user_mappings);
+	vfree(hdev->captured_err_info.page_fault_info.user_mappings);
 
 	hl_eq_fini(hdev, &hdev->event_queue);
 
@@ -2422,6 +2422,8 @@ inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
 			u8 flags)
 {
+	struct razwi_info *razwi_info = &hdev->captured_err_info.razwi_info;
+
 	if (num_of_engines > HL_RAZWI_MAX_NUM_OF_ENGINES_PER_RTR) {
 		dev_err(hdev->dev,
 				"Number of possible razwi initiators (%u) exceeded limit (%u)\n",
@@ -2430,15 +2432,15 @@ void hl_capture_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_
 	}
 
 	/* In case it's the first razwi since the device was opened, capture its parameters */
-	if (atomic_cmpxchg(&hdev->captured_err_info.razwi_info_recorded, 0, 1))
+	if (atomic_cmpxchg(&hdev->captured_err_info.razwi_info.razwi_detected, 0, 1))
 		return;
 
-	hdev->captured_err_info.razwi.timestamp = ktime_to_ns(ktime_get());
-	hdev->captured_err_info.razwi.addr = addr;
-	hdev->captured_err_info.razwi.num_of_possible_engines = num_of_engines;
-	memcpy(&hdev->captured_err_info.razwi.engine_id[0], &engine_id[0],
+	razwi_info->razwi.timestamp = ktime_to_ns(ktime_get());
+	razwi_info->razwi.addr = addr;
+	razwi_info->razwi.num_of_possible_engines = num_of_engines;
+	memcpy(&razwi_info->razwi.engine_id[0], &engine_id[0],
 			num_of_engines * sizeof(u16));
-	hdev->captured_err_info.razwi.flags = flags;
+	razwi_info->razwi.flags = flags;
 }
 
 void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_of_engines,
@@ -2452,7 +2454,7 @@ void hl_handle_razwi(struct hl_device *hdev, u64 addr, u16 *engine_id, u16 num_o
 
 static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 {
-	struct page_fault_info *pgf_info = &hdev->captured_err_info.pgf_info;
+	struct page_fault_info *pgf_info = &hdev->captured_err_info.page_fault_info;
 	struct hl_vm_phys_pg_pack *phys_pg_pack = NULL;
 	struct hl_vm_hash_node *hnode;
 	struct hl_userptr *userptr;
@@ -2514,13 +2516,15 @@ static void hl_capture_user_mappings(struct hl_device *hdev, bool is_pmmu)
 
 void hl_capture_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_pmmu)
 {
+	struct page_fault_info *pgf_info = &hdev->captured_err_info.page_fault_info;
+
 	/* Capture only the first page fault */
-	if (atomic_cmpxchg(&hdev->captured_err_info.pgf_info_recorded, 0, 1))
+	if (atomic_cmpxchg(&pgf_info->page_fault_detected, 0, 1))
 		return;
 
-	hdev->captured_err_info.pgf_info.pgf.timestamp = ktime_to_ns(ktime_get());
-	hdev->captured_err_info.pgf_info.pgf.addr = addr;
-	hdev->captured_err_info.pgf_info.pgf.engine_id = eng_id;
+	pgf_info->page_fault.timestamp = ktime_to_ns(ktime_get());
+	pgf_info->page_fault.addr = addr;
+	pgf_info->page_fault.engine_id = eng_id;
 	hl_capture_user_mappings(hdev, is_pmmu);
 }
 
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 9bcefbef5ad7..e578645acba9 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -2975,37 +2975,49 @@ struct undefined_opcode_info {
 };
 
 /**
- * struct page_fault_info - info about page fault
- * @pgf_info: page fault information.
+ * struct page_fault_info - page fault information.
+ * @page_fault: holds information collected during a page fault.
  * @user_mappings: buffer containing user mappings.
  * @num_of_user_mappings: number of user mappings.
+ * @page_fault_detected: if set as 1, then a page-fault was discovered for the
+ *                       first time after the driver has finished booting-up.
+ *                       Since we're looking for the page-fault's root cause,
+ *                       we don't care of the others that might follow it-
+ *                       so once changed to 1, it will remain that way.
  */
 struct page_fault_info {
-	struct hl_page_fault_info	pgf;
+	struct hl_page_fault_info	page_fault;
 	struct hl_user_mapping		*user_mappings;
 	u64				num_of_user_mappings;
+	atomic_t			page_fault_detected;
+};
+
+/**
+ * struct razwi_info - RAZWI information.
+ * @razwi: holds information collected during a RAZWI
+ * @razwi_detected: if set as 1, then a RAZWI was discovered for the
+ *                  first time after the driver has finished booting-up.
+ *                  Since we're looking for the RAZWI's root cause,
+ *                  we don't care of the others that might follow it-
+ *                  so once changed to 1, it will remain that way.
+ */
+struct razwi_info {
+	struct hl_info_razwi_event	razwi;
+	atomic_t			razwi_detected;
 };
 
 /**
  * struct hl_error_info - holds information collected during an error.
  * @cs_timeout: CS timeout error information.
- * @razwi: razwi information.
- * @razwi_info_recorded: if set writing to razwi information is enabled.
- *                       otherwise - disabled, so the first (root cause) razwi will not be
- *                       overwritten.
- * @undef_opcode: undefined opcode information
- * @pgf_info: page fault information.
- * @pgf_info_recorded: if set writing to page fault information is enabled.
- *                     otherwise - disabled, so the first (root cause) page fault will not be
- *                     overwritten.
+ * @razwi_info: RAZWI information.
+ * @undef_opcode: undefined opcode information.
+ * @page_fault_info: page fault information.
  */
 struct hl_error_info {
 	struct cs_timeout_info		cs_timeout;
-	struct hl_info_razwi_event	razwi;
-	atomic_t			razwi_info_recorded;
+	struct razwi_info		razwi_info;
 	struct undefined_opcode_info	undef_opcode;
-	struct page_fault_info		pgf_info;
-	atomic_t			pgf_info_recorded;
+	struct page_fault_info		page_fault_info;
 };
 
 /**
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 7815c60df54e..d7fe0af33bca 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -222,8 +222,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	hl_debugfs_add_file(hpriv);
 
 	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
-	atomic_set(&hdev->captured_err_info.razwi_info_recorded, 0);
-	atomic_set(&hdev->captured_err_info.pgf_info_recorded, 0);
+	atomic_set(&hdev->captured_err_info.razwi_info.razwi_detected, 0);
+	atomic_set(&hdev->captured_err_info.page_fault_info.page_fault_detected, 0);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
 
 	hdev->open_counter++;
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 0d9750006629..619d56c40b30 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -609,7 +609,7 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_info_razwi_event *info = &hdev->captured_err_info.razwi;
+	struct hl_info_razwi_event *info = &hdev->captured_err_info.razwi_info.razwi;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
 	if ((!max_size) || (!out))
@@ -788,7 +788,7 @@ static int page_fault_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_page_fault_info *info = &hdev->captured_err_info.pgf_info.pgf;
+	struct hl_page_fault_info *info = &hdev->captured_err_info.page_fault_info.page_fault;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
 	if ((!max_size) || (!out))
@@ -806,7 +806,7 @@ static int user_mappings_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	struct page_fault_info *pgf_info;
 	u64 actual_size;
 
-	pgf_info = &hdev->captured_err_info.pgf_info;
+	pgf_info = &hdev->captured_err_info.page_fault_info;
 	args->array_size = pgf_info->num_of_user_mappings;
 
 	if (!out)
-- 
2.34.1

