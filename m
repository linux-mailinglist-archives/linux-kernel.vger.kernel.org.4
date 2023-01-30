Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F4680FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbjA3N4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjA3N4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:56:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7AD2687E;
        Mon, 30 Jan 2023 05:55:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DDCF6101C;
        Mon, 30 Jan 2023 13:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8874CC4339C;
        Mon, 30 Jan 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675086958;
        bh=y9yaGsBJyJnk9oOg0t489VBVoCspVBbyGiGa10xF4ZU=;
        h=From:To:Cc:Subject:Date:From;
        b=MEFZHE/+zj2CX02jrHkKpx3xI1YHnoZr4JZvoAtDMyDoAkGgKQO4y6B3EWs0Zitv8
         +uKiEZWC6eA8IvK2ikXYV5otfCB81UBXNDhm9UPLyIv1olC+8GVDcSxwkSzTVKMuM1
         rne9EotNzLGaRG1XhoYu46ZcU76iLqJQcqWp35bOnNpEFHUof9+fe5fGoQbA70wF0I
         fAPPaM/xnKJd0zAEwACeAJhYWE9VUfLC/sip+2NVBXMuqgwzqTAZDvJ6U6rGm4K6HQ
         gVoLILg19QdJu9BN9asKE7SdJuix967deniquLrBS2U4EkcwrWiyNoNfviprFZxwS2
         CG+6xdR5vM5yw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-qcs404: fix duplicate initializer warning
Date:   Mon, 30 Jan 2023 14:55:47 +0100
Message-Id: <20230130135555.3268172-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

In one of the clocks, a redundant initialization for .num_parents
got left behind by a recent patch:

drivers/clk/qcom/gcc-qcs404.c:63:32: error: initialized field overwritten [-Werror=override-init]
   63 |                 .num_parents = 1,
      |                                ^

Fixes: 2ce81afa0c7c ("clk: qcom: gcc-qcs404: sort out the cxo clock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/qcom/gcc-qcs404.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index 5f58dd82d3fe..a39c4990b29d 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -60,7 +60,6 @@ static struct clk_fixed_factor cxo = {
 		.name = "cxo",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.num_parents = 1,
 		.ops = &clk_fixed_factor_ops,
 	},
 };
-- 
2.39.0

