Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026D63FBB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiLAXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiLAXKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15287C23CF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669936142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Au+k80w/pmMXn842EfJNDQH8P/z+f/qneC68ARqh1Us=;
        b=R/9R1A1Ww8tagOxCDUzhdjn4DgLOhEHt0vQxEFjkDOY7OBFeNyCs4LL9gi3in47fieBpm/
        jmzmYLak050E5FK+aKzbDIk7hM6YOmTJKedjmv8NrAPRLmt00p+I3rRHTX0abpEA1Ayd+p
        c0SO7iEJLzfGPl12RjZPT9BuWKbz0uA=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-_EeCtl4xMgazBUmmEZ-J9w-1; Thu, 01 Dec 2022 18:08:54 -0500
X-MC-Unique: _EeCtl4xMgazBUmmEZ-J9w-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-13ba8947e4cso1496587fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au+k80w/pmMXn842EfJNDQH8P/z+f/qneC68ARqh1Us=;
        b=v/9IpKNrqKTYgtlxKBSDPdLBNi4zyG1TVbsjaA9axn3g1a0vhCwaDppbxa3cELdqnz
         bNDpXdT8LkBUytIQMk4k8bDsTqIgA1PKWGwutAGVdGxajyw1AP2hVPMFQd7OG8tnl0Wz
         icoQTfHAG+bGgpanAdCg6r12TojaH+ysYSE/JZk7afc1N6rt8n2Yg4bzT6pK/tz/ji7W
         zr6pN86psFTfEoiVNSG2YHH7CEOkW7sRrackx7FlRABQIOdF7fJ7wEDvLL7T+qvTp4hP
         pOyNDpElC6u0jyOKyEQwf1KfkkFNvPxnBjaQiK59p5XLJil7jJTMfy/FpdNXDHiTj6xW
         HDrQ==
X-Gm-Message-State: ANoB5plt3Qbn4U06PmK5/AmZxDdVFt/sEsvddJrDL6A1BgCbg9OXav76
        wHeTzyT5Pg24Vvo5t6DuX6pvWxDyDFZY7JgL/Brwo+UAow0JwaMf2DwB69Wsb7vtbktQGk1wPri
        D0/LsFQ/vjf8ujrsevekxg1DG
X-Received: by 2002:aca:c108:0:b0:354:946b:f72f with SMTP id r8-20020acac108000000b00354946bf72fmr26849981oif.48.1669936134115;
        Thu, 01 Dec 2022 15:08:54 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pXPhwwXla9o1f3TOf302ZiviAEa7VY59few9IlfP2oWCgZT5Q9QV8Go8vg9BjCquwWs2B6w==
X-Received: by 2002:aca:c108:0:b0:354:946b:f72f with SMTP id r8-20020acac108000000b00354946bf72fmr26849967oif.48.1669936133904;
        Thu, 01 Dec 2022 15:08:53 -0800 (PST)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id y22-20020a4ade16000000b0049fb2a96de4sm2320393oot.0.2022.12.01.15.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:08:53 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 3/4] scsi: ufs: ufs-qcom: Remove usage of dbg_print_en
Date:   Thu,  1 Dec 2022 17:08:09 -0600
Message-Id: <20221201230810.1019834-4-ahalaney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201230810.1019834-1-ahalaney@redhat.com>
References: <20221201230810.1019834-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bitmask is unconditionally set in the current driver,
so all conditionals using it can be considered bit rot.

Let's take the current default conditional path everywhere and remove
dbg_print_en from the driver.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 18 +++---------------
 drivers/ufs/host/ufs-qcom.h | 11 -----------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 1b0dfbbdcdf3..b1fcff1fad0c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -22,9 +22,6 @@
 #include <ufs/ufshci.h>
 #include <ufs/ufs_quirks.h>
 
-#define UFS_QCOM_DEFAULT_DBG_PRINT_EN	\
-	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
-
 enum {
 	TSTBUS_UAWM,
 	TSTBUS_UARM,
@@ -1040,7 +1037,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	if (hba->dev->id < MAX_UFS_QCOM_HOSTS)
 		ufs_qcom_hosts[hba->dev->id] = host;
 
-	host->dbg_print_en |= UFS_QCOM_DEFAULT_DBG_PRINT_EN;
 	ufs_qcom_get_default_testbus_cfg(host);
 	err = ufs_qcom_testbus_config(host);
 	if (err) {
@@ -1191,14 +1187,9 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 
 static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
 {
-	if (host->dbg_print_en & UFS_QCOM_DBG_PRINT_TEST_BUS_EN) {
-		ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
-				UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
-		ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
-	} else {
-		ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN, 0, REG_UFS_CFG1);
-		ufshcd_rmwl(host->hba, TEST_BUS_EN, 0, REG_UFS_CFG1);
-	}
+	ufshcd_rmwl(host->hba, UFS_REG_TEST_BUS_EN,
+			UFS_REG_TEST_BUS_EN, REG_UFS_CFG1);
+	ufshcd_rmwl(host->hba, TEST_BUS_EN, TEST_BUS_EN, REG_UFS_CFG1);
 }
 
 static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host)
@@ -1315,9 +1306,6 @@ static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
 			 "HCI Vendor Specific Registers ");
 
-	if (!(host->dbg_print_en & UFS_QCOM_DBG_PRINT_REGS_EN))
-		return;
-
 	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_REG_OCSC);
 	ufshcd_dump_regs(hba, reg, 44 * 4, "UFS_UFS_DBG_RD_REG_OCSC ");
 
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a395bb5..e567e4636357 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -113,15 +113,6 @@ enum {
 	MASK_CLK_NS_REG                     = 0xFFFC00,
 };
 
-/* QCOM UFS debug print bit mask */
-#define UFS_QCOM_DBG_PRINT_REGS_EN	BIT(0)
-#define UFS_QCOM_DBG_PRINT_ICE_REGS_EN	BIT(1)
-#define UFS_QCOM_DBG_PRINT_TEST_BUS_EN	BIT(2)
-
-#define UFS_QCOM_DBG_PRINT_ALL	\
-	(UFS_QCOM_DBG_PRINT_REGS_EN | UFS_QCOM_DBG_PRINT_ICE_REGS_EN | \
-	 UFS_QCOM_DBG_PRINT_TEST_BUS_EN)
-
 /* QUniPro Vendor specific attributes */
 #define PA_VS_CONFIG_REG1	0x9000
 #define DME_VS_CORE_CLK_CTRL	0xD002
@@ -212,8 +203,6 @@ struct ufs_qcom_host {
 
 	u32 dev_ref_clk_en_mask;
 
-	/* Bitmask for enabling debug prints */
-	u32 dbg_print_en;
 	struct ufs_qcom_testbus testbus;
 
 	/* Reset control of HCI */
-- 
2.38.1

