Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7510160F34C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiJ0JLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiJ0JKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597D63A8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 02:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BF162240
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C1C433D7;
        Thu, 27 Oct 2022 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666861826;
        bh=dk25msN57Pr+8aicPfnpENNefhThVP89CLpSsSKLWow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQL6L+D/i/xRquWbhfxbVd5+bCQ7QmWj5zYPEEeswfNwY4u1Aor3QS3UJDQzkUU1Y
         Ni+oX2HCJlkJHfarACJIUYYCO3bYIpfSe6c3UJ0cY7NBjqA2aBwa2gsinzzHaH3Zfg
         ziD+pB3VZYXXB63l0Ye/xmNLuXJmm94xsiBp5sX+UT8fvVU+PpoP0lMHmu5L5S+N0V
         /7PJTQSrYalq5lXsUvJK5NDVMIFxM+/JfWti/W/piT7BbbT/m6dA0XGEunbUxlZXFx
         5IyudWxyDZ8x+zKDu+engH8qlyN2FFm17HCgaY7kV3DlVVg2uRN81yzs81pQIl1W4e
         zajwkxahS6P8A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 10/15] habanalabs: use graceful hard reset for CS timeouts
Date:   Thu, 27 Oct 2022 12:10:02 +0300
Message-Id: <20221027091007.664797-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027091007.664797-1-ogabbay@kernel.org>
References: <20221027091007.664797-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Use graceful hard reset when detecting a CS timeout that requires a
device reset.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c  | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index fa05770865c6..f1c69c8ed74a 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -798,7 +798,7 @@ static void cs_do_release(struct kref *ref)
 static void cs_timedout(struct work_struct *work)
 {
 	struct hl_device *hdev;
-	u64 event_mask;
+	u64 event_mask = 0x0;
 	int rc;
 	struct hl_cs *cs = container_of(work, struct hl_cs,
 						 work_tdr.work);
@@ -830,11 +830,7 @@ static void cs_timedout(struct work_struct *work)
 	if (rc) {
 		hdev->captured_err_info.cs_timeout.timestamp = ktime_get();
 		hdev->captured_err_info.cs_timeout.seq = cs->sequence;
-
-		event_mask = device_reset ? (HL_NOTIFIER_EVENT_CS_TIMEOUT |
-				HL_NOTIFIER_EVENT_DEVICE_RESET) : HL_NOTIFIER_EVENT_CS_TIMEOUT;
-
-		hl_notifier_event_send_all(hdev, event_mask);
+		event_mask |= HL_NOTIFIER_EVENT_CS_TIMEOUT;
 	}
 
 	switch (cs->type) {
@@ -869,8 +865,12 @@ static void cs_timedout(struct work_struct *work)
 
 	cs_put(cs);
 
-	if (device_reset)
-		hl_device_reset(hdev, HL_DRV_RESET_TDR);
+	if (device_reset) {
+		event_mask |= HL_NOTIFIER_EVENT_DEVICE_RESET;
+		hl_device_cond_reset(hdev, HL_DRV_RESET_TDR, event_mask);
+	} else if (event_mask) {
+		hl_notifier_event_send_all(hdev, event_mask);
+	}
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
-- 
2.25.1

