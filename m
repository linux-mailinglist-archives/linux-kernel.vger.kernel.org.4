Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED876C9D12
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjC0IAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjC0IAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:00:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CE444BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:00:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso10193984pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679904039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t835u8fPpTnpgpz0aOnogBgxIgEA8yK0GAtsldSZe9U=;
        b=IHujZ+yJH5Qfn6DB3SeaG6Lv0s3K8PfGgLtlNTZ/z2YwYag+mamqHhak08nyiSD202
         kGUyYiy3bfj06OKK+9FFuXG+j7pBDTHyDbbJKy+bA4W5zD7/SToBdUrJgiLUMgdawblz
         i0NmCSwGiJrFzwVYEe5HM4wItvf0xqgUtWVTCdBjV1ruzZdMkwJ5H6+TGQlQSUAdRJSY
         +3+2B44HzRMacOeF8Z31ktcDtrAXwpKjdpvE+CFso0R2jEg4BiBxCdCX518nWo4q5lQY
         3sVqqI6L91nqyB3c5HYrRXkFv/IAihCzguoF73FOeyhtDFEu4cptDMynTU4LuFKHkjsH
         AA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t835u8fPpTnpgpz0aOnogBgxIgEA8yK0GAtsldSZe9U=;
        b=XLxtPt7TJCfbmUmzO88hBP0HEZBHT4NUt2AF6I2y4yKiURHs9/TMzZr0193aDUVyIY
         CjgJRQGREvia5r4qo4ZGW7ps+4kQ6kg/ZjBGLYuTP9NPOuhAOPmsq26x+wNgAXKw462o
         Jw5KGOR61bZyFYFONlJEE8sY6iq/glNZePQxbTJm9qxbg7YLGsPnZf3crGB7gI+e4vUs
         TUcfNvGEVDZIW3V9JKQe4MBxG3ILUbGeZBd+41n0+cXUJexXAu/fFxXU1aoj6ElyA2n+
         4w0WYJkej0WxXIvAq3rZyx7+QeQ1xV5Cb7wgFLXGH6kjneKRMxJg4XoJItFI2ZrWyD3w
         +mZg==
X-Gm-Message-State: AAQBX9e9JanohUp+7W+4AnobpccppkfmlYlQtwLjAjB69p/6fp7WGTKZ
        UsqPpY9VkbEw4j5aV5uu9ibk
X-Google-Smtp-Source: AKy350Yl/PP07MKLFG2pkiPDQVZC7O3+X0DB170zIRdxpW6VfRQUJZ83xB4ggU47iKV+/Qgt3rV7CQ==
X-Received: by 2002:a17:902:e0c5:b0:1a2:1a5b:cc69 with SMTP id e5-20020a170902e0c500b001a21a5bcc69mr8084298pla.32.1679904039265;
        Mon, 27 Mar 2023 01:00:39 -0700 (PDT)
Received: from localhost.localdomain ([117.217.184.83])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902b94c00b001a1ed2fce9asm9844469pls.235.2023.03.27.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:00:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     will@kernel.org, joro@8bytes.org
Cc:     robin.murphy@arm.com, andersson@kernel.org,
        johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5] iommu/arm-smmu-qcom: Limit the SMR groups to 128
Date:   Mon, 27 Mar 2023 13:30:29 +0530
Message-Id: <20230327080029.11584-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms support more than 128 stream matching groups than what is
defined by the ARM SMMU architecture specification. But due to some unknown
reasons, those additional groups don't exhibit the same behavior as the
architecture supported ones.

For instance, the additional groups will not detect the quirky behavior of
some firmware versions intercepting writes to S2CR register, thus skipping
the quirk implemented in the driver and causing boot crash.

So let's limit the groups to 128 for now until the issue with those groups
are fixed and issue a notice to users in that case.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v5:

* Reworded the commit message and comment to reflect the fact that the
  hardware indeed supports more than 128 groups.
* Collected tags

Changes in v4:

* Spun off the SMR limiting part into a separate patch
* Dropped the quirk rework part as it is not really needed for now

Changes in v3:

* Limited num_mapping_groups to 128 as per ARM SMMU spec and removed the
  check for 128 groups in qcom_smmu_bypass_quirk()
* Reworded the commit message accordingly

Changes in v2:

* Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
* Moved the quirk handling to its own function
* Collected review tag from Bjorn

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index d1b296b95c86..decf63b8c97c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -268,12 +268,26 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
-	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
 	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	unsigned int last_s2cr;
 	u32 reg;
 	u32 smr;
 	int i;
 
+	/*
+	 * Some platforms support more than 128 stream matching groups than
+	 * what is defined by the ARM SMMU architecture specification. But due
+	 * to some unknown reasons, those additional groups don't exhibit the
+	 * same behavior as the architecture supported ones. So limit the groups
+	 * to 128 until the behavior is fixed for the other groups.
+	 */
+	if (smmu->num_mapping_groups > 128) {
+		dev_notice(smmu->dev, "\tLimiting the stream matching groups to 128\n");
+		smmu->num_mapping_groups = 128;
+	}
+
+	last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
+
 	/*
 	 * With some firmware versions writes to S2CR of type FAULT are
 	 * ignored, and writing BYPASS will end up written as FAULT in the
-- 
2.25.1

