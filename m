Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5C6A5D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjB1Qta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjB1Qt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:49:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBB241E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so951898plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mOXZ9qyQvv5sAkxxgH4iBEQJ9SxMhQVCvClo14WEls=;
        b=XT9Ge0azEd179tHlw2pSwavkiX0F9mGy47gdOEuNULHly3fiCsNMl7Tqn5xPYhNVse
         IYHBsvuwFB/rtt6CnWX2Eu0YOeAWacGkFLQ3vvnJ6doGAo5imhBNdsUk6BNsf9RWIF+E
         LQZouNgcGpKt6mqX/7qhCFuxeTD4QtmXAa7+Y0wZZDsqjB+YJ3N16zYdElts87jbfWhN
         1JBvu+J4BLTrJoqSbJst/Mju5xvXoAP/z03RgIpyPHqCaxqtuwhDBMYjfaJ4l5u9bHDh
         9JVl7SS/ZPrXpJsBW2dHWhfY2iIN9R/FnPAmMILB4oksgJD2yyNsZhJv7HGHAfmetspH
         Gbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+mOXZ9qyQvv5sAkxxgH4iBEQJ9SxMhQVCvClo14WEls=;
        b=g+oEMTZKdhmV2+eMq6CkX2zcudPQjsTOzrXw7/yNMk7jqYKsfckLAsGt3rgkHnBarM
         ftyZzMq4B7lLRGVtih6xTlbVHCcFAE5WbIVete5WQJ4oZMLT+IRzjnGzIJGtDhqSYbmx
         W8thoYIWHV7eLBJt0E3xETK25izu2lnrBSmxdD8Et2k27ZG1pVvAL/oqN14WDa/8UrD9
         Av5JrB5SCZ8OrvugWax6FwxvivT8VSz7CaJWX4ooKdpbzsoMJOoFY/rvcBuBzRZ6dZXt
         1QRjrooe9dCGnReaxDfYrTEwuZf8ARYKGWCyx/VLPfDup/Relz6OtxlckC6tVgvQeHH8
         UXWQ==
X-Gm-Message-State: AO0yUKUWq7+uKkHQIWl03kDjD/w4EHYUdMK7DfZ2lRl2yLJFvkCI7O9d
        v+Qm136aoiFpPavLbU+KJg/V
X-Google-Smtp-Source: AK7set9ZrqcVy8UGFbcDLQHMhw6Gg+BYvupVH/rHxZQU7eRrkxNSBkRhHUubgwjF62tE3xBTaXnbyg==
X-Received: by 2002:a17:902:e801:b0:19a:b4a9:9df7 with SMTP id u1-20020a170902e80100b0019ab4a99df7mr3750511plg.53.1677602922957;
        Tue, 28 Feb 2023 08:48:42 -0800 (PST)
Received: from localhost.localdomain ([103.197.115.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00476dc914262sm5908792pgp.1.2023.02.28.08.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 08:48:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/16] arm64: dts: qcom: sc8280xp: Fix the PCI I/O port range
Date:   Tue, 28 Feb 2023 22:17:46 +0530
Message-Id: <20230228164752.55682-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 1MiB of the I/O region, the I/O ports of the legacy PCI devices are
located in the range of 0x0 to 0x100000. Hence, fix the bogus PCI addresses
(0x30200000, 0x32200000, 0x34200000, 0x38200000, 0x3c200000) specified in
the ranges property for I/O region.

Fixes: 813e83157001 ("arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-msm/7c5dfa87-41df-4ba7-b0e4-72c8386402a8@app.fastmail.com/
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..a0065656442c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1657,7 +1657,7 @@ pcie4: pcie@1c00000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x30200000 0x0 0x30200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x30200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x30300000 0x0 0x30300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1756,7 +1756,7 @@ pcie3b: pcie@1c08000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x32200000 0x0 0x32200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x32200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x32300000 0x0 0x32300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1853,7 +1853,7 @@ pcie3a: pcie@1c10000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x34200000 0x0 0x34200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x34200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x34300000 0x0 0x34300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -1953,7 +1953,7 @@ pcie2b: pcie@1c18000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x38200000 0x0 0x38200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x38200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x38300000 0x0 0x38300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
@@ -2050,7 +2050,7 @@ pcie2a: pcie@1c20000 {
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
 				 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
 			bus-range = <0x00 0xff>;
 
-- 
2.25.1

