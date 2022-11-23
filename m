Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA70635178
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiKWHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiKWHu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:50:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A30FC71B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:50:04 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j12so15923323plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Xd0gDlZp0b1F7R46Bn1beu0377yVMDIxRd9gxYrRE=;
        b=j4a2IZ4M/RPn02KaaMa7o/DiXf8mhGrp8hO1u8giHS105CGBy7ebnfzwcG4Ysm3Z2K
         kaxfRevnkU72bEifmC5K/ilMeVXZC9kdXRrTFph5Dd+4P+gg5yT0H8eKeBDNCUnZMhtP
         8jmhF5FG90qgX6YdP3X5BzL5dHnPipH0647G5o5q7eTUZ14l9ax7zB8kQD3IOmHSbPAp
         Xrq4yyYFYxZ4ktvd7X0uVK724lPuIJgYS24OpnuTkgzYzkBp76epnP7TMIby91Wvq1aR
         dRCLodWM9m1RMxYDJD4rlsjA9RGAVl8nD3+7Vki373kL62fuNXYaEOdHVl2WpUu1DKjc
         0HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2Xd0gDlZp0b1F7R46Bn1beu0377yVMDIxRd9gxYrRE=;
        b=qxSIoCUcsbcBy1yFNKv1Yk6HKPZZFLJC6nv7XFbAIy/eXfGLtanxbi8W7KvN5ygZN4
         S/pZ7p7sc4m71i83uiO8kTy1Mcrn9oteg3lP57sCIqFrD8LwhQrikkqWjdozUsRrv7m2
         xGa/x4ERi0Fm2BLqQjMvl4Uo5WNmSsT/qVyNJS1jqnbhZAXGYDLf7fzmRraRIpkj49BT
         SIooeZnnwfvsZeESJg9UDKRJZbr+rzvpTlvX7FIg1zUNWCg0ilQedT4eU7Z4yXSfqEx/
         hdFMb4RGKYQoUVSq6vXbqkpWthDRsijxAQm2TTL+/UYrL7qVc2jyiLr5AhPUA8SrJ/jQ
         U5lQ==
X-Gm-Message-State: ANoB5pkYd/Qp7jl632dkqSNEWWZAE0kRfuIjmnshlrDOwEurRiVn0REA
        q5Kjhco+4U7nM6Exa9RYgGFk
X-Google-Smtp-Source: AA0mqf4EA/xu0LNp5Eeym9s5QmhuOi/k38g2Q5DDLTpsDvRmwE7yo049HbunO3rvytSj8UQTUayfsw==
X-Received: by 2002:a17:902:b184:b0:189:1d01:a4ae with SMTP id s4-20020a170902b18400b001891d01a4aemr8039549plr.93.1669189804266;
        Tue, 22 Nov 2022 23:50:04 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:50:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 15/20] scsi: ufs: core: Add reinit_notify() callback
Date:   Wed, 23 Nov 2022 13:18:21 +0530
Message-Id: <20221123074826.95369-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reinit_notify() callback can be used by the UFS controllers to perform
changes required for UFS core reinit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd-priv.h | 6 ++++++
 include/ufs/ufshcd.h           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index f68ca33f6ac7..37260c1af9f0 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -226,6 +226,12 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->reinit_notify)
+		hba->vops->reinit_notify(hba);
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9f28349ebcff..09927a011a84 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @reinit_notify: called to notify UFS core reinit
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	void	(*reinit_notify)(struct ufs_hba *);
 };
 
 /* clock gating state  */
-- 
2.25.1

