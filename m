Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3973E606B81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiJTWqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJTWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:46:23 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1D7B97A3;
        Thu, 20 Oct 2022 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :Subject:Date:To:From:Resent-To:Resent-Message-ID:Resent-Date:Resent-From:
        Sender:Reply-To:Message-ID:Cc:Content-ID:Content-Description:Resent-Sender:
        Resent-Cc:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yhrawtb8eXhszTBMzMp3oX/egk/zUhmr7nUvZdT/NYQ=; b=Ut7JNeZhP9UNLMpPyDnduNdTwp
        XBDHnUB6n5HXszRnR7MWHcGPnrStmgCBGbmuM0B6fZt8nZHt/bIL+GFNOAvfh1hWNC02T7U2MLM4d
        6oMw98qbAy0uyccM0iyJ1TZtAZ/mwSR4PlD4/1w9CrFhePtSCWqfpKTKIsDKDKeA77dE=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oleIf-009Ob6-BD; Fri, 21 Oct 2022 00:46:05 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Sep 2022 01:33:18 +0200
Subject: [PATCH 4/6] media: ipu3-cio2: make the bridge depend on i2c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
In-Reply-To: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_MID,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S230158AbiJTWqt/20221020224651Z+39696@vger.kernel.org>

drivers/media/pci/intel/ipu3/cio2-bridge.c: In function ‘cio2_bridge_unregister_sensors’:
drivers/media/pci/intel/ipu3/cio2-bridge.c:258:17: error: implicit declaration of function ‘i2c_unregister_device’; did you mean ‘spi_unregister_device’? [-Werror=implicit-function-declaration]
  258 |                 i2c_unregister_device(sensor->vcm_i2c_client);
      |                 ^~~~~~~~~~~~~~~~~~~~~
      |                 spi_unregister_device

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/media/pci/intel/ipu3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
index 39bd3be0b43d..65b0c1598fbf 100644
--- a/drivers/media/pci/intel/ipu3/Kconfig
+++ b/drivers/media/pci/intel/ipu3/Kconfig
@@ -21,6 +21,7 @@ config VIDEO_IPU3_CIO2
 config CIO2_BRIDGE
 	bool "IPU3 CIO2 Sensors Bridge"
 	depends on VIDEO_IPU3_CIO2 && ACPI
+	depends on I2C
 	help
 	  This extension provides an API for the ipu3-cio2 driver to create
 	  connections to cameras that are hidden in the SSDB buffer in ACPI.
-- 
2.37.2.609.g9ff673ca1a

