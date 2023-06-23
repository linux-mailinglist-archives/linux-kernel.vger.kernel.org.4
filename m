Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F73173BB8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFWPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjFWPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444319B;
        Fri, 23 Jun 2023 08:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A775761A87;
        Fri, 23 Jun 2023 15:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD60C433C0;
        Fri, 23 Jun 2023 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533806;
        bh=6tFbzhaBjmMoKkG1CNrCXK+CWNwGbleX71IfZSZAiRQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mDEZWbDgdq4hMs2Z9jt15TcgjRbUQiak6kDW7/sDpz1hUykHwK4yFRVHb8XXp6T2U
         ce3AcuUDeo4JGbomgkEqmbOvufUqNXyZxgNQNbTdQI5cpffJae8QEhZ7Hzx0m+w4uj
         eunRKNh3i1N+O/ugxP03zzduODf/mgqaf2/jbpakUccSSKzbEtaECmCdKmI1rYNKOq
         3ZctNYWyNmGJj3Xb4+5ZvTvknnYPl8OG4O0yQ9q284fsyMio13ObzjE5InpVP0uyFQ
         QR4zMlZpyRjNvTocgOiyBcGvw1YZ84AOnn7cm5RkbGbbJVdWzok9eEPN4xhmWOVxO8
         C15PaBm99di3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: [PATCH] media: tc358746: select CONFIG_GENERIC_PHY
Date:   Fri, 23 Jun 2023 17:23:09 +0200
Message-Id: <20230623152318.2276816-1-arnd@kernel.org>
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

The tc358746 driver selects CONFIG_GENERIC_PHY_MIPI_DPHY and links to
that, but this fails when CONFIG_GENERIC_PHY is disabled, because Kbuild
then never enters the drivers/phy directory for building object files:

ERROR: modpost: "phy_mipi_dphy_get_default_config_for_hsclk" [drivers/media/i2c/tc358746.ko] undefined!

Add an explicit 'select GENERIC_PHY' here to ensure that the directory
is entered, and add another dependency on that symbol so make it
more obvious what is going on if another driver has the same problem,
as this will produce a Kconfig warning.

Fixes: 80a21da360516 ("media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/Kconfig | 1 +
 drivers/phy/Kconfig       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index cf675ac4b1326..226454b6a90dd 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -1305,6 +1305,7 @@ config VIDEO_TC358746
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
 	select V4L2_FWNODE
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	select REGMAP_I2C
 	help
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index f46e3148d286d..8dba9596408f2 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -18,6 +18,7 @@ config GENERIC_PHY
 
 config GENERIC_PHY_MIPI_DPHY
 	bool
+	depends on GENERIC_PHY
 	help
 	  Generic MIPI D-PHY support.
 
-- 
2.39.2

