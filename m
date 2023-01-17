Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C466D4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjAQCx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjAQCwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:52:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE16303EB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:54 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so541127wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/FeGatlAHYslquVvHA/kdin0O1a8lc/TSdv5XPOTOw=;
        b=DDPBd9rpxtp2mWldtAhu3zcyIqHmJcmyewwOBUO3LYsQLkQKjYWKcDZBfgjWI6CLMo
         8ZljFi7xeuFWad7bgJ+e4xVZS8YA17hYW0xMpJY2YZalM3zQ4mQg4/709ecoPz08YF3w
         fdz6LLw7fdcm8TIetLK0jdIwVo9/hWzv2vaWzF3yr5Pe5R6XRIxJoEJuFDv76n44/l5f
         9oKXdeLEPzNu8AX7jxTyJUBUkGJQvJFfuePsLVwZ3YUM6wORIUsjXvm3xB5ZvoDa46A0
         ROEancQ5Mw0DmF6TBaKtWpF4MWXQFn8/GiwMzorAiOGQQq01C4cL4z01kWhouQmVcHpU
         5Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/FeGatlAHYslquVvHA/kdin0O1a8lc/TSdv5XPOTOw=;
        b=ckUFQDZe9FJ4pvoOejdiYpHz/A80cMhPSQ9iFd8ES57yxzmPg6Vngg4/lTf31KJLt2
         y1CDTmexS1V6i70oOc6eirGMiA5stvTjI1ZURRHn7EtRHonLFlqyMwXSPM0Y9n6n3U6t
         +IbBvqlarBhNaXzBA4VUzwECKktKmmYXSwEApSkcu/C5QvydSzf18y/6GEjwbT/8wldl
         VXMr24VfSsuAM35aGK4F8JmUcxJuw6bFx/hqCTLaTGC8OLbGfpDth3GFlUgcQb9wZzEC
         59tBRFEk8zOwT6fkngf3MmAVo34ca0lqQNqMqV2bSni1VgBsmQviWl5xqKMfw3jsx5Vd
         VrRA==
X-Gm-Message-State: AFqh2kqZWQ4O3DACDg524MdANIEHZhXsknMECwIF2TJyfPyfwLRmiovH
        bPhCchaQSuMz/yM8T3VzhwX6kQ==
X-Google-Smtp-Source: AMrXdXs3Rlxk9afh5VXax7PrzR2uWOf0/9UnkNWK7AquXf9M/JJS7K4UPx3uc4/h8lWTqVDMXjnT9Q==
X-Received: by 2002:a05:600c:4928:b0:3cf:a41d:844b with SMTP id f40-20020a05600c492800b003cfa41d844bmr1426739wmp.5.1673923733473;
        Mon, 16 Jan 2023 18:48:53 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6bd12ac27sm39482660wmq.37.2023.01.16.18.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:48:53 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: [PATCH v3 4/8] clk: qcom: smd-rpm: msm8936: Add PMIC gated RPM_SMD_XO_*
Date:   Tue, 17 Jan 2023 02:48:42 +0000
Message-Id: <20230117024846.1367794-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
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

The XO crystal input is buffered through the PMIC and controlled by RPM.
Create the relevant clock gate representation in the RPM clock definitions.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 8f6e274c60301..6f23ca4828f44 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -574,6 +574,8 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8916 = {
 };
 
 static struct clk_smd_rpm *msm8936_clks[] = {
+	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
+	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
 	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
 	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
 	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
-- 
2.38.1

