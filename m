Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386805EDA30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiI1Kfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbiI1KfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:35:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222857E37;
        Wed, 28 Sep 2022 03:35:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l18so7095441wrw.9;
        Wed, 28 Sep 2022 03:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VlqP1AskYRCJgZpOmLOH5h+eJII6uEEhzV2FKY09TpM=;
        b=DTfC8cRO4h96p8sysXVON6J9Afg0AIh7FepJtt+VLn4vdEP1O6KP2vN9ZzEG17cu3i
         bj5Vu0fkRv19kq2YNz50L4mwn0I8WhwVabrKIpYg5+S6P70K9j7lWwNT2WQnYPQNv/zZ
         vlL1tJUgcXyB1xMRzhKd2RRUi1YyF6SexSQ30zHjvEZk2fp5NixY32R/WOiWR3Mglvlb
         mYY/EJ75t+SRurv4nfAZIN9VefM/otvWGZtlifW2OFKzTcB62JnKxi/2fyWjk2rsVwxG
         +zb7tYa0yWJjmf2+hwRkkkAZC3vKIUaECmIm4UJBsiO6qg9+gIf9kSjtDo/pKKcZq3HQ
         mwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VlqP1AskYRCJgZpOmLOH5h+eJII6uEEhzV2FKY09TpM=;
        b=C2R+3rsq4iDXfOfSnuK9fKFnMHWv1Ok7vbrmapUuVO16rjHDXUJd7bfQyJq34xmSiq
         2JwXkeBcs/r482vcdnn6E9YOkca/tHeQIdpChm6RYyQAaSjHmQTldShztG9eTjg+heLu
         OJK2Mf1lsx43dnuCkLbNlPyI6wbPFf7DOsdgr1K+tQKxn7t6xyfOZntBq7tRVpSljWcs
         b+/nnkpoQaoMkI80s80AYrSRzO6Kh2Yc3Hy2KFcwzSRT9ZcnlySVZ3Gb5mM98P3iwRaE
         esIjwL1TT7IU/88i75isMJ7FN2Q75J1TnBKlz2ND3dcwvDJqBz4Smigpg1Qzzqbhe08E
         2Cnw==
X-Gm-Message-State: ACrzQf0MZjNCy+r52ndVgU/LNmI52env4/87Pa4K8qJYeM/vFkttKS2Q
        d9VQIjUPkVytyR4gMWydhUNzhcpBJVM=
X-Google-Smtp-Source: AMsMyM6Nn/owome5XUVTwmK5isJVi3P88vrnAy0fg1vRH4tRkcAY1sQMEJSJh4zlZ3mh94lLR/2xkQ==
X-Received: by 2002:a05:6000:231:b0:22c:c8e3:67e5 with SMTP id l17-20020a056000023100b0022cc8e367e5mr1514788wrz.570.1664361312395;
        Wed, 28 Sep 2022 03:35:12 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id x4-20020adfdcc4000000b0022b11a27e39sm3974476wrm.1.2022.09.28.03.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:35:12 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Wed, 28 Sep 2022 13:33:19 +0300
Message-Id: <20220928103319.621698-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928103319.621698-1-dsankouski@gmail.com>
References: <20220928103319.621698-1-dsankouski@gmail.com>
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

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
To: linux-kernel@vger.kernel.org
CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
CC: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
CC: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)

---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..00e51d22aeb1 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -76,6 +76,7 @@ description: |
         mtp
         qrd
         sbc
+        sagit
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
@@ -239,6 +240,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

