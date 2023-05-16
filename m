Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882F7057D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEPTrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjEPTrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:47:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05751BE6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8480163DB9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82409C433D2;
        Tue, 16 May 2023 19:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266445;
        bh=WJ7zJ8wKo3Z+xOwBRYH0RqKqN+ywQ2CmZE2kNKIwXgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScBp9XTf1mm/fEQERYAAs/zBoK/nbDJ0uqqFSmni2XihRGPIdvbwY3lfhG/YoV7Wk
         J5ctZDxpFI4vdvE84yROlQOdZt++NmUbf0ePCEcq3gAf4W0ER+QCu1TjjKdJMg8zwy
         XzcERynrFL0aWUV/od/4XdAGFFJAP1P/a3abFTGixVQcJ33obSRvsNIjuk5Dh9YzUq
         XlqokYWCIuxrYW2FM0CBvyrojG4GVxKaasDcH4rVYv3DL3b4MDus35EXkiWnSsy/9o
         GadEdoq7H/lLC2q01zg2HgZH0AXVtKEimojnWjMKwIvD36ya3ynPySjY3QcVIeXoGG
         XJY5mD3O5V5rQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mdio_bus: unhide mdio_bus_init prototype
Date:   Tue, 16 May 2023 21:45:36 +0200
Message-Id: <20230516194625.549249-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516194625.549249-1-arnd@kernel.org>
References: <20230516194625.549249-1-arnd@kernel.org>
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

mdio_bus_init() is either used as a local module_init() entry,
or it gets called in phy_device.c. In the former case, there
is no declaration, which causes a warning:

drivers/net/phy/mdio_bus.c:1371:12: error: no previous prototype for 'mdio_bus_init' [-Werror=missing-prototypes]

Remove the #ifdef around the declaration to avoid the warning..

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index c5a0dc829714..6478838405a0 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1900,10 +1900,8 @@ void phy_package_leave(struct phy_device *phydev);
 int devm_phy_package_join(struct device *dev, struct phy_device *phydev,
 			  int addr, size_t priv_size);
 
-#if IS_ENABLED(CONFIG_PHYLIB)
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
-#endif
 
 int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
 int phy_ethtool_get_sset_count(struct phy_device *phydev);
-- 
2.39.2

