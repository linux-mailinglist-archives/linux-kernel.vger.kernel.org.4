Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8A9603225
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJRSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJRSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:16:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26DD7D1F4;
        Tue, 18 Oct 2022 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1666117000;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=fWQgbZey9us7ESK6PQD6XKaBy+xKVXDQ/LVBroNYgfI=;
    b=EqMm5bHB0hlVXQl3bSuYXsPhoCM3mhe6EfGhSUfrFKwbyM4j2B8FwR/itIx/6yN0WQ
    cYTD5pfb5hZ/IivG25IxST+SJWiu7YFr6b/lB0qNdWYqv2vVXxGXKJLS0XiD5/ME6rvB
    OxoP5flgNUi4CXwGm0A/t3fuXi+FyTE5J/TjP62sTvoNIPkCHaC9iy9UK/0r9n+gvEsB
    mZxRkdthKFYcaUmU2B2izILiuKJAaruOD36/wKhLahkPRP/qf+L8MCZXcXszyjBKKBmU
    ZrEAtu2KHAOmpOMTogfRDi6mr9YNYp6V88LZ2NvQHE3gg8GRIXYShcXRTzW4opOgaB21
    f4dw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo02
Received: from linux.micron.com
    by smtp.strato.de (RZmta 48.2.0 AUTH)
    with ESMTPSA id zad98cy9IIGdYSV
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Oct 2022 20:16:39 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs nodes
Date:   Tue, 18 Oct 2022 20:16:27 +0200
Message-Id: <20221018181627.326657-4-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018181627.326657-1-beanhuo@iokpp.de>
References: <20221018181627.326657-1-beanhuo@iokpp.de>
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

UFS Boot and Device W-LUs do not have unit descriptors, and PRMB does not
support WB, we can use is_visible() to control which nodes are visible
and which are not.

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

