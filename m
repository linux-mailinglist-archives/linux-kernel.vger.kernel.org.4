Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE83734D78
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjFSIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjFSIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:21:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF54196;
        Mon, 19 Jun 2023 01:21:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC9460B61;
        Mon, 19 Jun 2023 08:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F8DC433C0;
        Mon, 19 Jun 2023 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687162869;
        bh=0vMnUhFvqF862nKrVnqmtvKfCO2g8YSrSHAeMLeCpOE=;
        h=From:To:Cc:Subject:Date:From;
        b=Im1oAPjxb88I1OL9rKcUOcX6tQi7vJu2/Qiq+GWFrdcb+UDkWix0qJ7aT1+yjSXBV
         mBjWA6fkl0bA1Xkv0WX8L4zAEUWtzzYOLXumWVILV875h9IVmLyazh6OIkL4Qp/7qX
         jcpCBLPLsMo1HSA+tKXl4vo0SZ58F5uOytSOlq9RSPusP3vLq+EbOsPME1F5RyYN0Y
         05tawIRBKzRUSEcPYP2UVdJ8g97rJdeQgzMJt3Eg883zUGga5tpY70xAV8m5ByA9oR
         n00m/ps70hZxUTVK8sd9s1BWSqBtGkHOurIcyiKtPNumxq8DvDP4fShhGLJzkKL9en
         jXhFFdeK/KdQQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Lee Jones <lee@kernel.org>,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: mlxbf3: remove broken Kconfig 'select'
Date:   Mon, 19 Jun 2023 10:20:50 +0200
Message-Id: <20230619082104.699331-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The new pinctrl driver selects GPIO_MLXBF3, but that can not be enabled yet because
the MELLANOX_PLATFORM symbol does not exist in the tree:

WARNING: unmet direct dependencies detected for GPIO_MLXBF3
  Depends on [n]: GPIOLIB [=y] && PCI [=n] && (MELLANOX_PLATFORM [=n] && ARM64 [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - PINCTRL_MLXBF3 [=y] && PINCTRL [=y] && (MELLANOX_PLATFORM [=n] && ARM64 [=y] || COMPILE_TEST [=y])

As it turns out, the pinctlr driver still builds fine without this, so just
remove the select statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 77ff9a641aebf..57d57af1f624e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -510,7 +510,6 @@ config PINCTRL_MLXBF3
 	select PINMUX
 	select GPIOLIB
 	select GPIOLIB_IRQCHIP
-	select GPIO_MLXBF3
 	help
 	  Say Y to select the pinctrl driver for BlueField-3 SoCs.
 	  This pin controller allows selecting the mux function for
-- 
2.39.2

