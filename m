Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53A70599E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEPVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjEPVdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:33:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFB8690
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:33:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaea3909d1so1365315ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684272819; x=1686864819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsC+YIR9GPviDXHSlkV5AONTmzt9XmYN5GUXlOjFZyw=;
        b=ZZAtXnRcvSPrSEfi+gIeXts/W17mQkTypLqlqCgL3DrfBC4wWWrre1Cm9zxo6reLik
         mwSrMoqKdOMAbB81imJh0BP4jvGzTg4b4hKoU3sGXdzoJw1Obj3pmx6lcuuqPzX+7kfq
         pnu9jsIeAXEig2PqEb2RM5mfJBwWSP40sZUP6sDI0lGT5Q1VSSuMbEOKLO8LaKWIlwAE
         SL6AX1YrZqbXOgLxtsc6b388WKqTAY97QaOvteb1bWvWxJnQTWSuLEGKiN1GKCO18fUO
         6+PhNh1sNC/1VhsgS087Uo1KrfvAlGWq/xZlQqLUma10dE98gsBemkwScMoFODZKFpK2
         iURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272819; x=1686864819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsC+YIR9GPviDXHSlkV5AONTmzt9XmYN5GUXlOjFZyw=;
        b=d4jLfjmf6FDrtZMx5+Mkq0oeSnNh4HjFQJNlFQci5q/KTkdEyN9feSTBqQH8FSnDo5
         xXxxeoc2JEsJiY797ZHfWGiWNgK8Psq4e9SesUeF0c8DyQMmxfi5YNSKgpVqlc9WOmwg
         XoL6v2JRpz6JG96oP3SPUFTriVLWwNAI1AUoF+mp1Qen57sKO0PDrz+mYfRGXv4bUz2z
         ygycYQwcfXWhZPnADOwKa2RC+CA+aWYPjHpJ5VhVrYEFS/jNl7m+U2UpeBPcLDjtCsi+
         vE1ojkbMZWXKlWWp1CXR2BEHDOuJo6nuZ0AUPW+pOHlB9MZJ10Y5WQTYw+PFrnCPQd9M
         ia/Q==
X-Gm-Message-State: AC+VfDwRCPIAcbzLgKRm+XXVMMoae0s17OITFFchIzbyDePOB4+8pRQL
        U45koyN2YkOr5GXYeHPAGSgViQ==
X-Google-Smtp-Source: ACHHUZ69C7YAPTQyIbUMSWPhfb0m0H1P8wr47rkB8sFXjt1r68NoVWqFIhwsKTO9qahORlFircF6Vg==
X-Received: by 2002:a17:902:cec9:b0:19a:a9d8:e47f with SMTP id d9-20020a170902cec900b0019aa9d8e47fmr54913536plg.36.1684272819027;
        Tue, 16 May 2023 14:33:39 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:7a51:340a:a439:1b87])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001ac7af57fd4sm16027676plb.86.2023.05.16.14.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:33:38 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v5 5/5] arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral
Date:   Wed, 17 May 2023 03:03:08 +0530
Message-Id: <20230516213308.2432018-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230516213308.2432018-1-bhupesh.sharma@linaro.org>
References: <20230516213308.2432018-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the USB-C type port on the Qualcomm QRB4210-RB2 board
can be set primarily in a 'device' configuration (with the default
DIP switch settings), it makes sense to enable the EUD debug
peripheral on the board by default by setting the USB 'dr_mode' property
as 'otg'.

Now, the EUD debug peripheral can be enabled by executing:
 $ echo 1 > /sys/bus/platform/drivers/qcom_eud/1610000.eud/enable

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 1a0776a0cfd0..0ce72f1ebc10 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -30,6 +30,10 @@ vph_pwr: vph-pwr-regulator {
 	};
 };
 
+&eud {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -253,7 +257,28 @@ &usb {
 
 &usb_dwc3 {
 	maximum-speed = "super-speed";
-	dr_mode = "peripheral";
+
+	/*
+	 * There is only one USB DWC3 controller on QRB4210 board and it is connected
+	 * via a DIP Switch:
+	 * - to either an USB - C type connector or an USB - A type connector
+	 *   (via a GL3590-S hub), and
+	 * - to either an USB - A type connector (via a GL3590-S hub) or a connector
+	 *   for further connection with a mezzanine board.
+	 *
+	 * All of the above hardware muxes would allow us to hook things up in
+	 * different ways to some potential benefit for static configurations (for e.g.
+	 * on one hand we can have two USB - A type connectors and a USB - Ethernet
+	 * connection available and on the other we can use the USB - C type in
+	 * peripheral mode).
+	 *
+	 * Note that since the USB - C type can be used only in peripehral mode,
+	 * so hardcoding the mode to 'peripheral' here makes sense.
+	 *
+	 * However since we want to use the EUD debug device, we set the mode as
+	 * 'otg' here.
+	 */
+	dr_mode = "otg";
 };
 
 &usb_hsphy {
-- 
2.38.1

