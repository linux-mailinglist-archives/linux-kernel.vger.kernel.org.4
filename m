Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134006EE4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjDYPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjDYPnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 11:43:39 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027BB210C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q4uSQaM42SXIPiBMHZHXrABS7QH8LGwkgcOHidbJtZw=; b=ldMazqi9VkjfJTdZCqDlNuzms5
        g8O53ctxm4edQh/lQLhBpmICAzIyOI1CfwttRS3LixCiSjYQ3hLUioAD5MOpU+3QQHw66goVTYCJT
        /Bn5DPRFhVhcLAq+N8gPFgtxcE+thhGnMWy0hBKJa2yt7y0jC7KWzZ/r4qwfqvQGPf1k=;
Received: from localhost ([127.0.0.1] helo=valinor.angband.pl)
        by tartarus.angband.pl with smtp (Exim 4.96)
        (envelope-from <kilobyte@valinor.angband.pl>)
        id 1prKp8-00HSJq-0Q;
        Tue, 25 Apr 2023 17:43:22 +0200
Received: (nullmailer pid 21774 invoked by uid 1000);
        Tue, 25 Apr 2023 15:43:20 -0000
From:   kilobyte@angband.pl
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Subject: [PATCH v2] mei: deduplicate X86 && PCI dependencies, make them apply to all subentries
Date:   Tue, 25 Apr 2023 17:43:14 +0200
Message-Id: <20230425154314.21728-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425152720.GA4155584@angband.pl>
References: <20230425152720.GA4155584@angband.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: kilobyte@valinor.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Borowski <kilobyte@angband.pl>

The Kconfig "depends on X86 && PCI" line was repeated for 4 out of 6 config
symbols here -- which was both unnecessarily repetitive, and caused a
dormant problem for the two remaining symbols lacking the dependency.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 v2: instead of adding new depends, wrap all of mei in "if..endif"

 drivers/misc/mei/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index d21486d69df2..f2ab2696fa78 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+if X86 && PCI
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
-	depends on X86 && PCI
 	help
 	  The Intel Management Engine (Intel ME) provides Manageability,
 	  Security and Media services for system containing Intel chipsets.
@@ -14,7 +14,6 @@ config INTEL_MEI
 config INTEL_MEI_ME
 	tristate "ME Enabled Intel Chipsets"
 	select INTEL_MEI
-	depends on X86 && PCI
 	help
 	  MEI support for ME Enabled Intel chipsets.
 
@@ -39,7 +38,6 @@ config INTEL_MEI_ME
 config INTEL_MEI_TXE
 	tristate "Intel Trusted Execution Environment with ME Interface"
 	select INTEL_MEI
-	depends on X86 && PCI
 	help
 	  MEI Support for Trusted Execution Environment device on Intel SoCs
 
@@ -50,7 +48,6 @@ config INTEL_MEI_GSC
 	tristate "Intel MEI GSC embedded device"
 	depends on INTEL_MEI
 	depends on INTEL_MEI_ME
-	depends on X86 && PCI
 	depends on DRM_I915
 	help
 	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
@@ -63,3 +60,4 @@ config INTEL_MEI_GSC
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 
+endif
-- 
2.40.0

