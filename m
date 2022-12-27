Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D962C656FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 22:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiL0VDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 16:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiL0VCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 16:02:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C4B491
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:45:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so13356828wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zataCZGEzQIAuQApeyUtcsVZkc4oA8sa1m255NDvRGY=;
        b=zrVy+kKkbz9k1gsIjjuRvlbDyNo3WywOnyq/Bd5HmBHXViEkk5VorO2rz4R6ZY1+E7
         UXG9zp2Z9zYWZknHFC5c9fHxxpfTMGkR1jDoRZVJkkRuS+xwWOh1DCUzNasCPLvQjJab
         ixsRbPuaWdO9IYwY71YkIwGEI84gMdn4PEia9/lbUX4o7DM0svZvSTXDuik/uiawgTJY
         S33Twkj/Ez7Kkep9FCkrXbvXmf64HqGKD5sK8EW+DvGTim86r4+jf+v4MnOtqWrplRuM
         CneoczR9eT+AW4Q6mkulZ1m6ewySzi48RUxq3lXaYxY4aQ2myq1MTdjFomL7+zQ1ZDRd
         dMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zataCZGEzQIAuQApeyUtcsVZkc4oA8sa1m255NDvRGY=;
        b=OjC+HmNVeq83EYEleK6dKq925fVR4RGJCsfHQJbb2HqdWhl3B6LoHbTUBUgnZFjFX2
         Y6PesoTsjAv8MvFRA+ABi3Fl6KvCs4T0s1cVSPpiFcYUucK0aY59DF4eANTo3UwcWzuh
         gMnq8mpqpGRazOqam+aIoMy7gae2Y6JRJs6gSEcrmfZnAwlX8rQYHwc5znwIP0bwXWS8
         f+GQ31ETL1Ykdv3JSuXJUPYDkUQooIIQxyt0cYqWXQB49z85z54SLZA2j2TSvhQJDLth
         NfKg74JIafzvE8PiSvDjLiLXbDp7jf9mdi1vAl3rVEYnMV0ZTG4TmKFEZP6h+EF1QYk0
         IU+w==
X-Gm-Message-State: AFqh2kovMH5/B4urb5CUzImZ4oaq9/S145/wcebi+6HYB3cVZsDy0fYc
        GJsBEmz2c9VGBRLbzbsXmP3rpA==
X-Google-Smtp-Source: AMrXdXvw6E/fLU4LrJLmKH1UOGgO5Vz2JoGtDvSOIeozEguWKgqjDyaSOskWVkAo7gkJ+8gN9Au1Qw==
X-Received: by 2002:a5d:4008:0:b0:242:7214:55e4 with SMTP id n8-20020a5d4008000000b00242721455e4mr13903988wrp.46.1672173950914;
        Tue, 27 Dec 2022 12:45:50 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000181100b002422202fa7fsm13337571wrh.39.2022.12.27.12.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 12:45:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
Date:   Tue, 27 Dec 2022 22:45:28 +0200
Message-Id: <20221227204528.1899863-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227204528.1899863-1-abel.vesa@linaro.org>
References: <20221227204528.1899863-1-abel.vesa@linaro.org>
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

By adding the newly added clk_sync_state_disable_unused as sync_state
callback to all sdm845 clock providers, we make sure that no clock
belonging to these providers gets disabled on clk_disable_unused,
but rather they are disabled on sync_state, when it is safe, since
all the consumers build as modules have had their chance of enabling
their own clocks.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---

Changes since v2:
 * None

 drivers/clk/qcom/camcc-sdm845.c  | 1 +
 drivers/clk/qcom/dispcc-sdm845.c | 1 +
 drivers/clk/qcom/gcc-sdm845.c    | 1 +
 drivers/clk/qcom/gpucc-sdm845.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sdm845.c b/drivers/clk/qcom/camcc-sdm845.c
index 27d44188a7ab..e5aeb832e47b 100644
--- a/drivers/clk/qcom/camcc-sdm845.c
+++ b/drivers/clk/qcom/camcc-sdm845.c
@@ -1743,6 +1743,7 @@ static struct platform_driver cam_cc_sdm845_driver = {
 	.driver	= {
 		.name = "sdm845-camcc",
 		.of_match_table = cam_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 735adfefc379..1810d58bad09 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -869,6 +869,7 @@ static struct platform_driver disp_cc_sdm845_driver = {
 	.driver		= {
 		.name	= "disp_cc-sdm845",
 		.of_match_table = disp_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 6af08e0ca847..0ff05af515c4 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -4020,6 +4020,7 @@ static struct platform_driver gcc_sdm845_driver = {
 	.driver		= {
 		.name	= "gcc-sdm845",
 		.of_match_table = gcc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
diff --git a/drivers/clk/qcom/gpucc-sdm845.c b/drivers/clk/qcom/gpucc-sdm845.c
index 110b54401bc6..622a54a67d32 100644
--- a/drivers/clk/qcom/gpucc-sdm845.c
+++ b/drivers/clk/qcom/gpucc-sdm845.c
@@ -205,6 +205,7 @@ static struct platform_driver gpu_cc_sdm845_driver = {
 	.driver = {
 		.name = "sdm845-gpucc",
 		.of_match_table = gpu_cc_sdm845_match_table,
+		.sync_state = clk_sync_state_disable_unused,
 	},
 };
 
-- 
2.34.1

