Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483175E6723
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiIVPbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiIVPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59AFB311;
        Thu, 22 Sep 2022 08:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3AC760EC3;
        Thu, 22 Sep 2022 15:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9446C433C1;
        Thu, 22 Sep 2022 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663860679;
        bh=/ClgbMOMNdyDBId+nHp5KxNiJpq7n5faUKKIUVMVzt8=;
        h=From:To:Cc:Subject:Date:From;
        b=oiaYGL6KwzhfWznS3WMx1ZHmk8H17jQ02eLb01pcNe20sLGneQaQouuk94EqdiSqX
         59sj4yt2EaPpcwVCZQPcIWJy7iZUm7xRblk9zfAMqB27owh+tQwwrkipFSo/3cbE/9
         A0I7cF32mJqa1zcMMJ75GerHgmKHfWeXD30PQcITN/syCCHDkLwEurj1HrpvMWBvWp
         +88iaLKh23Noni9SDUrh1QpNZEamk4wb8MVmS5rerXYGEQ8wWTSlQbE5Yi8MGgpop3
         HGNIcOYXzUKVkJ+3YSMzdRjeTjC2U6tIKNe/k7cvMdNcRc67053kflvd5Mi9hfCk+C
         CdFXlL7rPBAUQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] platform/x86/amd: pmc: Fix build without debugfs
Date:   Thu, 22 Sep 2022 08:31:00 -0700
Message-Id: <20220922153100.324922-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
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

Without CONFIG_DEBUG_FS, the following build error occurs:

  drivers/platform/x86/amd/pmc.c:984:17: error: use of undeclared identifier 'pmc_groups'; did you mean 'set_groups'?
                  .dev_groups = pmc_groups,
                                ^~~~~~~~~~
                                set_groups
  ./include/linux/cred.h:65:13: note: 'set_groups' declared here
  extern void set_groups(struct cred *, struct group_info *);
              ^
  drivers/platform/x86/amd/pmc.c:984:17: error: incompatible pointer types initializing 'const struct attribute_group **' with an expression of type 'void (struct cred *, struct group_info *)' [-Werror,-Wincompatible-pointer-types]
                  .dev_groups = pmc_groups,
                                ^~~~~~~~~~
  2 errors generated.

pmc_groups was only defined inside a CONFIG_DEBUG_FS block but
commit 7f1ea75d499a ("platform/x86/amd: pmc: Add sysfs files for SMU")
intended for these sysfs files to be available outside of debugfs.
Shuffle the necessary functions out of the CONFIG_DEBUG_FS block so that
the file always builds.

Fixes: 7f1ea75d499a ("platform/x86/amd: pmc: Add sysfs files for SMU")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 116 ++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 0616ef8ce64c..e47e54b095af 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -371,6 +371,64 @@ static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 }
 #endif
 
+static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
+{
+	int rc;
+	u32 val;
+
+	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
+	if (rc)
+		return rc;
+
+	dev->smu_program = (val >> 24) & GENMASK(7, 0);
+	dev->major = (val >> 16) & GENMASK(7, 0);
+	dev->minor = (val >> 8) & GENMASK(7, 0);
+	dev->rev = (val >> 0) & GENMASK(7, 0);
+
+	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
+		dev->smu_program, dev->major, dev->minor, dev->rev);
+
+	return 0;
+}
+
+static ssize_t smu_fw_version_show(struct device *d, struct device_attribute *attr,
+				   char *buf)
+{
+	struct amd_pmc_dev *dev = dev_get_drvdata(d);
+
+	if (!dev->major) {
+		int rc = amd_pmc_get_smu_version(dev);
+
+		if (rc)
+			return rc;
+	}
+	return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor, dev->rev);
+}
+
+static ssize_t smu_program_show(struct device *d, struct device_attribute *attr,
+				   char *buf)
+{
+	struct amd_pmc_dev *dev = dev_get_drvdata(d);
+
+	if (!dev->major) {
+		int rc = amd_pmc_get_smu_version(dev);
+
+		if (rc)
+			return rc;
+	}
+	return sysfs_emit(buf, "%u\n", dev->smu_program);
+}
+
+static DEVICE_ATTR_RO(smu_fw_version);
+static DEVICE_ATTR_RO(smu_program);
+
+static struct attribute *pmc_attrs[] = {
+	&dev_attr_smu_fw_version.attr,
+	&dev_attr_smu_program.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(pmc);
+
 #ifdef CONFIG_DEBUG_FS
 static int smu_fw_info_show(struct seq_file *s, void *unused)
 {
@@ -437,64 +495,6 @@ static int s0ix_stats_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(s0ix_stats);
 
-static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
-{
-	int rc;
-	u32 val;
-
-	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
-	if (rc)
-		return rc;
-
-	dev->smu_program = (val >> 24) & GENMASK(7, 0);
-	dev->major = (val >> 16) & GENMASK(7, 0);
-	dev->minor = (val >> 8) & GENMASK(7, 0);
-	dev->rev = (val >> 0) & GENMASK(7, 0);
-
-	dev_dbg(dev->dev, "SMU program %u version is %u.%u.%u\n",
-		dev->smu_program, dev->major, dev->minor, dev->rev);
-
-	return 0;
-}
-
-static ssize_t smu_fw_version_show(struct device *d, struct device_attribute *attr,
-				   char *buf)
-{
-	struct amd_pmc_dev *dev = dev_get_drvdata(d);
-
-	if (!dev->major) {
-		int rc = amd_pmc_get_smu_version(dev);
-
-		if (rc)
-			return rc;
-	}
-	return sysfs_emit(buf, "%u.%u.%u\n", dev->major, dev->minor, dev->rev);
-}
-
-static ssize_t smu_program_show(struct device *d, struct device_attribute *attr,
-				   char *buf)
-{
-	struct amd_pmc_dev *dev = dev_get_drvdata(d);
-
-	if (!dev->major) {
-		int rc = amd_pmc_get_smu_version(dev);
-
-		if (rc)
-			return rc;
-	}
-	return sysfs_emit(buf, "%u\n", dev->smu_program);
-}
-
-static DEVICE_ATTR_RO(smu_fw_version);
-static DEVICE_ATTR_RO(smu_program);
-
-static struct attribute *pmc_attrs[] = {
-	&dev_attr_smu_fw_version.attr,
-	&dev_attr_smu_program.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(pmc);
-
 static int amd_pmc_idlemask_show(struct seq_file *s, void *unused)
 {
 	struct amd_pmc_dev *dev = s->private;

base-commit: 401199ffa9b69baf3fd1f9ad082aa65c10910585
-- 
2.37.3

