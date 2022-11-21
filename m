Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632AF632907
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKUQJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKUQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:09:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291DCC72F0;
        Mon, 21 Nov 2022 08:09:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE8B91F899;
        Mon, 21 Nov 2022 16:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669046954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KyfNmcPz42geDnL1EI62RbwuzIIJ0tLz64n6CtQSE5I=;
        b=AxHbtyPn8fCOhgK03LCj+hsL1iGrhbOLg2ykdln3BBS3q2x7elr/R6Wkj8m8fCJB79AUQP
        TOo27oxKLH65LRjtrQ+L6EdBKjjw3ZmyOpQm4+8uuLj7DX6fpb/ELJR+mmOP/hLjP7zDe3
        sAjsRdxOJVrHnS/UvbnGwyl80SfCkSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669046954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KyfNmcPz42geDnL1EI62RbwuzIIJ0tLz64n6CtQSE5I=;
        b=ko02FeoOF0N1Xxryj1kDA6bduoJiMktnvqb0DEqehmw5HBSDGM7KzAbEwQVMazZJ/tynFq
        BVT6DLS1yOOHlECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EBD21377F;
        Mon, 21 Nov 2022 16:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y0E0Iaqie2N7VwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 21 Nov 2022 16:09:14 +0000
Date:   Mon, 21 Nov 2022 17:09:11 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Sean Young <sean@mess.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=" 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] media: rc: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221121170911.7cd72bfc@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

As a minor optimization, this also lets us drop of_match_ptr(), as we
now know what it will resolve to, we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
---
 drivers/media/rc/Kconfig     |    4 ++--
 drivers/media/rc/pwm-ir-tx.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-6.0.orig/drivers/media/rc/Kconfig
+++ linux-6.0/drivers/media/rc/Kconfig
@@ -314,7 +314,7 @@ config IR_PWM_TX
 	tristate "PWM IR transmitter"
 	depends on LIRC
 	depends on PWM
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	   Say Y if you want to use a PWM based IR transmitter. This is
 	   more power efficient than the bit banging gpio driver.
@@ -361,7 +361,7 @@ config IR_SERIAL_TRANSMITTER
 config IR_SPI
 	tristate "SPI connected IR LED"
 	depends on SPI && LIRC
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  Say Y if you want to use an IR LED connected through SPI bus.
=20
--- linux-6.0.orig/drivers/media/rc/pwm-ir-tx.c
+++ linux-6.0/drivers/media/rc/pwm-ir-tx.c
@@ -120,7 +120,7 @@ static struct platform_driver pwm_ir_dri
 	.probe =3D pwm_ir_probe,
 	.driver =3D {
 		.name	=3D DRIVER_NAME,
-		.of_match_table =3D of_match_ptr(pwm_ir_of_match),
+		.of_match_table =3D pwm_ir_of_match,
 	},
 };
 module_platform_driver(pwm_ir_driver);


--=20
Jean Delvare
SUSE L3 Support
