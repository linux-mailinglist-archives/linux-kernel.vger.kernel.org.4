Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAC7091A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjESI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjESI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95BCE52;
        Fri, 19 May 2023 01:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A823654DF;
        Fri, 19 May 2023 08:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44476C433EF;
        Fri, 19 May 2023 08:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684484772;
        bh=zccskR3KDaJ9BbnUz5SBNLBbWuOC91Z3hkOuUHIE9+I=;
        h=From:To:Cc:Subject:Date:From;
        b=VSmxtSVBXrVMlCGOsj6xh+gIo+eiyvSJ0UTJOBwofvtYONyPHqKMJSM2ySnusKLY3
         aGgz3Ov3kgP58GBohbc+y1AU3t9qBlSBmCWH+yP0D+FxXGZDlfH9FbAj1VDmSgQ2bV
         u4a/2vltRzL6Wnd5+y4Lm1UxoZfFleElMAvA19TtDB6efJhuEdP9oqDLgPE/4JZojJ
         uW7lriLZZjzfM8bSpnsEod2//28+U08owcRBrzG6eu4m4sdRcg6FCEzdt00bSnEGBV
         UYUrrfOnGiwHmoJvvXATtsfEMvYHEY7jtPGjO5sq0V6t1T3CZRb+oBkZqRtiwHbEPk
         yucxqoEmfbKGQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: lenovo-yogabook: add I2C dependency
Date:   Fri, 19 May 2023 10:25:52 +0200
Message-Id: <20230519082606.375471-1-arnd@kernel.org>
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

The added platform_driver support fails to link when I2C core support is
not rechable:

x86_64-linux-ld: drivers/platform/x86/lenovo-yogabook.o: in function `yogabook_pdev_probe':
lenovo-yogabook.c:(.text+0x5a5): undefined reference to `i2c_bus_type'

Add a Kconfig dependency to enforce a working configuration.

Fixes: 6df1523fa0b7 ("platform/x86: lenovo-yogabook: Add platform driver support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 9fe974d5f645..63637ea99c2f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -125,6 +125,7 @@ config YOGABOOK
 	tristate "Lenovo Yoga Book tablet key driver"
 	depends on ACPI_WMI
 	depends on INPUT
+	depends on I2C
 	select LEDS_CLASS
 	select NEW_LEDS
 	help
-- 
2.39.2

