Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3306542B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiLVOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiLVOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:14:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00015558B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so2015013pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r6KWtBC24mvcKhKbi7oMsl/OBPp4xpGlki0s+jabEY=;
        b=P4YYRDE7eLMbshCu/AHFfq4yO9XLNrx8vkP9s9ulv6mT6xjsgejmF7rZxI3q6MWsSr
         UcJ/yJdcKMahNPOMOwprplmiNGv11pKw3UvQEFcQzE30vtdW0VhOzTrWNV/1uvEvvluk
         OKfjfmw9AXCkybIh1bWJ/Q1J7cd6cPuLRqolxmcXGTN08h/p+BEieKI61QV1pHZ9ZKkR
         BgbFvnOWEgC8craFOZ56y8EqPp3zuw3fmmdf0tkDj+35Ic9zylbaBTXttoxUCBZw8lM7
         bSMJXQuRCBYHyGvemSAbZYbbI/xLN0tzsFHPyKRd1xShBmwCEfCM526PNiNxrlL5msmL
         ukbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r6KWtBC24mvcKhKbi7oMsl/OBPp4xpGlki0s+jabEY=;
        b=kb3K88Eq7xSGWpnyySB2p7lKNknvuUxifl8l4WdtUqIOspiqydQmoPjBeQAI2CJOuS
         jXNVKPTZiJXdyffPoGViQLLVeDwz+N0kobidxriYoHiEj3sLBjkvmX+AHyFeH/OfQ9hG
         tf/XW+/FwMym7hjqR85tIT8LPZz+ME02G8xmdsU60wtgxF9Z7m/V2wTz54f5ZjQNj/bf
         2WGXDGhJZDxVSeRxGxKLW6Gkpsk6X19f8PZnuTWotbYm7pGX3hM6mvmbImA3gVM0wPMJ
         9vy+LcXEjVGQghId8MKYHDsYFtyuAdjC+CIGYaQ7AceMfcmIwLeycirGQvg5UrZYdC80
         clIw==
X-Gm-Message-State: AFqh2kqCcR5sEJ0iSjbfyVDQ9dzFBwFD3DOYJV3Rygh3mFfug6+JBqox
        MN6Yyd1ZnpN5/fgbcgDPWPVE
X-Google-Smtp-Source: AMrXdXt39otDg2GPiuR+A8WWlXVq1iDlfUJ6rH6SVRvyktfugDgqkZ6oq6hotpPIIqAIrKuhLnlHxQ==
X-Received: by 2002:a05:6a20:3ca5:b0:af:ae01:54df with SMTP id b37-20020a056a203ca500b000afae0154dfmr9321720pzj.11.1671718374656;
        Thu, 22 Dec 2022 06:12:54 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:12:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 22/23] scsi: ufs: ufs-qcom: Add support for finding max gear on new platforms
Date:   Thu, 22 Dec 2022 19:40:00 +0530
Message-Id: <20221222141001.54849-23-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from Qcom UFS version 4.0, vendor specific REG_UFS_PARAM0 register
can be used to determine the maximum gear supported by the controller.

Suggested-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 ++
 drivers/ufs/host/ufs-qcom.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3efef2f36e69..607fddb7b4c3 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -291,6 +291,8 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
 		 * Hence downgrade the maximum supported gear to HS-G2.
 		 */
 		return UFS_HS_G2;
+	} else if (host->hw_ver.major >= 0x4) {
+		return UFS_QCOM_MAX_GEAR(ufshcd_readl(hba, REG_UFS_PARAM0));
 	}
 
 	/* Default is HS-G3 */
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 4b00c67e9d7f..dd3abd23ec22 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -94,6 +94,10 @@ enum {
 #define TMRLUT_HW_CGC_EN	BIT(6)
 #define OCSC_HW_CGC_EN		BIT(7)
 
+/* bit definitions for REG_UFS_PARAM0 */
+#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
+#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
+
 /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
 #define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
 
-- 
2.25.1

