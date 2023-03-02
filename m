Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E346A81B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjCBL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCBL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:58:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3D83F5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:58:01 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v16so13451919wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677758271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zax1e/yJTS424/9Wee2++pptHP3LVztZwrLQH3xAsR8=;
        b=e+wJc+dGfezyJhC9Ii7LBQqCcRLnZ0oEZ+MsSMvT7hFUWBRF9T/+rqzsw3i3w662BZ
         HNFD297Tj04qm5RnftgJmb9Mgf4kfpHgk5C+L6eY7p7FnlwYwv5lBNQY4nvhnzaG+zst
         QglHVOsZVGtvjz2Gi/a07gkIrdHquCzwPRARbNWwmVe2g/DrI7J+t8VzbeWCHKSmws0l
         PLhzc58GXUvVm9bZn3hhkWcGUUA1JhwIbRjvsf695SLrJAry2+s276tb0fDCbKyIodDH
         E5bST+4Ru+57ZANRQPFOz5yI/lQJvoHntXSkqy8CUverSoBDwjFwDE+LXhfTAvLBO3Lv
         f2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677758271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zax1e/yJTS424/9Wee2++pptHP3LVztZwrLQH3xAsR8=;
        b=uxQ6P+kHR11QvXzbbQf3ukxQe7pg4FDwQucGqmzPelKi0Z+RLUydiXxW6AeaB8qwPt
         p7bD4jzyXtSlG81p0RXpDNWP/7zG3K9Kv2KiV3N+qkw29NN8Lk+3pK3DlWA8pXtjTue3
         j3hrUhHd2znQsKwbPyC8lNXJKcqImfL2yEMiSjVjoLb8rL1RiA4dsoI/1arH6bYl7HCb
         f+4e/rqV2x7aVyRQkZVDuGDza1baWo6LkF4LxRMD+l7zFLH18qVWJ38lyhfI1uQ+drnr
         mZIQCjpiQSBaK36XxAgmYnNVEAc9frp2vksCHjmg2CUVlJFyaC7LqCoi/Aer94uJpQK3
         4l1g==
X-Gm-Message-State: AO0yUKVAji17EZDXTcxT/XEQuxgowTGfJD0CYKfPdaVcuREpYIPksk7Z
        O2FlyZNoGdASYDdHmL2o1kPozw==
X-Google-Smtp-Source: AK7set/W170Hj8fyDnDvQU9/NhwnU506gB/47nYOKGAQ4izd7jcOeyNSUg4Ush6gjK5oD8pHTfjd+A==
X-Received: by 2002:a5d:4e44:0:b0:2c7:f84:3c41 with SMTP id r4-20020a5d4e44000000b002c70f843c41mr6971403wrt.55.1677758270699;
        Thu, 02 Mar 2023 03:57:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4a50000000b002c5526234d2sm15298209wrs.8.2023.03.02.03.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 03:57:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sc8280xp: fix rx frame shapping info
Date:   Thu,  2 Mar 2023 11:57:38 +0000
Message-Id: <20230302115741.7726-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
References: <20230302115741.7726-1-srinivas.kandagatla@linaro.org>
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

Some of the SoundWire frameshapping data seems incorrect, fix these values.

Fixes: 1749a8ae49a3 ("arm64: dts: qcom: sc8280xp: add SoundWire and LPASS")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index f9aadf8209d5..022b0c041341 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1924,12 +1924,12 @@
 			qcom,ports-sinterval-low =	/bits/ 8 <0x03 0x1f 0x1f 0x07 0x00>;
 			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0B 0x01 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
-			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
-			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0x00 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0x0f 0xff 0xff>;
 			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
-			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff>;
 			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
-			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff>;
 
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
@@ -2029,15 +2029,15 @@
 
 			qcom,din-ports = <4>;
 			qcom,dout-ports = <0>;
-			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x03 0x03 0x03>;
-			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x01>;
+			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x00 0x02 0x00>;
 			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
 			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
 			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
 			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
-			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff>;
 			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
-			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
+			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x01>;
 
 			status = "disabled";
 		};
-- 
2.21.0

