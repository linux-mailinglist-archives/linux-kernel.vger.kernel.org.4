Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3636964729D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiLHPPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiLHPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125BABA29
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60E1CCE24B1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C52C433D6;
        Thu,  8 Dec 2022 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512452;
        bh=0Ny7Hg3x78P01JGdM08WcN1k/djTpuFQmBSNIxo7jgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbNUGvwrJTI+vrijnj+Mmqwu6/lP2LPmmuDiDstCMuBiW8GLyjvVDBupB4CifGAZL
         EDKG4YLGg5zUwQuDRoKmOJJVd1UyzNkUMamWHIL2oNbFeLXZ9D7vQQr735Mxh10P6a
         OaFQY643RxypX823iEmg3mo1QAV8jgN0J3nZhTT5f/o6Yw4OfaEpvmMNCzGzJLIqWC
         4vyZ+Wv4822ueSlRCCGMR7lBnhnwfwh4rbqu3kIimslsgNZqg/stwY8zq9Wv6NdOQT
         bzc9i5JNeA5sTCeeQjcFue84NBHvbZZGTGuismYcA8/VDaQ0BPGB46ub2hPPbOvRUm
         lJ1NzcmoNvUSw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tamir Gilad-Raz <tgiladraz@habana.ai>
Subject: [PATCH 13/26] habanalabs: adjacent timestamps should be more accurate
Date:   Thu,  8 Dec 2022 17:13:37 +0200
Message-Id: <20221208151350.1833823-13-ogabbay@kernel.org>
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

From: Tamir Gilad-Raz <tgiladraz@habana.ai>

timestamp events that expire on the same interrupt will get the same
timestamp value

Signed-off-by: Tamir Gilad-Raz <tgiladraz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 94d537fd4fde..8bbcc223df91 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -228,7 +228,7 @@ static void hl_ts_free_objects(struct work_struct *work)
  * list to a dedicated workqueue to do the actual put.
  */
 static int handle_registration_node(struct hl_device *hdev, struct hl_user_pending_interrupt *pend,
-						struct list_head **free_list)
+						struct list_head **free_list, ktime_t now)
 {
 	struct timestamp_reg_free_node *free_node;
 	u64 timestamp;
@@ -246,7 +246,7 @@ static int handle_registration_node(struct hl_device *hdev, struct hl_user_pendi
 	if (!free_node)
 		return -ENOMEM;
 
-	timestamp = ktime_get_ns();
+	timestamp = ktime_to_ns(now);
 
 	*pend->ts_reg_info.timestamp_kernel_addr = timestamp;
 
@@ -298,7 +298,7 @@ static void handle_user_interrupt(struct hl_device *hdev, struct hl_user_interru
 			if (pend->ts_reg_info.buf) {
 				if (!reg_node_handle_fail) {
 					rc = handle_registration_node(hdev, pend,
-									&ts_reg_free_list_head);
+								&ts_reg_free_list_head, now);
 					if (rc)
 						reg_node_handle_fail = true;
 				}
-- 
2.25.1

