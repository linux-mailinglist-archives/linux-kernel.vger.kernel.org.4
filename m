Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C567118BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbjEYVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjEYVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:02:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FCF199;
        Thu, 25 May 2023 14:02:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-510e419d701so5687375a12.1;
        Thu, 25 May 2023 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685048539; x=1687640539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQtz6v7Hj5j1tfmowjTsEjjYvDTSsmx54tvIW02KIzE=;
        b=BgR3QBvaOti23Wx+ddMulO5QO8k+UajcZBC+FwQS8tgAsD9oUdoxRDNQQAO2/N5O/E
         m40TonwXHFwM0FmymmxGGxAQAKadR69sfcEmx5N5HhCIXPN9sizvgHc29El4F8fJnJvy
         DNM+k/WW93t6ya/5ha1gLvxaK5o/YxFo+Xn6Hn/Ze2qQJyr2M8clRAqDt3DxZJbz0g6k
         4VVuruCe8TK84SvDrOQ0nRHzBkco4CUeszGDYD2sfzXIwyXmPycEzWVSsIgDGRosYSvi
         sxVZFPHXKaYos7wapvAVp9xLgwiGCf5dMblMznYTR9q1cSkocYb/HnpKBIGi1ECyzHc8
         B30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685048539; x=1687640539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQtz6v7Hj5j1tfmowjTsEjjYvDTSsmx54tvIW02KIzE=;
        b=kuWDbUcwoe7t1Cq0w2TtESDV3DJY80c8hFNg+ltg0ps2xQSdrd1KLz1PRZ29FN8XUV
         D+slVfzpEmV/sVtMx6a8k+ilmWACBDHMtEOqJcDDQAAZwky6LE2XYN4PHRwmVdkNIVCT
         RrhMRgNCZT1O3L9QrzV6zpwC+0iFbk2NI2D1mN69JAk+SO5zHoHlXxvX9Fyhzay6x2ST
         FHa1ltLhyXtGh7ODz0M1VvZUWGy3S99JDrkjE2e96NIQn/XVZ3LuY8D1NcZy2WlHvroz
         /kNS9DEfo7dUSKoAdzJyhgZwROPwAthbDXw1DPyEh02848NSeCyKER8aRTCEBGWbrwYO
         ir3A==
X-Gm-Message-State: AC+VfDxfuCWxh5QSiBmPcoW6UOFdgkYwNqC6Xs2BMa9hdTpYoyCsC6Ol
        jI5wQxNLL181iBgg2D9ZXWE=
X-Google-Smtp-Source: ACHHUZ4hUXusKtbwX40uslNL/odfRfMKq3ncRSrLNqdQUnhQNCdanji0hT9vGkn42s0sCkPb4I/kVg==
X-Received: by 2002:aa7:c688:0:b0:510:dd3e:86cd with SMTP id n8-20020aa7c688000000b00510dd3e86cdmr5994877edq.20.1685048539533;
        Thu, 25 May 2023 14:02:19 -0700 (PDT)
Received: from fedora.. ([213.149.38.146])
        by smtp.googlemail.com with ESMTPSA id c25-20020aa7df19000000b0050e04125a46sm913010edy.10.2023.05.25.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 14:02:19 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Date:   Thu, 25 May 2023 23:02:12 +0200
Message-Id: <20230525210214.78235-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525210214.78235-1-robimarko@gmail.com>
References: <20230525210214.78235-1-robimarko@gmail.com>
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
index bc98520c4969..78cf79ea4924 100644
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
+	*id = info->id;
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

