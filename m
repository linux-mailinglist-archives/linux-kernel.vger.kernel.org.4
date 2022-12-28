Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE307657FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiL1QI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiL1QHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89B17E07
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30402B81719
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491E2C433D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243659;
        bh=LRxjEmcUHk89qvwWOxESkLJnM3fumLFF+Py+w4Og2lk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FRqquti8y3vRc/D/HIC4Rw+ezG4MSL8Ipho5uS1Fgd9/f4c6jtCb+5Hkpmfg22ncf
         KbAkmdttuncwy2E8Dih4IFXvmluG18BlnNxAr/vUxobsDezalzs3pfZWXkgBZP/7Zl
         KBsuG0TpFtC02ivFX1MWcuDW8UbZr6oUDnW1u/Ay/67fLCy64hUwB/WQvHpc1gNEfQ
         5SZnAM3q2Vu7oFQVX9eneLCcUaobVlCB88GH5FcBPPnFCqcJObYbFEhabfwTXZCW1R
         X9a7grLUeaMZY7nzmrRbYR7TsL3kD9m3wUoAsNoWVpGAxZ8hYe7HzR/SW/Mp28inN8
         jmi7YlUCWvxtg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] habanalabs: move some prints to debug level
Date:   Wed, 28 Dec 2022 18:07:20 +0200
Message-Id: <20221228160723.387-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
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

When entering an IOCTL, the driver prints a message in case device is
not operational. This message should be printed in debug level as
it can spam the kernel log and it is not an error.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/command_buffer.c   | 2 +-
 drivers/accel/habanalabs/common/habanalabs_ioctl.c | 4 ++--
 drivers/accel/habanalabs/common/memory.c           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_buffer.c b/drivers/accel/habanalabs/common/command_buffer.c
index 390011b02239..3a0535ac28b1 100644
--- a/drivers/accel/habanalabs/common/command_buffer.c
+++ b/drivers/accel/habanalabs/common/command_buffer.c
@@ -368,7 +368,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 	int rc;
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_warn_ratelimited(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Device is %s. Can't execute CB IOCTL\n",
 			hdev->status[status]);
 		return -EBUSY;
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
index 079483421e12..0d9750006629 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -941,7 +941,7 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	}
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_warn_ratelimited(dev,
+		dev_dbg_ratelimited(dev,
 			"Device is %s. Can't execute INFO IOCTL\n",
 			hdev->status[status]);
 		return -EBUSY;
@@ -1026,7 +1026,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 	int rc = 0;
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_warn_ratelimited(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Device is %s. Can't execute DEBUG IOCTL\n",
 			hdev->status[status]);
 		return -EBUSY;
diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 1c38fab39337..56283dd874e1 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -2261,7 +2261,7 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 	int rc, dmabuf_fd = -EBADF;
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_warn_ratelimited(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Device is %s. Can't execute MEMORY IOCTL\n",
 			hdev->status[status]);
 		return -EBUSY;
-- 
2.34.1

