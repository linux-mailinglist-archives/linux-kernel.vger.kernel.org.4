Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2BC67D787
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjAZVSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjAZVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:18:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52896F236;
        Thu, 26 Jan 2023 13:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4131461948;
        Thu, 26 Jan 2023 21:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B1FC433EF;
        Thu, 26 Jan 2023 21:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674767917;
        bh=2Uqy/ORn+z83G19kbhBCW6Xg57SBjM5PofFXKPOAD6g=;
        h=From:To:Cc:Subject:Date:From;
        b=AuO93D4U+OQ3/vexpY74D12VjYbPp5Wg8cNSQazKcxNR8ZfBnQHjQS6BO0/ShaHZr
         0Me1nQfvraPC+rxhbxm6xxH4ucdAKzz9bM2JWMfMwDT/Em6Fyu58n1VNmJ8qOE5KDU
         kcQ5nlxra0yTCl6hnnblVuJEJs3RcmiS0hH9DBqDAennFUTbopmEDLy/Xu+N7U7kCC
         lxen4Kw1anJDdBxptCPesnp94rbsobU5HS4Eh/MggyFLQ/WKgwxZAmjYiQmD+dV34P
         YSslNdobgMqQBQUN8hCdRgAEH5dvD97B43p9kllxOWdeEYAtC6wx8rJG5WytkCG/e6
         Bz2wAMjdOEI5A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] scsi: ufs: qcom: fix platform_msi_domain_free_irqs() reference
Date:   Thu, 26 Jan 2023 22:17:31 +0100
Message-Id: <20230126211831.2274211-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

From: Arnd Bergmann <arnd@arndb.de>

The newly added MSI support is mostly hidden inside of an #ifdef,
except for one line that now causes a build failure when MSI
is disabled:

drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_remove':
drivers/ufs/host/ufs-qcom.c:1698:9: error: implicit declaration of function 'platform_msi_domain_free_irqs' [-Werror=i]
 1698 |         platform_msi_domain_free_irqs(hba->dev);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Above that, the symbol that guards the other call was recently
removed, so that is all dead code at the moment.

Remove the incorrect #ifdef and instead of a Kconfig dependency
to only allow building the driver when CONFIG_GENERIC_MSI_IRQ
is enabled. This symbol is always present when PCI_MSI
or ARM_GIC_V3_ITS are enabled, both of which should be present
on kernels that can run on Qualcomm SoCs.

The 'select RESET_CONTROLLER' in combination with this dependency
unfortunately causes a dependency loop and this is a user-visible
symbol, so it's better to change both to 'depends on'.

Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
Fixes: 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this is the best solution, both the GENERIC_MSI_IRQ
dependencies and the RESET_CONTROLLER dependencies are a bit
inconsistent already. Feel free to pick another approach that
addresses both of the bugs I found.
---
 drivers/ufs/host/Kconfig    | 3 ++-
 drivers/ufs/host/ufs-qcom.c | 8 --------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 139064e70a34..663881437921 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -57,8 +57,9 @@ config SCSI_UFS_DWC_TC_PLATFORM
 config SCSI_UFS_QCOM
 	tristate "QCOM specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_QCOM
+	depends on GENERIC_MSI_IRQ
+	depends on RESET_CONTROLLER
 	select QCOM_SCM if SCSI_UFS_CRYPTO
-	select RESET_CONTROLLER
 	help
 	  This selects the QCOM specific additions to UFSHCD platform driver.
 	  UFS host on QCOM needs some vendor specific configuration before
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 681da3ea7154..eb66b5f6cf19 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1538,7 +1538,6 @@ static int ufs_qcom_get_outstanding_cqs(struct ufs_hba *hba,
 	return 0;
 }
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static void ufs_qcom_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
@@ -1626,13 +1625,6 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	return ret;
 }
 
-#else
-static int ufs_qcom_config_esi(struct ufs_hba *hba)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
-- 
2.39.0

