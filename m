Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B566B143A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCHVi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCHVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:38:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274ED13C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:37:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h9so18044015ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678311414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ2JnYKphgULZ1WukulUiOrRt/1FnNLmapvkEFPxKD0=;
        b=r9LIl4XSQs7OKlujgiLWR7G77j2AtX6l5UZ+gPpG+PQokM4kkpyVdDNjT9tTIdAS2D
         Lt6V7SLf3UbZJk4UHm5LLT3HgUeZODY4RBryxwwkzYS4vp5RlLjlWrRoP8/FkkU5uH7h
         CqrrFu/5K2ImQlTj0WxabuGpqgNXWeV/JsjK4PRzT8oTdjfWpgxziQmOKAC+GMLGE6k6
         5I2AXlSr1T2bdZCpITT2UBSeQg1UAqFdp4dxXIp7w7zAqsdFmDrb8aUk6qVKUkadJji8
         vMRVWE/i0QY3KcRrknyk8J4hfS3ZpOzJrZmCcwgn0trBz4qVRSqWmThZkcsDp8+BAwEs
         KSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678311414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ2JnYKphgULZ1WukulUiOrRt/1FnNLmapvkEFPxKD0=;
        b=atG2voGNOIJBwPJNTiRXSG4b8McTK4ygJebI3LRkHQGEtu3lJM+dFJkCT/AuIlqrA4
         vEWynxq/s4bP4nQtb+58rNbQauKqZbM0A9DKX6i8tH5DOEoBTyMIyDCt+C2+sOdF4W0J
         F0uV4ABCnuuIf+PFH7U3D01BjMjCTB30YtgJSgQQtJwlbmndFQZFth/BNZ6+Ay8s9Bn1
         cbt43B7ameqTyC1bM8l5we5SMhrChNlEV8dcExuD8DF1G/Xngr/05OmppsSbdMwBCcwn
         2RHCZVYChytosMgNuDtUhY+iaPF0jBH/OvaGAEAHDxK5k1ANXngYydgzPIXqAJ9k1wH5
         VVFg==
X-Gm-Message-State: AO0yUKUfbyS++aN1ZOXlcFXwSQnnbEp6bjzRzPUz6NSB7rU+YhQGiODr
        EqH1iQsyqvI19QBSoEJHv/OYrg==
X-Google-Smtp-Source: AK7set93Mde/x199K21wD3Nt3Yvy2a6WF8aALGxR6cPON/jC7KCsOx8/6V/v8bmuwuVhf5IBPcscMw==
X-Received: by 2002:a05:651c:543:b0:295:a3f6:43b5 with SMTP id q3-20020a05651c054300b00295a3f643b5mr9956414ljp.39.1678311414571;
        Wed, 08 Mar 2023 13:36:54 -0800 (PST)
Received: from localhost.localdomain (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i15-20020a05651c120f00b00295a96a0f6csm2621936lja.102.2023.03.08.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:36:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: msm8998: Add MPM pin mappings
Date:   Wed,  8 Mar 2023 22:36:51 +0100
Message-Id: <20230308213651.647098-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MPM <-> TLMM pin mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8998.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8998.c b/drivers/pinctrl/qcom/pinctrl-msm8998.c
index a05f41fe2706..1a061bc9b8fa 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8998.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8998.c
@@ -1503,6 +1503,18 @@ static const struct msm_pingroup msm8998_groups[] = {
 	UFS_RESET(ufs_reset, 0x19d000),
 };
 
+static const struct msm_gpio_wakeirq_map msm8998_mpm_map[] = {
+	{ 1, 3 }, { 5, 4 }, { 9, 5 }, { 11, 6 }, { 22, 8 }, { 24, 9 }, { 26, 10 },
+	{ 34, 11 }, { 36, 12 }, { 37, 13 }, { 38, 14 }, { 40, 15 }, { 42, 16 }, { 46, 17 },
+	{ 50, 18 }, { 53, 19 }, { 54, 20 }, { 56, 21 }, { 57, 22 }, { 58, 23 }, { 59, 24 },
+	{ 60, 25 }, { 61, 26 }, { 62, 27 }, { 63, 28 }, { 64, 29 }, { 66, 7 }, { 71, 30 },
+	{ 73, 31 }, { 77, 32 }, { 78, 33 }, { 79, 34 }, { 80, 35 }, { 82, 36 }, { 86, 37 },
+	{ 91, 38 }, { 92, 39 }, { 95, 40 }, { 97, 41 }, { 101, 42 }, { 104, 43 }, { 106, 44 },
+	{ 108, 45 }, { 110, 48 }, { 112, 46 }, { 113, 47 }, { 115, 51 }, { 116, 54 }, { 117, 55 },
+	{ 118, 56 }, { 119, 57 }, { 120, 58 }, { 121, 59 }, { 122, 60 }, { 123, 61 }, { 124, 62 },
+	{ 125, 63 }, { 126, 64 }, { 127, 50 }, { 129, 65 }, { 131, 66 }, { 132, 67 }, { 133, 68 },
+};
+
 static const struct msm_pinctrl_soc_data msm8998_pinctrl = {
 	.pins = msm8998_pins,
 	.npins = ARRAY_SIZE(msm8998_pins),
@@ -1511,6 +1523,8 @@ static const struct msm_pinctrl_soc_data msm8998_pinctrl = {
 	.groups = msm8998_groups,
 	.ngroups = ARRAY_SIZE(msm8998_groups),
 	.ngpios = 150,
+	.wakeirq_map = msm8998_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(msm8998_mpm_map),
 };
 
 static int msm8998_pinctrl_probe(struct platform_device *pdev)
-- 
2.39.2

