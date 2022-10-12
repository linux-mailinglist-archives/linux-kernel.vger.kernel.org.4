Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146EC5FCB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJLSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJLSxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:53:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D6F4191;
        Wed, 12 Oct 2022 11:52:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s2so25738224edd.2;
        Wed, 12 Oct 2022 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CAyWpYtXuddAlUbBCA3K/HwUtznZXkw2zsS3NHSCM0=;
        b=gN+PtV6abL3YpnrfTeixZ6+VTa0aLogIhbu5qKOp45XqfYSpQPpFGNYcPOQQEnby+U
         lZcpEirtm1wENpRLMo3K9H9x1U9FTOHrgxc5DOQzIn41L1vMcJUzoJh/D4VMklq/dKXl
         JNwsZDDBVOuKpzmLl23C/hpeUspZNb2qZ33Q/9BEWORN7m95AA+0Qjy6vM3hNltw6teh
         dt8GO4fqJOknFZUw7MDfOu0FnL3vLZbq6nN6UHUUHGGOR3NvCuBueXahYKL37XSAM0Op
         YRMNWD3CMCanS13yMu9r4nXHodH57nAjRB6QBfb8MI2zz8amu/iBOKFvpDV5qU7SF/TO
         IzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CAyWpYtXuddAlUbBCA3K/HwUtznZXkw2zsS3NHSCM0=;
        b=npVA4YuykQMIBPgiqdwiXNQJ3xsmP8P0zmzbtjYAHwgGhjrPLZ7581Y8mojnAXkBO4
         nhrGW7nzMsRByVclnn8j/UFQ1iNFyV4QSU96lmyV+J5EGihtz6uwIx1tW+QS4/AeJ2gy
         kqJUP/WbVOclkjsf1LAmiafcXY4MlhtfC9wqh2K4UacIdCY+vkOiUr0wTcULp0mAQ5KF
         gA0JCCVg57aVWi1pm5c9+4DsJgvdZ39YToO8fN/vhDflslK7LEswnRCgWy5zOfGVWILb
         5aGcZ+FrjnQehLv7Rj9/HrwgVOBlBHd1e1qbFepA98Fg2ND9EMw7Aras7F+eYJacw7D/
         oWUQ==
X-Gm-Message-State: ACrzQf3UbvenhQqx6SDL6zis3Ge+E596SgLxGWElsCO7m8kglWMGuF1F
        MEm1HGtuUkmfVRZKB2B7Up7qvIbjb0k=
X-Google-Smtp-Source: AMsMyM4GfDaIqOTYqxppKv2N2ATyb4uQG4yVGaQHiuv+BbrVof0hWw6aIWCm/A+gqlYEEZHZXeuOjg==
X-Received: by 2002:a05:6402:1e8e:b0:45c:af84:63dd with SMTP id f14-20020a0564021e8e00b0045caf8463ddmr4056837edf.190.1665600770698;
        Wed, 12 Oct 2022 11:52:50 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id k6-20020a170906970600b00781dbdb292asm1644410ejx.155.2022.10.12.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:52:50 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Wed, 12 Oct 2022 21:52:44 +0300
Message-Id: <20221012185245.1282599-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221012185245.1282599-1-dsankouski@gmail.com>
References: <20221012185245.1282599-1-dsankouski@gmail.com>
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

Add xiaomi,sagit board (Xiaomi Mi 6) binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v2:none
Changes for v3:
- remove unused 'sagit' compatible line
Changes for v4: none
Changes for v5: none
Changes for v6: Start with capital letter and finish with full-stop
Changes for v7: none
Changes for v8: none
Changes for v9: add Acked-by tag

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..294075bafb97 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -239,6 +239,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

