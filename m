Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3966D8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjAQI7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbjAQI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:58:52 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC31E1C7;
        Tue, 17 Jan 2023 00:57:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c85so19626811pfc.8;
        Tue, 17 Jan 2023 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNF+cUC7Tk+3Ks9VwesOhSPqOeh30E6JOEl6C64DsqU=;
        b=Ck6q89nK+oJdP/XJySakaiWQa5q5zl0de5Nj3iHsyHZz4U3CvaE+Esq/qwQt1BQePV
         Yo6nyRXnmx3R/ZqPdqDdU8vARhOuD9OuGVFx1RFY3Fiu3A9gyRtY+QyVyYK7WJtYkzYr
         hBMRtSILCuKQvh7PQnXD7a5PN4aeisw9N1+XJ6EncHk+7+s880AUTcupVNBzfIhPxxOX
         OfDH6IoAjvJz5s2ECvcbzKaOer7+7HPf5UF5pX0kzH8nGPkkF1ghYQfahMGKpVi0KbxS
         30RELPKBCcX7suhfgj4cnfK4iZe5rHKlQwAeyvHLmY38ed2WuXebjLIJSoCl7fw55lqc
         TXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNF+cUC7Tk+3Ks9VwesOhSPqOeh30E6JOEl6C64DsqU=;
        b=iDWrjoeZ761TYC0DqHaty1RG7uuqw/jou8/q+9X0ekPb9BI9HJG4VtTTz5I8PvvL0L
         bPJ8pqAoSVp5bPoKCaW/nSFU29vTwjbddmplTkW7FT25M62vWTrtJqGIkOQj32ER7CnJ
         jCj7jOpYjGsNhU4vGUL2f9ycC7K7R6hPu/U6F7fRYOCwuLjj+fpCdezSxqCQQ80Qd7pV
         h04t0gOx8q8HbiS6K2WlaBPOFymGscchBznIE04vQtjVeiNoNR9gwXIATlU8Id4YYGr6
         S0gTs20mMvqWFUEWp7SHY5YYyuUzRyi5YBASlqZOV5htSMJD1YPVBqEsE9Mjt/jGIaNi
         K5oQ==
X-Gm-Message-State: AFqh2korAduDny2fY0p4dmiHAEKsfbSJydD2y6iZQvzgzIIw0GGECatT
        TVyYJykkTB11kCKhAGk2NXEKfk8f8ZQ=
X-Google-Smtp-Source: AMrXdXsxThkmCB9g0Edgx/mWaDS4XyX6dD9dUfJbVgZt4rjUmdF/JyxWEEBUarVNNwnWF6PUEGc0wA==
X-Received: by 2002:aa7:8f89:0:b0:58b:bce2:7eb7 with SMTP id t9-20020aa78f89000000b0058bbce27eb7mr14697457pfs.10.1673945852323;
        Tue, 17 Jan 2023 00:57:32 -0800 (PST)
Received: from localhost.localdomain ([103.104.171.42])
        by smtp.gmail.com with ESMTPSA id b131-20020a621b89000000b005815217e665sm19574781pfb.65.2023.01.17.00.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 00:57:31 -0800 (PST)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: set ath10k output power calibration string
Date:   Tue, 17 Jan 2023 08:56:25 +0000
Message-Id: <20230117085212.1.If242b1cd61b2e87e312dd9cf81e20301bae2a5a4@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the string to load RF output power table for pazquel360 project.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>

---

 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
index 6968aed35b8df..bc4f3b6c66341 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -67,3 +67,7 @@ ap_ts_pen_1v8: &i2c4 {
 	compatible = "google,sc7180-trogdor";
 	model = "sc7180-rt5682s-max98357a-1mic";
 };
+
+&wifi {
+	qcom,ath10k-calibration-variant = "GO_PAZQUEL360";
+};
-- 
2.17.1

