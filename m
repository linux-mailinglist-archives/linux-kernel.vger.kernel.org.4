Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077FD68E503
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBHAgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 19:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBHAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 19:36:41 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332723D088
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:36:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w5so7476847plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 16:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3+bGG7y1kbAherXT7mYVUYA30E1TcsSU+mggkUydAXQ=;
        b=W0H+U6Xyltr8ry9759aXuP7XI6Cq91ihJz3Ntu5eOQAPIEOYj+efFdkyyKMaz1LHHv
         tIymg18AO+wSjCICvCicEcYJ0arWdC7ENofw9kDSwrujcPp9mCpjxzf6YOkJvKsZRGBd
         TcDcgnRB7Ri0pBQ1fUGrnOG7h+mvjjbS5O0ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+bGG7y1kbAherXT7mYVUYA30E1TcsSU+mggkUydAXQ=;
        b=IcdbgE7X+R8H1LpxRUG7w8Nd7ysPFSP366GtxpNItfeH987YVYsmNTKwM1RajxSfiz
         xODPNrKymiJRDj5AlHnN9x4xEgqDkDMq3TH9vblJ9hYL+hFNQSE0lsVuF7uDFgLA72GH
         V9KjryqMnflKLxjz5UUF9vfkpxPMtbZxxTLN6j70gG0ZtQ8CEdz4dm6quDId6zVeP2lo
         +aJ7czjwCtVjp577iLi7rkZ4XAG4wTrt6uKT2zwZrfGKv/7hBmpVmp9k7Zz9TO25kFDY
         2OULqv++rWz2585t+8gi7EGPDuFlDz7JlJiEfNRpUGtxUFzOJa2gZzh+hkemiQRNmLz1
         K+cw==
X-Gm-Message-State: AO0yUKVhO1wfWtIUGXzaf9jFsw2GFECcmzsSS89yLWsRXqtekteXw0xa
        DHIf+3an/lOaFfWNYa7BHexJmg==
X-Google-Smtp-Source: AK7set/OsauGFkzcwNzAZcFZa1CdBVmUh8z09FXo6FmacJR+rgDUlKD7NfyRNyqmnfKK5gBUY+eFdg==
X-Received: by 2002:a17:903:1386:b0:198:e63d:9a3d with SMTP id jx6-20020a170903138600b00198e63d9a3dmr470298plb.26.1675816598865;
        Tue, 07 Feb 2023 16:36:38 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8f31:e721:5c9:1d71])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b0019907bfd26fsm5676738plb.178.2023.02.07.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 16:36:38 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: Power herobrine's 3.3 eDP/TS rail more properly
Date:   Tue,  7 Feb 2023 16:36:10 -0800
Message-Id: <20230207163550.1.I5ff72b7746d5fca8f10ea61351bde4150ed1a7f8@changeid>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the equivalent of commit f5b4811e8758 ("arm64: dts: qcom:
sc7180: Add trogdor eDP/touchscreen regulator off-on-time") and commit
23ff866987de ("arm64: dts: qcom: sc7180: Start the trogdor
eDP/touchscreen regulator on"), but for herobrine instead of trogdor.

The motivations for herobrine are the same as for trogdor.

NOTES:
* Currently for herobrine all boards are eDP, not MIPI. If/when we
  have herobrine derivatives that are MIPI they we can evaluate
  whether the same off-on-delay makes sense for them. For trogdor we
  didn't add the delay to MIPI panels because the problem was found
  late and nobody had complained about it. For herobrine defaulting to
  assuming the same 500ms makes sense and if we find we need to
  optimize later we can.
* Currently there are no oddball herobrine boards like homestar where
  the panel really likes to be power cycled. If we have an oddball
  board it will need to split the eDP and touchscreen rail anyway
  (like homestar did) and we'll have to delete the "regulator-boot-on"
  from that board.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This patch should be applied atop my recent series adjusting the
herobrine touchscreen rails [1]. If I need to send a v2 of that series
I will add this at the end of it as patch #8.

[1] https://lore.kernel.org/all/20230207024816.525938-1-dianders@chromium.org/

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index ded36b5d28c7..312cc0e1cbc7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -110,6 +110,22 @@ pp3300_left_in_mlb: pp3300-left-in-mlb-regulator {
 
 		regulator-enable-ramp-delay = <3000>;
 
+		/*
+		 * eDP panel specs nearly always have a spec that says you
+		 * shouldn't turn them off an on again without waiting 500ms.
+		 * Add this as a board constraint since this rail is shared
+		 * between the panel and touchscreen.
+		 */
+		off-on-delay-us = <500000>;
+
+		/*
+		 * Stat the regulator on. This has the advantage of starting
+		 * the slow process of powering the panel on as soon as we
+		 * probe the regulator. It also avoids tripping the
+		 * off-on-delay immediately on every bootup.
+		 */
+		regulator-boot-on;
+
 		vin-supply = <&pp3300_z1>;
 	};
 
-- 
2.39.1.519.gcb327c4b5f-goog

