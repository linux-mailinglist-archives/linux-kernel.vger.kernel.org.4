Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8B710BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbjEYMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240814AbjEYMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:10:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0C12E;
        Thu, 25 May 2023 05:10:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-510eb3dbaaeso4019607a12.1;
        Thu, 25 May 2023 05:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685016602; x=1687608602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpR8//zxRxGnU7TlHH6wfvPeUzP0bueyOOjz5my8OPQ=;
        b=JyAUpP40azFAgzu44H45xkrBVGgHg0wB8bsU3WOWhTNG+cQI0cMJ26LU3/XsvYfeK0
         FKbYqDbwE4XY2vUOU2q/MjWBaMMiBbCXECzYx8cCZZbC91FfKzpuDOZvkF80oRHD46Yw
         t+29ULqtPSATjFy6mFjhdLxjG6LwcwA76Tq4hXapj+K7OAB2pac5qXgio8LT8Id7/uLb
         ApRCPk16QmrF19OQrOhYK9mIQ1GuN5XAtQasOySTutrUCjkJn1FzcrEvdHHeWmUB2JBx
         jPhU8HNxen/pQx0O50DIo8oz/qC0fq4M/TvIU/OVAEgYRYyHVPrymygIq2F4bgRAd7Hu
         4Qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016602; x=1687608602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpR8//zxRxGnU7TlHH6wfvPeUzP0bueyOOjz5my8OPQ=;
        b=YjWbXTnTEZUF1HRm55g8upgvcOWyeZIgOY3Lb070cahCg7pptXWdrvkS18fjtdwfld
         ElmZcmvjstmgA6Z1oxaT919Pf6OvkMVl8Dk22PaHtvHhGmy69DL1StZbMX5hiN25zC98
         2m8PdQpAaNPjBZW5E9cF9gkyDcdNA4c6Q4M7g3mBod5Bd+8mrcZYyGcSJqXMI0Z4gBoV
         b+75WNeuC6DvsU/ianSLjdeD6enwUVnDL+KfdUES7CpOdTALemBVq+ZVDe7dZLy6yJUt
         sNPrLdozjYNahMgZcWpf4U8yrsoupsC5o46Oh3Fn5JwVq+QosbxHfcnwHRBrYG9ZJFsA
         e4lQ==
X-Gm-Message-State: AC+VfDzGJMwEB2R6VdrOAFD3iqHZiHH2J4hs4uHIzZcTrQzWwtSDEVIR
        unemRQqnhjexwwUM9CrUM2Y3VM+1eemvwA==
X-Google-Smtp-Source: ACHHUZ5aBde6tPLcqBDGHfEVvTLRdXHQJIeSYsVLxQ3Nb++kc357mWQ9s7DWheGjMzk0r4XiWUhcng==
X-Received: by 2002:a17:906:9b95:b0:96f:1f79:c0a6 with SMTP id dd21-20020a1709069b9500b0096f1f79c0a6mr1186172ejc.70.1685016602362;
        Thu, 25 May 2023 05:10:02 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id d5-20020a170906640500b0094ef923a6ccsm765216ejm.219.2023.05.25.05.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:10:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 3/5] soc: qcom: smem: introduce qcom_smem_get_msm_id()
Date:   Thu, 25 May 2023 14:09:54 +0200
Message-Id: <20230525120956.3095317-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525120956.3095317-1-robimarko@gmail.com>
References: <20230525120956.3095317-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a helper to return the SoC SMEM ID, which is used to identify the
exact SoC model as there may be differences in the same SoC family.

Currently, cpufreq-nvmem does this completely in the driver and there has
been more interest expresed for other drivers to use this information so
lets expose a common helper to prevent redoing it in individual drivers
since this field is present on every SMEM table version.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Change export to EXPORT_SYMBOL_GPL
* Use an argument for returning SoC ID
* Update kerneldoc
---
 drivers/soc/qcom/smem.c       | 24 ++++++++++++++++++++++++
 include/linux/soc/qcom/smem.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index bc98520c4969..185ed0da11a1 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
@@ -772,6 +773,29 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 }
 EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
 
+/**
+ * qcom_smem_get_msm_id() - return the SoC ID
+ * @id:	On success, we return the SoC ID here.
+ *
+ * Look up SoC ID from HW/SW build ID and return it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_smem_get_msm_id(u32 *id)
+{
+	size_t len;
+	struct socinfo *info;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	*id = info->id;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_msm_id);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index 86e1b358688a..cb204ad6373c 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
 
 phys_addr_t qcom_smem_virt_to_phys(void *p);
 
+int qcom_smem_get_msm_id(u32 *id);
+
 #endif
-- 
2.40.1

