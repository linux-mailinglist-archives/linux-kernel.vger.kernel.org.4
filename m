Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2D6BA834
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjCOGor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjCOGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:44:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C734F4E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso866042pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678862636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=BglwtNw4Zw6GRh3NfHk6LEm2Oj4z0BeFL1WzXqTChOCWXXCvoVhqsILwu5lTCJaVZy
         93EsJxt7kBmAuDAwQ7YV2Yz+JIA04ptQGXp6hGztSQBDZxpQEqigCtyrelB2F2VAZ3Ym
         D2HJzz8bGeUKno2mdhEU4ik5q8qvsN7utfXw5621DCemgdRgxyfjLv82CVsmxvaGStlZ
         2HlwoAGv/I9vMqeNsZEYpAbHSlwASAFT/cYjT5HvZgMOr31XtkyIoY1VRynL43L8syfT
         vWIdqjYCLYlcPFlGopijzR3YkC7gnrNWqCWbNty94EIcE+Uc0vlIeSwWBtR5QJWaS9aF
         VIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678862636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=DfXoZDTneWblx4q+dJU7h1qmRPGgzon8HIs5I6Divs2R8F89+94zWHE6VBhDbwCynV
         uzmgnHN+KKlOCF7r8NVCXynBCCt5I6bqOoL7ALVjmgkjCQ5EbYNHy69yCJzUea3ua2AU
         4woDWqnqmtl9gKBImcwtLnWPoeb9LdShghsvGlrbKKvFiDm75Yn3bOFq0He+rRST60xk
         jLfPtPiztQy5uG03qqUJ1sHTsMszEur6O1rlGQmFrQ0BPQLKoOnLuquaUV/ZqSbtKwds
         MinspRTNsXZ+7deMf/eptgNY94sa1DRa0wzdxgHPqVCDR+NXXUz7NYhieTBjd4hhoL3l
         ZOmw==
X-Gm-Message-State: AO0yUKVg+UVTql5aTX6uHUEl3JC/4K6sjHSwlutJYCoGPtC+WztBpJiF
        SZzRPosIrPT//G6OWhV48+p/
X-Google-Smtp-Source: AK7set/u9Jvr7n1AyROy8OIcMF5TkgS/9lBuiec1UM5YkZmTdjPmDnQgD1GbWXiK3viEcUpVja4mfw==
X-Received: by 2002:a17:90b:1e06:b0:237:4170:f63 with SMTP id pg6-20020a17090b1e0600b0023741700f63mr42945455pjb.18.1678862636155;
        Tue, 14 Mar 2023 23:43:56 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.35])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a6a8400b002367325203fsm550747pjj.50.2023.03.14.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:43:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 12/18] PCI: qcom: Use macros for defining total no. of clocks & supplies
Date:   Wed, 15 Mar 2023 12:12:49 +0530
Message-Id: <20230315064255.15591-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To keep uniformity, let's use macros to define the total number of clocks
and supplies in qcom_pcie_resources_{2_7_0/2_9_0} structs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ed43e03b972f..e1180c84f0fa 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -185,16 +185,18 @@ struct qcom_pcie_resources_2_4_0 {
 	int num_resets;
 };
 
-/* 6 clocks typically, 7 for sm8250 */
+#define QCOM_PCIE_2_7_0_MAX_CLOCKS		12
+#define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
 	int num_clks;
-	struct regulator_bulk_data supplies[2];
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
 	struct reset_control *pci_reset;
 };
 
+#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[5];
+	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
 	struct reset_control *rst;
 };
 
-- 
2.25.1

