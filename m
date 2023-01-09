Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365E9662AF7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbjAIQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjAIQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:16:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E38C48;
        Mon,  9 Jan 2023 08:16:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12166118C;
        Mon,  9 Jan 2023 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC111C433F1;
        Mon,  9 Jan 2023 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673281008;
        bh=i5nKSM8lt6iXWjRVvXe6ISTlNhz3W/J86aXjLiCfq28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoWa+Dqb2kKSYvB/S0lCnDkIoT5EEajQ6f08EX5g5RoQJB0CorVULfIZ+ruYhpJSm
         bUk5RFfdO8VkOjiOwskluCoQdmqW7NfzhSBpn6Sve7sy9UWpqZUIoBZiTY5nMkRNT2
         kdVZLq9swqGtK1sQb1JbxqdEznOH/0frpMiXxpoRKu1ZbQ6BDzTKv9KFLS/1ygXiBh
         Ez1CE5aXw0kpOTAIS59mmrvZsIgXt6xQ4f2BPcdfx26FmqbSeNdKUi8mFElfNaCin1
         /kvY7MrChpAbbGiFoDPzGvmPUy8PPI9BC6A/e+IKan7jdIYxd/XvUe0IyWWP67O7RT
         66xMHrWirKv3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] ARM: pxa: enable PXA310/PXA320 for DT-only build
Date:   Mon,  9 Jan 2023 17:16:34 +0100
Message-Id: <20230109161636.512203-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109161636.512203-1-arnd@kernel.org>
References: <20230109161636.512203-1-arnd@kernel.org>
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

After commit b5aaaa666a85 ("ARM: pxa: add Kconfig dependencies for
ATAGS based boards"), the default PXA build no longer includes support
for the board files that are considered unused.

As a side-effect of this, the PXA310 and PXA320 support is not built
into the kernel any more, even though it should work in principle as
long as the symbols are enabled. As Robert points out, there are dts
files for zylonite and cm-x300, though those have not made it into the
mainline kernel.

Link: https://lore.kernel.org/linux-arm-kernel/m2sfglh02h.fsf@free.fr/
Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index b90d98bae68d..03e25af6f48c 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -45,6 +45,8 @@ config MACH_PXA27X_DT
 config MACH_PXA3XX_DT
 	bool "Support PXA3xx platforms from device tree"
 	select CPU_PXA300
+	select CPU_PXA310
+	select CPU_PXA320
 	select PINCTRL
 	select POWER_SUPPLY
 	select PXA3xx
-- 
2.39.0

