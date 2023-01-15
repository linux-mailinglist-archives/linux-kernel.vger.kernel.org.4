Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924066B028
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjAOJkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAOJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:40:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25CC156
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 01:40:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3033160C6E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 09:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC140C433D2;
        Sun, 15 Jan 2023 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673775631;
        bh=UBzVcY5fRcwQWrhHV++8YM9LVjjvCcbqwKbKRaWY10k=;
        h=From:To:Cc:Subject:Date:From;
        b=S99mCXMmnxl+jXMUUKTRwMZcZtW4HC+qzZwuN8YxddJ4GLVphQCToke6aMSMWawjH
         c7BDz9cWwZBPtj33HzQMaCsyAbyLXBQCEUiy2tPKhKr16rZ6FB7Tx+44xIthAVEp3i
         pR8bengq/+P9p3qGtShNdtAqqMhbABz7DZtvjSWqD0wOwnAclaSwmdwgjc0WhwWxfd
         NGLH99ifTX3Hx2Wt4czhhMWlg26Ym0PwTGV42T+Iyud7Z9zLUtGnKMG4NqeTaFeRc0
         WeCr+Ozx9DrzSHitCjpV8F86EnxExiLF6iuOY59RZDf07kkn07VEH5Z7HBwWbbNn8T
         rQ0mOG+GA+sqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/5] habanalabs: check pad and reserved fields in ioctls
Date:   Sun, 15 Jan 2023 11:40:22 +0200
Message-Id: <20230115094026.289766-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: farah kassabri <fkassabri@habana.ai>

Make sure all reserved/pad fields in uapi input structures
are set to 0.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../accel/habanalabs/common/command_submission.c  | 15 ++++++++++++++-
 .../accel/habanalabs/common/habanalabs_ioctl.c    |  6 +++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index bb9584d72c32..c54f504383ac 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -1310,6 +1310,13 @@ static int hl_cs_sanity_checks(struct hl_fpriv *hpriv, union hl_cs_args *args)
 	enum hl_device_status status;
 	enum hl_cs_type cs_type;
 	bool is_sync_stream;
+	int i;
+
+	for (i = 0 ; i < sizeof(args->in.pad) ; i++)
+		if (args->in.pad[i]) {
+			dev_dbg(hdev->dev, "Padding bytes must be 0\n");
+			return -EINVAL;
+		}
 
 	if (!hl_device_operational(hdev, &status)) {
 		return -EBUSY;
@@ -2918,7 +2925,13 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	u32 size_to_copy;
 	u64 *cs_seq_arr;
 	u8 seq_arr_len;
-	int rc;
+	int rc, i;
+
+	for (i = 0 ; i < sizeof(args->in.pad) ; i++)
+		if (args->in.pad[i]) {
+			dev_dbg(hdev->dev, "Padding bytes must be 0\n");
+			return -EINVAL;
+		}
 
 	if (!hdev->supports_wait_for_multi_cs) {
 		dev_err(hdev->dev, "Wait for multi CS is not supported\n");
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 72493bf94ba3..5005e6fca691 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -884,9 +884,13 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	enum hl_device_status status;
 	struct hl_info_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
-
 	int rc;
 
+	if (args->pad) {
+		dev_dbg(hdev->dev, "Padding bytes must be 0\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Information is returned for the following opcodes even if the device
 	 * is disabled or in reset.
-- 
2.25.1

