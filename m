Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2CC6B42C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjCJOGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCJOG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:06:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C799116C12;
        Fri, 10 Mar 2023 06:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10EC5B82291;
        Fri, 10 Mar 2023 14:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E3C4339E;
        Fri, 10 Mar 2023 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678457170;
        bh=qaQcJQhx6nov9VzSU4N70ibWYjj88HenZA1ZKN3hd7I=;
        h=From:To:Cc:Subject:Date:From;
        b=dFVYpgzfrXIX6lJvbRPsJKK9ltfpFRMQSrfkSkha+QIXn1FLw6Y2ErRtrNuXbw5P5
         DN+dOu1IUgcbR8Cu4U0ZcLnyLJ0kxTHEN7lU5Ib5QyppPRuG8Pj+6N6wYSaz7dmegi
         Q+Hkb7eYb9X882mw6CUwSCcZihfHp6YPjybCGrm2nFnvVW1ksrCnv4tl+UJe1CUfC3
         Qj3FBvSQ20MeALIDpoJF2DZSE7lTxeqoVb+LmwqAtU1VHrRt4FOnvMQoLY8QywHek2
         dCGUUt/xnIBZi4rgJvh+sZstsfCk1La94zXatdp54ThtHK+X68kj0EIyZ8pFEGIMp0
         WEXP8MvCR9jhw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fsi: restore CONFIG_FSI dependency
Date:   Fri, 10 Mar 2023 15:05:37 +0100
Message-Id: <20230310140605.569363-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The assumption that the build dependency was not necessary turned
out to be wrong, as building SPI_FSI without FSI results in a link
failure:

aarch64-linux-ld: drivers/spi/spi-fsi.o: in function `fsi_spi_check_status':
spi-fsi.c:(.text+0x54): undefined reference to `fsi_device_read'
aarch64-linux-ld: drivers/spi/spi-fsi.o: in function `fsi_spi_read_reg':
spi-fsi.c:(.text+0x120): undefined reference to `fsi_device_write'
aarch64-linux-ld: spi-fsi.c:(.text+0x170): undefined reference to `fsi_device_read'

Fixes: f916c7080d28 ("spi: fsi: Make available for build test")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If possible, maybe just drop the original patch, rather than adding
this revert
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fd681a668c3c..1a9a7390d595 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -357,7 +357,7 @@ config SPI_FALCON
 
 config SPI_FSI
 	tristate "FSI SPI driver"
-	depends on FSI || COMPILE_TEST
+	depends on FSI
 	help
 	  This enables support for the driver for FSI bus attached SPI
 	  controllers.
-- 
2.39.2

