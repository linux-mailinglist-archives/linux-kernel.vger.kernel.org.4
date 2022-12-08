Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF1A6472A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLHPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLHPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4FAD30A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A03861F79
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EA1C433B5;
        Thu,  8 Dec 2022 15:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512457;
        bh=QCFI8Bg0UNmXzc0lLft98hLai46arv5oXu2M9fxiNmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ks5WIIexjuGux+LQlCrHSfwsGEnYE9GxB6qP7/MD63O5fncATPyVYrT7WXw1U1grF
         z82yCCTHWVO2x6ijzSRD9sgKEpFrHt1eKv6rqKEdVfmAZqhNoHMFKWuz3lJ0NEQ6XR
         qeARM0lBZTEfW7oadR5tv8nA0lOgFcL2hklRlThwmkzOD0xuHHKNhbqeeljg+PwnVs
         e+4endn65oQRm6prYRZu16SclzFejf+kSskkXTpGKUpsaWAIwL5b08wJJAo8fw+VG0
         u9k5gLINhxgvewurELgdTKW2fuI4hcB2k2N4Vf9QMNRNeMLhxWLS4cMLxfFcF801b5
         uAMY1HedC+9og==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 17/26] habanalabs: trace COMMS protocol
Date:   Thu,  8 Dec 2022 17:13:41 +0200
Message-Id: <20221208151350.1833823-17-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

Call COMMS tracepoints from within the dynamic CPU FW load.
This can help debug failures or delays in the dynamic FW load flow.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 046866c673e2..ebb81cf89f02 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -14,8 +14,32 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 
+#include <trace/events/habanalabs.h>
+
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
+static char *comms_cmd_str_arr[COMMS_INVLD_LAST] = {
+	[COMMS_NOOP] = __stringify(COMMS_NOOP),
+	[COMMS_CLR_STS] = __stringify(COMMS_CLR_STS),
+	[COMMS_RST_STATE] = __stringify(COMMS_RST_STATE),
+	[COMMS_PREP_DESC] = __stringify(COMMS_PREP_DESC),
+	[COMMS_DATA_RDY] = __stringify(COMMS_DATA_RDY),
+	[COMMS_EXEC] = __stringify(COMMS_EXEC),
+	[COMMS_RST_DEV] = __stringify(COMMS_RST_DEV),
+	[COMMS_GOTO_WFE] = __stringify(COMMS_GOTO_WFE),
+	[COMMS_SKIP_BMC] = __stringify(COMMS_SKIP_BMC),
+	[COMMS_PREP_DESC_ELBI] = __stringify(COMMS_PREP_DESC_ELBI),
+};
+
+static char *comms_sts_str_arr[COMMS_STS_INVLD_LAST] = {
+	[COMMS_STS_NOOP] = __stringify(COMMS_STS_NOOP),
+	[COMMS_STS_ACK] = __stringify(COMMS_STS_ACK),
+	[COMMS_STS_OK] = __stringify(COMMS_STS_OK),
+	[COMMS_STS_ERR] = __stringify(COMMS_STS_ERR),
+	[COMMS_STS_VALID_ERR] = __stringify(COMMS_STS_VALID_ERR),
+	[COMMS_STS_TIMEOUT_ERR] = __stringify(COMMS_STS_TIMEOUT_ERR),
+};
+
 static char *extract_fw_ver_from_str(const char *fw_str)
 {
 	char *str, *fw_ver, *whitespace;
@@ -1634,6 +1658,7 @@ static void hl_fw_dynamic_send_cmd(struct hl_device *hdev,
 	val = FIELD_PREP(COMMS_COMMAND_CMD_MASK, cmd);
 	val |= FIELD_PREP(COMMS_COMMAND_SIZE_MASK, size);
 
+	trace_habanalabs_comms_send_cmd(hdev->dev, comms_cmd_str_arr[cmd]);
 	WREG32(le32_to_cpu(dyn_regs->kmd_msg_to_cpu), val);
 }
 
@@ -1691,6 +1716,8 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 
 	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
+	trace_habanalabs_comms_wait_status(hdev->dev, comms_sts_str_arr[expected_status]);
+
 	/* Wait for expected status */
 	rc = hl_poll_timeout(
 		hdev,
@@ -1706,6 +1733,8 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		return -EIO;
 	}
 
+	trace_habanalabs_comms_wait_status_done(hdev->dev, comms_sts_str_arr[expected_status]);
+
 	/*
 	 * skip storing FW response for NOOP to preserve the actual desired
 	 * FW status
@@ -1778,6 +1807,8 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 {
 	int rc;
 
+	trace_habanalabs_comms_protocol_cmd(hdev->dev, comms_cmd_str_arr[cmd]);
+
 	/* first send clear command to clean former commands */
 	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
 	if (rc)
-- 
2.25.1

