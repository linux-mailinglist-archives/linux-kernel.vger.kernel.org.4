Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D738626B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 21:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiKLUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 15:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKLUdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 15:33:35 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E7BDEA;
        Sat, 12 Nov 2022 12:33:33 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v27so12115551eda.1;
        Sat, 12 Nov 2022 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cMJy9nOm2P66MZeYUb2V/jN22yFUu6wzb35clE65sY=;
        b=C2j7VHQqDlP/kfWdnS2tsWHux0YH97OOuU3UW88sgyoB7jLXqLySZowgOaPEncMAa0
         Cn3HllYv1iWwL4aLqb+KAarzAXalKZt98sfpeTX67ggcR+TJnQW/Y/UpupQNu03SRvPn
         jfgSIbVyHXkM1hxthT9NkIVvvpwQyqetiI3A4yueSQO428mMRubpNSLUx5+wH72yDFyN
         W4039tUq33kFgIuwzgMShcbFkYhpiFnqCjBZPn64PddGp5FBH/WRI7b0N0Wde9jr0GRz
         bhuI+1fUoAy2EV3Z1QCe53oJCMtRVojMa4A2NUcEgY9VX0DNNlnuWuSkP7a3hVNjPYks
         eaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cMJy9nOm2P66MZeYUb2V/jN22yFUu6wzb35clE65sY=;
        b=zHOgu8/aHTu3owxcKZuN3OXPWGMh01OCWizqONLl4chjnn/ZKPHtm5v3Ijsr/WqDTA
         N3O+Gt94OGFXekI5jZ2/2Jh7ry+PXwjXxImj2VR78ISTto98TRCirk/Un5ZM0/pQX2Xz
         9fDF4eEwq9QJF6BcjkiRa6l8Q1JjpWWPQGT+PnHphjufNvDVGOUWWjR6P96iaYyQjOTa
         6ehpgdNPhibouUBS8ZPTxATTokraBS4LqHgMWa9xoWXeq/7X7utLPARQLHdq4SORaQpP
         +QexWGcFdqgZuRTgBnSTskSnzLhkTRbR9AKOCe8a2Yy1jgU+4POzVymUPqLOTYpS3AW+
         slwQ==
X-Gm-Message-State: ANoB5pmhCWlIJt0ugjGeZH7vlgwC0mQkCRwT2xLsgV9FSFxfj+VT5Xuz
        Sscp1IVYdnEua5MacJA95cS7Mk+OLOM=
X-Google-Smtp-Source: AA0mqf6gNZvgGq2Fgv5GKthsnIxLpfc70CYaAIlx28KPym3YoXOjClGZ1OUtKSCTX5X8vYkgXqqCpQ==
X-Received: by 2002:a50:9f8b:0:b0:458:fa8f:f82c with SMTP id c11-20020a509f8b000000b00458fa8ff82cmr6217018edf.246.1668285211651;
        Sat, 12 Nov 2022 12:33:31 -0800 (PST)
Received: from localhost.localdomain ([46.216.4.225])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c441000000b004638ba0ea96sm2648962edr.97.2022.11.12.12.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 12:33:31 -0800 (PST)
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
Subject: [PATCH v12 1/2] dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
Date:   Sat, 12 Nov 2022 23:32:59 +0300
Message-Id: <20221112203300.536010-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221112203300.536010-1-dsankouski@gmail.com>
References: <20221112203300.536010-1-dsankouski@gmail.com>
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
Changes for v12: rebase on next/master

 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 97e1d0f07218..de0392551e9f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -258,6 +258,7 @@ properties:
               - sony,xperia-lilac
               - sony,xperia-maple
               - sony,xperia-poplar
+              - xiaomi,sagit
           - const: qcom,msm8998
 
       - items:
-- 
2.30.2

