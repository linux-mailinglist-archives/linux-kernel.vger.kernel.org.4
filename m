Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9A687EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjBBNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjBBNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:38:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C78B32D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:38:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so71531wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KwClGhcR7TdVaebtx7GjNjFtUcNjguDWac1KgeKIdY=;
        b=sirCRHdUNdmk19NjuwIv+KzZf/T/MflaVX5bG7x8jouHLbSLJM/uG+QxsjCo4xZ3hY
         1mC/m9W5hCJDtPt2LxHwuuRe4YF2GY/af9llJZU8/EbD60AXQChgZKZ+6eVQIp5Qi2lt
         iZmmIQmiA3/EDKFUZjMOBtnHzs4LfJnj5EoFQBgYD7Y9GZU7CPQfPPgvvD0PCrvqZICN
         Y8fQ0nWn8ZdU9HPlheAEQYvNetcKY5YssqYayjS2VTsm3fP1ADHNDYF8BL2orq7hLym1
         6ddVOX5BIrKwaw9No1kxBC50VOl9YG5HivL/LsIeOuJ/BfEtxGO/pYyff+c0ctfJOuuw
         34qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KwClGhcR7TdVaebtx7GjNjFtUcNjguDWac1KgeKIdY=;
        b=yc/9ZIxnOtgTm2DfqJn0jn3NFmf4pez0Sz5QmtngtqW0zH8tvGtQKmigxze1om1RJH
         TOGd6HA+Chd4lEAVki71Z7rpzQvz2n58xkO3mqfrIVrhgYaSoWuWqDy2/p1cJq5afkRZ
         qqtH0pv0DZG5dCX3o6816mYHZcUkcp7EUKaBPJZaw5giNk99k37S7KG/ZUd2S3GEKaXW
         CSNiNeNyFogfORrP5XNglBnGoiA4pVUMH71+PR505l5Lk5SYuN0AF1TzqUV+l5rvVmAj
         IB+Mv4pm/oUkMIX3+ddAbGkgzw/G7o3oMbEKakkAAiz5Mtsd6gIHNB5p2XmySDyegBoj
         POJQ==
X-Gm-Message-State: AO0yUKVZtlJ0awrjsIJX7Tumr+pFbPag09eI2sxVeGYTe/lLjH4oGzKj
        vAxWiy0jPgdoNbCD19dhp915wA==
X-Google-Smtp-Source: AK7set+PfKRoh/N122x8wKuwZjQQWzOVhywZf4QE6geVIDyMtQDdYSvmqsewNAcIn2OovgUXp9arlA==
X-Received: by 2002:a05:600c:3b26:b0:3de:3ee3:4f6f with SMTP id m38-20020a05600c3b2600b003de3ee34f6fmr6056336wms.8.1675345115442;
        Thu, 02 Feb 2023 05:38:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b003daf7721bb3sm4672657wmq.12.2023.02.02.05.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:38:35 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [RFC v3 7/7] arm64: dts: qcom: sm8550-mtp: Add eUSB2 repeater node
Date:   Thu,  2 Feb 2023 15:38:16 +0200
Message-Id: <20230202133816.4026990-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202133816.4026990-1-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the PMIC eUSB2 repeater node and add the usb-repeater
property to the eUSB2 PHY to allow it to be controlled by the
PHY driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 03862132fe41..9aaddafa0088 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -456,6 +456,11 @@ sdc2_card_det_n: sdc2-card-det-state {
 	};
 };
 
+&pm8550b_eusb2_repeater {
+	vdd18-supply = <&vreg_l15b_1p8>;
+	vdd3-supply = <&vreg_l5b_3p1>;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -562,6 +567,9 @@ &usb_1_hsphy {
 	vdd-supply = <&vreg_l1e_0p88>;
 	vdda12-supply = <&vreg_l3e_1p2>;
 
+	phys = <&pm8550b_eusb2_repeater>;
+	phy-names = "eusb2-repeater";
+
 	status = "okay";
 };
 
-- 
2.34.1

