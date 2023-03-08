Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE26B16AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCHXit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCHXid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:38:33 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCED05F222
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:38:29 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-176b48a9a05so617310fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678318709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIF+TzoNCpNgaaPFRZQkOEM2aIrfReHqLZ5t062NKS8=;
        b=Ltdx//bI8+EcfFFzVD0xzgZ4Q9JkiCo8HulKF9GyblSCbeO0M/DRcxuu8WKR+GRUt9
         6rkQSewqo20alox3EQ+oRwG64/ER6XRoEI5koKP+nd5pPV78gPeSp4lGf2DN5/bCpSVY
         UJXMb/luPG/27tbLPKu93kXMaa/V/kRtyHs6FCuQFYAfe6z9WSTqiELHdh+jywdC3Xi9
         /SmYl5EyeUI02L1KMc8YjRjPQ9DJ6vAPhbRAiNAsR6cVUPZA/4Ge9azkkf0yoRDl7gAX
         HjzXlRtiCn4bzKRnerkvp3AwZTvxIHWPNfegjOTCQvix4WHDgZkfqcl1OftcgReOrEQX
         aCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIF+TzoNCpNgaaPFRZQkOEM2aIrfReHqLZ5t062NKS8=;
        b=W8KG2k2g1bklvG8R+u9+8Shzg0SJLpQeM35V4lZ3Lk+bO/M7ss8fpaP0JIYTyjISJW
         NK2LNB4n5PGnQo5VlBS2ssGS5a0cd2if0nMu8av0rAP45gZARGCXHcG8m3fQlDdPE2Dj
         ZAcLRSjtlm1pTFzPhde28KTKdPkFJTC5NE4LUn6u5ke62D90eNs1TXfxFZzg1DVrQjGr
         WlB/Ew2PndO2BQYHRaJAAUukNb4Jm88f2JD3c27wNfI9euX8EZfyy3muPTISo2N8hdJC
         B2cv0cTT8VQ9aVl6xeN1dXE5z4o/RLavzlv/EeRbj9BDU7AMqAgJwFTw/u5c6cy7llRy
         pBwQ==
X-Gm-Message-State: AO0yUKUt9K8HXAnRQytQ5PSaH2H38CIpwRqDTK9w6bhD937dg4UszZge
        +4olNMXh2n30pEOEpWgeFEDLXg==
X-Google-Smtp-Source: AK7set9VYwr+T8z+k6L0BS4GEK0pru9L4q1IR9HnAm4ODTR2MOgjxtRbVtTujQn6EOwctOvNq02Lpg==
X-Received: by 2002:a05:6870:5703:b0:16e:9056:4a03 with SMTP id k3-20020a056870570300b0016e90564a03mr1788575oap.47.1678318709176;
        Wed, 08 Mar 2023 15:38:29 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id m41-20020a4a952c000000b0051ff746e2b2sm6714646ooi.8.2023.03.08.15.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:38:28 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] clk: samsung: exynos850: Make PMU_ALIVE_PCLK critical
Date:   Wed,  8 Mar 2023 17:38:19 -0600
Message-Id: <20230308233822.31180-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308233822.31180-1-semen.protsenko@linaro.org>
References: <20230308233822.31180-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMU_ALIVE_PCLK is needed for PMU registers access, and it must be always
running, as not only the kernel accesses PMU registers. Make it critical
to ensure that.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos850.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
index 6ab5fa8c2ef3..98b23af7324d 100644
--- a/drivers/clk/samsung/clk-exynos850.c
+++ b/drivers/clk/samsung/clk-exynos850.c
@@ -612,7 +612,7 @@ static const struct samsung_gate_clock apm_gate_clks[] __initconst = {
 	     CLK_CON_GAT_GOUT_APM_APBIF_GPIO_ALIVE_PCLK, 21, CLK_IGNORE_UNUSED,
 	     0),
 	GATE(CLK_GOUT_PMU_ALIVE_PCLK, "gout_pmu_alive_pclk", "dout_apm_bus",
-	     CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK, 21, 0, 0),
+	     CLK_CON_GAT_GOUT_APM_APBIF_PMU_ALIVE_PCLK, 21, CLK_IS_CRITICAL, 0),
 	GATE(CLK_GOUT_SYSREG_APM_PCLK, "gout_sysreg_apm_pclk", "dout_apm_bus",
 	     CLK_CON_GAT_GOUT_APM_SYSREG_APM_PCLK, 21, 0, 0),
 };
-- 
2.39.2

