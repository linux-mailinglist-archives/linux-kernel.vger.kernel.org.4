Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046E9656C12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiL0OlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiL0OlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:41:12 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE65BF3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id z26so19868013lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vva20aRYtWITvXzhJCrEBp9zvbKox19H7ncjjyBeiUQ=;
        b=CwQlcm0Xu7u4knS3Xz1eKSkMX2ulmbd5rnyqaWt4mpXzS5y3y08pfCr/SC0nrYBJpi
         0ZVqEKDCnO0WuhI+D5gkK5Kr2pH14H01DdGgb71BhDpgi9Cd+v38PE6qMNx/GxRpYtOY
         sWJF1GVN+BHYu8P4nuMg/qlxrqsgE6ZFap171oonzZZtU9zadvKhbTTgoVP8+OYlAmcr
         cJuZa5jm+e3697ZgFi+34guqqCfpgAOoU9EruH8f26QkW2QkunBJhs5Ubk2/iDS6seqY
         I+4asKHhn62tSDTBKiO8ozeGT4s15wBznoGBsfieNFfR04cBaEEbH2ee+Hr6SLHIXnF1
         s3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vva20aRYtWITvXzhJCrEBp9zvbKox19H7ncjjyBeiUQ=;
        b=dSEhctK1GJEDHD+Fnb5paAHQGAU0D0J9rVjY09y5W4LcQfuuH2l8+paXd5G3m8BdQ2
         QVOXV+NJpMZUYVRAe1GW2q/5s0l096MDmhkj0O1sFyxhaArpKcm0XHev5AN9Fvlnfv7+
         r50asOznadP4l267nyJoMWH7i7uyIlFoiY4hIS/D/OT1vZs00LfHro7LCdVCbWBKXYP0
         VnwbnMw6AayqxKtuk3IEY4fSuK+doyQe9GdHqbThf1SE/kzBNSQPD2m5kBsKsVKGGf5z
         X3CGICh5TMk/5RD0K/WKXEueEkpEhw7fmhqydd1l7bcQeVZntr3FQExVdFT8QuXGWels
         Umdg==
X-Gm-Message-State: AFqh2ko5iCbOVWYZsbdrUOv9sMgicgaXjbLeNWzXahjMOMBRlDqF23Pg
        YpDuH2Kvi0naTUC0crXwuiTAzA==
X-Google-Smtp-Source: AMrXdXtjaj7XuOTFtQa1Kfso9g1N3MMIS21twzxwcTLYpZKt9YaFuv38bL0VZMy5tjAxRP+36Kkb0A==
X-Received: by 2002:a05:6512:220e:b0:4b4:b610:1427 with SMTP id h14-20020a056512220e00b004b4b6101427mr10907565lfu.8.1672152068144;
        Tue, 27 Dec 2022 06:41:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512214100b004b5853f0fc6sm2261126lfr.246.2022.12.27.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:41:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/8] media: dt-bindings: qcom,sc7180-venus: document OPP table
Date:   Tue, 27 Dec 2022 15:40:58 +0100
Message-Id: <20221227144102.79391-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
References: <20221227144102.79391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Venus on Qualcomm SC7180 uses Operating Performance Points (both in DTS
and driver):

  sc7180-idp.dtb: video-codec@aa00000: Unevaluated properties are not allowed ('operating-points-v2', 'opp-table' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/qcom,sc7180-venus.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
index acdb54d5c69e..5cec1d077cda 100644
--- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
@@ -56,6 +56,10 @@ properties:
       - const: video-mem
       - const: cpu-cfg
 
+  operating-points-v2: true
+  opp-table:
+    type: object
+
   video-decoder:
     type: object
 
-- 
2.34.1

