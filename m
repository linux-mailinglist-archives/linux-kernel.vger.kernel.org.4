Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918E707401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEQVT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjEQVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:19:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41DFD2E8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64354231003so376561b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684358316; x=1686950316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsC+YIR9GPviDXHSlkV5AONTmzt9XmYN5GUXlOjFZyw=;
        b=mLEnL4+900Y3v1EqzSKYSJxW7S1yg/ELTQklPqGBcRBmawcubhgNP+sNXAvPz5XNQZ
         bzYl/HCY0Gj0DjZz+yT+WpWJqnVxfV3I19QTXwM0TPs36dZnrb/kF1uLJuBQMC7ho3yw
         D1VKf+c0humm1eT7OVArCXHOWmozEY2C4uwlCqgpNpe/JaziXFyfnlJchrdZ5pCFgSdQ
         PSvtFyKcpeq4GUJctxBrsUFZYnWtuNtlXDM/uWayPRI1dDFGYaZywPPGal1mPWBz471K
         ojUvE7j/m7OK1Hd3955o538yns9ywuFX4wL36FXlP6CP49dHP2T+PA4pRMEkg4HDfm2N
         Q7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358316; x=1686950316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsC+YIR9GPviDXHSlkV5AONTmzt9XmYN5GUXlOjFZyw=;
        b=TzUQMF1UNBhtyWkBzzL0jezu0GoyjLxd5aNQsPmTc5KK9QaBX+7HWHCmoasr1BXanb
         iT9HHWcskdzu8NfoMPb8zu5XlNd7v4Uhhdfph6D8DATCpwlRLAjfLYVe0yVpaTXzuN+a
         aCFihyiKvmwfd7bf6FXUrj9opkIYAtci+oR0dReNZqaCIUjlAUj0DAqmZVtKaHB+zejQ
         2TCYTzKkMJkC/XBpzKPR5khtFNclJjZNiunKfLUGX6T3aQab5eXrJynB9dB0/hLsmndq
         R9Gxtfj0TqSAjv408uzJzAJHfL3EQMzuT9VuYkbekb0VXUdgZf/A8Gx+u8OTVmQ+T8q8
         MTuA==
X-Gm-Message-State: AC+VfDyEsJgh04QPoy+haX3loy/OOaFZihREFLEuUKQ8j/8XVitYtL3Q
        1m59xXRBK+eWaeMoQ9GOS9EOyg==
X-Google-Smtp-Source: ACHHUZ7ZROYmKec5DJ3xETJ6t99Gy8RZhTD5iWOnz0B+vLWZcQYsGJlm6hN9VNbIaLXHbMbdKvjBVQ==
X-Received: by 2002:aa7:8882:0:b0:63b:54e4:871b with SMTP id z2-20020aa78882000000b0063b54e4871bmr778781pfe.8.1684358316360;
        Wed, 17 May 2023 14:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6bed:7a51:340a:a439:1b87])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79052000000b0064cb6206463sm4359210pfo.85.2023.05.17.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:18:36 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org
Subject: [PATCH v6 6/6] arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral
Date:   Thu, 18 May 2023 02:47:56 +0530
Message-Id: <20230517211756.2483552-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
References: <20230517211756.2483552-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

