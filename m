Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07193710175
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbjEXXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEXXFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:05:21 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E9A9;
        Wed, 24 May 2023 16:05:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-623a6c15aacso2977216d6.0;
        Wed, 24 May 2023 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684969519; x=1687561519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrFzx7G4H9QRCmQYSXPg0uma6wQ2uEflaOZc0x6PNfw=;
        b=dEEtuRpLsq6AiyU1eNLmXqJH3Xzh+W5LQnEJwuTgTTciXV39QhsSuVKuqFqFtzWYkw
         CSHx4pMRHYd7XGicfO3YGBf2Sxf/aaaB5IaOpCHwJWVHxkmIwdjO31v6a7nr8Hj09bvS
         aJ+4Mun+vMiHAf5mM/AZSCUZpuXTTWU02yYaKm+fA8jQGgAZd2AU+b2QqK30Ya2IDCc9
         zQH3jTRTwealbaDLOEWDboM1j7jd3JYjJ8AXFLjONw0Q96v2AQ0XzM2hCWoWM7zyggNd
         rTx51tvbmXn86Y65t7pbSMul1v3Sl2HxzYUxutQ7xeRNOjVqDMM1YWcy2IMPGiTfubj2
         VLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969519; x=1687561519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrFzx7G4H9QRCmQYSXPg0uma6wQ2uEflaOZc0x6PNfw=;
        b=GtqeEonaUmsMP8ERlOfsx19D5Fjnk7Lc7henZkJLjk6bRic1QmbZZ6GzH7BVPOblNM
         FtcGsb1YNkQNsTS4p9FAsLB1QmWSmIpBxdZPE5aCZr0s0/62zNfK6tZeRGZdjEiP0jHz
         1hDXY19mxqDtaBqr+O/jd0TkZGbZI/XrJAzq3BqPUqLA8Zb3PssJzr9HfrSs5J5zfLEw
         z2TRykgqCqMdpP3jAuThbpTWPZVifl6oDAuRSz8i4+l8Vj/CDcV/YPY0F/hzXXiDDzN5
         qJ3PEipumnQVqLLoizZYHXP69ceTcnmO2ZvQtVshioiH3/morkAPt/o4kawHC5RE6GT/
         KJMQ==
X-Gm-Message-State: AC+VfDyEHzWRjn3veg9hdFbG6QeYAnowVwlusUMZTq4tJ4EWKNA1YQMK
        Dqo38gpmcw6MY2istmCSjLE=
X-Google-Smtp-Source: ACHHUZ58zHEAHPo/4ezQC9Q0V6L7v82UcEclg5MNDLSIFpxNJ6yiaIVMZ5xYMV4A84FmD1U1EOlB1Q==
X-Received: by 2002:ad4:5ecc:0:b0:623:7707:5650 with SMTP id jm12-20020ad45ecc000000b0062377075650mr28892564qvb.15.1684969519151;
        Wed, 24 May 2023 16:05:19 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:650f:ad8b:38f6:d091])
        by smtp.gmail.com with ESMTPSA id ea15-20020ad458af000000b0062075f40f61sm3914019qvb.73.2023.05.24.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:05:18 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     david@ixit.cz, Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: Add samsung,expressatt to qcom.yaml
Date:   Wed, 24 May 2023 19:04:55 -0400
Message-Id: <20230524230459.120681-2-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524230459.120681-1-guptarud@gmail.com>
References: <20230524230459.120681-1-guptarud@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 3ffa682cd079..18ed09f359ee 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -192,6 +192,7 @@ properties:
       - items:
           - enum:
               - qcom,msm8960-cdp
+              - samsung,expressatt
           - const: qcom,msm8960
 
       - items:
-- 
2.34.1

