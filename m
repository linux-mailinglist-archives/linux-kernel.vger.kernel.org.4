Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52986A2E68
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 06:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBZFkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 00:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBZFj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 00:39:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4F136E9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AyoTZxblYHrDgUuDfRxaCtNtUrEUy/+HCnPw8W0zpKM=; b=vE34UtPha3vYcnY3CA1tx0eYDv
        n5+ZoUMoM6RFCuvENArB8yc9DIMT16fw+tSYZXAiWj1fA3D8ax7rXYNf5JYgfIB/YUQ9COkgHC8fL
        D7Zn3Qj2Qzg1sTL2ybUR4J4lDFS9LUprVbfxWKgURB8slpOt7OeittRhl5gPi46p1CGdTxgpPen/R
        pykahEiooe9Gcp+Gp/o/ASPVPptdRQzhM5li4XeEutcdEg7cS+Opmi9546ZCBAoBHeY48PvDqqz8g
        M7kn8FEuRWX2UhxnFgjCD8RPWXbAmr5IycK2as91NO5EzsI9qPoMKjXmDD/dcLemmrAYWBNtuPHK7
        x/lzHb8g==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pW9lL-006qYL-37; Sun, 26 Feb 2023 05:39:55 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Corey Minyard <minyard@acm.org>,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/8] ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it
Date:   Sat, 25 Feb 2023 21:39:46 -0800
Message-Id: <20230226053953.4681-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230226053953.4681-1-rdunlap@infradead.org>
References: <20230226053953.4681-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGMAP is a hidden (not user visible) symbol. Users cannot set it
directly thru "make *config", so drivers should select it instead of
depending on it if they need it.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on REGMAP_MMIO" to
"select REGMAP_MMIO", which will also set REGMAP.

Fixes: eb994594bc22 ("ipmi: bt-bmc: Use a regmap for register access")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Corey Minyard <minyard@acm.org>
Cc: openipmi-developer@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/char/ipmi/Kconfig b/drivers/char/ipmi/Kconfig
--- a/drivers/char/ipmi/Kconfig
+++ b/drivers/char/ipmi/Kconfig
@@ -162,7 +162,8 @@ config IPMI_KCS_BMC_SERIO
 
 config ASPEED_BT_IPMI_BMC
 	depends on ARCH_ASPEED || COMPILE_TEST
-	depends on REGMAP && REGMAP_MMIO && MFD_SYSCON
+	depends on MFD_SYSCON
+	select REGMAP_MMIO
 	tristate "BT IPMI bmc driver"
 	help
 	  Provides a driver for the BT (Block Transfer) IPMI interface
