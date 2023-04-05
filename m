Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD56D770F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjDEIgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbjDEIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA65271C;
        Wed,  5 Apr 2023 01:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E90621F6;
        Wed,  5 Apr 2023 08:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A95C4339E;
        Wed,  5 Apr 2023 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680683777;
        bh=ImzeZUFNJhml8hQCobJLElzt2smrsWg3HmVJ1efYQPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=RRzrlb4grcco6JMZ9hj9E0jLzPYBeGHOSy5nGU5wJ0BCNcmhkO7gL0eSp1+Pv3fc5
         7dVTq19HHGbuUrQEtx8PpzK0JzPPkk5xJX9aDPSBBiOGwwWPC5vjKeyBMKiLUQ+Qga
         fsOqMcthI4xiZEV7pcwc6kdEbBV/qnOkBqkk9Lw7UnNWz/e5VcM2xoZxAiXOdC7jte
         dppIPlfq/MAwmKFl7W25PwvPNQRNKBqIqOJT9AuEp6SoNjSnNn06h4Xts8l1hmz0Ms
         OxkXZX4CXveuWXtrXaxVTXSAmG4WQTWMqco/DR9D1wifQvNPwEPMuHE8G/Ag7tbmDU
         U48TP0O3LOOmw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Xiang Chen <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Yihang Li <liyihang9@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, John Garry <john.garry@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hisi_sas: work around build failure in suspend function
Date:   Wed,  5 Apr 2023 10:36:04 +0200
Message-Id: <20230405083611.3376739-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The suspend/resume functions in this driver seem to have multiple
problems, the latest one just got introduced by a bugfix:

drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
 5142 |         if (atomic_read(&device->power.usage_count)) {
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c: In function '_suspend_v3_hw':
drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:5142:39: error: 'struct dev_pm_info' has no member named 'usage_count'
 5142 |         if (atomic_read(&device->power.usage_count)) {

As far as I can tell, the 'usage_count' is not meant to be accessed
by device drivers at all, though I don't know what the driver is
supposed to do instead.

Another problem is the use of the deprecated UNIVERSAL_DEV_PM_OPS(),
and marking functions as __maybe_unused to avoid warnings about
unused functions.  This should probably be changed to using
DEFINE_RUNTIME_DEV_PM_OPS().

Both changes require actually understanding what the driver needs to
do, and being able to test this, so instead here is the simplest
patch to make it pass the randconfig builds instead.

Fixes: e368d38cb952 ("scsi: hisi_sas: Exit suspend state when usage count is greater than 0")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Maintainers: If possible, please revisit this to do a proper fix.
If that takes too much time, this patch can be applied as a
workaround in the meantime, and might also help in case the
e368d38cb952 patch gets backported to stable kernels.
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index d160b9b7479b..12d588454f5d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -5139,11 +5139,13 @@ static int _suspend_v3_hw(struct device *device)
 	flush_workqueue(hisi_hba->wq);
 	interrupt_disable_v3_hw(hisi_hba);
 
+#ifdef CONFIG_PM
 	if (atomic_read(&device->power.usage_count)) {
 		dev_err(dev, "PM suspend: host status cannot be suspended\n");
 		rc = -EBUSY;
 		goto err_out;
 	}
+#endif
 
 	rc = disable_host_v3_hw(hisi_hba);
 	if (rc) {
@@ -5162,7 +5164,9 @@ static int _suspend_v3_hw(struct device *device)
 
 err_out_recover_host:
 	enable_host_v3_hw(hisi_hba);
+#ifdef CONFIG_PM
 err_out:
+#endif
 	interrupt_enable_v3_hw(hisi_hba);
 	clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
 	clear_bit(HISI_SAS_RESETTING_BIT, &hisi_hba->flags);
-- 
2.39.2

