Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782216B4261
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjCJOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCJOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:02:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFD31165F7;
        Fri, 10 Mar 2023 06:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 759EA617D5;
        Fri, 10 Mar 2023 14:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF695C433A4;
        Fri, 10 Mar 2023 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456943;
        bh=ErYVAbLVamYNt3qQNBRsX1S2V8QgsRXls6t6ttuYrlY=;
        h=From:To:Cc:Subject:Date:From;
        b=p4YmYyE6q1EyqUqw/DTav8vWyakg1RfT7xytTEAcSgSFVydDWq5ZVeGXTGKwaH4hz
         PloPMEPQtM16c6yw3gwaOT6DxVHSZznny+MlawvnFsI4Kh5PggNfOFF2+rTvqJLbqm
         NDx6NK+r3Ovis4xS67Evbkt9L6AmWRTuC8eyXBf5WZpWF7/AQ7e6RqhOS9VcM/0f6j
         FaVibUE+BpkdecLpo2wsd7PfuntYdlJ0SQC5Eo4f4TFESxjRrS4WRSBvH21BZ2qCkH
         mOa/PFSu/iF/0wwghTVApq3oLNL5zVcPSLEd2Fgz3ZF2xnWcI8o8JkR3RKTHfC1Z3h
         IQdLi0f6lSVjQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <maxime@cerno.tech>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: avoid build failure on CLK_OF_DECLARE() with invalid name
Date:   Fri, 10 Mar 2023 15:02:04 +0100
Message-Id: <20230310140218.326626-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Generating an init function function from CLK_OF_DECLARE() broke for the
98dx1135_clk declaration because that string starts with a digit and
is not a valid C identifier:

In file included from drivers/clk/mvebu/kirkwood.c:15:
drivers/clk/mvebu/kirkwood.c:358:16: error: invalid suffix "dx1135_clk_of_clk_init_declare" on integer constant
  358 | CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
      |                ^~~~~~~~~~~~
include/linux/clk-provider.h:1367:28: note: in definition of macro 'CLK_OF_DECLARE'
 1367 |         static void __init name##_of_clk_init_declare(struct device_node *np) \
      |                            ^~~~
drivers/clk/mvebu/kirkwood.c:358:16: error: expected identifier or '(' before numeric constant
  358 | CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
      |                ^~~~~~~~~~~~
include/linux/clk-provider.h:1367:28: note: in definition of macro 'CLK_OF_DECLARE'
 1367 |         static void __init name##_of_clk_init_declare(struct device_node *np) \
      |                            ^~~~

This could be fixed in the driver by renaming 98dx1135_clk to a valid
C identifier, but it's easy enough to make the macro more robust by
reversing the two parts of the name, which makes it work for other files
that may have the same issue. Since CLK_OF_DECLARE_DRIVER() has a very
similar definition, do the same change in both.

Fixes: c7296c51ce5d ("clk: core: New macro CLK_OF_DECLARE_DRIVER")
Fixes: c28cd1f3433c ("clk: Mark a fwnode as initialized when using CLK_OF_DECLARE() macro")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/clk-provider.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c9f5276006a0..3586a029db05 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1364,24 +1364,24 @@ struct clk_hw_onecell_data {
 };
 
 #define CLK_OF_DECLARE(name, compat, fn) \
-	static void __init name##_of_clk_init_declare(struct device_node *np) \
+	static void __init of_clk_init_declare##name(struct device_node *np) \
 	{								\
 		fn(np);							\
 		fwnode_dev_initialized(of_fwnode_handle(np), true);	\
 	}								\
-	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
+	OF_DECLARE_1(clk, name, compat, of_clk_init_declare##name)
 
 /*
  * Use this macro when you have a driver that requires two initialization
  * routines, one at of_clk_init(), and one at platform device probe
  */
 #define CLK_OF_DECLARE_DRIVER(name, compat, fn) \
-	static void __init name##_of_clk_init_driver(struct device_node *np) \
+	static void __init of_clk_init_driver##name(struct device_node *np) \
 	{								\
 		of_node_clear_flag(np, OF_POPULATED);			\
 		fn(np);							\
 	}								\
-	OF_DECLARE_1(clk, name, compat, name##_of_clk_init_driver)
+	OF_DECLARE_1(clk, name, compat, of_clk_init_driver##name)
 
 #define CLK_HW_INIT(_name, _parent, _ops, _flags)		\
 	(&(struct clk_init_data) {				\
-- 
2.39.2

