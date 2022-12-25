Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CA5655DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiLYQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiLYQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:47:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE092679
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:47:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so9320718wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IysiqGhcAWvth9Fs82ZOVpj2oIBJKpLWqo2AlytJcCY=;
        b=d7E6ulsE2Z9rbTgYlZvmF/fIIy8FXGkmbNVF79cngXagX8AtuJa+3n6kHWn5D4FmZK
         ArDEXYwGSY1rSYY/uaW7cbwSmGg9aqQV+JUzZr+Hh0UP3tU1rL3PEfV7FPkOOsBfnNsc
         0YuUaH/NcagzNHwaZAHRIkSnLhery3ovncF5FYer1xNzP6D4ScKeGsrPPWcs7zhLQ5bm
         9W538DXa55Ng05upr/yZ5u1wAoG38DInQbOz5vMQ+l2JvYrA7LAegAhTC/+XfFgHlNtu
         7libcCW2qXC+5tKunIr1a8vIn4z6TNyQRjJpizKtBlwKtaqB29VA1zQ9hGBVk/NfiIko
         pxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IysiqGhcAWvth9Fs82ZOVpj2oIBJKpLWqo2AlytJcCY=;
        b=qtUH9mg3r8zUiSLb2Wyg5iIRW7HDfbbbwfW6K602rdjLmOqmydI1R+Y33qUiNUuDS+
         JdDdrp5tcYnYdKZtBI/JLyZJYXPb4oCBnmsfN9XUYHEVcRWQliT6FMjWZ6J8riUWausB
         xifS8ktF3QoAIA18SAGmX7ioB62bOwJGIt4bEc6nh4YBA4QCLbGGHCBiFkOvM2QtU8ui
         72X6n0VJIxyf0oAZz58fI+5q8TtUr1zmXzF2awYkxRKkgsAoAip9gRm5D4apRFDD/cII
         mcK3daBgwWXrUNNJSGWld54+TMG/rWraw/pjJ3j+Y+bTqhiAWCbQtqf+2MzjWsAUwOmp
         ZA9A==
X-Gm-Message-State: AFqh2kpP0gYBCYuJRpNFblGCJqqIoqyfh6T4VS7Fk9zZT6H9r7EZUoil
        tK4OVSWyHZ+O4C7KTSitZUsPHAEyOFQzAZUL
X-Google-Smtp-Source: AMrXdXv4mqxLWm+0qAs6B/nkLxlKRdsM23EFmLmxjrfIntdt78pszigJRdAMeWBQVE1pIRL0/5veRw==
X-Received: by 2002:a05:600c:4d21:b0:3d2:2a72:2573 with SMTP id u33-20020a05600c4d2100b003d22a722573mr11496316wmp.11.1671986831688;
        Sun, 25 Dec 2022 08:47:11 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003d973d4fb28sm5507545wms.4.2022.12.25.08.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:47:11 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] clk: qcom: sdm845: Use generic clk_sync_state_disable_unused callback
Date:   Sun, 25 Dec 2022 18:47:05 +0200
Message-Id: <20221225164705.437944-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225164705.437944-1-abel.vesa@linaro.org>
References: <20221225164705.437944-1-abel.vesa@linaro.org>
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

By adding the newly added clk_sync_state_disable_unused as sync_state
callback to all sdm845 clock providers, we make sure that no clock
belonging to these providers gets disabled on clk_disable_unused,
but rather they are disabled on sync_state, when it is safe, since
all the consumers build as modules have had their chance of enabling
their own clocks.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
---

Changes since v1:
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

