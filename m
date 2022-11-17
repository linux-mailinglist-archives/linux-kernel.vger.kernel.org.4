Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7719862E185
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiKQQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbiKQQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC87AF7C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31A14B8210B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BE9C433C1;
        Thu, 17 Nov 2022 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702019;
        bh=YAKqdM7h7qVJaewu+jPaUrt4aE7EX+bze99EdvKRQ1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZwM2AouHs7ushJpOB6Qdgx6wLFdtb0ll/NY5k8wwRtCWIq1ZI1UKi8GlweqkxNQ+
         1Qf2IhtZVySQgUjaE9jLe65eqcADBYC2n8iqPBdNWqUBHh2zuw85Ayq/IfBSPRTb/o
         /QuKU5p8KVMp2YWjZkHphnvI5ntpLO3QT4fdYEgMiC03vuQ2l0UrCnhiIDdkIgOd5R
         eR11WCfr/1odA6k4Nvpbhkb0WfbYxeiJLZnJ/8vUvKWvAt8nPqCApJHdr/lN63f7UO
         iOSciE3H5p3uWsZ88V421gLS5nNemQopMWNDTHYHJA/HAfA88tyMoDOt+wL6SEA/8w
         JaSJyBTbpf8dQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 18/20] habanalabs: extend process wait timeout in device fine
Date:   Thu, 17 Nov 2022 18:19:49 +0200
Message-Id: <20221117161951.845454-18-ogabbay@kernel.org>
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

Processes that use our device are likely to use at the same time other
devices such as remote storage.

In case our device is removed and a user process is still using the
device, we need to kill the user process. However, if that process
has a thread waiting for i/o to complete on remote storage, for example,
the process won't terminate.

Let's give it enough time to terminate before giving up.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/common/device.c     |  6 ++++--
 drivers/misc/habanalabs/common/habanalabs.h | 11 ++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0650e511a0f5..63d0cb7087e8 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -2300,14 +2300,16 @@ void hl_device_fini(struct hl_device *hdev)
 	 */
 	dev_info(hdev->dev,
 		"Waiting for all processes to exit (timeout of %u seconds)",
-		HL_PENDING_RESET_LONG_SEC);
+		HL_WAIT_PROCESS_KILL_ON_DEVICE_FINI);
 
-	rc = device_kill_open_processes(hdev, HL_PENDING_RESET_LONG_SEC, false);
+	hdev->process_kill_trial_cnt = 0;
+	rc = device_kill_open_processes(hdev, HL_WAIT_PROCESS_KILL_ON_DEVICE_FINI, false);
 	if (rc) {
 		dev_crit(hdev->dev, "Failed to kill all open processes\n");
 		device_disable_open_processes(hdev, false);
 	}
 
+	hdev->process_kill_trial_cnt = 0;
 	rc = device_kill_open_processes(hdev, 0, true);
 	if (rc) {
 		dev_crit(hdev->dev, "Failed to kill all control device open processes\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0781b8698f74..e7f89868428d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -50,9 +50,14 @@ struct hl_fpriv;
 #define HL_MMAP_OFFSET_VALUE_MASK	(0x1FFFFFFFFFFFull >> PAGE_SHIFT)
 #define HL_MMAP_OFFSET_VALUE_GET(off)	(off & HL_MMAP_OFFSET_VALUE_MASK)
 
-#define HL_PENDING_RESET_PER_SEC	10
-#define HL_PENDING_RESET_MAX_TRIALS	60 /* 10 minutes */
-#define HL_PENDING_RESET_LONG_SEC	60
+#define HL_PENDING_RESET_PER_SEC		10
+#define HL_PENDING_RESET_MAX_TRIALS		60 /* 10 minutes */
+#define HL_PENDING_RESET_LONG_SEC		60
+/*
+ * In device fini, wait 10 minutes for user processes to be terminated after we kill them.
+ * This is needed to prevent situation of clearing resources while user processes are still alive.
+ */
+#define HL_WAIT_PROCESS_KILL_ON_DEVICE_FINI	600
 
 #define HL_HARD_RESET_MAX_TIMEOUT	120
 #define HL_PLDM_HARD_RESET_MAX_TIMEOUT	(HL_HARD_RESET_MAX_TIMEOUT * 3)
-- 
2.25.1

