Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364268EC8F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBHKQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjBHKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:15:54 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5398140BD0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:15:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg26so12978095wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVEuYxssYzS6K5JrTOLvMTdbukj74pIFYD+z30S9/84=;
        b=VS3V3vJEHQN/F+Pe5DaKbbio/v4b9V6vMRPxKMe9+yY+91mSKgemsjWdrDcu1JeGXJ
         cdJIWD2jJi+V4ZySzq1GdZ6g1HP4LYQrGAIAmQB85vYbUIltjKEwAcUuUlDulhhBgsGN
         9BSY0D4iWk9cd8SKjX3wMPBht2t6Mqe9mt9lT2iU1O3Por7ralBb0vCg4kEsX23rOfoS
         cQ6wE6PC34jg/YUoxoDOnlaT+37DKKHzjdCmfrSvO0tIPSs4s0KPx1ynJGU/N7y2PZKQ
         ydEalrfM3VBUK/JwOmihWwkNOC1khv80gD3gmeh4LoVytIVIHbL0HYUTn/jpsQgEvRRV
         XR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVEuYxssYzS6K5JrTOLvMTdbukj74pIFYD+z30S9/84=;
        b=rert5YdeXqeasxnfpl9fsXLXOEwbRAuNhouJGCQA1BITsXtpjf+LleWnKM0evclRXP
         WorttJ74YCLkHhzbfyO2KQPC/Ok33GqnI63hivuXN7nmA8d3gBH3lGWAeyjhpK7XfoA3
         OGZgMLxdxKNuem1vZMyV+fvedUcvM10OyS/sWpjptSdHlSSmsepxo4wxViCc5iZknMAv
         x6qb44Cs3KIwc3b7mTtQjJbL/ujXcQlrRZwndWrrzNm+4Znm9gzxPatD5mbpjCmpLLGc
         ig7/l8NoLaZ0mo6D8q7k+KJabdWahyFi0OuJMx2U00nQmzYUm1bwYOupWUO6d0gTjcbu
         g9TA==
X-Gm-Message-State: AO0yUKUJXdSZWwQCZQpPTzjPxo0Nz1J8YhMsQdppc+xgh6ldYCYQ/o84
        0G32h+QHxRJfexbnRNOhbAYa8g==
X-Google-Smtp-Source: AK7set8QWSrB1VoOwQDhU4/XDsvh97uKEmQ5ftpRs9Z0p1SnhshHE2kaliOz0S8RQAp+4Zy2+7nrUw==
X-Received: by 2002:a05:600c:13d4:b0:3df:e1e9:200e with SMTP id e20-20020a05600c13d400b003dfe1e9200emr6033073wmg.39.1675851351905;
        Wed, 08 Feb 2023 02:15:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003dc4ecfc4d7sm1496328wmq.29.2023.02.08.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:15:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/7] arm64: dts: qcom: qcs404: align RPM G-Link node with bindings
Date:   Wed,  8 Feb 2023 11:15:40 +0100
Message-Id: <20230208101545.45711-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

Bindings expect (and most of DTS use) the RPM G-Link node name to be
"rpm-requests".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

---

Changes since v1:
1. Add Rb tag.
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9c9890cf1b10..bc2ed73afb74 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -223,7 +223,7 @@ rpm-glink {
 		qcom,rpm-msg-ram = <&rpm_msg_ram>;
 		mboxes = <&apcs_glb 0>;
 
-		rpm_requests: glink-channel {
+		rpm_requests: rpm-requests {
 			compatible = "qcom,rpm-qcs404";
 			qcom,glink-channels = "rpm_requests";
 
-- 
2.34.1

