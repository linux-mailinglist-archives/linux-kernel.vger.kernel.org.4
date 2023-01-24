Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF7679BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjAXOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbjAXOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:33:25 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59114861D;
        Tue, 24 Jan 2023 06:33:14 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o17-20020a05600c511100b003db021ef437so11069455wms.4;
        Tue, 24 Jan 2023 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEB48zMdwI4TeY+TZCjnVptJ50oNeRE3VPwVL3A71D8=;
        b=VeHlIXkJBBQqDjrpSPzIQUT4rQMmMOf4EDjvBgHEVxs6P3PpRCPkTyhqPL2Rp8kiEj
         PRMzDCHBe8azs7tBBfsZLBIIVoYR3k5o6nnW/CJeUoMl+YpErSwnTNku9JScIBBOT0xi
         3+Uq5Ikzruf+cvJktbVEzmSbC8D4kPSzsR/CCMpGuPR1q5Qe++2OYRTu15Gh1MKH+6rw
         2DiSlf2jN09OgRAGEHoLvdPO3+TbaOHGm3FZChJtwiOfAXwJzycORpcg6bZ8YZC0uAWQ
         /0OJE0cnO7BCAxf/P6Ki/Jqhk8Bw2otne+Ee+27kx/j+vjko8jWf+4qjp/jm8Rcd6vHY
         khbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEB48zMdwI4TeY+TZCjnVptJ50oNeRE3VPwVL3A71D8=;
        b=TIMJleTuJnqTadGklcHg5pF1vO+JfeTEHII9W6CgH6jqcH8D02DdroCRnH8OAs8/N/
         1Pu9SleAfD2uueXL4rbYdgwbsD2+4cTepLKyKe5KLoN8RefcAyVitMX/vzi/Jz9PQrap
         4ezSv/RZUcfjWOCm8jGeYAJPE/TX1IB/P4L7YaAl0V0if5p/fqwPqZMVH4hW4Rd62ZI2
         TrZ0rmCx+Imk5YE6E3HJrSVVEkYEBJr2bdKeecNvxGbOfYHrHiNd+j7hwo0ui6UIDqBI
         4fh6+xGoZAsI94JYejZt/GbxRUKDeQdDWIfmAvh+oGeiNjsCOc2bg8VyQyvs7FmVaQQq
         bHDw==
X-Gm-Message-State: AFqh2kqcf7e1KxvI1pklX+ICKpvBmvbPpLioGi8zocqhQt7xwf7iqDer
        aOzuug9KbKAtGqOstOSCda0=
X-Google-Smtp-Source: AMrXdXt1wvCntI5QMRIHB/So328KNfnhxM7JH857EjfQIxQogZgtff9z1T9TVx4n/fBngiWZg9r8qQ==
X-Received: by 2002:a05:600c:34d1:b0:3db:1434:c51a with SMTP id d17-20020a05600c34d100b003db1434c51amr22296989wmq.40.1674570793039;
        Tue, 24 Jan 2023 06:33:13 -0800 (PST)
Received: from localhost.localdomain (93-34-89-61.ip49.fastwebnet.it. [93.34.89.61])
        by smtp.googlemail.com with ESMTPSA id j14-20020a05600c130e00b003db0bb81b6asm2083039wmf.1.2023.01.24.06.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:33:12 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom,ids: Add Soc IDs for IPQ8064 and variants
Date:   Tue, 24 Jan 2023 15:32:35 +0100
Message-Id: <20230124143236.1038-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Add Soc IDs for Qualcomm IPQ8064 and variants.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f7aef3f310d7..dc86461ab664 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -45,6 +45,10 @@
 #define QCOM_ID_MSM8126			198
 #define QCOM_ID_APQ8026			199
 #define QCOM_ID_MSM8926			200
+#define QCOM_ID_IPQ8062			201
+#define QCOM_ID_IPQ8064			202
+#define QCOM_ID_IPQ8066			203
+#define QCOM_ID_IPQ8068			204
 #define QCOM_ID_MSM8326			205
 #define QCOM_ID_MSM8916			206
 #define QCOM_ID_MSM8994			207
@@ -80,6 +84,8 @@
 #define QCOM_ID_APQ8094			253
 #define QCOM_ID_MSM8956			266
 #define QCOM_ID_MSM8976			278
+#define QCOM_ID_IPQ8065			280
+#define QCOM_ID_IPQ8069			281
 #define QCOM_ID_MDM9607			290
 #define QCOM_ID_APQ8096			291
 #define QCOM_ID_MSM8998			292
-- 
2.38.1

