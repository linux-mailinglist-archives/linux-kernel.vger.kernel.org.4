Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966C75B35AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIIKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIIKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:51:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC42E55B6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:51:43 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l12so1333594ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sCVJmb9xEdoepPQapuaHWdyOe5wlqvz7CXJRYzFvRGs=;
        b=uNjVJntF8483UJyZWTkP24XMsK2XlYPextJ4dK98j/kr+8m986TL+CYzLvmoDe0CeI
         iOMIsE4CTvQgSIzC+D5d170MoIWi6QsM79s6u/C6f8LKs1zYa1FQzaEPATVg+xZcFSrA
         8cXM510uRoho92iUVieF8er0Mg6idpI/agqI2v5dHdqogQ7zqE3uggVSsOJjL1F4wgrm
         r3n+NhpUxq57SheHxWgO9PQqwVL3RFG3aKPOTrVPngkgtiqvQrWeSgDhStdCwaBxpfKz
         FJxpAcDcd9baJH8hJoITOEc2XHOrbc6WlmvXfQN1/o/yhA43RtIkDqQoR8Jj49UdRSwL
         y6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sCVJmb9xEdoepPQapuaHWdyOe5wlqvz7CXJRYzFvRGs=;
        b=Kl5DQb+3baMd8eDb7yafhUv3H7VuoU+vgBjulmTE6ebd+elhjY/RASfzcjlkuITtnp
         v5f1uuHqjGabToThaOSCY3/fY2e2V/uGR7P21yfJA3eg8fcBEk5y49sanHzIhqRIYlky
         +Jc/YvPZVF10CA2DTfTDutX1y2OrLFEx+c3kwfdEYDe8kD6CqGjRbZkWKX1/LF7alnko
         5atdlSgPyahGuoLvMrkXhXzJEMo3I5/7cjgLy8LQ6CrERUtnMHvFOSPv2dBYlG7qYnSn
         5q6ceBQa0rOTIA1JLmqj6vKT9Vg77qb/Te+PSSBqtZrawHion8ZRleQ0h7G9stHwKqv8
         yQdg==
X-Gm-Message-State: ACgBeo2eKY6H3iFIUw194CMS5XoZ/e2Ymt0jy0QfN/ZM6ZsZ/myn+lGR
        yvI19d3rQfhiZ9SdQUO7nfo2BQ==
X-Google-Smtp-Source: AA6agR4riXi8qgEvRvFYPBCgO4ABuF2M4+Lqvy5b3hyLHNRFuzJkS4lacnmE/ks0rm2XNU9zWe4iBw==
X-Received: by 2002:a2e:978f:0:b0:26a:a62e:8f2c with SMTP id y15-20020a2e978f000000b0026aa62e8f2cmr3804421lji.153.1662720701591;
        Fri, 09 Sep 2022 03:51:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea448000000b00268b85321eesm24796ljn.113.2022.09.09.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 03:51:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: defconfig: enable newer Qualcomm SoC sound drivers
Date:   Fri,  9 Sep 2022 12:51:36 +0200
Message-Id: <20220909105136.421877-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sound support:
1. machine drivers for Qualcomm SC7180 and SC7280 SoCs,
2. Qualcomm ADSP Peripheral Image Loader used already on SC7280.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Enable CONFIG_QCOM_Q6V5_ADSP=m
2. Don't cc soc@kernel.org
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 265454620682..d41423c6079b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -792,6 +792,8 @@ CONFIG_SND_SOC_APQ8016_SBC=m
 CONFIG_SND_SOC_MSM8996=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_SM8250=m
+CONFIG_SND_SOC_SC7180=m
+CONFIG_SND_SOC_SC7280=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
@@ -1087,6 +1089,7 @@ CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
+CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
-- 
2.34.1

