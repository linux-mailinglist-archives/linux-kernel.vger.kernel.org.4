Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD776F7D28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjEEGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjEEGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:41:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172216370
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:41:09 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24dfc3c662eso997433a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683268868; x=1685860868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz6g2/625qlFmhiR93VnIJ+EVOsf12tbuuuDirZwZ9U=;
        b=MmA7Y+uUYYhv+yAq02uAK8CEia0LlV4pux4QKHpZFC0gkmfB1CQgMBVEQQg/9XU48g
         qYArqTuHSsRi8p5ZmrZYxMze6dorq5vbED1me6hx7gKOUkOcNk4qN0ZBhQtcB0mpMEJL
         DGEFs1sPgNw82bJdShebVPVxdBcZc/SwcCEp8AKfOiHStBE7L/hXSxKrjnGPu4211oyF
         rL43hNZYqLdiGqiI+KbaA/Pp5kWjLiyPFpXU83xoWhRjd9BuESvbieLZOmEPO7ux26T5
         WEinZT8zCN7PTBiYTtPSVhySoqy3VAiXGmd336t6Gngckqh3aG28ZWrGCkPjU0UpNYH3
         CBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683268868; x=1685860868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz6g2/625qlFmhiR93VnIJ+EVOsf12tbuuuDirZwZ9U=;
        b=jetTC5Wes2Pce7AorYv5sypguUr4xIxC9FCulr9kY0gqN6f7SE2QVVuu53VGK2/nPO
         7DqEz+enq0g+jnQGpzf0siOx+rePpvI6o36PfsJZEKKfvQCc2EYwvEKzGeBc1ip+sVvC
         d14buCmMTK/Sj/jI5DefmCOC1h2zjLdxTX8HLlyhOE17t4UaElKNGgAv2294SaEQHk6V
         fMrLqFpMucp99bhsvhotcPulAO2avEh1SvAQ3Gv+JJko2MpYTkJIoap5IKymJ0ncgSY4
         LzG6tNfJ1jPy18pWQmWkyPO2RhS2EdTtA3ggQRXrCirFiINv2+1AZ/Yqbykvk0QGojql
         +9jA==
X-Gm-Message-State: AC+VfDx7lofZiEizwBoflxC66PpBO3kZtIYgZaqKXc7rBg4F2JLsKw+2
        KeaKCWLSBc7hQU/99M2QsGROyA==
X-Google-Smtp-Source: ACHHUZ7bu2wArNoHuLvlQnjk8//3Ao/e4FZ1KTLuUotie7kxB4Xc+nU1hmRfbTzX8r59/0PujftApw==
X-Received: by 2002:a17:90b:3a8d:b0:23f:9fac:6b35 with SMTP id om13-20020a17090b3a8d00b0023f9fac6b35mr419434pjb.39.1683268868592;
        Thu, 04 May 2023 23:41:08 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902848400b001ab0b2dad2fsm816251plo.211.2023.05.04.23.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 23:41:08 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: [PATCH v4 5/5] arm64: dts: qcom: qrb4210-rb2: Enable EUD debug peripheral
Date:   Fri,  5 May 2023 12:10:39 +0530
Message-Id: <20230505064039.1630025-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
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

Since the USB-C type port on the Qualcomm QRB4210-RB2 board
can be set primarily in a 'device' configuration (with the default
DIP switch settings), it makes sense to enable the EUD debug
peripheral on the board by default by setting the USB 'dr_mode' property
as 'otg'.

Now, the EUD debug peripheral can be enabled by executing:
 $ echo 1 > /sys/bus/platform/drivers/qcom_eud/1610000.eud/enable

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

