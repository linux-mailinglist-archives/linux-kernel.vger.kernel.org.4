Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F367E343
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjA0L3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjA0L3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:29:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC17E681;
        Fri, 27 Jan 2023 03:28:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 33D662003F;
        Fri, 27 Jan 2023 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674818898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tDOqTbs0S3Y0iW7HxTYwoZGCDL2WVLefPe2n98YmMuk=;
        b=eQmkJHzYyShNotnOsAuCffwXvYJOAC9lLBUOLg8k2yXbrXdAnumj7p3nB7tMaQVYRx0bbO
        ao5iAwLyJWtgyXlirw1GU52L4FMTDIa5D0gDdF+8ZYdP+mZOb+kJqEv0dFqPa04C4hvVue
        uOxm4NxBBtNSP3kLD1lob03F7hMgmY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674818898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tDOqTbs0S3Y0iW7HxTYwoZGCDL2WVLefPe2n98YmMuk=;
        b=IxFGJ3LqrCl5bt0C2vF/VtW/yDY8ITWzELW/Jno4GLwuLiOsGtudj5NB4fSCH3svcgDptu
        qeLQESI2b5vA/gBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEB911336F;
        Fri, 27 Jan 2023 11:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b+feNFG102PBXQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 27 Jan 2023 11:28:17 +0000
Date:   Fri, 27 Jan 2023 12:28:16 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Daniel Hung-yu Wu <hywu@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH RESEND] Input: atmel_captouch - drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230127122816.02b6ea26@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

As a nice side effect, dropping the alternative dependency on
COMPILE_TEST allows removing preprocessor directives, which will
speed up the build.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Hung-yu Wu <hywu@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig          |    2 +-
 drivers/input/misc/atmel_captouch.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-6.1.orig/drivers/input/misc/Kconfig
+++ linux-6.1/drivers/input/misc/Kconfig
@@ -107,7 +107,7 @@ config INPUT_ATC260X_ONKEY
 
 config INPUT_ATMEL_CAPTOUCH
 	tristate "Atmel Capacitive Touch Button Driver"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on I2C
 	help
 	  Say Y here if an Atmel Capacitive Touch Button device which
--- linux-6.1.orig/drivers/input/misc/atmel_captouch.c
+++ linux-6.1/drivers/input/misc/atmel_captouch.c
@@ -249,7 +249,6 @@ static int atmel_captouch_probe(struct i
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id atmel_captouch_of_id[] = {
 	{
 		.compatible = "atmel,captouch",
@@ -257,7 +256,6 @@ static const struct of_device_id atmel_c
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_captouch_of_id);
-#endif
 
 static const struct i2c_device_id atmel_captouch_id[] = {
 	{ "atmel_captouch", 0 },
@@ -270,7 +268,7 @@ static struct i2c_driver atmel_captouch_
 	.id_table	= atmel_captouch_id,
 	.driver		= {
 		.name	= "atmel_captouch",
-		.of_match_table = of_match_ptr(atmel_captouch_of_id),
+		.of_match_table = atmel_captouch_of_id,
 	},
 };
 module_i2c_driver(atmel_captouch_driver);


-- 
Jean Delvare
SUSE L3 Support
