Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470071FC94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjFBIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjFBIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:51:01 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9296C10EF;
        Fri,  2 Jun 2023 01:50:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id ED5803F181;
        Fri,  2 Jun 2023 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1685695846;
        bh=9iDW23eSDGpAU5YPcKTOrXKlERG4X+SdChKCH7zHRoE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=YeXM7zAYzGpv/Tgh19segV9F0cuncXXVEmaobPJ0MIVMdrRkhjpcmeW2nS1F00BlO
         lJO2gfE5ZwyDtZQDtlryH4uEzhlsulbaUDjWR/xAioOseUVily8cZkUWHHnxEY829O
         IZLMWXfBKirAz0Lnc809TPdds3niGmrg0eotgcqptRTf2d95GPxiqrnGacQmBcruGa
         bTaWkXlW+/VlvlnOPfigL7s2zLXEm6LuyPSB6RdU4fWJ53LIj2HTt5z/CFZjVHDdeY
         DOZDv4c/CnjpHBJ3mpYW3MWdFnoOsF1geOhhwSVm+Nm6YGCJi04fQ8bqaGCFhF2HC7
         VA07WFU6wvUDA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     dlemoal@kernel.org, bblock@linux.ibm.com, acelan.kao@canonical.com,
        linux-pm@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] scsi: core: Wait until device is fully resumed before doing rescan
Date:   Fri,  2 Jun 2023 16:49:56 +0800
Message-Id: <20230602084956.1299001-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During system resuming process, the resuming order is from top to down.
Namely, the ATA host is resumed before disks connected to it.

When an EH is scheduled while ATA host is resumed and disk device is
still suspended, the device_lock hold by scsi_rescan_device() is never
released so the dpm_resume() of the disk is blocked forerver, therefore
the system can never be resumed back.

That's because scsi_attach_vpd() is expecting the disk device is in
operational state, as it doesn't work on suspended device.

To avoid such deadlock, wait until the scsi device is fully resumed,
before continuing the rescan process.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v6:
 - Fix !CONFIG_PM_SLEEP compilation error.

v5:
 - Use a different approach. Wait until the disk device is resumed.

v4: 
 - No change.

v3:
 - New patch to resolve undefined pm_suspend_target_state.

v2:
 - Schedule rescan task at the end of system resume phase.
 - Wording.

 drivers/scsi/scsi_scan.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index d217be323cc6..092f37464101 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1621,6 +1621,11 @@ void scsi_rescan_device(struct device *dev)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 
+#ifdef CONFIG_PM_SLEEP
+	if (dev->power.is_suspended)
+		wait_for_completion(&dev->power.completion);
+#endif
+
 	device_lock(dev);
 
 	scsi_attach_vpd(sdev);
-- 
2.34.1

