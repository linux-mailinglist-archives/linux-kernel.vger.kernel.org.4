Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE067335CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjFPQTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbjFPQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:18:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3994EF6;
        Fri, 16 Jun 2023 09:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9297961479;
        Fri, 16 Jun 2023 16:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D17C433C0;
        Fri, 16 Jun 2023 16:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686932169;
        bh=V6jMrEt+FXDoE/Ml8OcTXnxM+sj50uwyqWWQ98+Wug8=;
        h=From:To:Cc:Subject:Date:From;
        b=el0IlpyAFVeltCcnsKIGmQaegZOmK7k1IBfPrcVInRdLQwK9umuSEBRwNaoMFbzGa
         hvYURaDEE68HtVWCyNYu5DIMS3jQPu1Q0NhjTJnB/wjfWulslj1iA2R24lZAqHE3jE
         bRSicMCbr4ljoMRUlXRCEzA2WF41GpV2HUKva3mcrnbNalf3FFDwQqgWypkPVZ57ba
         Mx3xq30xQTtt+8bviOkzIz541V0H12kOzDtN4ovGDCMtGFJ1XzIAkYPdD2JYJnVY+7
         eZGab1DZ49tOOOe6KWEM056OqWQ9U830G4TJjhzGzrMmRntXFH+UK2TJu0UeZmSQsb
         60Cz8lUj8Seew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Prathamesh Shete <pshete@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: tegra: avoid duplicate field initializers
Date:   Fri, 16 Jun 2023 18:15:55 +0200
Message-Id: <20230616161603.1127687-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The drv_reg field is initialized both in the DRV_PINGROUP_ENTRY_N/DRV_PINGROUP_ENTRY_Y
macros and in DRV_PINGROUP_Y. Since each pingroup expands both macros, the are
always duplicate and turning on -Woverride-init (which is disabled by default)
causes a huge amount of warnings like:

drivers/pinctrl/tegra/pinctrl-tegra234.c:1384:27: error: initialized field overwritten [-Werror=override-init]
 1384 | #define DRV_PINGROUP_Y(r) ((r))
      |                           ^
drivers/pinctrl/tegra/pinctrl-tegra234.c:1397:28: note: in expansion of macro 'DRV_PINGROUP_Y'
 1397 |                 .drv_reg = DRV_PINGROUP_Y(r),                   \
      |                            ^~~~~~~~~~~~~~
drivers/pinctrl/tegra/pinctrl-tegra234.c:1447:49: note: in expansion of macro 'DRV_PINGROUP_ENTRY_Y'
 1447 | #define drive_soc_gpio08_pb0                    DRV_PINGROUP_ENTRY_Y(0x500c,    12,     5,      20,     5,      -1,     -1,     -1,     -1,     0)
      |                                                 ^~~~~~~~~~~~~~~~~~~~
...

Remove the intialization that is never used here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/tegra/pinctrl-tegra234.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra234.c b/drivers/pinctrl/tegra/pinctrl-tegra234.c
index fd70725392162..86c2b84e792d9 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra234.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra234.c
@@ -1442,7 +1442,6 @@ static const char * const tegra234_functions[] = {
 		.schmitt_bit = schmitt_b,			\
 		.drvtype_bit = 13,				\
 		.lpdr_bit = e_lpdr,				\
-		.drv_reg = -1,					\
 
 /* main drive pin groups */
 #define	drive_soc_gpio08_pb0			DRV_PINGROUP_ENTRY_Y(0x500c,	12,	5,	20,	5,	-1,	-1,	-1,	-1,	0)
-- 
2.39.2

