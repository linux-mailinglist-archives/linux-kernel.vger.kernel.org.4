Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6398D63F27D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiLAOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiLAOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:16:38 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BDC6E64
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:16:38 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d3so1744070plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9z15GcvNuRMNo2BN/9lRT8Q5BhNXbMviW/S6PD92K0M=;
        b=SHoQhPFJ3XyXWJgXVxmO7wu2YTqgDSWfvNfeW370fWnYzaYu1QaSwAUmr4x0ksAx8P
         mT2lHH5Tg4fagALN9RqqSXxobR39W/JnRxTjSHEBl4Jk4OmSSnn9Uc4YW2LDrgP+MWGd
         1f0JS5qm4AftYIUU454/ACbxDpvh/CkogI3alCVBv6v6QP6MrJebsUoHpTX8vR5ALDR4
         KCO4zhenqo/DGRl6XAJ3HzaxnqD7cuB+iNCtFAeH2y8Rxos6B7CVfUaN7tm+gsxAIPA/
         ABeA0I76PersCtwiK4M7nrUYh2t5keuW6Ya5EFGZ/aRjMDP7tc2quRhsiH/deIe+fPNk
         96qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9z15GcvNuRMNo2BN/9lRT8Q5BhNXbMviW/S6PD92K0M=;
        b=Dvy0V2d3XXt3ZNohI35lT8JkIVxA2Q19aWDbT7K2uEysSBCQHwSX06eqvGbNluJkCI
         ck6TgCnQBXtFxqtfgH0h8vt7Ei275YyKns7940T3Ri2RhnrghN7rRUnm89YWi5QGcsmf
         oMvFaoco8lq+AHJkEOd2bnc9SYgfm5FIz5PFC5Ooc6LQNvxYi9fuAmxh471JTzlBDT1F
         GL8rRhWLazVYfBOL1e3js8EBLz9Ac0iuA3lJs0klBe3pesq+j7K8W/JmVZyOcBPL7F4Q
         0oHZ2PGwBTmQMHc7uP1Of/MJc7zEq0kJG34EfFRBivWfPDwRb5WY4OudCPlc1ND+Cedc
         rs4A==
X-Gm-Message-State: ANoB5plRAO1WZHh/Uvs2fMuhtaJDSgP/lfbxoOFdWp10xJ39helFZEUZ
        CwNR3F+n49WX6O1xgytRqI4ZNw==
X-Google-Smtp-Source: AA0mqf61oU5Em0iyGfYt0eGOn2HIev6wP3V7ev+tWGJit0sNvnU76MYg4nbdtInKpxdUKaVql6Zr3A==
X-Received: by 2002:a17:902:8bc4:b0:187:2790:9bc2 with SMTP id r4-20020a1709028bc400b0018727909bc2mr50317178plo.61.1669904197688;
        Thu, 01 Dec 2022 06:16:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c61:2814:c945:522d:e948:beb1])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ff0200b0018975488514sm3663041plj.126.2022.12.01.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 06:16:37 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 2/4] soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to the soc_id table
Date:   Thu,  1 Dec 2022 19:46:17 +0530
Message-Id: <20221201141619.2462705-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
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

Add SoC ID table entries for the SM8150 and SA8155 SoCs.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 545934aead43..92b27db60840 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -305,6 +305,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA658) },
 	{ qcom_board_id(SDA630) },
 	{ qcom_board_id(SDM450) },
+	{ qcom_board_id(SM8150) },
 	{ qcom_board_id(SDA845) },
 	{ qcom_board_id(IPQ8072) },
 	{ qcom_board_id(IPQ8076) },
@@ -315,6 +316,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA632) },
 	{ qcom_board_id(SDA450) },
 	{ qcom_board_id(SM8250) },
+	{ qcom_board_id(SA8155) },
 	{ qcom_board_id(IPQ8070) },
 	{ qcom_board_id(IPQ8071) },
 	{ qcom_board_id(IPQ8072A) },
-- 
2.38.1

