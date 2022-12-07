Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72D645BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiLGOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLGOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:01:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C65D684
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:00:45 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s196so16476448pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 06:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGwgSnOhYi02xVu+IbkUS49u1T5vi+3uXVqLwkjF92c=;
        b=RelowFhh6oDnHAyNKyX5GbA0mViEyG82HTuOCWYZ5qrEcSdJzwUBvwFBBkWMWJVLJS
         XQ3r67OTKq+d0YJ+zYjUP+DwVXu6cA4OsIXmXxXwuJz0ZYIEj2jbu7bUdy/uIB64TN/B
         3wp1Jd1vmyS5dBY19RdVefXiyHrbBtesuuq5FyzuRz0fd3ZAWF+Mbz0rRWgrPWxl2EWt
         DDesFiVgla6qIu4YzL9mosel0xcmbHZQ4Q913AxLMXeXPl67p9ko9DuQWmDMSrp9yxgt
         5kM9BPICjX/IMuGDeziQRWvE5dnp7fZGCifql6pp8otxSixvDtscV77RApqMb76xzJc8
         +Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGwgSnOhYi02xVu+IbkUS49u1T5vi+3uXVqLwkjF92c=;
        b=b9wreoZjph7Q2fpGT4SNSj9ef3S1SAeSR2Ta4RUYceFCEENPiksnY6bcW7XGNPZesL
         ng1diop/lA/YGaXhz9Av5I7kmMq2mD38Pgh9T1UiXewrbqlvX3AT8bcqDGEcf6/Ks0pi
         VNUAyOrY4++3hlUba7hiqPVlp8MNz6qqb8K5UuOUL570cPDlzbHODJzNMpYpvqT2wHFA
         m97TiAjHfhTP2EAstJ1U0uH7nJ9IE77mLdfLtYZI9xxW0r8Akt0uteseGQkggN45TLB0
         fgZbeP+4VUmf5OoIwmHoNoWLJz+dLd2Sz56BvOJcbWA10xPem+9aJ/cHHvWMGWHIvT9P
         SLGA==
X-Gm-Message-State: ANoB5pkZKzKBq+Kqu1XQm5QobKa+6rcT3zD6Xo1BEb3JgGtVKhyPxox/
        DvaCFt/DaKaeEzw/TeiI8rhF
X-Google-Smtp-Source: AA0mqf4xthVb9iLjHkSf+QcyPhznIdyUnH2woOTMyd/m/Su3Q10nTYhwPFoFW3QGv3znCqBN5a1TjQ==
X-Received: by 2002:a62:ee0f:0:b0:56c:8dbc:f83e with SMTP id e15-20020a62ee0f000000b0056c8dbcf83emr73052440pfi.41.1670421645105;
        Wed, 07 Dec 2022 06:00:45 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.5])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00186b69157ecsm14720160plg.202.2022.12.07.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:00:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 11/12] arm64: dts: qcom: sm6350: Fix the base addresses of LLCC banks
Date:   Wed,  7 Dec 2022 19:29:20 +0530
Message-Id: <20221207135922.314827-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
References: <20221207135922.314827-1-manivannan.sadhasivam@linaro.org>
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

On SM6350, there is only one LLCC bank available. So let's just pass that
as "llcc0_base".

Cc: <stable@vger.kernel.org> # 5.16
Fixes: ced2f0d75e13 ("arm64: dts: qcom: sm6350: Add LLCC node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 43324bf291c3..c7701f5e4af6 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1174,7 +1174,7 @@ dc_noc: interconnect@9160000 {
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm6350-llcc";
 			reg = <0 0x09200000 0 0x50000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg-names = "llcc0_base", "llcc_broadcast_base";
 		};
 
 		gem_noc: interconnect@9680000 {
-- 
2.25.1

