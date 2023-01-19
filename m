Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044267359A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjASKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjASKeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:34:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F2B676C6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:33:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA3161510
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35464C433D2;
        Thu, 19 Jan 2023 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124431;
        bh=L8rZG8Abv4/0u4UKyqrEt+o9G0yPEGVbe8tLin4R8q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VL5edJ2bj4lOGlm12KhhDKhfXmeIon0shD/povk/Zu/MaSV79lcORskCI+ltk7c1E
         0ayxnDp1nnMcrCrpb3PYTphUP9PTo/kgfmWrsq987gfQ4WMJzDGlAX2gWtI9PiHPOb
         BnWNHOwOJXudEQvw+AwPAYL1Uj7oEz1grIJu0WCWeNvWOvEpuKpea+iIMmpAvo+wvZ
         0FUfaEtQZBv9VzQAdh2CuZHvAXsOSSUEfIbnh7oLydpp45fnhMQrrO/MMQ70bljboG
         bpHDZ9YDh07FNv0xeSSx1t0uj9Eaeoy4o6VI4XljeTDRfnDYN9p8F6Kfx40hcS2KYY
         l0vy9IJxRgUgQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 05/10] habanalabs: refactor user interrupt type
Date:   Thu, 19 Jan 2023 12:33:34 +0200
Message-Id: <20230119103339.718430-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

In order to support more user interrupt types in the future, we
enumerate the user interrupt type instead of using a boolean.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h | 21 ++++++++++++--------
 drivers/accel/habanalabs/common/irq.c        | 19 +++++++++++++-----
 drivers/accel/habanalabs/gaudi2/gaudi2.c     |  9 +++++----
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 0b7fe4afd92d..a0dfbf4f6cbb 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1083,20 +1083,25 @@ struct hl_cq {
 	atomic_t		free_slots_cnt;
 };
 
+enum hl_user_interrupt_type {
+	HL_USR_INTERRUPT_CQ = 0,
+	HL_USR_INTERRUPT_DECODER,
+};
+
 /**
  * struct hl_user_interrupt - holds user interrupt information
  * @hdev: pointer to the device structure
+ * @type: user interrupt type
  * @wait_list_head: head to the list of user threads pending on this interrupt
  * @wait_list_lock: protects wait_list_head
  * @interrupt_id: msix interrupt id
- * @is_decoder: whether this entry represents a decoder interrupt
  */
 struct hl_user_interrupt {
-	struct hl_device	*hdev;
-	struct list_head	wait_list_head;
-	spinlock_t		wait_list_lock;
-	u32			interrupt_id;
-	bool			is_decoder;
+	struct hl_device		*hdev;
+	enum hl_user_interrupt_type	type;
+	struct list_head		wait_list_head;
+	spinlock_t			wait_list_lock;
+	u32				interrupt_id;
 };
 
 /**
@@ -2691,11 +2696,11 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	p->size = sz; \
 })
 
-#define HL_USR_INTR_STRUCT_INIT(usr_intr, hdev, intr_id, decoder) \
+#define HL_USR_INTR_STRUCT_INIT(usr_intr, hdev, intr_id, intr_type) \
 ({ \
 	usr_intr.hdev = hdev; \
 	usr_intr.interrupt_id = intr_id; \
-	usr_intr.is_decoder = decoder; \
+	usr_intr.type = intr_type; \
 	INIT_LIST_HEAD(&usr_intr.wait_list_head); \
 	spin_lock_init(&usr_intr.wait_list_lock); \
 })
diff --git a/drivers/accel/habanalabs/common/irq.c b/drivers/accel/habanalabs/common/irq.c
index 8bbcc223df91..a986d7dea453 100644
--- a/drivers/accel/habanalabs/common/irq.c
+++ b/drivers/accel/habanalabs/common/irq.c
@@ -333,13 +333,22 @@ irqreturn_t hl_irq_handler_user_interrupt(int irq, void *arg)
 	struct hl_user_interrupt *user_int = arg;
 	struct hl_device *hdev = user_int->hdev;
 
-	if (user_int->is_decoder)
-		handle_user_interrupt(hdev, &hdev->common_decoder_interrupt);
-	else
+	switch (user_int->type) {
+	case HL_USR_INTERRUPT_CQ:
 		handle_user_interrupt(hdev, &hdev->common_user_cq_interrupt);
 
-	/* Handle user cq or decoder interrupts registered on this specific irq */
-	handle_user_interrupt(hdev, user_int);
+		/* Handle user cq interrupt registered on this specific irq */
+		handle_user_interrupt(hdev, user_int);
+		break;
+	case HL_USR_INTERRUPT_DECODER:
+		handle_user_interrupt(hdev, &hdev->common_decoder_interrupt);
+
+		/* Handle decoder interrupt registered on this specific irq */
+		handle_user_interrupt(hdev, user_int);
+		break;
+	default:
+		break;
+	}
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 80cd4413b87d..65c720a0c64c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2966,11 +2966,11 @@ static void gaudi2_user_interrupt_setup(struct hl_device *hdev)
 
 	/* Initialize common user CQ interrupt */
 	HL_USR_INTR_STRUCT_INIT(hdev->common_user_cq_interrupt, hdev,
-				HL_COMMON_USER_CQ_INTERRUPT_ID, false);
+				HL_COMMON_USER_CQ_INTERRUPT_ID, HL_USR_INTERRUPT_CQ);
 
 	/* Initialize common decoder interrupt */
 	HL_USR_INTR_STRUCT_INIT(hdev->common_decoder_interrupt, hdev,
-				HL_COMMON_DEC_INTERRUPT_ID, true);
+				HL_COMMON_DEC_INTERRUPT_ID, HL_USR_INTERRUPT_DECODER);
 
 	/* User interrupts structure holds both decoder and user interrupts from various engines.
 	 * We first initialize the decoder interrupts and then we add the user interrupts.
@@ -2983,10 +2983,11 @@ static void gaudi2_user_interrupt_setup(struct hl_device *hdev)
 	 */
 	for (i = GAUDI2_IRQ_NUM_DCORE0_DEC0_NRM, j = 0 ; i <= GAUDI2_IRQ_NUM_SHARED_DEC1_NRM;
 										i += 2, j++)
-		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i, true);
+		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i,
+						HL_USR_INTERRUPT_DECODER);
 
 	for (i = GAUDI2_IRQ_NUM_USER_FIRST, k = 0 ; k < prop->user_interrupt_count; i++, j++, k++)
-		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i, false);
+		HL_USR_INTR_STRUCT_INIT(hdev->user_interrupt[j], hdev, i, HL_USR_INTERRUPT_CQ);
 }
 
 static inline int gaudi2_get_non_zero_random_int(void)
-- 
2.25.1

