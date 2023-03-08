Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE046B1356
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCHUr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCHUrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:47:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576F234EF;
        Wed,  8 Mar 2023 12:47:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF25618C4;
        Wed,  8 Mar 2023 20:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F7EC433D2;
        Wed,  8 Mar 2023 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678308442;
        bh=6E1H2Z/E8dY9nZuxGrA6Q8VG9UE5a8kZIkR58SCgZT8=;
        h=From:Date:Subject:To:Cc:From;
        b=lHO2gpSSg/evJCiJhdwipU4Xzs14heHT0s+FrOC/gnGSAQP1/8pIcWAn/ICVHH8cH
         O9nAZD88jK9xnqtE6oGBlfqrlzbjIgFGqfMWQjRTRPXg8uoSyUNAeVbvaVFfXwb9lF
         hVGNlywVke0QNxKdIoWSvbYG+aJsqqFlB9lAgNVaoxeXsZ0iInvklpOA2hMjrKlGuR
         1+M3vEDziMz9L7bVxrSfzlxsnZS0ddwslZPTDK+03dRwm3JTxLLqdTdcKMpFUxMGk5
         H4x+0BK5jtzTQQAyF8qxt7VgkKfvrvICYOE2Y3JOtnrl5eQVFo5qUMTdLBRg0q9x6d
         QjzlwUcZR+FoA==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 08 Mar 2023 13:47:11 -0700
Subject: [PATCH] clk: Avoid invalid function names in CLK_OF_DECLARE()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-clk_of_declare-fix-v1-1-317b741e2532@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE70CGQC/x2N3QrCMAxGX2Xk2kBt/dl8FZGRdqkLzk4SEWHs3
 e28PJzv8C1grMIGl2YB5Y+YzKXCftdAGqncGWWoDN754IJrMU2Pfs79wGkiZczyxUOObXc+HTs
 fGGoYyRijUknjlj7J3qybeCnX/f/telvXHwkqWOd9AAAA
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     linus.walleij@linaro.org, saravanak@google.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131; i=nathan@kernel.org;
 h=from:subject:message-id; bh=6E1H2Z/E8dY9nZuxGrA6Q8VG9UE5a8kZIkR58SCgZT8=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCkcX6JurS44elNhesQF177P12buWz7pzS4f2UlRdYWME
 8zd2mTfdZSyMIhxMMiKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJcL5lZDjRzvvp0KELkotc
 583n/241ofjNzYbvLRKqlgtffP51rW4/w/+Y1YG2fW8irLLsz9cdWjlvRsVH9mv2p7at5988b9H
 eJVf4AA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit c28cd1f3433c ("clk: Mark a fwnode as initialized when using
CLK_OF_DECLARE() macro"), drivers/clk/mvebu/kirkwood.c fails to build:

 drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
 CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
 ^
 include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF_DECLARE'
         static void __init name##_of_clk_init_declare(struct device_node *np) \
                            ^
 <scratch space>:124:1: note: expanded from here
 98dx1135_clk_of_clk_init_declare
 ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^
 drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal constant
 include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF_DECLARE'
         OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
                                         ^
 <scratch space>:125:3: note: expanded from here
 98dx1135_clk_of_clk_init_declare
   ^

C function names must start with either an alphabetic letter or an
underscore. To avoid generating invalid function names from clock names,
add two underscores to the beginning of the identifier.

Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro")
Suggested-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/clk-provider.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c9f5276006a0..6f3175f0678a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1364,12 +1364,12 @@ struct clk_hw_onecell_data {
 };
 
 #define CLK_OF_DECLARE(name, compat, fn) \
-	static void __init name##_of_clk_init_declare(struct device_node *np) \
+	static void __init __##name##_of_clk_init_declare(struct device_node *np) \
 	{								\
 		fn(np);							\
 		fwnode_dev_initialized(of_fwnode_handle(np), true);	\
 	}								\
-	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
+	OF_DECLARE_1(clk, name, compat, __##name##_of_clk_init_declare)
 
 /*
  * Use this macro when you have a driver that requires two initialization

---
base-commit: 89dc65a7cc8a119c395c0931b12d7a514f9d2bcc
change-id: 20230308-clk_of_declare-fix-4fb89765923e

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

