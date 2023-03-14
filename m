Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602036B9E71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCNSbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjCNSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F1C1A48F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso13838126wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuuEjmrbMj1oVSmMC53YE236zaBmRiKiAfz/V0m6A8g=;
        b=wNzmctlA1WtK9v028tbq9ylEjdTPyatTxL8veKW1ylMOMx7tN3jbK6zUnnQ86iYWHY
         L5pjuTrVpyXrVLaqqMD3bhEcoMo+5MFK+OthVb/taJGnIMsdFLzPruA67XHdrDgR9983
         RsQe3FPLjpMyhL8LiPuapf8+/fwgRrqd+q6cfNO+Dj2Ei5rO8zSfdqL6cbNUaLRPNWQj
         PXp+OEsl5PsO24/OA4aQv37NLbRQf8zMpLDMinKQIcqKfXitzii8BeYeX7/tX7CqzaYV
         qS9GDdmscqjbYVDR0dN4OxkJrgfY0Evz5qOZVGQoRAYCxpqmI2I5++aTxoW3AZbb45nl
         sDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuuEjmrbMj1oVSmMC53YE236zaBmRiKiAfz/V0m6A8g=;
        b=ZpP6nW/ZQhJ5/y2a4OGU3buMgRyMbv8BwehmbU0uts3SsqRmtq59y9zTOOORQfDdwf
         ZzzeO6CXss5P5qpBjswUl38CRmkbVO9Q8v8rHd2oJ2ciFZiXO69x9Nr046Wr9111nvir
         oEG61H3D6RDxz205BD8migVcaVJTbhEcHcQ5eQYCiC57K0FHiAE+ibui8UHzAbZknPZ1
         3uQq4RXkmWLqz0UBwOeTjQyt2c7s3gHrcsd0vaWBsYVLcE11D+8Fxc2UiK8zwXfb8msg
         GJukOypPVJvIv2G9xgKPeabK/inbJMrvmw46gg4f5U+LtSrvpOvv1ITD8ss7xXFbocCS
         ho1g==
X-Gm-Message-State: AO0yUKXRRhjiWBJmOx91n9RnzjfPNYu3AP3MaOohAQ90orOm2KDSgDpz
        nQ9OEr1kehBQRZzCP4qxzWkNKg==
X-Google-Smtp-Source: AK7set+DuSjV0TVBYAzpUW5T23+3Dh5B6PpeWaJX6Qu4GYSM7vLMdB6o51w99gLRrR4EhcTYd6O15A==
X-Received: by 2002:a05:600c:4ecf:b0:3eb:29fe:70ec with SMTP id g15-20020a05600c4ecf00b003eb29fe70ecmr16501959wmq.27.1678818655642;
        Tue, 14 Mar 2023 11:30:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 02/14] arm64: dts: qcom: sa8775p: add the pdc node
Date:   Tue, 14 Mar 2023 19:30:31 +0100
Message-Id: <20230314183043.619997-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the Power Domain Controller node for SA8775p.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 41 +++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index c5b73c591e0f..428d9e0849b8 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -585,6 +585,47 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 			};
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
+			reg = <0x0 0x0b220000 0x0 0x30000>,
+			      <0x0 0x17c000f0 0x0 0x64>;
+			qcom,pdc-ranges = <0 480 40>,
+					  <40 140 14>,
+					  <54 263 1>,
+					  <55 306 4>,
+					  <59 312 3>,
+					  <62 374 2>,
+					  <64 434 2>,
+					  <66 438 2>,
+					  <70 520 1>,
+					  <73 523 1>,
+					  <118 568 6>,
+					  <124 609 3>,
+					  <159 638 1>,
+					  <160 720 3>,
+					  <169 728 30>,
+					  <199 416 2>,
+					  <201 449 1>,
+					  <202 89 1>,
+					  <203 451 1>,
+					  <204 462 1>,
+					  <205 264 1>,
+					  <206 579 1>,
+					  <207 653 1>,
+					  <208 656 1>,
+					  <209 659 1>,
+					  <210 122 1>,
+					  <211 699 1>,
+					  <212 705 1>,
+					  <213 450 1>,
+					  <214 643 2>,
+					  <216 646 5>,
+					  <221 390 5>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
-- 
2.37.2

