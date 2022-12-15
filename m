Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6254C64DEDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiLOQmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLOQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:42:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F02F029
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:42:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7764261DE1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8AEC433D2;
        Thu, 15 Dec 2022 16:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671122557;
        bh=k+D2QBSlKI6hPk7Hqyn2WSrMF81848vCoxcbS8XEPPE=;
        h=From:To:Cc:Subject:Date:From;
        b=Omragm4ED0mXgPuLWTB7oX4v7uNQnvi8sD0kYVaSTArFG0Tot+MCTElzjZkztyWvm
         2ofzVnOmtou6KNuJULR7HJ0Xc7L/Rb+AYy5mJeBj0nu834YzonWEosaKLaRXq/7IZT
         Np0gaq06Z3rhMnwmY2JvoOEvIAko+yyOQ+QzzqozfqJ+f0LPL/PrAUuGJBOjaakDYS
         /1gTUq7Z71hRXT8RYdR0/ngmPYyh4wpba/t/VIhlcfB8pI6WeYbZWWShp2zGT6WtVV
         pzxCJwxkRHKoMydVCZUPgR7LjVl/hdUnLhkEKIz73dvMhg+IN3p4lRCWCyPF1AcXPH
         lRBqBQ4UesOaA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] phy: AM654: fix serdes dependencies
Date:   Thu, 15 Dec 2022 17:42:27 +0100
Message-Id: <20221215164233.890351-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
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

Building without CONFIG_OF leads to a harmless Kconfig warning:

WARNING: unmet direct dependencies detected for MUX_MMIO
  Depends on [n]: MULTIPLEXER [=y] && OF [=n]
  Selected by [y]:
  - PHY_AM654_SERDES [=y] && (OF [=n] && ARCH_K3 || COMPILE_TEST [=y]) && COMMON_CLK [=y]

Change the dependency to limit compile testing to OF-enabled
builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 15a3bcf32308..381bc499053e 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -23,7 +23,7 @@ config PHY_DM816X_USB
 
 config PHY_AM654_SERDES
 	tristate "TI AM654 SERDES support"
-	depends on OF && ARCH_K3 || COMPILE_TEST
+	depends on OF && (ARCH_K3 || COMPILE_TEST)
 	depends on COMMON_CLK
 	select GENERIC_PHY
 	select MULTIPLEXER
-- 
2.35.1

