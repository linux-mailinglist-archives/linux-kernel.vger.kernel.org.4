Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8D6933EA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 16:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBKVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 16:03:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0B514E84;
        Sat, 11 Feb 2023 13:03:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E87AB80957;
        Sat, 11 Feb 2023 21:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C07FC433D2;
        Sat, 11 Feb 2023 21:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676149412;
        bh=/j5yG0cNv728tEpBHhIkw1FFheDNqEhLZgaqWpsTmNY=;
        h=From:To:Cc:Subject:Date:From;
        b=r4LT5mhG0aYwOZHkywvHeOaInxGMkt+Cy3ftISZXnwU9i7IiTU9FYTEHzrNyhy3/S
         +0/jxtf9E54zBT5kvwacrG+4JWqdeiDxNAAKHaGFJdgCKlC/3ojpRs3SSfDREWhNqe
         A6wtefclz5gX8cCQrB8BSnq1FGWamr93bM1ql4VpBR94VKz+gthPKNr/SmaCOGCC12
         yERpeJ7HBsBXCNXcLA94wgfQ+K0jEhbfzjTWQsmrB6ewJfYkSrfdSkYAfVNwtNpbIy
         UiWgFL1pHJse12bu/P7HZaZ1gvna/cUNuXbNFGnUKlCVtkkeMWlgJK2iqWELeaHIRd
         +V1YNKW1n8l0Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: omap: drop TPS65010 dependency
Date:   Sat, 11 Feb 2023 22:02:53 +0100
Message-Id: <20230211210326.364653-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The original TPS65010 dependency was only needed for MACH_OMAP_H2,
which is now gone, but I messed up the conversion when I removed that
symbol.

Now the missing TPS65010 causes a boot failure on other machines
such as the SX1.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 0d7bb85e9413 ("ARM: omap1: remove unused board files")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've already applied this patch to the arm/boardfile-remove
branch which has the original broken patch. Posting it for reference.

 drivers/mmc/host/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e1b88b51cc80..e13b0b0b8ebb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -488,7 +488,6 @@ config MMC_SDHCI_ST
 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
-	depends on TPS65010
 	help
 	  This selects the TI OMAP Multimedia card Interface.
 	  If you have an OMAP board with a Multimedia Card slot,
-- 
2.39.1

