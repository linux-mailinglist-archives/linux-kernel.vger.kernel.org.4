Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87EF66E457
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjAQRCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjAQRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:02:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B054393E;
        Tue, 17 Jan 2023 09:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 332106149A;
        Tue, 17 Jan 2023 17:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C67C433D2;
        Tue, 17 Jan 2023 17:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974943;
        bh=J0fMJMgzFoKpVLn+Krs4tXYA63OB6Vo+2PIw/pLLrAw=;
        h=From:To:Cc:Subject:Date:From;
        b=gOsZkyAXeNghzO5zL4f/bDsyewx6FbmWk5rvXdLOEvJkEUJaBmQMKy1khkUUIVTd4
         Oc8m/RR2SuwRihhHcJet6Uy8cU68N/+HUee3bnWhhDZ+GjHvetErRgX8k/owV3j5UI
         T6jdml3rFZOoNe8lxzrVWZB36P4QQhG/IH/tgmTm9Tv0wLcufmxJT0pef5l4Wf0YPu
         BH5mkjJcg6S+bTjTcVSuGZxUJVeaZYCvLUm0XD6WzavhBHvpQlBcd7k53bTvn942x3
         xmxN5nA1eQS4jOoFd9iUHAy7oyixABvFmzEt65DPZIjUMJbr30gpEKLEbyhCg6oXoE
         zbHPWi3bP2I+Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: rpmh: remove duplicate IPA clock reference
Date:   Tue, 17 Jan 2023 18:02:09 +0100
Message-Id: <20230117170217.2462320-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

One of the ones that were recently added was already there:

drivers/clk/qcom/clk-rpmh.c:578:35: error: initialized field overwritten [-Werror=override-init]
  578 |         [RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,

Fixes: aa055bf158cd ("clk: qcom: rpmh: define IPA clocks where required")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/qcom/clk-rpmh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 393b83f6020e..45ee370f3307 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -575,7 +575,6 @@ static struct clk_hw *sc8280xp_rpmh_clocks[] = {
 	[RPMH_IPA_CLK]          = &clk_rpmh_ipa.hw,
 	[RPMH_PKA_CLK]          = &clk_rpmh_pka.hw,
 	[RPMH_HWKM_CLK]         = &clk_rpmh_hwkm.hw,
-	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sc8280xp = {
-- 
2.39.0

