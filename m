Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A862E168
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiKQQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiKQQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:20:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643873B8A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:20:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4022B62129
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39DDC433D6;
        Thu, 17 Nov 2022 16:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668702002;
        bh=ZN1OImQXtdV/N+x4MEmihbOCG5GyKnlc5upWgVkA87I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uAPHuz1e1elQCUTlIboF8V9UIMamUtm78xZfnt4wZkdceqvIsLHcI127q8j8J0TO4
         qRnjhSpLra/X28V+v+uAQBpqSpGMpobQ+v0qwxY2oe9RaXaUrpmwlSryGImIsBcaSd
         OUExCNftFazT3rsS0l/iODjaKWHzfXcnjHAvWKMxzFPo2JP8iAefxc1d8WxZz9uHYq
         7oXlKPRJqZlXcBob1qgdu9Rq0MNllMssHFZQAarTl5gIbW5kE4onxUwcazwUqvNXov
         Fhr3SeydjXwtov1OBl387y3lPG7H8XmAjrmgQ6ZNwrlmnfHHayhg8SUqiS9sv+tAe5
         O42P6rr8oWjlQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 05/20] habanalabs/gaudi2: implement fp32 not supported event
Date:   Thu, 17 Nov 2022 18:19:36 +0200
Message-Id: <20221117161951.845454-5-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

Due to binning, Gaudi2 does not always support fp32.
We add support for such an event in case fp32 is used by the user
in such a device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c                      | 5 +++++
 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h | 1 +
 .../include/gaudi2/gaudi2_async_ids_map_extended.h           | 4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index f21b68be6d20..77bdbab41e6c 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9148,6 +9148,11 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
 		break;
 
+	case GAUDI2_EVENT_CPU_FP32_NOT_SUPPORTED:
+		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
+		is_critical = true;
+		break;
+
 	default:
 		if (gaudi2_irq_map_table[event_type].valid)
 			dev_err_ratelimited(hdev->dev, "Cannot find handler for event %d\n",
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
index 34406770a76a..305b576222e6 100644
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
@@ -957,6 +957,7 @@ enum gaudi2_async_event_id {
 	GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG0 = 1317,
 	GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1 = 1318,
 	GAUDI2_EVENT_ARC_DCCM_FULL = 1319,
+	GAUDI2_EVENT_CPU_FP32_NOT_SUPPORTED = 1320,
 	GAUDI2_EVENT_SIZE,
 };
 
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
index 5bd4383c9f2c..d510cb10c883 100644
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2018-2021 HabanaLabs, Ltd.
+ * Copyright 2018-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -2663,6 +2663,8 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 		.msg = 1, .reset = 0, .name = "STATUS_NIC11_ENG1" },
 	{ .fc_id = 1319, .cpu_id = 625, .valid = 1,
 		.msg = 1, .reset = 0, .name = "ARC_DCCM_FULL" },
+	{ .fc_id = 1320, .cpu_id = 626, .valid = 1,
+		.msg = 1, .reset = 1, .name = "FP32_NOT_SUPPORTED" },
 };
 
 #endif /* __GAUDI2_ASYNC_IDS_MAP_EVENTS_EXT_H_ */
-- 
2.25.1

