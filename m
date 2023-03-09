Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861CE6B1EDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCIIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCIIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:52:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0FEDC092
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:52:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p20so1226187plw.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=QlHM9WzaNYPlNEkXYyyFnr+5ZcQhqyh7YDcg0zxTlaCrZSuTkzyKt7zpeLB0nhaRRS
         vY2PX+HAo7SErnKbnenM9dQsPPP4kAPAHODJpOcnMS0AExPgXvL5pN3lo3BEAXA5RF8f
         hmvX/gmwNlsYnRYFLDKtudy5zZ+ysQy+BvG2NZYy+edI51Ru0dclTnTwf9WUR/XHDFgI
         g7Hwgm/ZxSS26D7huci1fkGX6bdo4GVJcRcF6drQh6707Qp1E5byZmuwf6xarNh19m4z
         wLrJpOWfbbhge0/FN/KZJOFmJcrCCWr4c99gCkhMczaBxeKz9BMdFcnU8KxsLwl1JF5F
         opxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=UPDv0ixLyzWdwMYcwmQCpxyE8sXD6LEQVbi3UNcXFxeP0J6k47/pg853nMHldybFcl
         irhZ0cgGS+dUCp8CxuAAbOclC//ybh3baz54SCZv3BK5b/zmD+mgtUn7irzel0iz9kSU
         39nYr71fo9t9XuS0+Mlg5v0UaZQMgFfvM9ekJdCHTdVUJjaP/HDhvs9xjLoH1KPveDWd
         FW1qQKhvQtOVtbR3nCkesekKGIG3im7IlWUoa1RqrUONzP9ul01Aj0pGDSLd9phr2SNv
         pdBdxYAve7DPOhKU3lg1Mvs9dvzwOICEcVtcNXOw4frQqxWCmNeu4b2+aax8/pom8Mfc
         TIVQ==
X-Gm-Message-State: AO0yUKVGRPst73Ba274fuca1eVDpFVhoT1VqZqrHssaWAngAqA+u6W28
        hduwLrMyPmMe7IWf+QEb9+Ns
X-Google-Smtp-Source: AK7set+Hs+f5ctQNyheWzJTuxjgHF/4URTVNW3lyukxYE2fI0jhqjvjHYtYrKgTjMtzA87GEnoacWg==
X-Received: by 2002:a05:6a20:a025:b0:cd:9db3:a7c1 with SMTP id p37-20020a056a20a02500b000cd9db3a7c1mr20729333pzj.44.1678351923338;
        Thu, 09 Mar 2023 00:52:03 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 12/17] PCI: qcom: Use macros for defining total no. of clocks & supplies
Date:   Thu,  9 Mar 2023 14:20:57 +0530
Message-Id: <20230309085102.120977-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

