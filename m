Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FD96689F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 04:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjAMDOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 22:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjAMDOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 22:14:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EA621B4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:14:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g13so31262771lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 19:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqhrEGDhyNyct6j4UIY/bUU8rmAKJvJsZVTD0uXyplg=;
        b=EijPl8leAc4s6WSCWxgCiOUVzOKj9SfqolbfYNRNFvGZ4CdrAmgz7BUXQ5loayvIVL
         Vhu5Ml52r1uANUUmT8XeQCZQplLyBTw3QxH2f8OetmETqgQjFjcw8OQQ6Chtns/5bpt0
         Gf01zbPDDlKoM8Wa4HPjVdIadzAZgScwC0HEoA+e20iS9//sLnQuC0PzMEp3YMw8TJnQ
         w+90TtM8qwJKjt0ogwU5Jrcw0FJ2/H9limJiqlFo3BIgh/4RGNeP4zWBqQ5CpYv2rs2H
         1yGE29Jx3oSYNe7pVapiqN2YwaRwKtfshMKChKjV8roCH4zEddAQbv/gmZoaE25RabHY
         59ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqhrEGDhyNyct6j4UIY/bUU8rmAKJvJsZVTD0uXyplg=;
        b=qXcrmQopFh40kdnv1MW1xGRsqgJHfYRAYDj+HzgDXOxM/bZUZJRNoWzVptFDq2umL7
         pchN6B6JtLSYOrbwuKkm19tBbPsXN7HZFPhZLaBPqPaByYaQ6NqvI4cYB2Oa4Qk37RXA
         wYfBGmD38OOFzkHRlCcvxfhCVfuy/nXT1y7MdcrFl+piJv3r3yh3ycZlQfZBdo2O2h5j
         FsxeUb3GmVs4KODV2bZzKl0cB3S+4+ZF3kiqZ8KIbJS177rt42AhaoXfrJFUknUC+EgM
         KzkSkxl9G7pG1K9KKA7NyTbDuIJ/bDLvua6JUuvY0o/eXh4vU1naU1CPE4r8pblfWzyu
         GU6A==
X-Gm-Message-State: AFqh2krRfEOchPoVOe96ONrT7le9C9K328qq2XJtL2OmM58So0MH5P6s
        hoTJJsDEZwrmWpyaDJNkDt8X2w==
X-Google-Smtp-Source: AMrXdXv8B+aSQqpoWPejfljGbBfrwKd1UBoGFnD1EVy3WEmjxhuMINI07fu6exs743agH2pTNjzCWA==
X-Received: by 2002:a05:6512:3c82:b0:4b5:adae:b6be with SMTP id h2-20020a0565123c8200b004b5adaeb6bemr34753954lfv.42.1673579651452;
        Thu, 12 Jan 2023 19:14:11 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b004cb09fd48ebsm3584858lfr.149.2023.01.12.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 19:14:09 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal/drivers/qcom/lmh: Use driver data as flags instead of bool
Date:   Fri, 13 Jan 2023 04:14:00 +0100
Message-Id: <20230113031401.2336157-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
References: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the OF driver data is used to determine whether to manually
enable the LMH algorithms through secure calls. In preparation for
introducing support for SoCs with a configuration that differs from
both SDM845 and SM8150, convert this to a set of bitflags for more
flexibility.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/thermal/qcom/lmh.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 4122a51e9874..5e8ff196c9a6 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -28,7 +28,7 @@
 
 #define LMH_REG_DCVS_INTR_CLR		0x8
 
-#define LMH_ENABLE_ALGOS		1
+#define LMH_ENABLE_ALGOS		BIT(0)
 
 struct lmh_hw_data {
 	void __iomem *base;
@@ -92,9 +92,11 @@ static int lmh_probe(struct platform_device *pdev)
 	struct device_node *cpu_node;
 	struct lmh_hw_data *lmh_data;
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
-	unsigned int enable_alg;
+	unsigned int flags;
 	u32 node_id;
 
+	flags = (uintptr_t)of_device_get_match_data(dev);
+
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
 	if (!lmh_data)
 		return -ENOMEM;
@@ -144,9 +146,7 @@ static int lmh_probe(struct platform_device *pdev)
 	if (!qcom_scm_lmh_dcvsh_available())
 		return -EINVAL;
 
-	enable_alg = (uintptr_t)of_device_get_match_data(dev);
-
-	if (enable_alg) {
+	if (flags & LMH_ENABLE_ALGOS) {
 		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
 					 LMH_NODE_DCVS, node_id, 0);
 		if (ret)
-- 
2.39.0

