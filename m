Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9F5F6289
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJFIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiJFIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E277D92594
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9CE618A2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5057C433D7;
        Thu,  6 Oct 2022 08:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044610;
        bh=Z7koDOX2N0DzjTg+BL9ft7KWPriTFQs6K+rIPk1Vft8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZlYjToJPChoaoGpGZKaFFBFSN2rsIMeSoxeaUUTYTGegfWCiInVJjpM6/zavolnM
         /J179heIPW78hvKnqGN3qY780SF6sB4BzqRHIcRKtyIk8lhwPIgUqVqtl3GzCycgPT
         gD6brKZ6f7d5B7W+u86k3DtUGBBRvEWVwBWV+RjZsbO61ucVt2al+cmH5JqdFOLlPF
         r7idLZYBa/K0gGznH4bH9T4JFtUSwidSiirMBq2OfubNIpg0hXmSx4Vbzcg6lIymoY
         DceIKRPbMWpdqWqcU8Ua4g1CnqHruc0K2dW8Bfs96qfxsWH6XVtRFUKGlxEBBLdIMw
         BeJc/nIDfhJ2Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 13/13] habanalabs: verify no zero event is sent
Date:   Thu,  6 Oct 2022 11:23:08 +0300
Message-Id: <20221006082308.1266716-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

The event notifier mechanism should not raise an empty
event (event equals zero).

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 5 +++++
 drivers/misc/habanalabs/gaudi/gaudi.c   | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b8b32285720d..9b54d1df5302 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1746,6 +1746,11 @@ void hl_notifier_event_send_all(struct hl_device *hdev, u64 event_mask)
 {
 	struct hl_fpriv	*hpriv;
 
+	if (!event_mask) {
+		dev_warn(hdev->dev, "Skip sending zero event");
+		return;
+	}
+
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1a99f7be8b60..337123f73501 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7945,7 +7945,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entr
 	/* despite reset doesn't execute. a notification on
 	 * occurred event needs to be sent here
 	 */
-	hl_notifier_event_send_all(hdev, event_mask);
+	if (event_mask)
+		hl_notifier_event_send_all(hdev, event_mask);
+
 	if (reset_required)
 		hl_device_reset(hdev, flags);
 	else
-- 
2.25.1

