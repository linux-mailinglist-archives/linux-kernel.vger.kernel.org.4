Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56436767A2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjAUR3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUR3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:29:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A02005D
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:29:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C484521C8A;
        Sat, 21 Jan 2023 17:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674322152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j4VO2ktFD8XwmrMnjC4SihkmySP43vA2bq/lKUWsQuU=;
        b=BiMQR+g7BofqhZNKJ2b6A4BMcW7mvOPXihXcTiJZ8iQ6z6RbCT/RCA9RWKJI290PCAIK3y
        uJ3rrJ/WpYix2WSnbgdkE9guRneHBH9+YCqIzGKxwd4UH56UbpCRnYjjI28yx6FnuaeKLk
        8bLWLR2q6/wsNw+Q07rpqRUJ3FDDWFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674322152;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j4VO2ktFD8XwmrMnjC4SihkmySP43vA2bq/lKUWsQuU=;
        b=oWEN7s0U0c6JFZA9U8lOLLEPHOmbYyVZTWyI/kOFAc0vo+J3P1jn+THyXWQk2dlBGUutN5
        BchbKpm0hr8t3DAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 999EA1357F;
        Sat, 21 Jan 2023 17:29:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5NADJOggzGP3IwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 21 Jan 2023 17:29:12 +0000
Date:   Sat, 21 Jan 2023 18:29:11 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: |PATCH RESEND] clocksource/drivers/timer-microchip-pit64b: Drop
 obsolete dependency on COMPILE_TEST
Message-ID: <20230121182911.4e47a5ff@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.1.orig/drivers/clocksource/Kconfig
+++ linux-6.1/drivers/clocksource/Kconfig
@@ -706,7 +706,7 @@ config INGENIC_OST
 
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel


-- 
Jean Delvare
SUSE L3 Support
