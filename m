Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74368ADA6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBEAoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 19:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBEAoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 19:44:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5622120690;
        Sat,  4 Feb 2023 16:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b2WyZrtmPUwW7ibcZwI17X+YOhCURjH4jEMa7j9F8OI=; b=dMsaI9GsbZkr2FzxUFQ1Z5MEXb
        Na5fclS4w34wQD+N4D3qKIpq80w2KQz8SqZaoMqCKbN3KfnvYDQCgYV9d3L/bLE2oJt2Tdb3ptKi6
        WRBsjYXyQcpxxGxh57jo3i2+cJae54sS9uxbn00B0UtmjHgVhLeiH46aLjyoUe9BtRaG7sGL5bGIG
        nwSFHkkefGOuHdQNT0mcNgqHk3J2o+VgPXNOHRfhvtUVPftfy474p3Iavi6EUSeS+KLKiq00A4JXw
        Dd9kBmWQLDkjUclo6AoyjKmYUYYIVjpeiPiCKFTcSh5RPzQlgGsWl/7InUniq7MZNNxC9+6MvKmTy
        yyg83sKA==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOT8R-005mfr-L2; Sun, 05 Feb 2023 00:43:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Kirill Tkhai <tkhai@yandex.ru>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] sparc: allow PM configs for sparc32 COMPILE_TEST
Date:   Sat,  4 Feb 2023 16:43:57 -0800
Message-Id: <20230205004357.29459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing randconfig builds for sparc32 with COMPILE_TEST,
some (non-Sparc) drivers cause kconfig warnings with the
Kconfig symbols PM, PM_GENERIC_DOMAINS, or PM_GENERIC_DOMAINS_OF.

This is due to arch/sparc/Kconfig not using the PM Kconfig for
Sparc32:

  if SPARC64
  source "kernel/power/Kconfig"
  endif

Arnd suggested adding "|| COMPILE_TEST" to the conditional,
instead of trying to track down every driver that selects
any of these PM symbols.

Fixes the following kconfig warnings:

WARNING: unmet direct dependencies detected for PM
  Depends on [n]: SPARC64 [=n]
  Selected by [y]:
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for PM
  Depends on [n]: SPARC64 [=n]
  Selected by [y]:
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
  Depends on [n]: SPARC64 [=n] && PM [=y]
  Selected by [y]:
  - QCOM_GDSC [=y] && COMMON_CLK [=y] && PM [=y]
  - SUN20I_PPU [=y] && (ARCH_SUNXI || COMPILE_TEST [=y])
  - MESON_GX_PM_DOMAINS [=y] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  - BCM2835_POWER [=y] && (ARCH_BCM2835 || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - BCM_PMB [=y] && (ARCH_BCMBCA || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - ROCKCHIP_PM_DOMAINS [=y] && (ARCH_ROCKCHIP || COMPILE_TEST [=y]) && PM [=y]
  Selected by [m]:
  - ARM_SCPI_POWER_DOMAIN [=m] && (ARM_SCPI_PROTOCOL [=m] || COMPILE_TEST [=y] && OF [=y]) && PM [=y]
  - MESON_EE_PM_DOMAINS [=m] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  - QCOM_AOSS_QMP [=m] && (ARCH_QCOM || COMPILE_TEST [=y]) && MAILBOX [=y] && COMMON_CLK [=y] && PM [=y]

WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
  Depends on [n]: SPARC64 [=n] && PM_GENERIC_DOMAINS [=y] && OF [=y]
  Selected by [y]:
  - MESON_GX_PM_DOMAINS [=y] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]
  Selected by [m]:
  - MESON_EE_PM_DOMAINS [=m] && (ARCH_MESON || COMPILE_TEST [=y]) && PM [=y] && OF [=y]

Fixes: bdde6b3c8ba4 ("sparc64: Hibernation support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Kirill Tkhai <tkhai@yandex.ru>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/sparc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -283,7 +283,7 @@ config ARCH_FORCE_MAX_ORDER
 	  This config option is actually maximum order plus one. For example,
 	  a value of 13 means that the largest free memory block is 2^12 pages.
 
-if SPARC64
+if SPARC64 || COMPILE_TEST
 source "kernel/power/Kconfig"
 endif
 
