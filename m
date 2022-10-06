Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB65F6216
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJFHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiJFHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:52:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D351E3C3;
        Thu,  6 Oct 2022 00:52:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so2740431ejc.4;
        Thu, 06 Oct 2022 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58v87dq5o9bWCP1ukFW7Svs23Z0siAjRTO2QEyyxGrI=;
        b=p2FW3j5JaqDpbUBxhyb0iUsWWp19vmSWyNaylPlxmqWal1QEVSVSiEEC1SVhyVN3Rb
         ez9Ybo7zZyYwMNB8kUDiFXcLqcV0JwaE19f1zHQzoseBWab0a3grg1mbK1Aw7dcG22hw
         4qClcn2vU/8fOz9od9XlDzsYnqmiAYJO7K2T/OCbQelXq5VPv+QMkDWWV+mFPoPsqD7k
         7D5D/m8bjnfyEOl7bp8K6NA9DC5cE8o5YTfH6l8XboO7W/JAgHcnaMv0KVStzjI75+nP
         +bcUtNs3Va72jhxopNPey+KIp/9zvTC8fnTGydq2gAMCbKFxVUIgvhk2pNQofgiktkvu
         xPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58v87dq5o9bWCP1ukFW7Svs23Z0siAjRTO2QEyyxGrI=;
        b=ZL/KvabtGdFpt/0jqbTcBF/S+GRDVu/cPDmbeesUuASNqKhexppRrE3etHap/pqrUh
         Hs2FaSoh/lUq5bEK3rmObGaP4M6559Hq0oSFrVOkkgHJzwklpFX2CxtYg+/8Ih3NAbX+
         c+X/+wdrumGwUdRZCKGvZqfL6QHk3XAZGkfVjARRqE5bAjhnE/tlHI1od90EXelckEmu
         rWjfJVDyo3z/IKs2/phsK0V+rSDYz6n2V/rKH5/wtRC7DDklm8E2v4Fn+89ULy7n4Xjf
         /DPl7/Y2V3TLphUlnjGKDbR8R45iWXfYcblJb8jNf5hBWAlUBJGdYAdLZ9fICL7vPLrb
         5xDA==
X-Gm-Message-State: ACrzQf3wnsMoKXzEpE8OOt+g/HGcHkM9toacqSDQZs/AlW9dpgOtsQ2S
        XDQuVhpgpv0Jepa7h+QU5JnfK746kpM=
X-Google-Smtp-Source: AMsMyM7fdD2np3M2pii1pPr/YWFlE6rJKHG0nI9G62QPdVxFSxE8teLVY8530E8JRnVerhCnD0z+Cg==
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id bf4-20020a170907098400b0077f4d959e2fmr2993759ejc.176.1665042742699;
        Thu, 06 Oct 2022 00:52:22 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id g25-20020a056402321900b004542e65337asm5338329eda.51.2022.10.06.00.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:52:22 -0700 (PDT)
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
        DEVICE TREE BINDINGS)
Subject: [PATCH v7 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Thu,  6 Oct 2022 10:51:24 +0300
Message-Id: <20221006075125.1056605-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006075125.1056605-1-dsankouski@gmail.com>
References: <20221006075125.1056605-1-dsankouski@gmail.com>
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
---
Changes for v2:none
Changes for v3:
- remove unused 'sagit' compatible line
Changes for v4: none
Changes for v5: none
Changes for v6: Start with capital letter and finish with full-stop
Changes for v7: none

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

