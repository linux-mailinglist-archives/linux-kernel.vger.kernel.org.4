Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9207D62E167
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiKQQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiKQQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC113F0C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 530E4B82105
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39079C433D7;
        Thu, 17 Nov 2022 16:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702000;
        bh=Wyk7lT1v0uAkDcUm3xXjjvQqRWlvY+GJsghgh3FORyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9OvvzvCEeLyHpMz5WACCkl/FfLI0IBsLSd3EVvzT6Lw90f4iLghlsOL0YH3rFSiK
         c4+sVHcfQUfyKpHn0kWK6SdDmFGyYP8pfoAnHjbfuS0IcamW05jP/hXJnJZP80SVXy
         lBmMmeqFbz1csCCF4X6jviCTAIV5o8UF2sd6lNTXrOjtPHWAto3vfuEAvyUCzxPpMC
         sHIXOhgVYRqpSqTJELPeWKn8UqB17T3QxiOPi7eXY+ZmzdxjzORDmDmzUUom+rowpJ
         5XYMbErdere4/DfVfa5SwOyGqde5273fyppB2g/SjGTaecM6Helb2JwNMwyrtpfMly
         Km7gL+pRuEPsQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 03/20] habanalabs: use single threaded WQ for event handling
Date:   Thu, 17 Nov 2022 18:19:34 +0200
Message-Id: <20221117161951.845454-3-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

Creating event queue workqueue using alloc_workqueue made it run in
multi threaded mode, which caused parallel dumping of events as well as
parallel events notifying to user, causing logs with multiple
events to be out of order.

Fixed by creating event queue workqueue as single threaded work queue.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index d1a609589558..65bb40f81901 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -787,7 +787,7 @@ static int device_early_init(struct hl_device *hdev)
 		}
 	}
 
-	hdev->eq_wq = alloc_workqueue("hl-events", WQ_UNBOUND, 0);
+	hdev->eq_wq = create_singlethread_workqueue("hl-events");
 	if (hdev->eq_wq == NULL) {
 		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
 		rc = -ENOMEM;
-- 
2.25.1

