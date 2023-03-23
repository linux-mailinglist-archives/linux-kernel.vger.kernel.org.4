Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A416C6EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjCWRbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjCWRbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:31:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBB2B610
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j13so22123384pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axzKHWKEv5YVhGt7OnDPPiY6mPvXZ76IZmLOehTivRM=;
        b=Hr6ofu6oqBQij15HDorCxP6qJd/DFWqt6l/Ey7WIKytvKq0Hg1t6qCmeE664vXR+Z9
         N59aPdWEExquxwyH812aZNz20iZjJTt5Bk3jJvB2U7kgSZVLQutKqiBNL36uDXjSqWfU
         jL5NAUAv3Uxd6DivSrdFnrub1l7TcPWrtBjyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axzKHWKEv5YVhGt7OnDPPiY6mPvXZ76IZmLOehTivRM=;
        b=Fapam9n1hU33HLmaQal6BVKoYe0exM/msG5KjY20NfWEssm1/Ujzqd/M5zbdXjf2+r
         FBBAXJEqD5lrE7SE9uQefBUKlPc9fPVLPLrp4I+L1fsZ62XIgd0qgb0TD86jN+jNLsW3
         he9lT2RYZJDb4Fs5o5cEcmmxtxvxEYpeSzNc+g5aMBEIy+AdN75e28NXtET0XGmXH0r8
         9aT8EG6E8tHNclT2Lj2rKhs7z2UcxN47x0OOtiqY8dANMmBh5jyLKZqwGoYtddsdQATq
         2kjk/QG8BCHUbu1X5P/pBMGkBgnOLnoE9TLhX0STn/8NqabTgLQT0KB+FWH1aHq6AAQu
         DKMw==
X-Gm-Message-State: AO0yUKVV4zzYtQx9/Vr4jz+ztN/wmHwcNJyo472pjLciZn4mvxHp5p/2
        YEv/x/Supgz0wRUy9cDY7K6zmQ==
X-Google-Smtp-Source: AK7set98W2pL/pZaFCyJ1kV68FLpW0uLABrjIbr4GjXq3ykVerKMR6GAGJsUb4A7bHVMxCGlYMXUNg==
X-Received: by 2002:a05:6a20:8b14:b0:d9:840f:79c2 with SMTP id l20-20020a056a208b1400b000d9840f79c2mr464959pzh.2.1679592679750;
        Thu, 23 Mar 2023 10:31:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] spi: spi-qcom-qspi: Support pinctrl sleep states
Date:   Thu, 23 Mar 2023 10:30:09 -0700
Message-Id: <20230323102605.5.I79544b9486033bd7b27f2be55adda6d36f62a366@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fairly common practice for drivers to switch to a "sleep" pinctrl
state at the end of its runtime_suspend function and then back to
"default" at the beginning of runtime_resume. Let's do that for
spi-qcom-qspi.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/spi/spi-qcom-qspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index c334dfec4117..7851cf1986cc 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_opp.h>
 #include <linux/spi/spi.h>
@@ -581,6 +582,8 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
 		return ret;
 	}
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return 0;
 }
 
@@ -590,6 +593,8 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
 	struct qcom_qspi *ctrl = spi_master_get_devdata(master);
 	int ret;
 
+	pinctrl_pm_select_default_state(dev);
+
 	ret = icc_enable(ctrl->icc_path_cpu_to_qspi);
 	if (ret) {
 		dev_err_ratelimited(ctrl->dev, "%s: ICC enable failed for cpu: %d\n",
-- 
2.40.0.348.gf938b09366-goog

