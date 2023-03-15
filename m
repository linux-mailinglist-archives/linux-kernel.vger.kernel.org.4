Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7626BB8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjCOQCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjCOQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:02:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44007769C6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:02:11 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n16so5878181pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/Lsu5smiLBa9MSeSGWc1WGcnC/b/RQv3FtSyR7SFF4=;
        b=FgJU1ov+oT6SE1jCig02atP/jcu4Ky1MMsOM1FlYtRFqjFVv1R2X91E1B44pRjXW72
         XhwL0NdpyrC/pI+RXSlf95HXcW8FZRLXMJvbW095TirxYMv9dn82SCbbwVxemSNiD/UJ
         wEUkY7Es/JycBM9us9jPaOGcr5gxd/LjDtcHOJoWcaYOrtbtZ8yGFv4wVNovau9zv+lL
         aig8HVp6iirjZRsa68QqeoY5AlsnNaTFt4V/SUJGYxBSBqdC2y0gERpwZbTs3cf6xrB+
         33qpxOA2kyoPaGaXl9pYnlk4SNmgJSZgRvFMuemLaa2Jj+8+UeSprGD6JFiAbjqwXAmj
         PSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/Lsu5smiLBa9MSeSGWc1WGcnC/b/RQv3FtSyR7SFF4=;
        b=p7Fm3us3ZJV9fRt+Dv+PdzTYHF5t1N+DZ3/SGhA3Rovoyi81MmyP1oqtf1exUobTu8
         mADgvGzwD55Pov0uHRcUhF9btMH/Tbg7McAP1G1Yt9/umJhqP5eV1DI/S527NYQj4DMH
         LhKJO7qwPpuq+ytsCBbOhonH3b/KorCDgk1Mo2GyUHQ5HpyuZuVAWH8Qk4GU9b3WFnsi
         1Mh2OxSC3aGr+TFWTAntwsZj14hkqDNinx6Wr+Q+DiKbdX8AYFza03AnvU/wLLQJk6/m
         xpYINgO0lI/d95p36fTQU/n9NIE6vHIEE5F/99nzfxmWsDGIFlIBu4mYzH4Nwt0JZYgq
         NoGg==
X-Gm-Message-State: AO0yUKVtzHwqakP3gW9hBdN4P+6kaCEoJezvasTTCCkhujlUohxirqAw
        AA6hq7D1UDbqhUNKYBwiqGjTkw==
X-Google-Smtp-Source: AK7set8Z4HGNMWRt5GVuA9st6blRtNG8gAmAR6OHCAZyk1xzCzctYdB2+DaMPJ97/T59reoxXbfTbg==
X-Received: by 2002:a62:64c9:0:b0:5aa:4db8:9ab1 with SMTP id y192-20020a6264c9000000b005aa4db89ab1mr4981pfb.23.1678896125274;
        Wed, 15 Mar 2023 09:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id o1-20020a655bc1000000b00502dc899394sm3457170pgr.66.2023.03.15.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:04 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for QRB4210
Date:   Wed, 15 Mar 2023 21:31:50 +0530
Message-Id: <20230315160151.2166861-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230315160151.2166861-1-bhupesh.sharma@linaro.org>
References: <20230315160151.2166861-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ID for QRB4210 variant.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index c3c078a8c0dab..6bfd35e00c5fa 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -229,6 +229,7 @@
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_QRB4210			523
 #define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
-- 
2.38.1

