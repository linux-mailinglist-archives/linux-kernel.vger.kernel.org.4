Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B03671831
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjARJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjARJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:50:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75F82BEF1;
        Wed, 18 Jan 2023 01:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BF56172E;
        Wed, 18 Jan 2023 09:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67AAC433D2;
        Wed, 18 Jan 2023 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032512;
        bh=THV3Tcy6xKn4dLWFPpXMkIx/yzhzy/uhRugjcM+mCQw=;
        h=From:To:Cc:Subject:Date:From;
        b=eswJ/MjCDwkZofaT5ikZ6b7HXSzTGPGjVmvXuXARnnmJmyEg+aEoKMaGOSrFFiS8L
         v8y93xxX2kFQna/QY9FLaTkKb2d/SQpJEDL0sRI0DU8NnHCbAao2QCwL3i5jb2Y7iE
         H5BPi2/U/Lzy1pylzBgcegIPSIqEgvsre2wQG0qvpThEcS1/P4Q7JrSTT+eU8v7SI3
         dySnY1foDWK63HYK+e3CTe23vWKf3cVbO5gHs0Be4gMHsvOgjBLVRlpZv626fTe8tK
         vxmzIOlT/k7QLqaXZN8LxYf2zj1GWgDyq2x77/OczYehLnU6B8JrLMS2UQw6a2F+Hg
         x+T0Yvf4f1G/g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kushagra Verma <kushagra765@outlook.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: fix extcon dependency
Date:   Wed, 18 Jan 2023 10:01:41 +0100
Message-Id: <20230118090147.2126563-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
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

The dwc3 core support now links against the extcon subsystem,
so it cannot be built-in when extcon is a loadable module:

arm-linux-gnueabi-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_extcon':
core.c:(.text+0x572): undefined reference to `extcon_get_edev_by_phandle'
arm-linux-gnueabi-ld: core.c:(.text+0x596): undefined reference to `extcon_get_extcon_dev'
arm-linux-gnueabi-ld: core.c:(.text+0x5ea): undefined reference to `extcon_find_edev_by_node'

There was already a Kconfig dependency in the dual-role support,
but this is now needed for the entire dwc3 driver.

It is still possible to build dwc3 without extcon, but this
prevents it from being set to built-in when extcon is a loadable
module.

Fixes: d182c2e1bc92 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index b2f72b0e75c6..be954a9abbe0 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -3,6 +3,7 @@
 config USB_DWC3
 	tristate "DesignWare USB3 DRD Core Support"
 	depends on (USB || USB_GADGET) && HAS_DMA
+	depends on (EXTCON || EXTCON=n)
 	select USB_XHCI_PLATFORM if USB_XHCI_HCD
 	select USB_ROLE_SWITCH if USB_DWC3_DUAL_ROLE
 	help
@@ -44,7 +45,6 @@ config USB_DWC3_GADGET
 config USB_DWC3_DUAL_ROLE
 	bool "Dual Role mode"
 	depends on ((USB=y || USB=USB_DWC3) && (USB_GADGET=y || USB_GADGET=USB_DWC3))
-	depends on (EXTCON=y || EXTCON=USB_DWC3)
 	help
 	  This is the default mode of working of DWC3 controller where
 	  both host and gadget features are enabled.
-- 
2.39.0

