Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4337151AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjE2WQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjE2WQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:16:00 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F5120;
        Mon, 29 May 2023 15:15:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so4246137e87.0;
        Mon, 29 May 2023 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685398540; x=1687990540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqYkfa5sDJgAMTWjlOv2KfLblT5wPAPNCKQ3KCIe074=;
        b=SbjrkF9wlug1TUgUyIl+ptIUjtXZLUSEU+mKA9hy8iP/IYdaEuk4WIVHKJa+kPlVM9
         AYqBuXrEeMS+NaF7Zw63BKXhbQhPEjn2RhsW7QmTi0kxnwP986IMW7YgAedFc4E6hSL4
         RiwyJU5iQT6C+1GGh5mDkpQogDTcG8mhXxYgsmf145q9u1B/6fuvrH7HXX5MYEUI9qMm
         Q4eGitAL0eQSk1K2ULVjEyZ/g0+lyJ66anMm7ByH6gnSeEJZ86m2pqgvw5NRdwHCPdef
         hvMbSn76zLCzjHWPCoxJpnfK7BTWLG1G9F303Er0EgV/Vwi8nH+FGCWmfbKaunu+SGv+
         crMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685398540; x=1687990540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqYkfa5sDJgAMTWjlOv2KfLblT5wPAPNCKQ3KCIe074=;
        b=ZD1TOWelI3QhOxYPSTg0WtpzSFg6Pau66PT76kfQdLlvXBXpt/VJy4lG8ILmGDmMou
         MXE68sJeQs05b6EEcYO1+F+l3pUhRNR3wz4DlaLegrTrt3rPsjQIdNVhTlxN6XrEMRQ0
         8E1zQoHQU069P2V2WjP6/sCjXRO2w2IARTm7yuqdFYkbkqhuaotovQxCR6TzBqsQrvT9
         ix0ghHONohUBWKvu10fLdSTo5vj57S7AsQL+UGWBkdEzJLiGnlmhALJWmJt7GesmHDg1
         3+5KMk4uTnsr0itwqxAfbR+gXcubcHrHeb/4yGGv08xO+R8l5oQ2hgg+P8kkeJm+j34L
         aUFA==
X-Gm-Message-State: AC+VfDxK4IiRZna94nIgG3sGmkM9btDTrry/WcHfrSaodL1RFF6mrAin
        cWvL0+glQKrMDtiMMuT+LZ2veaBZXSL0ew==
X-Google-Smtp-Source: ACHHUZ6Mfd9AZLyIGNfOj5sv2Lt7e9LVTCTXeVYrnqr6Vg4aoeoL3DR83Q6prMThRXl9YQMLj/a8SA==
X-Received: by 2002:ac2:4d10:0:b0:4f2:5393:b7c with SMTP id r16-20020ac24d10000000b004f253930b7cmr12095lfi.67.1685398539899;
        Mon, 29 May 2023 15:15:39 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id c20-20020ac24154000000b004eb12850c40sm132993lfi.14.2023.05.29.15.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 15:15:39 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: pm8941: Add thermal zone config
Date:   Tue, 30 May 2023 01:15:01 +0300
Message-Id: <20230529221501.43455-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
References: <20230529221501.43455-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zone for the PMIC thermal sensor.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-pm8941.dtsi | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index a821f0368a28..b3e246bacd78 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -3,6 +3,37 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+
+/ {
+	thermal-zones {
+		pm8941-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8941_temp>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				crit {
+					temperature = <145000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 
 	pm8941_0: pm8941@0 {
-- 
2.34.1

