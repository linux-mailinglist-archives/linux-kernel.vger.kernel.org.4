Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D525B7261C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbjFGN5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbjFGN45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9CB1BEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F0163F99
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 13:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE65C433EF;
        Wed,  7 Jun 2023 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686146215;
        bh=r/dkeieRe+CBoWvVAbirfQe75r6oLh/K8kfqL8af9hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBhVEDK+bGfJNxNkcrFUiig1oWzsBWPMPtjov+xF+5agQV6NYtYaDfU7xTAQhH/XW
         hTHp1n1g4wkwBygN4PCLDkJ0a4yY/eZiaTUHURRV/vnnjH38RAXjedh3la9SF1dO/f
         OTKHTuhKrNavhhi+tRgkpaJ/WIlLocnI28wpcHnV1lScn2fUyf3D1I1MZlc29ofQiP
         LPsDLGGbkQPSZPNEGFbUmqbGG9OLZaGVHnA+CyKbxWgUu7zN8VwSQijOq8sYjz/LVt
         bs254+DnLjkTQpPyQx9CYn4LZfWqVmViL+Mr6JA4o38CJ2wt2Al8OmCXcWTPi5CH1m
         Zl8I09ruBqFhQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Joyce Ooi <joyce.ooi@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net: altera-tse: fix broken Kconfig dependency
Date:   Wed,  7 Jun 2023 15:56:33 +0200
Message-Id: <20230607135638.1341101-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607135638.1341101-1-arnd@kernel.org>
References: <20230607135638.1341101-1-arnd@kernel.org>
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

The CONFIG_PCS_ALTERA_TSE symbol is gone, so make sure the ethernet
driver selects the correct symbol for its replacement, avoiding:

x86_64-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `altera_tse_remove':
altera_tse_main.c:(.text+0xdf): undefined reference to `lynx_pcs_destroy'

Fixes: 196eec4062b00 ("net: pcs: Drop the TSE PCS driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/altera/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/altera/Kconfig b/drivers/net/ethernet/altera/Kconfig
index 93533ba034294..17985319088c1 100644
--- a/drivers/net/ethernet/altera/Kconfig
+++ b/drivers/net/ethernet/altera/Kconfig
@@ -4,7 +4,7 @@ config ALTERA_TSE
 	depends on HAS_DMA
 	select PHYLIB
 	select PHYLINK
-	select PCS_ALTERA_TSE
+	select PCS_LYNX
 	select MDIO_REGMAP
 	select REGMAP_MMIO
 	help
-- 
2.39.2

