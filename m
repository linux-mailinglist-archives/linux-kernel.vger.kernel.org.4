Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71D469F14B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjBVJXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBVJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:23:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9356927D7C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:23:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17895611C0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B0DC433D2;
        Wed, 22 Feb 2023 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677057786;
        bh=PEl/1o6Ky0H58zZDig1uvvTpR+B+kcuCg0hsc6tBDMM=;
        h=From:To:Cc:Subject:Date:From;
        b=DsDWSCshW2OK6d8a9z0RBRHKU6NLAASN+1no5Fmegp8h0vBwA6ioZPkIAjf7nbEmS
         SYGKiQAnIWR3HyVpgKLAbfdScIKZ3LXCHqGJVfRBIZjTvNj/nCDKjDaJaRyDNhyVMz
         qGVqGCMAsGJ5USWP1MLlpOHLZEmOuH4Yau4+x+Coxd04zqMGLOe2rfw9+S2JU+1V1K
         8obX4EkAwaPfju2e+ZLQdY9TDuw7tv+y9KuijYyTi6T50yeRcyke4VrqcJLDqkQGx2
         KI7Wzl/ZFyJzsPz8piCEDhxH465uYNSbtlNq2g8jlcylQSuZI6UgUkG+n7Hw11XCk1
         3Cc/oLrCZllCQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/2] tty: ipwireless: move Kconfig entry to tty
Date:   Wed, 22 Feb 2023 10:23:01 +0100
Message-Id: <20230222092302.6348-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.2
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

