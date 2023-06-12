Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975D072C492
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjFLMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjFLMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0B3E4E;
        Mon, 12 Jun 2023 05:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B3E361DDA;
        Mon, 12 Jun 2023 12:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0C6C4339B;
        Mon, 12 Jun 2023 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686573633;
        bh=A6bGNMNMde5NDVbabkyRI7fOdxDo5P2/Hp6ldKTKw+g=;
        h=From:To:Cc:Subject:Date:From;
        b=EvyNJE8QHXsqnkhPDN0RwUjIaTgp50gmyRxBVXf78l7CffpCTYKedAHHytcqiEFsh
         j3J8OpAlJ0rqweuexIStvLasjC61KfEqCivJV1deUQxWH4d6vU9FfMQsGotkM6WeXq
         GaGy4eUmWQHvccN9egFravTdCPWpgX9tkH6oFHtwu6E7PPvwmvq8dmCqzYjNAygXi3
         ze5uxupfm2+jOLyzwZTA7+0DpK4tyVFlFQ5x9GsjScUlYS7l+qpd3u3ILrU3xvzkB9
         ZBh0v9R1Q/ZJVaSIYyHhMPOKYU6omGdWArmq+VTOsymKV0iSvUgOxcJipCekMPhTNS
         2VoZ74c/fV6pQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mao Wenan <maowenan@huawei.com>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] net: ethernet: ti-cpsw: select CONFIG_GENERIC_ALLOCATOR
Date:   Mon, 12 Jun 2023 14:40:04 +0200
Message-Id: <20230612124024.520720-1-arnd@kernel.org>
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

The dependency was lost for both cpsw and davinci-emac, but only
added back for the emac driver, so a cpsw-only build can still fail:

x86_64-linux-ld: vmlinux.o: in function `cpdma_desc_pool_destroy':
davinci_cpdma.c:(.text+0xd9fb97): undefined reference to `gen_pool_size'
x86_64-linux-ld: davinci_cpdma.c:(.text+0xd9fba8): undefined reference to `gen_pool_avail'
x86_64-linux-ld: vmlinux.o: in function `cpdma_desc_pool_create':
davinci_cpdma.c:(.text+0xd9fd21): undefined reference to `devm_gen_pool_create'
x86_64-linux-ld: davinci_cpdma.c:(.text+0xd9fe15): undefined reference to `gen_pool_add_owner'
x86_64-linux-ld: vmlinux.o: in function `__cpdma_chan_free':
davinci_cpdma.c:(.text+0xd9ffde): undefined reference to `gen_pool_free_owner'
x86_64-linux-ld: vmlinux.o: in function `cpdma_chan_submit_si':
davinci_cpdma.c:(.text+0xda039e): undefined reference to `gen_pool_alloc_algo_owner'
x86_64-linux-ld: davinci_cpdma.c:(.text+0xda064f): undefined reference to `gen_pool_free_owner'
x86_64-linux-ld: vmlinux.o: in function `cpdma_check_free_tx_desc':

Fixes: b2ef81dcdf383 ("net: ethernet: ti: Add dependency for TI_DAVINCI_EMAC")
Fixes: 99f6297182729 ("net: ethernet: ti: cpsw: drop TI_DAVINCI_CPDMA config option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fce06663e1e11..18b2160a96260 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -51,6 +51,7 @@ config TI_CPSW
 	tristate "TI CPSW Switch Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on TI_CPTS || !TI_CPTS
+	select GENERIC_ALLOCATOR
 	select TI_DAVINCI_MDIO
 	select MFD_SYSCON
 	select PAGE_POOL
@@ -67,6 +68,7 @@ config TI_CPSW_SWITCHDEV
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	depends on NET_SWITCHDEV
 	depends on TI_CPTS || !TI_CPTS
+	select GENERIC_ALLOCATOR
 	select PAGE_POOL
 	select TI_DAVINCI_MDIO
 	select MFD_SYSCON
-- 
2.39.2

