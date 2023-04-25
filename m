Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F76EDED5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjDYJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjDYJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:13:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1A2685
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:13:08 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so53955081fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1682413987; x=1685005987;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l34Q+7TdUCHFwbLdB27KGTRN9LF/0aSi+VbSXHJLpqE=;
        b=cjnTowehqiW/x4BS0rjz22+E9nzNksVfF4S48Snabpr+X9sljqjNwKeOWzGJJjJqxe
         W9759yVOcEIQ647iflQ8e6bhCVdLhhRwTyIdisYM4NNrkEtmad1x4ZWFpXcW6OKwsWGz
         BcQQ7d2Uo0mWywERSslNdZnadiAgUmsQjjCvJnItuFmunD1gMuzn746g9clXH+ePgPfu
         8TzQuSjxHNuyO597w7tNd+lUnAfv0vzOqnSSeXpU9/5PUmyZ0KcY499gMJs8GoWD1Xen
         6yqjuEwQNgaMkTTn2uPCA+P+EVkNF+qFVcx6gQVJ2Spj7hsGV8Xe8tssSL1UlpNe+Iwm
         Gg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682413987; x=1685005987;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l34Q+7TdUCHFwbLdB27KGTRN9LF/0aSi+VbSXHJLpqE=;
        b=bqkqKSgBflvqNoUFlDfRoWmSouQLwMGKth4gJXLueOOMAVXkktDoUZO3LkpiiVIxCj
         eV9/8mgSsLMCJgYJAkpimsLTWJQXkTRpt2L3R+OYOGhi19QNyGwbt3l4MeqiwxrgRMDG
         NL50LW7l4YjJ/ZQs9OckDCrNqrkwse1Rb0ueXqWapMggcnl9GfHdVOtwj8/yCuwxgv5r
         o2Yvdl485drLWA3gCvJdGRvWxck5M7AJ4rdUpgsKbeM5G6WdHAdgJRn9onfUfiaejtRy
         X21G9qtG1he08y5iUJ2iIzG+Y4r4oxo9i6tN1cRGbRqLciqLKX4BZCLBxlXKnC6VPIXn
         BOwg==
X-Gm-Message-State: AAQBX9fILlMsfEs2+ejFII5xb0ZcVJtKu29jkDBKVZu5LkU7ecTQ1AlC
        dbWytk6rLxvXgdL5ODEym2R8MA==
X-Google-Smtp-Source: AKy350ZYa7GYt+xP5M/MDlFGHK3ZRW7Y1PZkiYgrLxdKzUYBUzVs5ysrvz2PZX1oIKpmn2Q+Z+qs+w==
X-Received: by 2002:a2e:9b95:0:b0:290:6e01:8d0b with SMTP id z21-20020a2e9b95000000b002906e018d0bmr2773202lji.26.1682413986874;
        Tue, 25 Apr 2023 02:13:06 -0700 (PDT)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id r22-20020a2eb616000000b0029ab1f2b196sm2027792ljn.24.2023.04.25.02.13.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2023 02:13:06 -0700 (PDT)
From:   Mantas Pucka <mantas@8devices.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mantas Pucka <mantas@8devices.com>
Subject: [PATCH v2] clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks
Date:   Tue, 25 Apr 2023 12:11:49 +0300
Message-Id: <1682413909-24927-1-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDCC clocks must be rounded down to avoid overclocking the controller.

Fixes: d9db07f088af ("clk: qcom: Add ipq6018 Global Clock Controller support")
Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
v2: remove unnecessary newline in commit message

 drivers/clk/qcom/gcc-ipq6018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 3f9c2f61a5d9..5c5d1b04ea7a 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -1654,7 +1654,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_data = gcc_xo_gpll0_gpll2_gpll0_out_main_div2,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
2.7.4

