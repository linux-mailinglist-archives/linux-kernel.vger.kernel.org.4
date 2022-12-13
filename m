Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA9564BCD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbiLMTKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiLMTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:10:45 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F525C6A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:43 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s10so4387304ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08W4M5ecrrhDdw881i3P0twnVzROKcZey0x07rUUL38=;
        b=tHKiLpkK7CqXBNo391zBO1Wqcc37AhhKYcicBLSW3SDI4wuxZbmQd8GlAm7K5MiG2H
         irSBilrVT5VUk+3NmAZnAK/HpLZ/yk4M3HTOUmmLgwj4lBYg2gGgBvvdEJQx1whFyEVv
         TpjsFJQ2EWvtZY2uikg+zsf3OvnW7MoM1vcn6w4TxKDM1Pb2f2/SbA/bGdq802UxG1sB
         dtxzbgrv3ITnxXZYFuvsMj+pMCZt1g3Y8X4ppWgFPRh0P31XURZ39gb2VQrg0n9actaV
         g8AbheiFDFU//qX32kbk8WA49Bsa3XQA8xF6v3LKkk+vzfP34ndZ9pPbaY1UHpGi2da0
         /MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08W4M5ecrrhDdw881i3P0twnVzROKcZey0x07rUUL38=;
        b=d+lCtDqcnR1V92QEtZYe04cQj0dOVgI8PmVPWPLnnz3HhM9vI1JgTcag5qTCfqP1jx
         7akV11XzmOXQr7iET1bdGSnAixPHlPaKoTpHdChu1zIdLbwIZ46TW+Rok63VXer8AEvL
         Fv0QgFzupf2egtjTnrzSjW2Zuykwpyxg4UXav6Qkvao/F7EHA3potHSxjKWW3R55WXjD
         WfuoeHON3S1FomUKxWEcvfZbbKCj1EVofUAM9j56spKxY7B7ADmMmueM4h1S1rGdAkOs
         xFyVtLTBNv4qOfex1eglqu6HQUg3rH2n7XLf0VXUKw6x3V60uYJnnJGzLg6cBIbywefZ
         7wHQ==
X-Gm-Message-State: ANoB5pk/3vvEOqA+HfMYlzgePjWMZqptTtt0RJrjQ8iLAjwFJHrBJM/a
        wLwIvHdDaZI5Mh9e2zAKE0th6w==
X-Google-Smtp-Source: AA0mqf6FgGAGi5hv6VNmifSRh5rdt/V0r+gPARkCVrqAEhaAVL8ZBK8Rte3tEVImDZ5wCxFNikcIQQ==
X-Received: by 2002:a2e:854b:0:b0:279:eb16:5bb5 with SMTP id u11-20020a2e854b000000b00279eb165bb5mr5388032ljj.40.1670958642014;
        Tue, 13 Dec 2022 11:10:42 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651c119c00b0026dfbdfc1ddsm372023ljo.11.2022.12.13.11.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:10:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arm64: dts: qcom: sm8450-nagara: Include PMIC DTSIs
Date:   Tue, 13 Dec 2022 20:10:31 +0100
Message-Id: <20221213191036.611241-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213191036.611241-1-konrad.dybcio@linaro.org>
References: <20221213191036.611241-1-konrad.dybcio@linaro.org>
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

Now that SPMI is finally in place, include the DTSIs of PMICs present
on Nagara.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index 45ee922de4e8..e29fb7adc780 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -5,6 +5,12 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350b.dtsi"
+#include "pm8350c.dtsi"
+#include "pm8450.dtsi"
+#include "pmk8350.dtsi"
+#include "pmr735a.dtsi"
 
 /delete-node/ &adsp_mem;
 /delete-node/ &rmtfs_mem;
-- 
2.39.0

