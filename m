Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7A65BFBB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjACMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjACMSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:18:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FFB101CA;
        Tue,  3 Jan 2023 04:18:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFC7612F0;
        Tue,  3 Jan 2023 12:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD60C433EF;
        Tue,  3 Jan 2023 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672748280;
        bh=iozRXvof/ZOKofGbVDi16VyshF0obFK3LOrZ9yM/zjI=;
        h=From:To:Cc:Subject:Date:From;
        b=uZDfUwPXN4L3EpU8wFKNuCvwmq3O6BNZXunpSK+3huzZ0aQhcq81VfRvAZ/bwXwcR
         YxrTZDAL6W+v1/A0JTsiDjyLmPWYywxdRPgwvu7lqeJciUoYQb3ACOXwmUmyj0wTOt
         PlBv+xKI9oT93M5GTtJMgxiSRcPW9+kZFuIfIV4sNdsWQTwKH/cpdtq4rpm8MGbe0R
         taAsx0T8aA+MKMXGGqr9T1EtOfsEoKfxjvHs/NkesuCmlGKDS2NXLV2T3loDQIgsaj
         WO9P4jEnqiyZE0KDgBCUZATP6xhsB5xgocpaQAuKNkEqKvMM5G9+bswo/jyX6NHvPA
         5kR9FmLSJxPYg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Piyush Mehta <piyush.mehta@amd.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: xilinx: include linux/gpio/consumer.h
Date:   Tue,  3 Jan 2023 13:17:46 +0100
Message-Id: <20230103121755.956027-1-arnd@kernel.org>
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

The newly added gpio consumer calls cause a build failure in configurations
that fail to include the right header implicitly:

drivers/usb/dwc3/dwc3-xilinx.c: In function 'dwc3_xlnx_init_zynqmp':
drivers/usb/dwc3/dwc3-xilinx.c:207:22: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_clk_get_optional'? [-Werror=implicit-function-declaration]
  207 |         reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~
      |                      devm_clk_get_optional

Fixes: ca05b38252d7 ("usb: dwc3: xilinx: Add gpio-reset support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 8607d4c23283..0745e9f11b2e 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-- 
2.39.0

