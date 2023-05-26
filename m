Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0193B712E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbjEZUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbjEZUsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:48:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08A1B6;
        Fri, 26 May 2023 13:48:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-969f90d71d4so165635266b.3;
        Fri, 26 May 2023 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685134087; x=1687726087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eFkvxxfZGUWIwdt4Yk1IwgTRk71PWUDf3wOYpRw1LM=;
        b=oHp6ck0f9MlkTkklyXE4ayemD+ST6s3ykHOS/4QXEsHgKgibi63kVFKRV2bQyeIgMI
         2irNYGMoVVXVhE29ExeeNRRZJRa+xS1wdsUtFt52j9NTwkFll0n9mJ39nPMgZy+RIkM+
         JkBpHhqAz1/rGL0faJ+EGXu0q3bK0kNoTX09JcbOphuBUaJfrjfc+NOksOMYCG/KItvP
         G3tz+5DueHCQAnrxI5hW5BW+83wEUxVtgQbqF7ELFUFuieWu74gKVTeVj3qD+8ukzIBB
         DQSgUkZmGX8ZPDjP7P7XM5Lp6EMJYQdYUVElrnM/UMxRk1a4OqLk6GMWi1IrC3gp4I1f
         6UEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134087; x=1687726087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eFkvxxfZGUWIwdt4Yk1IwgTRk71PWUDf3wOYpRw1LM=;
        b=Usv1NvB/58Cv4GmgjfVMdCL6iRQwq37CF6UwSgJfdLU7kcX1UhM8rjxyOhncvAsi05
         dQvgUHl5mdTgEYV4DUN2OWJrAchprOXnLJGltVU+zVFZILcfljtC1sgLWJTp2tqMLlN9
         npzIrgUlnZNdAazHudGDYh/LgmsWHWnjYTdLos/6/LNJAQ9DAHQ+bEbHEL0W24BitrzJ
         5ULhV9zHpl94K92Pax0n1Yv04d7pVSZS7QoMOJLZD1KKvEGdWF17AjELYsbQqr5aBx+G
         LAmwuEaUXSWo1t1wAt3U/tSQLDqRO4ZUlNwFbrjLh+WXL9z63b3bhq25TJqkFyadxOLA
         PbIQ==
X-Gm-Message-State: AC+VfDyJAKlNf1FmA1UX/0CGpR2fgeBjhyWejJf/airWRxwabhbIJYuG
        XP2I0fQ2gDV7CImkj6iD93t4zBE5efInxw==
X-Google-Smtp-Source: ACHHUZ4ZLkwcnY9Sj0z0sYSrR/+0JuJnjoh+WJFfArB/rromxPsYjXooWxUHyo0C8dH5ajc3O9qFgQ==
X-Received: by 2002:a17:906:6a14:b0:962:582d:89d7 with SMTP id qw20-20020a1709066a1400b00962582d89d7mr3535398ejc.38.1685134087534;
        Fri, 26 May 2023 13:48:07 -0700 (PDT)
Received: from fedora.. (dh207-98-6.xnet.hr. [88.207.98.6])
        by smtp.googlemail.com with ESMTPSA id m13-20020a170906160d00b0095342bfb701sm2604413ejd.16.2023.05.26.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:48:07 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Date:   Fri, 26 May 2023 22:48:00 +0200
Message-Id: <20230526204802.3081168-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526204802.3081168-1-robimarko@gmail.com>
References: <20230526204802.3081168-1-robimarko@gmail.com>
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
Changes in v5:
* Convert the __le32 ID to CPU endinaness

Changes in v4:
* Change helper name to qcom_smem_get_soc_id()
* Remove len and just pass NULL, that is sufficient here

Changes in v3:
* Change export to EXPORT_SYMBOL_GPL
* Use an argument for returning SoC ID
* Update kerneldoc
---
 drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
 include/linux/soc/qcom/smem.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index bc98520c4969..b0d59e815c3b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -14,6 +14,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
@@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
 }
 EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
 
+/**
+ * qcom_smem_get_soc_id() - return the SoC ID
+ * @id:	On success, we return the SoC ID here.
+ *
+ * Look up SoC ID from HW/SW build ID and return it.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int qcom_smem_get_soc_id(u32 *id)
+{
+	struct socinfo *info;
+
+	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	*id = __le32_to_cpu(info->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
+
 static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
 {
 	struct smem_header *header;
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index 86e1b358688a..223db6a9c733 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
 
 phys_addr_t qcom_smem_virt_to_phys(void *p);
 
+int qcom_smem_get_soc_id(u32 *id);
+
 #endif
-- 
2.40.1

