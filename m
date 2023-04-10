Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C56DC901
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDJQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDJQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:02:27 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9500959E9;
        Mon, 10 Apr 2023 09:02:19 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7606d7ca422so2227239f.1;
        Mon, 10 Apr 2023 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681142538; x=1683734538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OimWLmHWLNmjUtWvHz0GKrLoEkNOAR/VpuvZ24QH1vk=;
        b=Z67vskReD6+pMfBslUhc+RH+EootiAkqi9MxvLJFKmNMJFGr3TNfo6qQs2vtQ/ENzm
         dVZ9MhetJTicu5Tr6AEnSCygtCKRVBHWe4Q6T+nzLcHRELlrWmJJxuhhcx0aUft/EhLF
         EIiWIDYbLOM0+jlZYFihdiUNcLWIpIHwYyzMXaCfrqeihWolofv9YPLZ9LeWQKYmvvyi
         aDb1ZFHn2kshzxK3o1RNbEFRMHXmgf5Ju9Ugq+knuePUZoZ0xKDMOmjxDQZTa+SSvkAz
         CDqZnDio0EXEuVYhqAKie023NDJnMT+SsLUSo+MDO3Y6IX/7VMwxlwFmi0sBPcXXqMQM
         cSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681142538; x=1683734538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OimWLmHWLNmjUtWvHz0GKrLoEkNOAR/VpuvZ24QH1vk=;
        b=V3VvzMrRo7XhOys/sASrIohpkem90dv3mVwbJ34p4JQdwSGM42BkURnLigc3hQ1LpF
         ZatmtSPzBTn5kBzh4saXMHXKJmPk/IgPwjAL/oL/zPOkByf4WulSnoXtYmxVyrAiu5ZS
         l64u5EdNtceYvK2tJgh98OOILr/UHf+8ciHQq57Jo9J48Epw7FXFutmyrcNMrc40ZFAM
         85p2+spGFoi9XrJ6DXQ/3xIVauEhyvq0T9jGPbom01cZFmzRQse6GUP9FOXgL4CexBJ6
         79yDNbf4JLJzWPrxjYiqlGIDUQiHcNcUhCW/0jZUFKY1xXhqjFj7jlNicMpvdEaK8HE6
         J7Vw==
X-Gm-Message-State: AAQBX9frToxysSY4+o4P2Fu1f0YDSWXCGnnPmcKMVTxLIcm58Qrk3tQd
        u5UQg+BzVka7FImCsoD8emY=
X-Google-Smtp-Source: AKy350Z59s0GrsR0yuSD6xvISmlAK+CYc8yGMYknebPn6Ckygm3n7TfHVhI2mENciDQhDY2sfavmEA==
X-Received: by 2002:a05:6e02:1b86:b0:326:3cfc:f702 with SMTP id h6-20020a056e021b8600b003263cfcf702mr3927375ili.2.1681142531732;
        Mon, 10 Apr 2023 09:02:11 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c7-20020a5d9a87000000b00746041ecbf9sm3184435iom.39.2023.04.10.09.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:02:11 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v2 5/5] arm64: dts: qcom: sdm845-shift-axolotl: update focaltech touchscreen properties
Date:   Mon, 10 Apr 2023 11:02:00 -0500
Message-Id: <20230410160200.57261-6-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
References: <20230410160200.57261-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The touchscreen nodes were added before the driver patches were merged.
Update the focaltech touchscreen properties to match with the upstreamed
focaltech driver. Also, the touchscreen used is in axolotl is fts5452
and not fts8719.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index b54e304abf71..96dd4628d9a7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -474,23 +474,22 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,fts5452";
 		reg = <0x38>;
-		wakeup-source;
+
 		interrupt-parent = <&tlmm>;
-		interrupts = <125 0x2>;
-		vdd-supply = <&vreg_l28a_3p0>;
-		vcc-i2c-supply = <&vreg_l14a_1p88>;
+		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
+
+		avdd-supply = <&vreg_l28a_3p0>;
+		vddio-supply = <&vreg_l14a_1p88>;
 
 		pinctrl-names = "default", "suspend";
 		pinctrl-0 = <&ts_int_active &ts_reset_active>;
 		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
 
-		reset-gpio = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-		irq-gpio = <&tlmm 125 GPIO_TRANSITORY>;
 		touchscreen-size-x = <1080>;
 		touchscreen-size-y = <2160>;
-		focaltech,max-touch-number = <5>;
 	};
 };
 
-- 
2.40.0

