Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE45BCB81
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiISMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:10:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5480AE5A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 54E91CE1009
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B83C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663589434;
        bh=ULkYpmBM29DnvU4UoSkKL3vvWUuUnLQSfkf+lc1m12M=;
        h=From:To:Subject:Date:From;
        b=pgPosi1sN1NA9BFn1O7Y7argdC5oElYpcN8BvvxZaCM0gJ/EQCNJuDeIgrhyITJAr
         4xMYa02ZiIn6dsAYhkuuwpA1h4LodSkRU5AH/rEuc7qgh6772poysV7VakULoOH78N
         MhTuDYxat7lvbx7GwdyDFC+ZCrG8ZZ/5CH6oZc0FDxU00t+57CNGQZ8tOSGkgyVCh/
         94QCGThDhjrbDYyC5zbbiaYrDt4g+jTetMalxmlz/SMa+OcmJltvMQer0/+58V6bxv
         KMQHCqbriGt0PqkYm7ZphOg1LjgQZ2yUva8BCS9dc0c/3dPSS3B4d5Np8ogXltz9jB
         Ouxbf5V7H/L8w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: failure to open device due to reset is debug level
Date:   Mon, 19 Sep 2022 15:10:24 +0300
Message-Id: <20220919121025.58172-1-ogabbay@kernel.org>
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

If the user wants to open the device, and the device is currently in
reset, the user will get an error from the open().

We don't need to display an error in the dmesg for that as it is
not a real error and we can spam the kernel log with this message.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 5250bfb6790e..112632afe7d5 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -161,7 +161,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	if (!hl_device_operational(hdev, &status)) {
-		dev_err_ratelimited(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Can't open %s because it is %s\n",
 			dev_name(hdev->dev), hdev->status[status]);
 
@@ -271,7 +271,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 
 	if (!hl_device_operational(hdev, NULL)) {
-		dev_err_ratelimited(hdev->dev_ctrl,
+		dev_dbg_ratelimited(hdev->dev_ctrl,
 			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev_ctrl));
 		rc = -EPERM;
-- 
2.25.1

