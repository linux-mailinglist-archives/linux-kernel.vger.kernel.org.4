Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C86EC061
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjDWO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDWO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:26:26 -0400
X-Greylist: delayed 2072 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Apr 2023 07:26:24 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B5E103
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=t7E2Cfb8s9cniW4an/ct2kiBsoLowqJvY125LeR0Aqw=; b=IwRroCzm2yYthRD2acJt/nlQuD
        7W26ifGrFqykO4xnGMq8P7M2p77nC4ZGOD90+c9sQF7aHmOq9EvlNHMZ6Yt8AaeUdSIAT4FbisCXB
        0FdebBR9sD1LI7YtYh7jzRy+aYw9tCMI596pVCB5xqlVN38SFgbDalQ5vKVbj5+FqpLM=;
Received: from localhost ([127.0.0.1] helo=valinor.angband.pl)
        by tartarus.angband.pl with smtp (Exim 4.96)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1pqa7o-00GisH-05;
        Sun, 23 Apr 2023 15:51:32 +0200
Received: (nullmailer pid 55273 invoked by uid 1000);
        Sun, 23 Apr 2023 13:51:30 -0000
From:   kilobyte@angband.pl
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Date:   Sun, 23 Apr 2023 15:51:24 +0200
Message-Id: <20230423135124.55196-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: kilobyte@valinor.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Borowski <kilobyte@angband.pl>

All other MEI configs do so already.  This fixes a Kconfig gripe if I915
gets ported to other archs (such as RISC-V in Intel Horse Creek...).

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/misc/mei/hdcp/Kconfig | 1 +
 drivers/misc/mei/pxp/Kconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 54e1c9526909..83e67771ac6b 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -4,6 +4,7 @@
 config INTEL_MEI_HDCP
 	tristate "Intel HDCP2.2 services of ME Interface"
 	select INTEL_MEI_ME
+	depends on X86 && PCI
 	depends on DRM_I915
 	help
 	  MEI Support for HDCP2.2 Services on Intel platforms.
diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
index 4029b96afc04..95f2c2470d28 100644
--- a/drivers/misc/mei/pxp/Kconfig
+++ b/drivers/misc/mei/pxp/Kconfig
@@ -5,6 +5,7 @@
 config INTEL_MEI_PXP
 	tristate "Intel PXP services of ME Interface"
 	select INTEL_MEI_ME
+	depends on X86 && PCI
 	depends on DRM_I915
 	help
 	  MEI Support for PXP Services on Intel platforms.
-- 
2.40.0

