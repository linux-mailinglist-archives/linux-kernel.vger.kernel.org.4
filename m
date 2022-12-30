Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49F2657426
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiL1InQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 03:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiL1Imj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 03:42:39 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6533101EB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:51 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id q68so2692754pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 00:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEcc2ZZg4+/rCWO8lF+EBDL5HIag6zFEZ6LhCeBUUxo=;
        b=mM6JYQb0jk21og7RBPj3Pp04t+jep2+4Zn+V+h8iqDvgSqUJi+xO4sCiKl2AseYPGT
         4ECPjuk5wGtGhAFBWt77nLJKn8jbWFjka0hpnyNoQLv10Oh2HWmfydarS7uN0Xs+wEXN
         73YnCny+mzGFwoqfdhKR23yjYvkwx9otssh26xK5XKNsn/LhdbKpOJS/WvJ6SYx3SecF
         K8/E+1lzQXmeNHAcJu16O+BuyW0LiEzv8qrI0iDnFonMswmi2dmV9irgA7MceQRUTxEG
         F1UsM+ZNkoMn0NFfdaN5GLoeHoqhAQYUCcq8IlPflSKOlhArg8QkfIatJYVGWhgv0VH3
         pjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEcc2ZZg4+/rCWO8lF+EBDL5HIag6zFEZ6LhCeBUUxo=;
        b=Djcls7lh+41YaV6ax9rVkHYnujvB+44QCKBiaGVCd1OhNYqjg985JGvv1i8QfjUljt
         WHwIcrk6ZvwWCPqcPKct0cDM5tb24fkVkbtDe+7UBEhTztLIxtuntOlg+CoU94hjUTax
         OozNxkjtX2qzzlb7jJkvrfcDWaSvlO6tnvHBhrklP0VxUgiI9MZcXbNLKxr6WYv+nwXa
         0aGOQxcjJUlUH8cqx+RE6uQHh3X4Je4jCYYKGrDKho7k/RqLQYata5TxJbWeR+UgElRx
         5RD1Dl2BKzVwDGTj3A1DKL1aC0lyWnuR0CmbPW09fUN1gh8htFOkTRnmeRy87KfhhLhR
         7ovw==
X-Gm-Message-State: AFqh2kqSS76SMnq6QGp6yHf7MuirIQCrH7tf4ps5vRbSaV3Bf8T6KJK2
        16MMiEjL97K8iZ0SG4q2gzRs
X-Google-Smtp-Source: AMrXdXvZYH0gAWe1kQmcT/Bq4rXI3pGKlar5Q3Mhyfgz9CNgIOcmHM16EWtZr8j/D49kmR0RCsEO8A==
X-Received: by 2002:a62:6347:0:b0:56b:d328:5441 with SMTP id x68-20020a626347000000b0056bd3285441mr22743715pfb.11.1672216911280;
        Wed, 28 Dec 2022 00:41:51 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.73])
        by smtp.gmail.com with ESMTPSA id d188-20020a6236c5000000b0057a9b146592sm9786286pfa.186.2022.12.28.00.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 00:41:50 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 09/17] arm64: dts: qcom: sc8280xp: Fix the base addresses of LLCC banks
Date:   Wed, 28 Dec 2022 14:10:20 +0530
Message-Id: <20221228084028.46528-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
References: <20221228084028.46528-1-manivannan.sadhasivam@linaro.org>
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

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 109c9d2b684d..0510a5d510e7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1856,8 +1856,14 @@ opp-6 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sc8280xp-llcc";
-			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09400000 0 0x58000>, <0 0x09480000 0 0x58000>,
+			      <0 0x09500000 0 0x58000>, <0 0x09580000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc4_base", "llcc5_base",
+				    "llcc6_base", "llcc7_base",  "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

