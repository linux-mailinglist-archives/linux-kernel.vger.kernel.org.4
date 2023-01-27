Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1C467E403
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjA0Lrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjA0LrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:47:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EE83241
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z5so4721683wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeX5sh0pB1nWQRCFP8JlWLr9E5y8r+895bK99p9ZBeQ=;
        b=hBc1g0y38tVDw1ZyxddtgM2GHACdd7x2KcdVVDPMCXcB524JDcmsU5a8nhID6V/KQn
         qYqV6l1XEy1UwFFnGfiCJdOuCZneUzqliOAsvByag1sxm88aKNKdqNtYJ/GwL//nw9J/
         0B3ePqdthyxH8c++CGKgJ1U936gAfQkGOncOERpCJS2ci1Z92nHvdiTnzlKa9I86YQ9L
         ieVO01JJb9hulQpqLrldGTp5y2/JoYwSKY8FyzwI+2ZAmX/+/fubrmdDlZjhdhpY19Kk
         lP1+8Jw4VeVvXmgWBM268XUo5DprZ1wfICK2H/Z3Onj5toZwavvVAeZ5ZtE1ks+4PdFf
         aYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeX5sh0pB1nWQRCFP8JlWLr9E5y8r+895bK99p9ZBeQ=;
        b=GIAtZpsWIs9/sjVxMyaQ2dWxXqEky6Hqp2FYHeYE6ftdrkDrWHsBPsT/6ZUKe3jQmh
         FB8j3QtHCeMTcUjOkDt6omR878KLnNXTBx6631BQL/emFoP5TGgkTZ0SFsrSehFX2uso
         YCLTZgJnyoB+JySdl2LkMkdWmHr3VSmc0r4T1JtYcYbWgycN16i2kYAl2zNQ3bVSwSu8
         ZXxDyTiWKzykb+Ra6CyATcifvrDpW8lHCLoVL5enIDoB2meM9XiYpVns/kq87lBZTQZM
         qlI3wLxNeWdKi+2/ObwIpfeoSFYDVx5Ql+KtnkKvUqg1AwgaBH0xxDmFR2EPRnLS6Pcs
         iKsQ==
X-Gm-Message-State: AFqh2kpgz4QZj428hJUaicZaPT4cKUZZzBESOu96VM9ZNd2sMF9Fjkq0
        DTtNmNSTaG6tQToNaReVQPUctQ==
X-Google-Smtp-Source: AMrXdXt6CXcCZeXYmt/Q6tlUG01BEN2phXAn8KELn5WFgFd8UWWw2zHvB2nfWetl2B/5p9dCcy3lng==
X-Received: by 2002:adf:dd41:0:b0:2be:d9e7:f39a with SMTP id u1-20020adfdd41000000b002bed9e7f39amr20718354wrm.43.1674819852872;
        Fri, 27 Jan 2023 03:44:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b002bfc2d0eff0sm3807760wrs.47.2023.01.27.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:44:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/11] ARM: dts: qcom-sdx65: align RPMh regulator nodes with bindings
Date:   Fri, 27 Jan 2023 12:43:38 +0100
Message-Id: <20230127114347.235963-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
References: <20230127114347.235963-1-krzysztof.kozlowski@linaro.org>
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

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
index 85ea02d8362d..ed98c83c141f 100644
--- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
@@ -65,7 +65,7 @@ vreg_bob_3p3: pmx65_bob {
 };
 
 &apps_rsc {
-	pmx65-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pmx65-rpmh-regulators";
 		qcom,pmic-id = "b";
 
-- 
2.34.1

