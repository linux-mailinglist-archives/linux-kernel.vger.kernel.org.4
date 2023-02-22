Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED17069F0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjBVIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjBVIuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:50:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4182E3433F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D43B81203
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CD6C4339B;
        Wed, 22 Feb 2023 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677055817;
        bh=PEl/1o6Ky0H58zZDig1uvvTpR+B+kcuCg0hsc6tBDMM=;
        h=From:To:Cc:Subject:Date:From;
        b=XyhV8izeheaftzNw3aw5HQpsK83jafj7vD2+F2PLnPhikgsxJcZ34mOwp9hnzSFTY
         sIlHuGATeuTiKF3+mTucJaJ2wcCPnNzm4mJDWYCHKeXdl2ngC9mpRSXGwHvu9Otlli
         yBDMNJZ/0hMG0YM7TjJXj+GFmhTQ+IhdfmXqjvusQmQmP5RNIIvWtc21/ia6kAf6jN
         hOAEl0pa/O/Xfacp+Qx3c6BLE5CaalpE96F91dV2Z0mvShoYfGIIRBfRLBWUXDpSpZ
         k1y7x033Au9+UeF/f+hHQqb7DcnWidHCEVsfaDIIvjwkvXEKhRrRjHrGgtcGLxUySU
         z4qgwZ2IdfcIw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] tty: ipwireless: move Kconfig entry to tty
Date:   Wed, 22 Feb 2023 09:50:12 +0100
Message-Id: <20230222085013.32331-1-jirislaby@kernel.org>
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

The ipwireless' Kconfig entry is currently sitting in char/pcmcia. But
the driver is in tty/. So move the entry to tty/ too.

First, it makes sense to have the entry along the driver. Second, whole
char/pcmcia is about to pass away.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/pcmcia/Kconfig | 9 ---------
 drivers/tty/Kconfig         | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
index f5d589b2be44..26724990074c 100644
--- a/drivers/char/pcmcia/Kconfig
+++ b/drivers/char/pcmcia/Kconfig
@@ -55,14 +55,5 @@ config SCR24X
 
 	  If unsure say N.
 
-config IPWIRELESS
-	tristate "IPWireless 3G UMTS PCMCIA card support"
-	depends on PCMCIA && NETDEVICES && TTY
-	select PPP
-	help
-	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
-	  some countries (for example Czech Republic, T-Mobile ISP) this card
-	  is shipped for service called UMTS 4G.
-
 endmenu
 
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index d35fc068da74..4de4fb9ce61a 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -301,6 +301,15 @@ config GOLDFISH_TTY_EARLY_CONSOLE
 	default y if GOLDFISH_TTY=y
 	select SERIAL_EARLYCON
 
+config IPWIRELESS
+	tristate "IPWireless 3G UMTS PCMCIA card support"
+	depends on PCMCIA && NETDEVICES
+	select PPP
+	help
+	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
+	  some countries (for example Czech Republic, T-Mobile ISP) this card
+	  is shipped for service called UMTS 4G.
+
 config N_GSM
 	tristate "GSM MUX line discipline support (EXPERIMENTAL)"
 	depends on NET
-- 
2.39.2

