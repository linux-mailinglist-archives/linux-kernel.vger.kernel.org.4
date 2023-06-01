Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278F971F4CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjFAVed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjFAVeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3E19B;
        Thu,  1 Jun 2023 14:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340C8649ED;
        Thu,  1 Jun 2023 21:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ACCC433EF;
        Thu,  1 Jun 2023 21:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655262;
        bh=JaawEy6UWWYzmcaegnIYS0KJ7XgSuoVg+Fttrdrlbrk=;
        h=From:To:Cc:Subject:Date:From;
        b=RhL49pjguuM0U8HHZyTiLBHqUMvtYDzUdanUcH9iNwRPLDAGKA7+SYxq6SDacDX4w
         ZrO+yPiThRxfNO4Z/owuCVEZmW+Y6ARc1cql5e3zWu8fer5EN+5UAswmvNBoQuISIt
         zmHjKDvDqYOVzgC1Q9oOHKCwNdEY14X54U45TdzyKN15b+W0thDhPR3jYEP2y89DZK
         oMscPf/6HOIv9d6MOk5eX3clahsERIaaG2czNefxq/kGJELssDMjCt/1F/nXGaMOh0
         KUdoCnxvO98VJUUGvEoRHmAyxyM2nnoW5gh/mu9m2zo2ZZfrV/eWAvTVP9Znplr/SU
         PmCzKalqb8ilA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mantas Pucka <mantas@8devices.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-ipq6018: remove duplicate initializers
Date:   Thu,  1 Jun 2023 23:34:12 +0200
Message-Id: <20230601213416.3373599-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent change added new initializers for .config_ctl_val and
.config_ctl_hi_val but left the old values in place:

drivers/clk/qcom/gcc-ipq6018.c:4155:27: error: initialized field overwritten [-Werror=override-init]
 4155 |         .config_ctl_val = 0x240d4828,
      |                           ^~~~~~~~~~
drivers/clk/qcom/gcc-ipq6018.c:4156:30: error: initialized field overwritten [-Werror=override-init]
 4156 |         .config_ctl_hi_val = 0x6,
      |                              ^~~

Remove the unused ones now to avoid confusion.

Fixes: f4f0c8acee0e4 ("clk: qcom: gcc-ipq6018: update UBI32 PLL")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/qcom/gcc-ipq6018.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
index 48f9bff7c80fb..86b43175b0422 100644
--- a/drivers/clk/qcom/gcc-ipq6018.c
+++ b/drivers/clk/qcom/gcc-ipq6018.c
@@ -4150,8 +4150,6 @@ static struct clk_branch gcc_dcc_clk = {
 static const struct alpha_pll_config ubi32_pll_config = {
 	.l = 0x3e,
 	.alpha = 0x6667,
-	.config_ctl_val = 0x240d6aa8,
-	.config_ctl_hi_val = 0x3c2,
 	.config_ctl_val = 0x240d4828,
 	.config_ctl_hi_val = 0x6,
 	.main_output_mask = BIT(0),
-- 
2.39.2

