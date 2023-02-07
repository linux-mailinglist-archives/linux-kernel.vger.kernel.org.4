Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C871B68D35F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBGJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjBGJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:57:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A610E8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:56:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n13so10606185wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjrreO/cdcWjaF0NqbiW3YouGZbLhGjexUtio5V0gjw=;
        b=Sjq7kVXQPYkZ5w3GDiFKGQld0ZlghHs4wtWm7Lr9qkfJA2FixfxmoBg9UFD58hhHtA
         K9Jw0fXpmXONpEZeSZD9Qz+mCVfvyThsnTfbS8kRzKknCaPYNPoqRgb5zbL6RQUt9Js8
         Ezf7Gw/YrlulMma4w2bzlpnGHwT4svcu0yTjHXH2wnV9GkfTO98JCo4sRdHgXpOeXUHn
         4ahX3HVHCn3KcRTGrkoREPmsO5xg1Iy3tZZ/0BhT9Rtr+ysr5bRuqlCdsCxEhMho/9zW
         4xozF5nEmgOdmsD6DNCenGCcfrDjaWSDEVDxf5fDDaQY82mSa8+6F1GgcLrwcoH8Y1sr
         L+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjrreO/cdcWjaF0NqbiW3YouGZbLhGjexUtio5V0gjw=;
        b=JTlUm8pA+eSUzpy1gORrFAkKy8PdJIFimJMkd4giSE8Zlz2F3TRYEOsliV6ExzzwuB
         RUJqRqlw14dOiZ49bFm372AQn3jmZKGCw+H20Ma20grREL7oPvcN63A7SFu9E+2qNyrc
         2OneZmycspejFxtDKX5auIkuMCfx6GLYPd5DPsL4Wlpbi+XNKa6L/LDW2cKsh7vTI7oN
         Wf01n/dHQb2nGY/GDzcdm/GB7PwpdSnXwM2/9Surpaym2uEozW0ROMo+6MwJM0NUFuFj
         VdZOcBxxiBraqxzWHt2W9b0prMAQRimgK/GZaRUpxajGLD8aq6QxlNTcFtdy2nyvCguX
         LBJQ==
X-Gm-Message-State: AO0yUKUMbP3zepzPCtuRSfvEbl2bjs70Lxk2dRe/ae0/HrcLseRYZBKK
        r1tcqHf2ECCO/asSKqwoBa1ISWp9orI90CiN
X-Google-Smtp-Source: AK7set8fpr1RSVtOGTk19Fdkfj3vPfHbVIuNLTvlgJtHNgCUKF8iVPgpF6WhOdCfsd40QVdTUXDpVw==
X-Received: by 2002:a05:600c:4b1c:b0:3df:eb5d:c583 with SMTP id i28-20020a05600c4b1c00b003dfeb5dc583mr2551310wmp.17.1675763803385;
        Tue, 07 Feb 2023 01:56:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c19d000b003dd1b00bd9asm14309860wmq.32.2023.02.07.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:56:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mailbox: qcom,apcs-kpss-global: drop mbox-names from example
Date:   Tue,  7 Feb 2023 10:56:39 +0100
Message-Id: <20230207095639.36537-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm G-Link RPM edge bindings do not allow and do not use mbox-names
property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See:
https://lore.kernel.org/linux-arm-msm/20230207090852.28421-1-krzysztof.kozlowski@linaro.org/T/#t
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 943f9472ae10..56b386b688b3 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -155,7 +155,6 @@ examples:
         interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
         qcom,rpm-msg-ram = <&rpm_msg_ram>;
         mboxes = <&apcs_glb 0>;
-        mbox-names = "rpm_hlos";
     };
 
   # Example apcs with qcs404
-- 
2.34.1

