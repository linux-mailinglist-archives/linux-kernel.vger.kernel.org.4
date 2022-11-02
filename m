Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0961669F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKBP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiKBP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:56:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B52A70A;
        Wed,  2 Nov 2022 08:56:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z14so25170148wrn.7;
        Wed, 02 Nov 2022 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzUq6Pj3tMoJKlKiPW90OGjmQ67b5jkxfowDlw11UYA=;
        b=DJbykN3XSfBCV0PZj8ULWDoMxgnE4XYpZCTKPxbN4fPdGCHeiXrpThdwBkNMSey0f4
         4tn4UCKuK7ft0RG53eoEZAN3QHVFErf4tOpowBhm4aUSFNBmcoesRZi9ktooEnz1fp1K
         oSAP5hR7pGpymiOeLvnNelvOFRbgJSnoKT8kCD9VFS189b2tF11nkwnYXfDardPAYtJX
         6qn1CoMpXsrhSDL2O74dyMtDy1+SspIe256ZWMi0hSbBb2ZJnotaTquG2guIYgcyVaVs
         Er8dtB8XNKyrAn5mYMwG5w17YZJ65Y8hong8Jz/GjRkCU3I9newXsjjHx7kDRY3MzjNn
         nEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzUq6Pj3tMoJKlKiPW90OGjmQ67b5jkxfowDlw11UYA=;
        b=gClFqPw72axP2ivB+3GVbSkOqcSjLc3BLWs0Yis2AW+ftQJph1al7nbd7hYWI53HXB
         rRJq/lb6F4tS6Vf506bUihg2t5TqiqW+iqCSwJFjdI75c2Z18dkE8HWQtCf+qqFKjZWC
         VE4RVJkUnsVG8Cby3+h8v8xbtKrVlmN5Dk2oGWDZREx97xkviY5sktetnDUojXikSSsu
         zVxL40lTnHZvhA46KYCGzUm7DnwOs1455/Xv/CHIQMx1jGW3bVCbGyN0MAvWYbV3dujb
         9XW2mIJl65EXQiKxmHjJKdGdd0YRdHQfTbEda7xjylC3sp7/w3/VF23KTjqzt9Xzj4ic
         RP8A==
X-Gm-Message-State: ACrzQf3N+mzxiuELC+/aNF3fYrsQTtI63T5NsPtjBGVzM/25/poon5BZ
        dG6rTj/3v7AYbvMUkHvWJQBLuAddA7s=
X-Google-Smtp-Source: AMsMyM4otDML20Jfti/UsfD+zPtaO/D9iEfgkj2zWNNYY2Rs0+WzJVYTc7GWvkxDiCFSKAWMJPG6Ow==
X-Received: by 2002:a5d:50c2:0:b0:236:6709:6de5 with SMTP id f2-20020a5d50c2000000b0023667096de5mr15036020wrt.127.1667404564927;
        Wed, 02 Nov 2022 08:56:04 -0700 (PDT)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id r10-20020a05600c35ca00b003cf6e1df4a8sm2915162wmq.15.2022.11.02.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:56:04 -0700 (PDT)
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
Subject: [PATCH v11 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Wed,  2 Nov 2022 18:55:57 +0300
Message-Id: <20221102155558.1895829-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102155558.1895829-1-dsankouski@gmail.com>
References: <20221102155558.1895829-1-dsankouski@gmail.com>
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
Changes for v10: none
Changes for v11: rebase on v6.1-rc3

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..1e619cdc63ef 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -242,6 +242,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

