Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EB46B7C42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCMPm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCMPmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:42:53 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB854CAF;
        Mon, 13 Mar 2023 08:42:37 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x10so7121353ill.12;
        Mon, 13 Mar 2023 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678722156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Ze74Wqiwoy+UoDUCp8J1XaBj1vJnEUZTusFoq9moE=;
        b=BimnIqxTwSiDYb1RhYLwSmSaSO5/Cc0aYXpkigxTECJcqtYbadTcQNBLUC5Vk3KxDj
         ubj6NJV8XUm3v+S/96QKe7lkW2iEXGqrTvekYVoYtmlNpNeFGt7g0QZIWKiqiuS04FtR
         H0/Zi46AWxyrTfF/3Qx7rlETuJ3TExDrDN+AjZQK7TLHPoKO6ZiEL639mvFv2tekKkge
         hULT41WYfd+97TZzt8ehR2Is9WIZUDHx5cmXfOXlKfnKMNcv18QDAs9XUVbDWuns7fJ1
         2KPpUL+twkkRO+iX64zlew7iqbGFdb4nU8XAbL/F4CU/ERzpCXkpht5qvvqIgonPIMC1
         dJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678722156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2Ze74Wqiwoy+UoDUCp8J1XaBj1vJnEUZTusFoq9moE=;
        b=bGQ/pZGRggj4vpif3qIPL37FmpUxunRtNYden0aOkxKgFmR9oVOIvpdezO+2824GeV
         oflSCGfHlRe/ygJKB1S+GKhX4BgGBEZ8tMBMBjVlg+H3H5QsjnFNhHUPxl112zAAwZcX
         +paMsVn6eJRxssqsdnKtapURpaLyaUAFdklmy069wGiMdZH7yvgo+80/3vMu/m7s3txH
         JQasQGt8umY7c9E3eGWpXKBg3Ih2gj45Qy3AVBV4m0alZ0ch/KmY8qaQFCxc8MEYfMwB
         YyQaIe8mo5TzS2GHftJEOArZayldT10R2zvGKqITRMhBI6WYS6/i0/uD+N0Xcc41CRBL
         8zTg==
X-Gm-Message-State: AO0yUKXaCCpzTCx4jcq6kbLj19/K36PURQ5jy37v371RJ0tpcbjHOSch
        Ca5PnATPhTC4WiSs057oTtU=
X-Google-Smtp-Source: AK7set+Vl/0K+UpvklfYvhGTqN6mqCPg2BW/QUGATLZ4AuHk+ZkE2wefb/vvJVJS0kSmEDgVPMwuoA==
X-Received: by 2002:a92:d186:0:b0:323:504:cff6 with SMTP id z6-20020a92d186000000b003230504cff6mr2294080ilz.3.1678722156328;
        Mon, 13 Mar 2023 08:42:36 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id o9-20020a02b809000000b003c4e02148e5sm2509588jam.53.2023.03.13.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 08:42:35 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v2] arm64: dts: qcom: sdm845-xiaomi-beryllium: add notification LED
Date:   Mon, 13 Mar 2023 10:42:26 -0500
Message-Id: <20230313154226.136726-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The Poco F1 has a single color white notification LED. Enable the
Qualcomm Light Pulse Generator (LPG) driver based notification LED.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
Changes in v2: (No functional changes)
- Fixed the inconsistency in the commit title prefix
- Minor update to commit message.

 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index e0fda4d754fe..9d11502e5e0e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -2,6 +2,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -322,6 +323,16 @@ vol_up_pin_a: vol-up-active-state {
 	};
 };
 
+&pmi8998_lpg {
+	status = "okay";
+
+	led@5 {
+		reg = <5>;
+		color = <LED_COLOR_ID_WHITE>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &pmi8998_wled {
 	status = "okay";
 	qcom,current-boost-limit = <970>;
-- 
2.39.2

