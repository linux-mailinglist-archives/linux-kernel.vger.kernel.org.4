Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5676E4C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDQO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjDQO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:56:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85165AD0B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:55:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f177cb2c6cso112835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681743343; x=1684335343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVLpu463weUnMVF2zbdwbH3MNpH2/6HWhiak2FggVPg=;
        b=D7o3l3xcWWlfo+EXUnDR08gc9zaDZak181rwXLSSGGskUajUsAkBRcBC76KHtJIX8g
         NfcOJzAZlMKZ0GUfmsJP6dtOtpP02blCi8coTZr5ZdEBmJ4KDyfzIrys7zygH2rgWCu9
         N7M0j3rY/XNH8cgh16sAb0AVsjJSZPdViJ1AIR/YM8foAEQV40hqTbr8MbotN+Hm/yN4
         4TeSuCUnwTMg55dxWMt+UyCDWfXdbjqB+r+w9iVju830bGcDHc5MGVQ9ybFw/m9Z0XFd
         LsyVc90FWbKgS/byLEGEohsfH2VzMolRPDMADoq4Ej64KsbLT3W/HAgDj5xzACtZZzPe
         y1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743343; x=1684335343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVLpu463weUnMVF2zbdwbH3MNpH2/6HWhiak2FggVPg=;
        b=hfuEVFXQ2oqmKBWal1m4ilhpTcerWdzHflRaKuLLiCslXMtdnIy43netyZZf+qnJ1q
         /oLK5LT86wSpktlnO8hWLI6wOQm5ThXJGX7ATzEwoSQuMlndo2rBwKpPuOh9MZCK9hdI
         Eo2emS6q7A7s61RfM4QocGjC0NFi7THcIpovYBbw6FBo1pVzlHBAdvatGBu2OFgeuYzt
         QKXWsga0auNsc/LLGUVdwqkjrHMOm+mXpl/QeCqFakR0h6fCVwSu+TIeLUKuvoubbfvM
         glMkGz3EITHhaQQrVCqBvf3ITv9a3mH9UbXMoLRgLTqqpjqjC8OTj9UAKaEbsgLq1xza
         rOrg==
X-Gm-Message-State: AAQBX9eV8EVEqzMTYa1+Vhtt9CrMvIHvT0/2Uj8ZRudWO633ixlDF6VP
        luvYsRBd4/djkMwYTXxmmQsu5g==
X-Google-Smtp-Source: AKy350ZTjkqzUgTQGHGrJ9JuARTqLhAJbKksuC56qgRgq3evGrn857zKaOJqn9OLamzUI4n7teZ4bA==
X-Received: by 2002:adf:e8c1:0:b0:2ef:1c8c:1113 with SMTP id k1-20020adfe8c1000000b002ef1c8c1113mr5931168wrn.9.1681743343288;
        Mon, 17 Apr 2023 07:55:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d564f000000b002f7780eee10sm7998301wrw.59.2023.04.17.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 07:55:42 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node
Date:   Mon, 17 Apr 2023 16:55:36 +0200
Message-Id: <20230417145536.414490-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230417145536.414490-1-brgl@bgdev.pl>
References: <20230417145536.414490-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parikshit Pareek <quic_ppareek@quicinc.com>

Introduce sdam_0 node, which is to be used via nvmem for power on
reasons during reboot. Add supported PoN reaons supported via sdam_0
node.

Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 5abdc239d3a6..3c3b6287cd27 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -88,6 +88,14 @@ trip1 {
 			};
 		};
 	};
+
+	reboot-mode {
+		compatible = "nvmem-reboot-mode";
+		nvmem-cells = <&reboot_reason>;
+		nvmem-cell-names = "reboot-mode";
+		mode-recovery = <0x01>;
+		mode-bootloader = <0x02>;
+	};
 };
 
 &spmi_bus {
@@ -133,6 +141,19 @@ pmm8654au_0_gpios: gpio@8800 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmm8654au_0_sdam_0: nvram@7100 {
+			compatible = "qcom,spmi-sdam";
+			reg = <0x7100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x7100 0x100>;
+
+			reboot_reason: reboot-reason@48 {
+				reg = <0x48 0x1>;
+				bits = <1 7>;
+			};
+		};
 	};
 
 	pmm8654au_1: pmic@2 {
-- 
2.37.2

