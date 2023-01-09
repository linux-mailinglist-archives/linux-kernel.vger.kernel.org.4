Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D90662AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjAIQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjAIQQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:16:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33879D117;
        Mon,  9 Jan 2023 08:16:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFE76B80E34;
        Mon,  9 Jan 2023 16:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA60C433F2;
        Mon,  9 Jan 2023 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673281013;
        bh=maFSsDjqqGGoQ3/lQVYYKJAVzHG0X16yepNh/8qHMfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnXMUvjQXJEPbmIqZNiLAt1EAD0poi72kefAuSolZ3TlwF8VRF24JqaT9qfijYUSH
         fkpByvhw2SACz18AdEZbHqLNZt9V5zBr4aW1Ofd4XW6ZidjsSgQk76Z5Drjb7+exEI
         3dui/CxNvFPu0anR9HCj8zR5CZrA2p4GO8Hh+RbqZBF4BLlylSnhaRKGRfYBVGi8uK
         5iF66Igh7fTo7R3moLgnkya2mlAjVH5medE7VcER/pb8za0KIkH3bzRArqap8/3DrQ
         015NMAOgebqVfUYWaQ/8N6PXaORliBTRUOcDMKq3lJwYp4irYujbeFi8CufKjY1Vif
         fJcVd8WxU2Fjg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/3] ARM: omap1: fix building gpio15xx
Date:   Mon,  9 Jan 2023 17:16:36 +0100
Message-Id: <20230109161636.512203-4-arnd@kernel.org>
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

In some randconfig builds, the asm/irq.h header is not included
in gpio15xx.c, so add an explicit include to avoid a build fialure:

In file included from arch/arm/mach-omap1/gpio15xx.c:15:
arch/arm/mach-omap1/irqs.h:99:34: error: 'NR_IRQS_LEGACY' undeclared here (not in a function)
   99 | #define IH2_BASE                (NR_IRQS_LEGACY + 32)
      |                                  ^~~~~~~~~~~~~~
arch/arm/mach-omap1/irqs.h:105:38: note: in expansion of macro 'IH2_BASE'
  105 | #define INT_MPUIO               (5 + IH2_BASE)
      |                                      ^~~~~~~~
arch/arm/mach-omap1/gpio15xx.c:28:27: note: in expansion of macro 'INT_MPUIO'
   28 |                 .start  = INT_MPUIO,
      |                           ^~~~~~~~~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/gpio15xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index c675f11de99d..61fa26efd865 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/soc/ti/omap1-soc.h>
+#include <asm/irq.h>
 
 #include "irqs.h"
 
-- 
2.39.0

