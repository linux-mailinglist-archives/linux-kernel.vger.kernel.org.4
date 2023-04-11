Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23696DDCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjDKNrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjDKNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:47:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F857196
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:47:24 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a29so9308495ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681220842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnOa1rnUIW+VOH2jrUKXRz6zTj4Kf4Fep5TGBDQYvsQ=;
        b=k5dSAhm5qHMWnCH2FNZJ51zDDkW5l7jKxuKcwwGlLqCG9z9X8FeAxp3DVocNrWpUAz
         HeRV6hY8oD99WT26OLXsHK/v7fTEiIEc6DhEHtt0q+wVSYzRxOzYRA2xyD4pFdWzNtJM
         DkbwD1D6WV2ke3I9ns/rE2+Zt4MZhUM5cdnB0pPKCmfj9jLwcsQnOwmwTcJXgIvoiQ4O
         kBCugDzNdOp+S9pT4pP+to4dhveDhL5m6Ksy1YdxUK0dblmSgAOFfa+nflArPPelj39y
         W6S6zEpNzlD3g2HD0DJbLizz5FpZdGZDxPlt0S4tRkjk7RZl7VbT2UkXfms7XBkVkJKb
         tDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnOa1rnUIW+VOH2jrUKXRz6zTj4Kf4Fep5TGBDQYvsQ=;
        b=3veHcQuX04i46u5XtLNdwn4tNVNIBInclxXulYtvdflaeoBl4wpkmQXq05p9ZJ7xHr
         kP/SoBSvvrB20Lx9Vw7IZV7/vl8xJy5fO4P4NTP2kDwVGBm4w+XCxNW923X7KZqdDVm2
         YK9lPyTUP9Mh4qkUqIt8DQSTanyd1d6M01SYd8EVP776SrxpyEYqa2GJGb0pFMH2g6qe
         6eM9V4xsBl6ouXKGxpw5NjX+YxlbBGqx5UQpwv8B2N68DWEzmhR9ft6xdRyXGDDd5bgZ
         9eShhaoLo3r0r0TfWO0zVvhSDKiE6u1iLNF0+ankCv74O9Dniv343RQkhSViaAEpGqmS
         nzLg==
X-Gm-Message-State: AAQBX9fAmlpl/FmP2w+xV8jUOBUnHaFv8mPXrosRub/TcLIhR3i7z6J2
        thaeF8kHeUX6RbJq5scUL7PfDg==
X-Google-Smtp-Source: AKy350a1m+Y/HfUj1FBHEOehNpusviqs5rax+2zYdmiHX+5UhMZqOIUVFE/wXrizC+lNWX3MH7O2ww==
X-Received: by 2002:a2e:920b:0:b0:2a7:7b5e:271 with SMTP id k11-20020a2e920b000000b002a77b5e0271mr651740ljg.24.1681220842452;
        Tue, 11 Apr 2023 06:47:22 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e680a000000b002a77583b718sm1245887lja.12.2023.04.11.06.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:47:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 15:47:17 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: Split out SA8155P and use correct
 RPMh power domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-hanaau-v2-3-fd3d70844b31@linaro.org>
References: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
In-Reply-To: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681220837; l=2119;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GTxTzfHDkLcCspsXqSwwuRYb2T4ZqC5yjZaaQlxphPk=;
 b=rGen8sT5XjdbxkaKlembBhwUlJG9cvFLwnBLZgGvlrDk0vTG0pSChCVlSvyincyAJApnpLzvzqmn
 bp5/4k1tC/1SmWyCyIDP9M4jbjGcJ8jKEswNLy7TL1/NKp5KaGBP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMhPD setup on SA8155P is different compared to SM8150. Correct
it to ensure the platform will not try accessing forbidden/missing
RPMh entries at boot, as a bad vote will hang the machine.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts |  2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi    | 40 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 339fea522509..15e1ae1c1a97 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -7,7 +7,7 @@
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "sm8150.dtsi"
+#include "sa8155p.dtsi"
 #include "pmm8155au_1.dtsi"
 #include "pmm8155au_2.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
new file mode 100644
index 000000000000..ffb7ab695213
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ *
+ * SA8155P is an automotive variant of SM8150, with some minor changes.
+ * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone,
+ * though the cmd-db doesn't reflect that and access attemps result in a bite.
+ */
+
+#include "sm8150.dtsi"
+
+&dispcc {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_dsi0 {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_dsi1 {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
+
+&mdss_mdp {
+	power-domains = <&rpmhpd SA8155P_CX>;
+};
+
+&remoteproc_slpi {
+	power-domains = <&rpmhpd SA8155P_CX>,
+			<&rpmhpd SA8155P_MX>;
+};
+
+&rpmhpd {
+	/*
+	 * The bindings were crafted such that SA8155P PDs match their
+	 * SM8150 counterparts to make it more maintainable and only
+	 * necessitate adjusting entries that actually differ
+	 */
+	compatible = "qcom,sa8155p-rpmhpd";
+};

-- 
2.40.0

