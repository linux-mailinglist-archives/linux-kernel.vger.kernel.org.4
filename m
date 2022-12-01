Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D263FBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiLAXKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiLAXKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:10:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59638BDCEB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669936131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWddiBlQqBNhSTyOdkG+l/0Pm1/3GQWtxNtEP2I5kzo=;
        b=WovC6FPsh+57rsf9Mch+jfTAdPE+DmRFPs6667+KVaiRdORr1jYXe+uCp40HcBMdQrEVmc
        b2woZpVo5Cd/0ZpJrxK3tndGhWoXytIK7SJZoiHBFlbPG28E7Iaet0xkDrNjOJnUMfp/E9
        MW9RYUFqRYNZmK6sv1Ol+sdTRAWZJX8=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-2ZsGQQIfNUqtR5Z3OwQNdw-1; Thu, 01 Dec 2022 18:08:50 -0500
X-MC-Unique: 2ZsGQQIfNUqtR5Z3OwQNdw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1438729f685so1497016fac.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWddiBlQqBNhSTyOdkG+l/0Pm1/3GQWtxNtEP2I5kzo=;
        b=0NPOzQZb1frJtehiD5PviAqXUoxDb80NHFsgqmTRHC9hlTI4hvwqp0s7CuQmQzqjVX
         9GFv0toO2DkF2T+a8LDitG3uB2pylP3FxPBi0mqNEWCugFW1AQUWm5+QDhv+NMdqIvEV
         hTy1A6ffY2VWYLAe0XKmh9BR94yX7zh424E2IXmkOs6WaV34FfoOwcMEcTyFtEm2Dz3t
         aaCUu20xDZKX4GU0tAulhZ/omVYi0OEdkMwgQuQTjHalgCntFpmxSp4/fvgJNcVsmllu
         Gv5rWeyHf9TCnfV75YJxNjdCNXp1K+Ywa2KyFgbygACC0HDv0Jd9s1niNl3FbdI8lp3Y
         HFSg==
X-Gm-Message-State: ANoB5plX1Mwr9ZKS9C6OONqcB3/elNJSDBtWADnkWUkxON3h1FRl1PH9
        tQGGfK9plKKqwMeA5fOFIwfKEiyxRdt6WhnbO0/sm21x8pVva6Cn9ZUO8txQ7oiTOabnnyO9bU8
        oL67H4MZV2eHcuaXYUa/nTZpx
X-Received: by 2002:a05:6808:1392:b0:359:a4de:1d3a with SMTP id c18-20020a056808139200b00359a4de1d3amr35015719oiw.138.1669936129811;
        Thu, 01 Dec 2022 15:08:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ldM0XY97CgV0SgmS9Vg+rOodybF9ypHIvBpdfMIIk02dw0lwb8AdGXmUb9S9iicT3fBTZ8A==
X-Received: by 2002:a05:6808:1392:b0:359:a4de:1d3a with SMTP id c18-20020a056808139200b00359a4de1d3amr35015708oiw.138.1669936129594;
        Thu, 01 Dec 2022 15:08:49 -0800 (PST)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id y22-20020a4ade16000000b0049fb2a96de4sm2320393oot.0.2022.12.01.15.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:08:49 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 2/4] scsi: ufs: ufs-qcom: Clean up dbg_register_dump
Date:   Thu,  1 Dec 2022 17:08:08 -0600
Message-Id: <20221201230810.1019834-3-ahalaney@redhat.com>
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

The current implementation has abstractions that don't give any
benefits.

The print_fn callback (and its only callback implementation,
ufs_qcom_dump_regs_wrapper()) was only used by
ufs_qcom_print_hw_debug_reg_all() and just multiplies len by 4
before calling ufshcd_dump_regs().

ufs_qcom_print_hw_debug_reg_all() is only called by
ufs_qcom_dump_dbg_regs().

There's no real gain in those abstractions, so let's just do the work
directly in ufs_qcom_dump_dbg_regs() (the dbg_register_dump callback).

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 106 ++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 59 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 70e25f9f8ca8..1b0dfbbdcdf3 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -52,12 +52,6 @@ static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
 	return container_of(rcd, struct ufs_qcom_host, rcdev);
 }
 
-static void ufs_qcom_dump_regs_wrapper(struct ufs_hba *hba, int offset, int len,
-				       const char *prefix, void *priv)
-{
-	ufshcd_dump_regs(hba, offset, len * 4, prefix);
-}
-
 static int ufs_qcom_host_clk_get(struct device *dev,
 		const char *name, struct clk **clk_out, bool optional)
 {
@@ -1195,58 +1189,6 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
 	return err;
 }
 
-static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
-		void *priv, void (*print_fn)(struct ufs_hba *hba,
-		int offset, int num_regs, const char *str, void *priv))
-{
-	u32 reg;
-	struct ufs_qcom_host *host;
-
-	host = ufshcd_get_variant(hba);
-	if (!(host->dbg_print_en & UFS_QCOM_DBG_PRINT_REGS_EN))
-		return;
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_REG_OCSC);
-	print_fn(hba, reg, 44, "UFS_UFS_DBG_RD_REG_OCSC ", priv);
-
-	reg = ufshcd_readl(hba, REG_UFS_CFG1);
-	reg |= UTP_DBG_RAMS_EN;
-	ufshcd_writel(hba, reg, REG_UFS_CFG1);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_EDTL_RAM);
-	print_fn(hba, reg, 32, "UFS_UFS_DBG_RD_EDTL_RAM ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_DESC_RAM);
-	print_fn(hba, reg, 128, "UFS_UFS_DBG_RD_DESC_RAM ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_PRDT_RAM);
-	print_fn(hba, reg, 64, "UFS_UFS_DBG_RD_PRDT_RAM ", priv);
-
-	/* clear bit 17 - UTP_DBG_RAMS_EN */
-	ufshcd_rmwl(hba, UTP_DBG_RAMS_EN, 0, REG_UFS_CFG1);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_UAWM);
-	print_fn(hba, reg, 4, "UFS_DBG_RD_REG_UAWM ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_UARM);
-	print_fn(hba, reg, 4, "UFS_DBG_RD_REG_UARM ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TXUC);
-	print_fn(hba, reg, 48, "UFS_DBG_RD_REG_TXUC ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_RXUC);
-	print_fn(hba, reg, 27, "UFS_DBG_RD_REG_RXUC ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_DFC);
-	print_fn(hba, reg, 19, "UFS_DBG_RD_REG_DFC ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TRLUT);
-	print_fn(hba, reg, 34, "UFS_DBG_RD_REG_TRLUT ", priv);
-
-	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TMRLUT);
-	print_fn(hba, reg, 9, "UFS_DBG_RD_REG_TMRLUT ", priv);
-}
-
 static void ufs_qcom_enable_test_bus(struct ufs_qcom_host *host)
 {
 	if (host->dbg_print_en & UFS_QCOM_DBG_PRINT_TEST_BUS_EN) {
@@ -1365,10 +1307,56 @@ int ufs_qcom_testbus_config(struct ufs_qcom_host *host)
 
 static void ufs_qcom_dump_dbg_regs(struct ufs_hba *hba)
 {
+	u32 reg;
+	struct ufs_qcom_host *host;
+
+	host = ufshcd_get_variant(hba);
+
 	ufshcd_dump_regs(hba, REG_UFS_SYS1CLK_1US, 16 * 4,
 			 "HCI Vendor Specific Registers ");
 
-	ufs_qcom_print_hw_debug_reg_all(hba, NULL, ufs_qcom_dump_regs_wrapper);
+	if (!(host->dbg_print_en & UFS_QCOM_DBG_PRINT_REGS_EN))
+		return;
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_REG_OCSC);
+	ufshcd_dump_regs(hba, reg, 44 * 4, "UFS_UFS_DBG_RD_REG_OCSC ");
+
+	reg = ufshcd_readl(hba, REG_UFS_CFG1);
+	reg |= UTP_DBG_RAMS_EN;
+	ufshcd_writel(hba, reg, REG_UFS_CFG1);
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_EDTL_RAM);
+	ufshcd_dump_regs(hba, reg, 32 * 4, "UFS_UFS_DBG_RD_EDTL_RAM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_DESC_RAM);
+	ufshcd_dump_regs(hba, reg, 128 * 4, "UFS_UFS_DBG_RD_DESC_RAM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_UFS_DBG_RD_PRDT_RAM);
+	ufshcd_dump_regs(hba, reg, 64 * 4, "UFS_UFS_DBG_RD_PRDT_RAM ");
+
+	/* clear bit 17 - UTP_DBG_RAMS_EN */
+	ufshcd_rmwl(hba, UTP_DBG_RAMS_EN, 0, REG_UFS_CFG1);
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_UAWM);
+	ufshcd_dump_regs(hba, reg, 4 * 4, "UFS_DBG_RD_REG_UAWM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_UARM);
+	ufshcd_dump_regs(hba, reg, 4 * 4, "UFS_DBG_RD_REG_UARM ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TXUC);
+	ufshcd_dump_regs(hba, reg, 48 * 4, "UFS_DBG_RD_REG_TXUC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_RXUC);
+	ufshcd_dump_regs(hba, reg, 27 * 4, "UFS_DBG_RD_REG_RXUC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_DFC);
+	ufshcd_dump_regs(hba, reg, 19 * 4, "UFS_DBG_RD_REG_DFC ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TRLUT);
+	ufshcd_dump_regs(hba, reg, 34 * 4, "UFS_DBG_RD_REG_TRLUT ");
+
+	reg = ufs_qcom_get_debug_reg_offset(host, UFS_DBG_RD_REG_TMRLUT);
+	ufshcd_dump_regs(hba, reg, 9 * 4, "UFS_DBG_RD_REG_TMRLUT ");
 }
 
 /**
-- 
2.38.1

