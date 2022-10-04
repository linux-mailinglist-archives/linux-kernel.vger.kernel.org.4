Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE45F3E49
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJDI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJDI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:26:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7E922B1A;
        Tue,  4 Oct 2022 01:26:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21AF01F8DD;
        Tue,  4 Oct 2022 08:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664871968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H1Hk6lCMjhjIrK/vqumKpa8S2cOkrzXNW7d+6hCEqg8=;
        b=vJiqd8VRxXkTbMHSN4aiT72TwxTw1Ck/1GTH6IeqQ07J57ysKFjVSOP9MaNOD7PTvVNu3c
        Weu0hoI7P3Y7i59xA0CJV6kV7eQl0oNsP7GJcwLyk6wug0n79nddrhyY8cQ3V4NSF9Z59S
        q/GbJoWlb2kEv9/dkWbSnawyQsUEw30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664871968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H1Hk6lCMjhjIrK/vqumKpa8S2cOkrzXNW7d+6hCEqg8=;
        b=2c/ErdMw6oxsKZBA5cr6JY+XpuETrWt4XrLflfWtEu/rBvbrtRxV4SgqctoM0YLZA3yLNS
        oLA6yjLMzJdRQCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE55B139EF;
        Tue,  4 Oct 2022 08:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEsXOB/uO2NHTwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 04 Oct 2022 08:26:07 +0000
Date:   Tue, 4 Oct 2022 10:26:06 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Daniel Hung-yu Wu <hywu@google.com>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: atmel_captouch - drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20221004102606.5d49e5d7@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
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

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

As a matter of fact, dropping the alternative dependency on
COMPILE_TEST allows removing preprocessor directives, which will
speed up the build.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Hung-yu Wu <hywu@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig          |    2 +-
 drivers/input/misc/atmel_captouch.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-5.19.orig/drivers/input/misc/Kconfig
+++ linux-5.19/drivers/input/misc/Kconfig
@@ -107,7 +107,7 @@ config INPUT_ATC260X_ONKEY
 
 config INPUT_ATMEL_CAPTOUCH
 	tristate "Atmel Capacitive Touch Button Driver"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on I2C
 	help
 	  Say Y here if an Atmel Capacitive Touch Button device which
--- linux-5.19.orig/drivers/input/misc/atmel_captouch.c
+++ linux-5.19/drivers/input/misc/atmel_captouch.c
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
