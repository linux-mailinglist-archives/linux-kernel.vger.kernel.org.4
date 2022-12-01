Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3988263F6C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLARtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiLARsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:48:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E36BA095
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:46:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so2816890pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j6MDpCLb+McpecemKMLJBiFRu5JxDaZjTLdO5ExkiE=;
        b=qm1An1wnNA4JoFkmc8RLxXAUN5b1VJMqvUQeJKWDZO8VpPHJJytH/a0wukFgCOEsQR
         PvGKlwQN3Pb2fuYtDoCTV5/tIrJy8CRXv6LJCganss6jIk07kEbQAJ8d7u5mEwU0skZ/
         FJcYOO/573sfawqfjpoM3U2FdRTle6JLR41EA/ous0A/ZUB5pZeqWumjGpPRQpWAbKFY
         VsMFWP/tJF23y85ZNZSPrmt2VHgyHmj38L6j2wN5MEBC7GBGnugxzq6yXUW0ncuTybE0
         BBq71sWiayRPPaKTcEuZpZSiHF4xm4IKTVcSO5oTbYBy7l9R13Rq2KSseUJNbeZLo+yR
         Mrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j6MDpCLb+McpecemKMLJBiFRu5JxDaZjTLdO5ExkiE=;
        b=wtcaYf5caQHX3vGPyGDUEbsmFmuasQCbed/w0WljeHNCH0kYRPbaIwa0io/hlRDNet
         QQSmMcpnU89nGVguDgqlOZRbOUadFgpmsobhiV1oZ4YtFfQGOuFaQWjFAAjrBBzUsULN
         oqZtdDorqYCidGqPoQNK6sXupEmhQkAiH+xIKQgfBiWhArr033XlSruu3CzGa83AV44s
         RDcaAHLMUQBxWHc+XPYVIAuj4Hv+rPQyi4czMCJEhOvyM0pw2VDS3KNfWijp2s/5+5f4
         u5iegT2d7YgSZKR5YLlemOnbqTG2ohfvicp3oeNb3K6xbHhhGO1N/04r9xskKmDPuU9P
         a+wg==
X-Gm-Message-State: ANoB5pkw8Vt0yaUKz+R1KjWLXSbUClqhr+kIeZ1AcfwRAcpkVNy04s82
        DlV5+tsXQ8cS5CMrJrFwzw0S
X-Google-Smtp-Source: AA0mqf78KOsPbaaFlVhcd28Ih9c2G7S6cX3mlAYi31+Gy7RmnH1cTQ9mb4rh4Nel4BZ59XsqVQWANg==
X-Received: by 2002:a17:902:ce90:b0:187:19c4:373a with SMTP id f16-20020a170902ce9000b0018719c4373amr61127615plg.163.1669916769695;
        Thu, 01 Dec 2022 09:46:09 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:46:08 -0800 (PST)
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
Subject: [PATCH v4 22/23] scsi: ufs: ufs-qcom: Add support for finding max gear on new platforms
Date:   Thu,  1 Dec 2022 23:13:27 +0530
Message-Id: <20221201174328.870152-23-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

