Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37A8618C79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiKCXFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKCXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:35 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B221839;
        Thu,  3 Nov 2022 16:05:21 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e19so1845278ili.4;
        Thu, 03 Nov 2022 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=YrXJHawRRWzh3qewhN8EUHT06aI+9pk3h+1WC6QxUM1suq32PYtmBjW/ef3xcjKfs2
         a+jFj+ZVEmA9SJRbMZ7Ds7li0PgiyF4OYgnQaSbJI0dMXHIrTpoNw1wpNwqyouGLa/je
         urLI//h7Ej7EO69uqDE/VeztoHwnWUnuZqgyquOxDxVUc/SQx7r8/Zg9iRdcutyUcarb
         4w8of9E5vrVakyS4avFhecun+1TaevpMoLHUrdjRmJtenH6R0rSzg9XskS8MHwD9JOA6
         W8xWl0//PiUACqmamsitLQ6hbUGO4vTzwJNO6rNe/l/tjlGoMUzFLLBiCfIorTJOLH/+
         OA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQdXfHXD2jNc0ULYmRYiq2ER1KgTrvIMpk00EXTgBbk=;
        b=Pghv7ODF7pF/jlJ4NCUuHU9l7Xy9MVpp0OwSuKLa3j8c0R/IkloZQLZwsRigJyXbo7
         1VMcwUUbnauNB4pbCp3EjkEXI931OG9PqG9Ht9p2GHdnztnipxsrz1eMnJu1wbirh8sA
         FPh9cqeZyi2A5rPHO/Wum5ElKcMCHgS0ZSiHEyQU1a8eC1Ta7IPn/vysX5GeF5qaMY0c
         MhzXe9ehiw/KSTGPjkrfoKwpgnPVhjTfG9BxeRctfRoYAu/Q39lzcrTP2mnhSICl/0Mp
         KkzT62/IYqQBaBA002mLR4nGtvmGOHbB63ODVOfRSypOzYzcCfisrsCV6UOwAC4luLyp
         UYOA==
X-Gm-Message-State: ACrzQf1v8jYoI25+Pknf4JYbPFRVW7MXx4qV3fpY7eB78R1GFcXB3qy9
        Jpzi5h0X40WyKwNYWAIvRL8=
X-Google-Smtp-Source: AMsMyM5NvaF/ZP6kxZ3TxQh8HtkfdZuxUBHDzPSs5hC1zkr2vCqNiFg4QdPrltMaMG45kc5zbqcjRg==
X-Received: by 2002:a92:c541:0:b0:2fa:771:f5f0 with SMTP id a1-20020a92c541000000b002fa0771f5f0mr19830186ilj.195.1667516721231;
        Thu, 03 Nov 2022 16:05:21 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id b11-20020a056638388b00b003751b68b84esm631291jav.32.2022.11.03.16.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:20 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
Date:   Thu,  3 Nov 2022 19:03:49 -0400
Message-Id: <20221103230349.212861-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103230349.212861-1-mailingradian@gmail.com>
References: <20221103230349.212861-1-mailingradian@gmail.com>
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

The Snapdragon 670 and Pixel 3a initial device trees are about to be
added. Add the compatible strings for the board.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..f9eddc22d4a4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -51,6 +51,7 @@ description: |
         sdm632
         sdm636
         sdm660
+        sdm670
         sdm845
         sdx55
         sdx65
@@ -654,6 +655,11 @@ properties:
               - xiaomi,lavender
           - const: qcom,sdm660
 
+      - items:
+          - enum:
+              - google,sargo
+          - const: qcom,sdm670
+
       - items:
           - enum:
               - qcom,sdx55-mtp
-- 
2.38.1

