Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4E6472A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLHPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLHPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AAABA15
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02351CE24C0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB12C433C1;
        Thu,  8 Dec 2022 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512455;
        bh=kqnJh32428fEtQQnluf14oKM86g0ErJo5Wv73mAYI7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igZeISUToq2SvC+PazVTJLrjcGauZWwZlAuV0owz8QbRIiO1/tssi7+zKg2qApZ40
         lIAvImA8IkDniGVJVwFjHT3sKqw8f3Hyb6RPgmTJWWctCdEtxvNHJPH8itlm3+57f0
         yAoMwgEow7fjb5vcp6pQ/kR/RXLQwJmyMcP0Dp4aNUfRilitsQDz1rntwyIOBLxbyN
         f+3fL2G8Tmsx0Hr2YGRmprpoHBaByDlbtvsKxtXj+axefhUWbDt95w3Xr4TV1ss7bo
         I4KWdQjqPTbZ3jaujyaI2N2xOjDdLJYAtP7epqRMohPUuHRoB2FSMfkCGxJlvBFUaN
         c6zR+RUhhOUOg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 15/26] habanalabs/gaudi2: support abrupt device reset event
Date:   Thu,  8 Dec 2022 17:13:39 +0200
Message-Id: <20221208151350.1833823-15-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

In certain scenarios, firmware might encounter a fatal event for
which a device reset is required. Hence, a proper notification
is needed for driver to be aware and initiate a reset sequence.

In secured environments the reset will be performed by firmware
without an explicit request from the driver.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c                         | 1 +
 drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h    | 1 +
 .../habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h   | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 8373239ad1bc..ba3b0ae76ebf 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -9226,6 +9226,7 @@ static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_ent
 		break;
 
 	case GAUDI2_EVENT_CPU_FP32_NOT_SUPPORTED:
+	case GAUDI2_EVENT_DEV_RESET_REQ:
 		event_mask |= HL_NOTIFIER_EVENT_GENERAL_HW_ERR;
 		error_count = GAUDI2_NA_EVENT_CAUSE;
 		is_critical = true;
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
index 305b576222e6..50852cc80373 100644
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_events.h
@@ -958,6 +958,7 @@ enum gaudi2_async_event_id {
 	GAUDI2_EVENT_CPU11_STATUS_NIC11_ENG1 = 1318,
 	GAUDI2_EVENT_ARC_DCCM_FULL = 1319,
 	GAUDI2_EVENT_CPU_FP32_NOT_SUPPORTED = 1320,
+	GAUDI2_EVENT_DEV_RESET_REQ = 1321,
 	GAUDI2_EVENT_SIZE,
 };
 
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
index d510cb10c883..82be01bea98e 100644
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi2/gaudi2_async_ids_map_extended.h
@@ -2665,6 +2665,8 @@ static struct gaudi2_async_events_ids_map gaudi2_irq_map_table[] = {
 		.msg = 1, .reset = 0, .name = "ARC_DCCM_FULL" },
 	{ .fc_id = 1320, .cpu_id = 626, .valid = 1,
 		.msg = 1, .reset = 1, .name = "FP32_NOT_SUPPORTED" },
+	{ .fc_id = 1321, .cpu_id = 627, .valid = 1,
+		.msg = 1, .reset = 1, .name = "DEV_RESET_REQ" },
 };
 
 #endif /* __GAUDI2_ASYNC_IDS_MAP_EVENTS_EXT_H_ */
-- 
2.25.1

