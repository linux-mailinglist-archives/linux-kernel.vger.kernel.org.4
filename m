Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43786BB489
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjCONYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjCONXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:23:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36876078
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so16255425edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678886622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnW0CMrrRD3o9YvTtj/2PZfd1w3APSitkBSkSzkAq3A=;
        b=cIoenhYmTDDKZ0euB2ODKr3LotX4ppL2RTmY7rx4LHYybPdccQrPSTr+zjPffclIwD
         k+6Q4fDW3EAwNRRuFsbyhhImD8R3omHYItX05zQqnwsqlABoIOICjL/Cf/X9pC4J8Wjv
         HZj1lO/Nsh2knHgaHr7f2V67UlTJVZWVAoynksoC9l8EeKEowzrk0pY+o+vQHm3IeQnm
         PvdZtWTxW3F3JCNkpG+rgvq0x8m1XaGQ7HaEivuI/+dOvcEeU3nYVP0i9mtPnqsRSVM6
         X1N4cWtUjSaXy2FJCd1/duAtLA7rV8DmP43e1rCd0jFSF52WSdUK/eikCZgXZ0TRFum3
         eCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnW0CMrrRD3o9YvTtj/2PZfd1w3APSitkBSkSzkAq3A=;
        b=NlZOEt1rLgxVR1LCQDv0fU78EjpchIegKV43FCMaL98ZYuGqGHvSS56K7/zM34pZE/
         YPELBt1xL+3s1N8T7uYE3wOa3VIonpwynhd0XtIUCSxVI4q7X6wZrlC8ReThyT2Smh0X
         IU6am7EIGWHx1R1KVJpxdydMrK/IsM8ax3UdstNEzV6UHTltuyNaDSBdqLsIuxZXJiP9
         JG19NJYyBMegrh54aaTFGekKSMkNQ1SahbBOxycyh5fVNOYQTcx3ffhnq8MxNnD1AdQj
         B9WT9ciCnlEiDoxqAqdtusqJ3fgP3EfNMIDafR3TkkvW+wL2DUYevBv4HhoP2/39iMA4
         dJiw==
X-Gm-Message-State: AO0yUKWZJMyFuC/zQZd/78lG1S/KRcXqu4sltO8qijF0ngMmbyQROX1c
        1Potf9iBRD4T9VmJDzEa5Ei2Dg==
X-Google-Smtp-Source: AK7set+W+V2K+JVgObXv7PEO2bdA92Y2AmBplxjf8AwC8skNcxMQIt1ZNpm4fZzwq+uDEYAYCDcLJQ==
X-Received: by 2002:a17:906:dff5:b0:8b1:3193:4874 with SMTP id lc21-20020a170906dff500b008b131934874mr5703584ejc.46.1678886622632;
        Wed, 15 Mar 2023 06:23:42 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id pj18-20020a170906d79200b008b133f9b33dsm2497365ejb.169.2023.03.15.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:23:42 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [RFC PATCH 5/5] clk: qcom: Add sync state callback to all SM8450 providers
Date:   Wed, 15 Mar 2023 15:23:30 +0200
Message-Id: <20230315132330.450877-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315132330.450877-1-abel.vesa@linaro.org>
References: <20230315132330.450877-1-abel.vesa@linaro.org>
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

Now that we have support for sync state delayed disabling of unused
power domains and a provided generic gdsc sync state callback, add it to
all the providers related to the SM8450 platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/camcc-sm8450.c  | 1 +
 drivers/clk/qcom/dispcc-sm8450.c | 1 +
 drivers/clk/qcom/gcc-sm8450.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sm8450.c b/drivers/clk/qcom/camcc-sm8450.c
index 51338a2884d2..6ae360898aee 100644
--- a/drivers/clk/qcom/camcc-sm8450.c
+++ b/drivers/clk/qcom/camcc-sm8450.c
@@ -2847,6 +2847,7 @@ static struct platform_driver cam_cc_sm8450_driver = {
 	.driver = {
 		.name = "camcc-sm8450",
 		.of_match_table = cam_cc_sm8450_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index adbfd30bfc96..45f4ea3d26bc 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -1803,6 +1803,7 @@ static struct platform_driver disp_cc_sm8450_driver = {
 	.driver = {
 		.name = "disp_cc-sm8450",
 		.of_match_table = disp_cc_sm8450_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
index 84764cc3db4f..f2b542753553 100644
--- a/drivers/clk/qcom/gcc-sm8450.c
+++ b/drivers/clk/qcom/gcc-sm8450.c
@@ -3262,6 +3262,7 @@ static struct platform_driver gcc_sm8450_driver = {
 	.driver = {
 		.name = "gcc-sm8450",
 		.of_match_table = gcc_sm8450_match_table,
+		.sync_state = gdsc_sync_state,
 	},
 };
 
-- 
2.34.1

