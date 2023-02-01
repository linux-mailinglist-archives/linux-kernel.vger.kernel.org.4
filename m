Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB751683AF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBAAJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjBAAJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:09:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DA42E81F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:09:06 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mc11so24086674ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZe1ZAfPMUAgxNYKvTD219Xk42rFPChmIi+qpZotkIw=;
        b=bfkawtuYi/wd0snVs0/FdZiyhfffs5Srch/gxaN0NEJ/pOylUEbuqDChFuLYjDGiUp
         Yrnt7FQf9AnJg1G3tQC/jFpsxtgNLdJCrA0rX1zCZPftbDGPG+9hIGvz26euYNt6j+T+
         Mi1eoXhbFpcD+xx8AA03teeeYF3SGQrSI1i/7M6PmweHn11txtYTWDFdrvL6+PonmeJp
         zqPqzgMJI+G/7XFpuA/84h5WvcYJO9ioy33aU1YH7vFFZA0WkBXj4T+V+ZYGUPwLNxc0
         8C6lhVQu5iy8ER6Jz/ZX9/dHwA9UrkccU78ldcmefVSRGwqxia4BxoBJVqZvfACCnGKr
         mV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZe1ZAfPMUAgxNYKvTD219Xk42rFPChmIi+qpZotkIw=;
        b=x8gCi/hIMsMvhZfmEnlDe/c+Er5PPxrm76xSumeGlg+ZZXQabTJBVCNEX8MTjlhom+
         53oC+pNRh/NUqssEAMXlH4JNbi9iKK6UufjA4JFr/xr/7uD/2FlX8GeWnz3UaJKeTFYB
         ThsK2cnVn5m3m47/Z7heFp8YAN40s+bpkGFsebJKh+Khcu02u2ZJ5Sesztshkb8qvoMB
         YEXUDbpKd2ZqPZ9DcxVfltjiVqJzZdKKAQXQ2w1Y0XsbJNoxfiuQPyHJbZrxkQUyZgq4
         6cFS7DGzKCKIAuAaydlB6DcXOfmNZblTGDAMuDl9U9kleQf9bjoUbuUkwmhWtGMzSXV8
         6wJw==
X-Gm-Message-State: AO0yUKUVcfsJGfcYHBipP2Odhtui7+k2tYPZ3jZkn+rFlrfbLSSY85qf
        k7vDgX8mfjN4tmWrn+BcnGZCyziTKkQ1ftk/
X-Google-Smtp-Source: AK7set/GF3TwWrgQzz/XCg0dV9elDDSxv+RBHCVujE9/jndkXbNAkaQjYGY/j5WsAuQHUHjwiemuVg==
X-Received: by 2002:a17:906:4cc1:b0:887:2267:c0a0 with SMTP id q1-20020a1709064cc100b008872267c0a0mr266752ejt.21.1675210144832;
        Tue, 31 Jan 2023 16:09:04 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id o13-20020a056402038d00b0049622a61f8fsm5681364edv.30.2023.01.31.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 16:09:04 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Michal Orzel <michal.orzel@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: Add a couple of missing part numbers
Date:   Wed,  1 Feb 2023 01:09:00 +0100
Message-Id: <20230201000900.3150295-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Add Cortex X1C and add/clarify various recent Qualcomm Kryo cores,
which almost exclusively mimic ARM IDs nowadays.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:

- Don't change the name of QCOM_CPU_PART_KRYO_4XX_SILVER

 arch/arm64/include/asm/cputype.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 683ca3af4084..a4260d3194fc 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,7 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -107,9 +108,17 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
+#define QCOM_CPU_PART_KRYO_5XX_GOLD	ARM_CPU_PART_CORTEX_A77
+#define QCOM_CPU_PART_KRYO_6XX_GOLD	ARM_CPU_PART_CORTEX_A78
+#define QCOM_CPU_PART_KRYO_6XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X1
+#define QCOM_CPU_PART_KRYO_6XX_SILVER_V1	ARM_CPU_PART_CORTEX_A55
+#define QCOM_CPU_PART_KRYO_7XX_GOLD	ARM_CPU_PART_CORTEX_A710
+#define QCOM_CPU_PART_KRYO_7XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X2
+#define QCOM_CPU_PART_KRYO_7XX_SILVER	ARM_CPU_PART_CORTEX_A510
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
-- 
2.39.1

