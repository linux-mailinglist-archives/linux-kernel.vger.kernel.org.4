Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA04F62E17C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbiKQQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiKQQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8357A35D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB983B8210A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE70C433D6;
        Thu, 17 Nov 2022 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702010;
        bh=j3xCV8+gZ5DdIUThsLOjpQ6nM+SExrFIzy3t+gNDPRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4LpwbMKQLwC9zSQYUUu0PR6ZuMdKhgDA2mZpE9vaUBr0LceUvgEFN5PAzlqHmLlq
         XpkfNmYtAZkkKMAgYeiaNphtDhh5EAIj0+Va8pv6yYKYVmBKhaOEwHORrm4lbOP8GI
         qMc/jsJfB4CxlyoSCYi4ch+Tjyn8CNS433HL900DX5Dhq1mPbkuZOuMxIU/VROgTVB
         UAbUaX40oG7CzRhrOUgYhNwbygYV0prvVITuKSLlICozutlM+0Fji4V44hV1iWv8RH
         vpq7jtW58e+w8hSnqbxUOAxG0CnY/PBo4w7WxrF8tzGzkQGryp/LEjRB5F1nc5l0k3
         aTJJaOUew264A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 11/20] habanalabs: fix print for out-of-sync and pkt-failure events
Date:   Thu, 17 Nov 2022 18:19:42 +0200
Message-Id: <20221117161951.845454-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117161951.845454-1-ogabbay@kernel.org>
References: <20221117161951.845454-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

Add missing le32_to_cpu() conversions, and use %d for the value
returned from atomic_read().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c   | 4 ++--
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 8 ++++----
 drivers/misc/habanalabs/goya/goya.c     | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index cbe1daf5a793..7b93f0d26dd0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7347,8 +7347,8 @@ static void gaudi_print_out_of_sync_info(struct hl_device *hdev,
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI_QUEUE_ID_CPU_PQ];
 
-	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
-			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
+		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
 static void gaudi_print_fw_alive_info(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 65c9b535aa69..bdb5782afb7e 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8684,8 +8684,8 @@ static void gaudi2_print_out_of_sync_info(struct hl_device *hdev,
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
 
-	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
-			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
+		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
 static void gaudi2_handle_pcie_p2p_msix(struct hl_device *hdev)
@@ -8751,8 +8751,8 @@ static void gaudi2_print_cpu_pkt_failure_info(struct hl_device *hdev,
 	struct hl_hw_queue *q = &hdev->kernel_queues[GAUDI2_QUEUE_ID_CPU_PQ];
 
 	dev_warn(hdev->dev,
-		"FW reported sanity check failure, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
-		sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+		"FW reported sanity check failure, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
+		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
 static void hl_arc_event_handle(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5ef9e3ca97a6..0f083fcf81a6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4475,8 +4475,8 @@ static void goya_print_out_of_sync_info(struct hl_device *hdev,
 {
 	struct hl_hw_queue *q = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
 
-	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%u\n",
-			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
+	dev_err(hdev->dev, "Out of sync with FW, FW: pi=%u, ci=%u, LKD: pi=%u, ci=%d\n",
+		le32_to_cpu(sync_err->pi), le32_to_cpu(sync_err->ci), q->pi, atomic_read(&q->ci));
 }
 
 static void goya_print_irq_info(struct hl_device *hdev, u16 event_type,
-- 
2.25.1

