Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E684F6C8D70
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCYL3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCYL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:29:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F9813D44;
        Sat, 25 Mar 2023 04:29:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k37so5448520lfv.0;
        Sat, 25 Mar 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/omv0XmiZuQK7Oc5l5JxiCh3msEP6oIygvtCwqgkM8=;
        b=p7xcQ6uCAoD3CBoBMAhx1yaM5fVT2XSS+akgG50HuFR+gyN5heLw0dwC8uN29OnE+m
         eOO/NYERfWw9Fu3dSjX2ZH+beaAIxW/9dGah9wqmmoXO/pYQWfPjZNhmE6uxRZh9H7cm
         fqQwQ1S+LP/EKS+wJBSzAZTDXOZ9JubwC5/+iY5AvaaaOyVVhIKOT9nFUWCpEiwSrF4k
         iXRS/dTOHxwK8gMiCeov/QjX/4aZgPxPjJKDeOrFZneEPJzotLOn6t5Fdi/KktS87SJg
         jekdQuQuxPHSxbd4VJxfCb1utA2E9N4iBL0obJv7El8o6/1T6VN90K6k6u1CokSP7V/a
         HfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679743741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/omv0XmiZuQK7Oc5l5JxiCh3msEP6oIygvtCwqgkM8=;
        b=JlP5MKF1+xP5EfusBGCpJtO6MAJYNTfoqlRQkxcRzMhL/m2NH3x1KQKIeAP0aDEUTS
         04GQHUv5BLYn9kIfiUlczXLEwqs2PCAhTFA1Ay+kVWBVuVkmtsjcy/RQoheINZA+Iqkx
         WctgwVPjrFg+/3LKJf/+ApbbPwnOs/WK86dIsFMMS/GYXLAO3SroaRp4mp2A3OE5insb
         0IbpPZ9CmtD3vbe8TlkF6lXedoZOmxx/lu7TwO/yQbBEieJG8NGry/uMcp/C742las3J
         VztzXQgQTC16+JwzdupoCLa9EUyf1GoFsXTYIIdi/eBh8Ncng2jA4pNqqcLeuuBTmO3a
         hthA==
X-Gm-Message-State: AAQBX9e+q1KD0GOkeLj8oOmqjYxnOPhQQD3SobfEa5j6TFsrf6tnvFkY
        RfAqVl4qCYi3Ocv4xe0K9TxiV6Q9H5RrIQ==
X-Google-Smtp-Source: AKy350ZjOER9Q7QbZRS4yqQNlLQKE+EPnMFgvDdoZNzaYj2ltWfRV2oBNHrBMZa3NH4HrVpiHHsPbA==
X-Received: by 2002:a05:6512:951:b0:4ca:98ec:7d9a with SMTP id u17-20020a056512095100b004ca98ec7d9amr1624745lft.15.1679743741616;
        Sat, 25 Mar 2023 04:29:01 -0700 (PDT)
Received: from localhost.localdomain (cdb25.neoplus.adsl.tpnet.pl. [83.30.151.25])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004eaf55936eesm1502510lfp.233.2023.03.25.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 04:29:01 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: msm8953: Provide dsi_phy clocks to gcc
Date:   Sat, 25 Mar 2023 12:28:50 +0100
Message-Id: <20230325112852.18841-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325112852.18841-1-a39.skl@gmail.com>
References: <20230325112852.18841-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide clocks from dsi_phy to gcc, this will make
sure we don't fallback to global name lookup.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 438a70eb6152..5dd10c35ee0d 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -640,10 +640,10 @@ gcc: clock-controller@1800000 {
 			#power-domain-cells = <1>;
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&sleep_clk>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>;
+				 <&dsi0_phy 1>,
+				 <&dsi0_phy 0>,
+				 <&dsi1_phy 1>,
+				 <&dsi1_phy 0>;
 			clock-names = "xo",
 				      "sleep",
 				      "dsi0pll",
-- 
2.25.1

