Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8B96F7E44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEEH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEEH5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 03:57:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6018111558
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 00:57:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6439d505274so369621b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683273466; x=1685865466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASPdjssv+eJExTJTXyWCjTmaIC0fu4B7/nrk3o0mOEg=;
        b=JO3IyNFcmDL44htRKeFX9ji2ce7HYjosvtXJLzpdTuZX/HhgldZpNvJB9A+WwWFeBo
         BOwe4n9fLnLZdvhLj2LInmcQc21xq6CybXg8HNQLci/+i2oLiOkBFe7vNJGvzKfEGQdU
         7z2UkWMxfzjpt9MejWRihxEn4/MrxsFPfPCSRTLOUaghWJPGSz0o5QWrzG7rFvr4tggf
         PfTlbhFaRkwb+lvZhMSMx3kbl8+5QJ1bRShl7zZSbuYkIfsfCiBG8dPK2Znz+sD099P0
         LjJGjA335PHEWIbGdWV1xLA6fB7dAcwKvTCSyKPNeScO9dkrmrItM+FUys7fs1YcsTiH
         8gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683273466; x=1685865466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASPdjssv+eJExTJTXyWCjTmaIC0fu4B7/nrk3o0mOEg=;
        b=HYi49Q4cYvh8WB1XnjhYElxXTWnb2zNSCPEQVnvNyGFLQxeXyvoxx3hBrQEorzttDo
         p4QCxQmB0P8/WmBrFQatPHcetmYTQ+o6/fyIpW6xkbpOfx3X8eQun4Bs6aJH09byleaQ
         pPmdIXwgr3wPuhLsbdUydfTTqji2vTfIAxf+x0LeAQc4e7d9BEDKiqBegaJDMcah5fzG
         equdb9/GoCDt42EIfi/RB13e/PdRqjeEMbBEldNIHQosFV/mApbWmpMWyROOe5ASaNRR
         ki+poPi8jUHyqYVc5XZeWVyO2LkvlTxi6uGsKI1lbfCejPe0ngI46L7Q1f9HEMERC384
         5aUQ==
X-Gm-Message-State: AC+VfDzAGbCHbqeGbRY1bP11a36xKhv4hwSBO035vaqvqjq6RE6vpi83
        DTBZyMqBFO580kC/5E5l2fsPzQ==
X-Google-Smtp-Source: ACHHUZ7kOB/JqKHCpHc6VTD5WpkBCzZ6f7xeWwCnqK0kZ7AXFH771D8TByr/oA5bNRnWUhUR4cm7XQ==
X-Received: by 2002:a05:6a00:815:b0:640:defd:a6de with SMTP id m21-20020a056a00081500b00640defda6demr1449038pfk.5.1683273465830;
        Fri, 05 May 2023 00:57:45 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id p17-20020aa78611000000b006242f4a8945sm988873pfn.182.2023.05.05.00.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 00:57:45 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
Date:   Fri,  5 May 2023 13:23:52 +0530
Message-Id: <20230505075354.1634547-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230505075354.1634547-1-bhupesh.sharma@linaro.org>
References: <20230505075354.1634547-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the default and sleep pinctrl states for SDHC1 & 2 controllers
on QRB4210 RB2 board.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index dc80f0bca767..504543ad1a1b 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -190,6 +190,10 @@ vreg_l24a_2p96: l24 {
 };
 
 &sdhc_1 {
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+
 	vmmc-supply = <&vreg_l24a_2p96>;
 	vqmmc-supply = <&vreg_l11a_1p8>;
 	no-sdio;
@@ -200,6 +204,11 @@ &sdhc_1 {
 
 &sdhc_2 {
 	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
+
+	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
 	vmmc-supply = <&vreg_l22a_2p96>;
 	vqmmc-supply = <&vreg_l5a_2p96>;
 	no-sdio;
@@ -216,6 +225,13 @@ &tlmm {
 			       <49 1>, <52 1>, <54 1>,
 			       <56 3>, <61 2>, <64 1>,
 			       <68 1>, <72 8>, <96 1>;
+
+	sdc2_card_det_n: sd-card-det-n-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &uart4 {
-- 
2.38.1

