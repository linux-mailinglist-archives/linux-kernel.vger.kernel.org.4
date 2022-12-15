Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768B64DF24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLORAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLORAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:00:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268F2BFB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:00:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C7FE61E60
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA2C433EF;
        Thu, 15 Dec 2022 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123640;
        bh=gR+wX+srr1B/B9kWpwsVVXgzAsmM4vadRSx512XFtuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=dN7+oaru7J77u494qD3TZ10X0BjIDrggwescIF2Pnqd4t4OcewN697IyGEqvXMLRW
         4FcWftSzaEzz6Lfd+q9XDZCQ4IAD7q3DYB59TPg8VW4/eQYStvVlljHbWS3ENHDQSh
         fOhUkY6eb5tYyiqWnIVPPZh1k8a3mSYtpUc/i+tB0F8AWR9O44WsNYgvdIA8xIwnVE
         nez5O8kR/Y0IJ0dna85zUoKrPoVbsISebpeFGPKZLzNZYekyKFrO4VM9xfdBRVkNoo
         hHzDnJ1Lz7gKSq1qMRT28aulWXxP03ikMiS4tkKeq3FTLW6wEHNW+qzI4sdiug2oxz
         nca0x9NaBOALg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>, Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: ti-sci: fix compile test dependencies
Date:   Thu, 15 Dec 2022 18:00:24 +0100
Message-Id: <20221215170036.2308972-1-arnd@kernel.org>
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

The SCI reset driver can be compile testing on targets that
do not support the SCI firmware, but it fails to link when
the firmware driver is built as a module, and the reset driver
is built-in:

arm-linux-gnueabi-ld: drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
reset-ti-sci.c:(.text+0x422): undefined reference to `devm_ti_sci_get_handle'

Prevent this configuration by limiting the compile test
to configurations without SCI firmware.

Fixes: a6af504184c9 ("reset: ti-sci: Allow building under COMPILE_TEST")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index de176c2fbad9..2a52c990d4fe 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -257,7 +257,7 @@ config RESET_SUNXI
 
 config RESET_TI_SCI
 	tristate "TI System Control Interface (TI-SCI) reset driver"
-	depends on TI_SCI_PROTOCOL || COMPILE_TEST
+	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
 	help
 	  This enables the reset driver support over TI System Control Interface
 	  available on some new TI's SoCs. If you wish to use reset resources
-- 
2.35.1

