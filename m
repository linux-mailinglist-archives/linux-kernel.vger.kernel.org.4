Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC4608FC7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJVVhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJVVhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:37:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F6FA020;
        Sat, 22 Oct 2022 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666474620;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=d0/HieIBh0r5Mr2qWbDo21B/n0XfJBUvPVCy24zUI7k=;
    b=aKq4NskIMmb1g3JLYFpHG9OPBzBVsj7vVyigeDAj1kMj+Sra3jc2J9dMQi3U6tZGRX
    VqsEP6R2l5sEOcKt0rg18OOgSK6j9L1G4HlfwxvXs+TXOZ8OSlbXj+E62rjj5wHcvTte
    e91fgYXufN16ypBHu8JF0ABBa964DLj2vZ81rHQFC6dsS7/RfnX/rvX89WnbY3WZYvvu
    KsAqu3dZvbwfOFeaVRWEd/SwuAPWhLRBrOlrM1hc79HNofevelC0kfIZX7zltsAAPex1
    LLIyqAJur7wRRN0z0fppXhpf4O92MjgNzUPw8t8/Z+HtJpsZa3ri+LlhJUFfsztRW17I
    keSQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD/R51xABQjgP5pGGXp2Dw="
X-RZG-CLASS-ID: mo02
Received: from linux..
    by smtp.strato.de (RZmta 48.2.0 DYNA|AUTH)
    with ESMTPSA id zad98cy9MLb0nUV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 22 Oct 2022 23:37:00 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs nodes
Date:   Sat, 22 Oct 2022 23:36:50 +0200
Message-Id: <20221022213650.626766-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022213650.626766-1-beanhuo@iokpp.de>
References: <20221022213650.626766-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

UFS Boot and Device W-LUs do not have unit descriptors, and RPMB does not
support WB, we can use is_visible() to control which nodes are visible
and which are not.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/ufs/core/ufs-sysfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index eb6b278c4e79..883f0e44b54e 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -1285,9 +1285,27 @@ static struct attribute *ufs_sysfs_unit_descriptor[] = {
 	NULL,
 };
 
+static umode_t ufs_unit_descriptor_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct scsi_device *sdev = to_scsi_device(dev);
+	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
+	umode_t mode = attr->mode;
+
+	if (lun == UFS_UPIU_BOOT_WLUN || lun == UFS_UPIU_UFS_DEVICE_WLUN)
+		/* Boot and device WLUN have no unit descriptors */
+		mode = 0;
+	if (lun == UFS_UPIU_RPMB_WLUN && attr == &dev_attr_wb_buf_alloc_units.attr)
+		mode = 0;
+
+	return mode;
+}
+
+
 const struct attribute_group ufs_sysfs_unit_descriptor_group = {
 	.name = "unit_descriptor",
 	.attrs = ufs_sysfs_unit_descriptor,
+	.is_visible = ufs_unit_descriptor_is_visible,
 };
 
 static ssize_t dyn_cap_needed_attribute_show(struct device *dev,
-- 
2.34.1

