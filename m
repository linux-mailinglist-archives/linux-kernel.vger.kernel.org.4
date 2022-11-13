Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4C626D95
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 04:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiKMDal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 22:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKMDai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 22:30:38 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E913DF7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 19:30:36 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1668310234;
        bh=2gTkiOcwRu1rvtsieSB6uYYfG6KwpnDzYJ7VI3RNyQA=;
        h=From:To:Cc:Subject:Date:From;
        b=b+WhP7YAnAS8pr7aHdB3Jd89kWdSvdLDW7JXO+7p6QDkJPFCKHIeablhfi6hZJVAk
         aUPJmiokBqqZEYesqNT2f2QNOEsfiRhZ0byPrg7N8FzHSxPzcBp0KmR5X8OuA1+k0/
         qh3BCMAbMS2ky54HSMU/PAH9kuVRnT3Xx/bcUyf8=
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-input@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] macintosh/mac_hid.c: don't load by default
Date:   Sun, 13 Nov 2022 04:30:22 +0100
Message-Id: <20221113033022.2639-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668310220; l=1025; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=2gTkiOcwRu1rvtsieSB6uYYfG6KwpnDzYJ7VI3RNyQA=; b=/j6qqxCFitLVms6T0bo554pD1PYuGU4fej2PB1Xt0KyhqBLYFyNUkX4SOqLu/KdIPnSZhFsqjkBg 3h1eojjyBbDRrxOrzFCCOvAKyxqK+6wbQJaNfxQj6LsvS1MZuqjR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be no need to automatically load this driver on *all*
machines with a keyboard.

This driver is of very limited utility and has to be enabled by the user
explicitly anyway.
Furthermore its own header comment has deprecated it for 17 years.

Fixes: 99b089c3c38a ("Input: Mac button emulation - implement as an input filter")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/macintosh/mac_hid.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index d8c4d5664145..d01d28890db4 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -149,8 +149,6 @@ static const struct input_device_id mac_hid_emumouse_ids[] = {
 	{ },
 };
 
-MODULE_DEVICE_TABLE(input, mac_hid_emumouse_ids);
-
 static struct input_handler mac_hid_emumouse_handler = {
 	.filter		= mac_hid_emumouse_filter,
 	.connect	= mac_hid_emumouse_connect,

base-commit: fef7fd48922d11b22620e19f9c9101647bfe943d
-- 
2.38.1

