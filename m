Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323AA68D3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjBGKH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjBGKHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:07:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B58FF14
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:07:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so5819297wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKMj2GrW/0IWEFwUHj5fN41AhztAWQXTY5GE6ULWiQU=;
        b=Iv6iwSaQJlKVZaW1lqcy3c3fW0hALbOBXhgV0OyG4Cmi7x2DljC/Mag3RDB6KnHRDS
         3yY0L0mSz+DUcg7gSlIVOra4in4Msu2t5t7IvN2GgytpfhH/YO1BYrWoPb0oVr3yVjL3
         aFSpGh39WX8kChKAFusd7rwoB+KvPQGvz31NzUOaTggPmiyNE5WENebMvig/z4b0mZP6
         +6zaN7XbMOM6hUdIFyvjRcRTAHb9CfffkUzur265W7qiS/t+oL84FV6CctTslXMTIA1g
         GbBILSBeJHQou9okphvsJOxG6vQqryokZQ4Z8VCUBarocOJYFIKgCeNfxaHqOdwtg8lq
         tqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKMj2GrW/0IWEFwUHj5fN41AhztAWQXTY5GE6ULWiQU=;
        b=Ar0krDRnGO8AJ3c/ZG5p4mxqAVZlvH83kl+fRhpXK/Wdy9j58SbKAZs3ZNpw62ZZAN
         QQQSRVL4Ayo+NujCMELub9MloIGDvfIRFpnjCIaQ2dFloikw1K1E4Xzu77rI1KGpXKTS
         uWg4zk+WoXCjo6KfCiqxJb/5L3WHSRel9s4KGsLmT3gC2qmzDHxLPA3gnUvimDEeinKW
         26iSkmW8/u9FJoz016jL2NcWLjdEJzZfoj+3loHKwEiOSE2DTcAsM10PJWcmZ0TRZ5ku
         Glig54v0RZVQUN3Q6ViroFxhRxOu728Jt9Oabtlo2XgNnaZQEVi3YWWQWM1lok9jLxPb
         RPJQ==
X-Gm-Message-State: AO0yUKVWd1blW3cynIhrFRo7iriD32NjwSXY+FL/DGABUBFJqvJXMlF4
        lMi6GWn2ouDRD+GK77RGleCOPA==
X-Google-Smtp-Source: AK7set8zoJ2ik1Ev/uf5LBOOsWWOsE1Imh2sAGajgE8ZwBxzm13v/VVPmxWuPeF4ait5SodPpSV7dg==
X-Received: by 2002:a5d:6101:0:b0:2c1:2a1c:a8d2 with SMTP id v1-20020a5d6101000000b002c12a1ca8d2mr2089831wrt.27.1675764454953;
        Tue, 07 Feb 2023 02:07:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:274f:8489:6db8:7d33])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm5283173wrc.13.2023.02.07.02.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:07:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: arm: add the SoC ID for qcom SA8775P
Date:   Tue,  7 Feb 2023 11:07:29 +0100
Message-Id: <20230207100730.218725-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230207100730.218725-1-brgl@bgdev.pl>
References: <20230207100730.218725-1-brgl@bgdev.pl>
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

Add the SoC ID entry for SA8775P.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 22d7ba17804b..bfdf066cc690 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -223,6 +223,7 @@
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_QDU1010			587
-- 
2.37.2

