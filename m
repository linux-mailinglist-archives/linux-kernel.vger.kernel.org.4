Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8A56F9B58
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEGUNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjEGUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499F711574;
        Sun,  7 May 2023 13:12:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac82912a59so39509111fa.3;
        Sun, 07 May 2023 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490364; x=1686082364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7CHae7+5m8beN7f9XP5eWdtzHxIDO1y+j4SXyxtt94=;
        b=G9jzurHa8nNyZP2gEZHRkO3F5n8K1pbneMPhhhBgPM0RzaaxtKaJuevqGi+oz9fdqZ
         8t5lpO+fG4+wGKNwv2ZDYbgcs5Dnfqm3EhDctmWtXUPEjSgX/h3X3nAOshz8YDnaJUKS
         VqPzBvAGycNrvLvyQboGuxCEErmcrmmE7zT7W6fCS4VF7vBnjsozlTA/xIMbQnYK0BR3
         JGHPhuxv/FZJz5moI4s8fYxVUGsfVEY1RxZD1suXVodyb9toNfweuvYv162tUV0ds7b7
         vr7uAK8b69ZS4OKVhZXywEYHP9XbIHbYCVMvYLjS3ca/GDKMMs4Sr49PkW3af86vTIR0
         t0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490364; x=1686082364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7CHae7+5m8beN7f9XP5eWdtzHxIDO1y+j4SXyxtt94=;
        b=DZyM3uYfZM7xaekB7ovoxLmx8tduFkoj/gY/4WZabY49TFlFndHhXuQZZ7aSoRAGAk
         Rp/2GoZlhNE/aBACUnxQIJciHnWHjR5j3WTj2nQR+IZrLSlApRQ3Sm1m68fmSTShqbU2
         WXJTj0G30BZKG0NcAREThxElwXhfhk7bt5vX6m5bsfm+EeWcvx6hhPOCvUXcmnc/Rojz
         +zgJAx+gcs59Qj8jI6mDes25qQ4kyKlM5XvpNwFfbnsGR/d7Wpb37ejNgkNt/ZmsxLAl
         qGNH17goJgCzjEh2dxg3Vy55eyjnKI+tBAH3KBEnPg4lxCX49yR1YtVkiwXj3lP15gTA
         d48w==
X-Gm-Message-State: AC+VfDz/nOQvcsTGqt7rMiXgbgQ97VCkYZPzniZEl90myNFCxY0VWhvD
        heg51MdFXC5LCgQxmmcd6m02efNBmvBXXg==
X-Google-Smtp-Source: ACHHUZ49SJUulchUIZqSSFMF1cC/vP6zZTyDx/WNK7A5YU0Nw9wVWfd2jeHsu0x4qdXxHac9cEc5WQ==
X-Received: by 2002:a2e:91c4:0:b0:2a8:cedd:f371 with SMTP id u4-20020a2e91c4000000b002a8ceddf371mr2550138ljg.15.1683490364515;
        Sun, 07 May 2023 13:12:44 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:44 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: nvmem: qfprom: Add compatible for MSM8226
Date:   Sun,  7 May 2023 23:12:19 +0300
Message-Id: <20230507201225.89694-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Document QFPROM compatible for MSM8226.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2173fe82317d..0baf7819ab46 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
           - qcom,ipq8074-qfprom
+          - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.34.1

