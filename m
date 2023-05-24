Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B0371016C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjEXXEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEXXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:04:39 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0751E73;
        Wed, 24 May 2023 16:04:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f697a1da09so1767071cf.3;
        Wed, 24 May 2023 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684969449; x=1687561449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoTnwldgTHnhUuNWL04YkEejXlnGtSWGcde0hm+P0A8=;
        b=Z3AO/wfVMDTFVpsingvFFnZdKWcTKkweyn7Eu9sYVITZzzmtHpfhVzmjFHaKY7H8OL
         EEFxmdZIqVxNrCX/M3WZKnFMLlxnK4D5EvVywt3WHVR2XHxVMjtT3gs+uwnGRzJprO22
         ckXXq7DT20gtB0dIqRkG1PcMoVGBd5akcIxFiDYvgMDVZur8GFG+9ckij3ZvZg653z5b
         Sc/Xyu7rxiw8EJe+NznqWHfjA5gPx49riLQ3CZ8fLra01s0fF//jSc/o2Qsqjjam80l0
         BjQuG4K4unAVcNNi5awldSckSXlGrWYqIABIxCkbIsH/I0CC1kSRGxLHd5bve2vrvlbW
         L8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969449; x=1687561449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoTnwldgTHnhUuNWL04YkEejXlnGtSWGcde0hm+P0A8=;
        b=T0Z70PiQtQXD2EBJSc1EW++3dtF1Zn/vbNGFQgSzEP508yjaQo7yz/7bf5JY2BjIio
         v79Woz3S1B2Ty9njykiFwajVeov9XGzLsvgbPUZL0+FBEo5t55hfYPHIMtG9yyxCwCbh
         XEHGX+FMt579XTVKgK4Bm8WaHuiDc9tu+tzeNhnuNQFNSc4qy5Dj8631Rp+9RrmyS7Zk
         7Mywjm6gfPrhF8BZIW03gO08K4HCb2aFuYZTW6zHizYs7MC+p58TkWlDbQutny19aavq
         8nxt0TFJw0Q4sRpoHH01uqqYmd3mItUpTW+UsO8H/bUnoGepqrKlhc2TJ8lxlxxHl+4w
         qQMA==
X-Gm-Message-State: AC+VfDyQLTOPwZQdRXCzcOaBRNp0s6nRDEPiKhV6jgLYMUXVaRwRqyVL
        AzHoX2nbgSBAOsTvQN5NjXQCm8JviMzlkw==
X-Google-Smtp-Source: ACHHUZ4RZOOSVikIYLXezOIlVZwKU+GPBXK09N1oVnSS3lZAOgd3AjSlbPFXBD9AeJf9c+dCLcUrqA==
X-Received: by 2002:ac8:58d4:0:b0:3f5:2be9:89fe with SMTP id u20-20020ac858d4000000b003f52be989femr30105447qta.35.1684969449286;
        Wed, 24 May 2023 16:04:09 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:650f:ad8b:38f6:d091])
        by smtp.gmail.com with ESMTPSA id i24-20020ac84898000000b003e388264753sm4073322qtq.65.2023.05.24.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:04:08 -0700 (PDT)
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
Subject: [PATCH] ARM: Add missing msm8960 for list of strings
Date:   Wed, 24 May 2023 19:03:37 -0400
Message-Id: <20230524230338.120619-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The list of supported 'SoC's didn't include msm8960 even though
qcom,msm8960-cdp exists.

Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..3ffa682cd079 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -40,6 +40,7 @@ description: |
         msm8939
         msm8953
         msm8956
+        msm8960
         msm8974
         msm8976
         msm8992
-- 
2.34.1

