Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEB6778F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAWKQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjAWKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:16:55 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF027D99;
        Mon, 23 Jan 2023 02:16:37 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id kt14so29134129ejc.3;
        Mon, 23 Jan 2023 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne7laZb1v2Bqbj6brLBa/Nq0CF7MhBrYeAZ1Rknt7PU=;
        b=MDrw8EC56uJUTpWXz4zqWZ3xCO1EeCmiB5N4OToQkcepvcpPSFsJ6VS7SgGCgKyVCa
         rWJhpLfgDXmxWr4gvsDvs+8L5Yo40IvZLmk2MYDFsUG3mUK9SO7HzQ1UoSh7Wafel9TQ
         BN/44+qkIKB3WHnA6i+bvjzXI4eaHWXr2M96g6eMJEEK5Btf8guWLlncfIH9JA8BB27s
         LiUSIiaEv2mKaatvvc3iG6kdtBJMGLKaHdD7w+WITGtkbqbuqxZlfaWrx4Qru8lpSmSm
         vNji9iI29HW3haWD2iXVQGtsrZ1c84/c5QtOxgPdImoi++hi49b+INsM3EYrJhBVqA/U
         6oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ne7laZb1v2Bqbj6brLBa/Nq0CF7MhBrYeAZ1Rknt7PU=;
        b=ss2q1/OhYOU4ZCCuWAFvFw7Qmtt/NRYUuuRXpFggiJtI39eNR6EyPSPeswViPvJxQK
         t5WLh/JM3YYjaY4TS1Xgv4KFTBaRxME81qGtHolbwUerAkw/qwVOfO77EEYrhReF0+8c
         NBKdOYRCKDKGq9nBXYHlnkV9Bb9at7gJGbaaQJpBkeiZLWcU7Ge1IBT8hphdWczD68hQ
         FE6xiG7KvP0mZkcCabJXo+ws9hP2qUgbLtVz4pgIKiFmCZ8GLngqcCVZOvXGLHnQhGl2
         88EkQ2foZ+9NPmCwD60F/t0YIL5p6UNNFp3DWdSSjbntfCZWQphgzHCR2ksE8vY+8zru
         5hQw==
X-Gm-Message-State: AFqh2kpZ+5SHBbsTE0KlzZkfXuHUJ4ZPxlHQb5XyFX8PNRkEhgT+WLpZ
        hibzZm65mtDzN4eSubai3xA=
X-Google-Smtp-Source: AMrXdXtYSv+WHJfge/QRmmysi0IUo7WvlbnlIkPcWqPYKjyjtGX8xPb2vvrEX0OrkEWseWr5KepPGQ==
X-Received: by 2002:a17:906:6d14:b0:7c1:765:9cfc with SMTP id m20-20020a1709066d1400b007c107659cfcmr38761622ejr.34.1674468995615;
        Mon, 23 Jan 2023 02:16:35 -0800 (PST)
Received: from fedora.. (cpezg-94-253-128-151-cbl.xnet.hr. [94.253.128.151])
        by smtp.googlemail.com with ESMTPSA id m15-20020aa7c48f000000b0049dc0123f29sm12579125edq.61.2023.01.23.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:16:35 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_kathirav@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
Date:   Mon, 23 Jan 2023 11:16:31 +0100
Message-Id: <20230123101631.475712-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123101631.475712-1-robimarko@gmail.com>
References: <20230123101631.475712-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has efuses like other Qualcomm SoC-s that are required for
determining various HW quirks which will be required later for CPR etc,
so lets add the QFPROM node for start.

Individidual fuses will be added as they are required.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Enlarge the register space size due to info from Kathiravan T.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 8eba586065a3..ff59a2f38293 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -301,6 +301,13 @@ mdio: mdio@90000 {
 			status = "disabled";
 		};
 
+		qfprom: efuse@a4000 {
+			compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		prng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
-- 
2.39.1

