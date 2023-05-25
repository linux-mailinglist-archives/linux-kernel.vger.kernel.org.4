Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAFD7116CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjEYS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243217AbjEYSy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37821BE2;
        Thu, 25 May 2023 11:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F15960C57;
        Thu, 25 May 2023 18:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F2C4339C;
        Thu, 25 May 2023 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040232;
        bh=XfcKkZtxKstYYKPK9PwLNRnvqhJBvVMhgNGhqJjmmCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6p3dJ7YLnk337oIEBkfBYFuqHYQmFPiK+9/K23ywRlh7DJWp/LFNZRN3EDDdf90W
         FEz/5Tlux6ptv+ZrUZPzBri4uT4jOKF6/cMo3Dao+rCVrZqnKa/nXhmpX4l0y1RVZC
         1FCLHHtunEpRayAw/9DIkmctZ46+4xU0UCpYp5STDKga7U8JD1f7TeD+CAiOW5QT7Y
         BtHc3No3FOGcfKLedGPC/IN7g/WX8CVexmPUzRHnASdwubhQjUKJJZUERaRsP54+i1
         ezqwHtVD6+sWIFlXgJsB9Y2WA8vnmaK4H3s/QkcIySmM0rurAPD5w6SnzXipWXAHrR
         KXJsPMR2F8Vkg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, andrew@lunn.ch,
        hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 27/27] mdio_bus: unhide mdio_bus_init prototype
Date:   Thu, 25 May 2023 14:42:36 -0400
Message-Id: <20230525184238.1943072-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

[ Upstream commit 2e9f8ab68f42b059e80db71266c1675c07c664bd ]

mdio_bus_init() is either used as a local module_init() entry,
or it gets called in phy_device.c. In the former case, there
is no declaration, which causes a warning:

drivers/net/phy/mdio_bus.c:1371:12: error: no previous prototype for 'mdio_bus_init' [-Werror=missing-prototypes]

Remove the #ifdef around the declaration to avoid the warning..

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230516194625.549249-4-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/phy.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 80750783b5b0a..f0b4197cfe39c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1192,10 +1192,8 @@ int phy_ethtool_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd);
 int phy_ethtool_nway_reset(struct net_device *ndev);
 
-#if IS_ENABLED(CONFIG_PHYLIB)
 int __init mdio_bus_init(void);
 void mdio_bus_exit(void);
-#endif
 
 /* Inline function for use within net/core/ethtool.c (built-in) */
 static inline int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data)
-- 
2.39.2

