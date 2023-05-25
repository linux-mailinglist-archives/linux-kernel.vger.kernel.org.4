Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD36711610
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243385AbjEYSuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242708AbjEYSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AF1709;
        Thu, 25 May 2023 11:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B6F63A0B;
        Thu, 25 May 2023 18:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A6C433A1;
        Thu, 25 May 2023 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040155;
        bh=GWWCsIKjGbJCqa6PV3qLYfiKPWV1AECmUz6kv+1Yd8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRO5/UXA+V7BdBi8PuwXSD1zxXMzylxNYnmPmpkNUntNvRJclIlOujvh9T/8wM9zU
         x79CiWFD7MW0e9NtuS9rJgD9OTSG0Fs7rMf0a2/G35aB4/Y53RL1s/Jp6CqSDBtjPN
         zyyQ9j+f70drusD37NzD6mMgP2mINNYedS8XDpgS47EWaE+lHYwOfEVpKvfMO7Bvh+
         Q1LfmbI9zasCN0JiIkIdTSclOHTUXCVkbVPNwCso6QGwfLbeP50Iex8IwgdZV4aFxI
         bDufPv82X6R/VHy6vkn2UuvNk9kUtadfcpycOcY7a6f0SdPnpwfXxT2OV9wTdyW99u
         tjJi2JYPAdvKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, andrew@lunn.ch,
        hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 31/31] mdio_bus: unhide mdio_bus_init prototype
Date:   Thu, 25 May 2023 14:41:02 -0400
Message-Id: <20230525184105.1909399-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
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
index 08725a262f320..273a9409c77d6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1604,10 +1604,8 @@ void phy_package_leave(struct phy_device *phydev);
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

