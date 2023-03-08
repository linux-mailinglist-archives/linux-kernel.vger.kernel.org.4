Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9A86B04C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjCHKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjCHKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:40:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E489CBE2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:40:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so841269wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuXf3qcdLoRKFYAi7wFYWNuVj8BPbd9z/6kD6caVGIg=;
        b=5C2/LiaFtyBREM0JKDYWoNNVB0qyOVdu3+HWqwuEmRi9luVy+Tb8FlJGMh529yIb6a
         B1u20kfEWf34yjdQu0vAh8P94GiqO7uoClkfIRpGnrrqMhDTMs+1dalCCTWF3/fpiNuq
         OsOCSnPGMTfqSwEJxljS4tNsrKXr7B9sCvKFTF8L4Gv3o03aakCCcCktX59/HzeIIoBv
         sMUjU2POXr4ikDUM+fNl/4IvcrKbQJMy1fadFOU5NbgXJhSy8K7qZeQszP+EiopswKUt
         IUmNtZmxDrHBHkEMxmx5iRiKXMEIzaYwu57EDLYUnxlQ6b502yJ7Rf6xXIL575QpRNXq
         pzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuXf3qcdLoRKFYAi7wFYWNuVj8BPbd9z/6kD6caVGIg=;
        b=5ubCbloAXM/lEk9h+fw+7AEDF+qt6LacGdlyT2uRGrgAvBMlzK5Ld6FMKT3hvYNLyl
         qCb7FbLGJ/nxJUcPd14eNxMXF4CmcOzEoGxcuiigBd7vszktduQdEO9MYca6OVUVRkEL
         8APpIExY4OjiasuTQPl0reJIlgPxfr+ZwhG9BcoCCvagdJZHUvMwZ+5pOp47mGwxwojV
         2Y+9RXT5w1Qxvg7jxu8QeUBoffwlbhNV1ZyYQ4DrtjBTrVNtTA4oHVdvNe1TtDJFfkAB
         YPoe17LOf/6G6LCf2Rf6eg6nTSXmIkUOvsdMLgfqYnhViEWp7usOcjM73OXMs150ARij
         0vNA==
X-Gm-Message-State: AO0yUKVu8ytJzXdP7uxuM+wy+T2hDhGIjc1RZuqXjiWsTgvFUEp+v8Ql
        LCO5+mgyQL6hCAXqJ1ynFuoDgg==
X-Google-Smtp-Source: AK7set88f9VDY6OD221xEGqrJMUuKOEV9ESLdXbIpXkTqVnktny20FFDQ9dOQeDTodNGIYCG6iJazw==
X-Received: by 2002:a05:600c:3512:b0:3ea:e554:7815 with SMTP id h18-20020a05600c351200b003eae5547815mr16735930wmq.9.1678272015962;
        Wed, 08 Mar 2023 02:40:15 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2326:fd4c:82e3:7e07])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003eb0d6f48f3sm20664135wmn.27.2023.03.08.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 02:40:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 2/9] arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
Date:   Wed,  8 Mar 2023 11:40:02 +0100
Message-Id: <20230308104009.260451-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230308104009.260451-1-brgl@bgdev.pl>
References: <20230308104009.260451-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the second instance of the QUPv3 engine on the sa8775p-ride board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 3adf7349f4e5..a538bb79c04a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -24,6 +24,10 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
-- 
2.37.2

