Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950546B4862
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjCJPB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjCJPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:01:28 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41D12C436;
        Fri, 10 Mar 2023 06:54:58 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-176261d7f45so6038506fac.11;
        Fri, 10 Mar 2023 06:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uImUbNaV7wiBHen0L703XZwJA1EUSBWF5TLrsQa3YcU=;
        b=4ZbjPo5LB7eZ280GPReYYHpcpZX4wf2SRfP627EQE2CAywOKVOWNuy1KRHgZ53mv8L
         bm7Cqy95JhNuD+SVEk4q5RctBBH/sK5Z6dtM5E/xHnHpm2f/SRPyQiY6F/TXcYSds4m8
         s2QUiZ4BJ0vvdQe2j5M/kf0Lh3KGwBOvT5vKhUZXomIXkHxFYCwlCozxy5dF5q5/7rlE
         +nP5QM1YT64RkSMChhHP6fQX5ttajWhQu9YpFBLb+f2nMk6cWLozNusaD/z26+QPA2BW
         HBJFvcZjTnCjXO2iwKkyYui9ZqRuA/ITYbf+bq0r8N5c8LMjVTRQ79N4kKLlWsWdLGuv
         4MWQ==
X-Gm-Message-State: AO0yUKWqgUIvE4wditpcDNDtB6LaBEljIac2+fbSeIQY16TFxQYHiezL
        C93nJREdq40ZfzPhDoHa6A==
X-Google-Smtp-Source: AK7set+mUxeO0Q6zckV3Wzj+6l9vR087TJSeGxvZsKMOFQZVU9d3N3/5VVxhw7OKw38MOpvafeMSpw==
X-Received: by 2002:a05:6870:9107:b0:16e:18a:7e08 with SMTP id o7-20020a056870910700b0016e018a7e08mr15840947oae.39.1678459713975;
        Fri, 10 Mar 2023 06:48:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k6-20020a056870d38600b001764f55398bsm113643oag.20.2023.03.10.06.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:33 -0800 (PST)
Received: (nullmailer pid 1545179 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:24 -0600
Message-Id: <20230310144724.1545153-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 drivers/soc/qcom/smem.c      | 2 +-
 drivers/soc/qcom/smsm.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 18c856056475..e376c32cc16e 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -395,7 +395,7 @@ static int qmp_cooling_devices_register(struct qmp *qmp)
 		return -ENOMEM;
 
 	for_each_available_child_of_node(np, child) {
-		if (!of_find_property(child, "#cooling-cells", NULL))
+		if (!of_property_present(child, "#cooling-cells"))
 			continue;
 		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
 					     child);
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 4f163d62942c..25f5925a8d51 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1045,7 +1045,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	int i;
 
 	num_regions = 1;
-	if (of_find_property(pdev->dev.of_node, "qcom,rpm-msg-ram", NULL))
+	if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
 		num_regions++;
 
 	array_size = num_regions * sizeof(struct smem_region);
diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index 3e8994d6110e..8c137dff7dac 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -510,7 +510,7 @@ static int qcom_smsm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for_each_child_of_node(pdev->dev.of_node, local_node) {
-		if (of_find_property(local_node, "#qcom,smem-state-cells", NULL))
+		if (of_property_present(local_node, "#qcom,smem-state-cells"))
 			break;
 	}
 	if (!local_node) {
-- 
2.39.2

