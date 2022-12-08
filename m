Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221196472A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiLHPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiLHPOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4977ABA3B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B88C61F7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2EEC433C1;
        Thu,  8 Dec 2022 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512465;
        bh=Efq5ukaDJ2ts0dWvrsIKmLu4t+yi7P/WceV654akUco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+6qIkS34HzWkqwr1Qnuodm0vPwocNi7IE+dJqiZH0srusbkvR3o9BS/oSZdYyPYJ
         R0oCtxpU3t/TZqf6lhu+V8b4sx1IDCBe+qgRyBONFiBnvBgaCKIjNQu1HXnHHEAFjY
         c5JoHVn8Dm3jLsrRHqtzPnlXFYPREesRkzYdBIPVZh76pLubUFkp/gQuFx0o+ceKfN
         B4TQ6DX5o5pxQFp/cTosPvFlRtYPwqTM3SadQPIJAxFwAI+aFjoAU2RGIHvmW0iww8
         c6bqQFCWC46Nf5O+SGAm+DEnj+w8pxhGJvsevoYANOFeS8rmLvxaGCH7zbl887lJ2+
         6FITrXOCs2fsg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 23/26] habanalabs: fix handling of wait CS for interrupting signals
Date:   Thu,  8 Dec 2022 17:13:47 +0200
Message-Id: <20221208151350.1833823-23-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

The -ERESTARTSYS return value is not handled correctly when a signal is
received while waiting for CS completion.
This can lead to bad output values to user when waiting for a single CS
completion, and more severe, it can cause a non-stopping loop when
waiting to multi-CS completion and until a CS timeout.

Fix the handling and exit the waiting if this return value is received.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index cf3b82efc65c..0ec8cdcbb1f5 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2590,7 +2590,9 @@ static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence
 		*status = CS_WAIT_STATUS_BUSY;
 	}
 
-	if (error == -ETIMEDOUT || error == -EIO)
+	if (completion_rc == -ERESTARTSYS)
+		rc = completion_rc;
+	else if (error == -ETIMEDOUT || error == -EIO)
 		rc = error;
 
 	return rc;
@@ -2849,6 +2851,9 @@ static int hl_wait_multi_cs_completion(struct multi_cs_data *mcs_data,
 	if (completion_rc > 0)
 		mcs_data->timestamp = mcs_compl->timestamp;
 
+	if (completion_rc == -ERESTARTSYS)
+		return completion_rc;
+
 	mcs_data->wait_status = completion_rc;
 
 	return 0;
@@ -2994,15 +2999,15 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 free_seq_arr:
 	kfree(cs_seq_arr);
 
-	if (rc)
-		return rc;
-
-	if (mcs_data.wait_status == -ERESTARTSYS) {
+	if (rc == -ERESTARTSYS) {
 		dev_err_ratelimited(hdev->dev,
 				"user process got signal while waiting for Multi-CS\n");
-		return -EINTR;
+		rc = -EINTR;
 	}
 
+	if (rc)
+		return rc;
+
 	/* update output args */
 	memset(args, 0, sizeof(*args));
 
-- 
2.25.1

