Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAA6C48DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjCVLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:17:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C534F4B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 04:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA666202A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE57C433D2;
        Wed, 22 Mar 2023 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679483833;
        bh=hxYlSbdZtdkYUaS/j6XHRDcBiXZlnQz/QqL+Bt8m+2k=;
        h=From:To:Cc:Subject:Date:From;
        b=U9KJvy1B/utPReWCd/fUqy5WoB93BhUvGfD8dAas9yAKCatpUlJj99pl89q46pL+V
         s9KU98lG8Sua9QeBTJ8lEGUsVBix+UrNadcA1tN3149AFk4jBZGv4w5LUpLawfzJe4
         joQAuNPobXqSlBgC4gToGn8eRZjypzCfGbFpY3D2KmhH2OzbbT7BH7JavxSEpsnbhY
         UBAj5aBqajN9H6kZE5nKjo7CFVOR7qbV4dB1PBdaa4Iu0bRezl9MgZTWRdFiTfLzwo
         +JmXBvPqnLplDn+yEw5p08ejbGaS7d8WD/cBGEX1bIJC8AD2oPAAMPgccX9hLCGCn0
         U/QCyMTCuaT8Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
Date:   Wed, 22 Mar 2023 12:16:51 +0100
Message-Id: <20230322111708.1042312-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_USB_ROLE_SWITCH=m, tusb320 cannot be built-in:

ld.lld: error: undefined symbol: fwnode_usb_role_switch_get
>>> referenced by extcon-usbc-tusb320.c
>>>               drivers/extcon/extcon-usbc-tusb320.o:(tusb320_probe) in archive vmlinux.a
ld.lld: error: undefined symbol: usb_role_switch_set_role
>>> referenced by extcon-usbc-tusb320.c
>>>               drivers/extcon/extcon-usbc-tusb320.o:(tusb320_state_update_handler) in archive vmlinux.a

Add the appropriate Kconfig dependency to prevent this
configuration but still allow the driver to be built-in
when USB_ROLE_SWITCH is disabled.

Fixes: 19685ae43489 ("extcon: usbc-tusb320: add usb_role_switch support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/extcon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 290186e44e6b..0ef1971d22bb 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -185,6 +185,7 @@ config EXTCON_USBC_TUSB320
 	tristate "TI TUSB320 USB-C extcon support"
 	depends on I2C && TYPEC
 	select REGMAP_I2C
+	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB Type C cable detection extcon
 	  support using a TUSB320.
-- 
2.39.2

