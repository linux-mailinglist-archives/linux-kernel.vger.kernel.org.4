Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2D5F3287
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJCPaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJCPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:30:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D06112AB1;
        Mon,  3 Oct 2022 08:29:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C04B12187A;
        Mon,  3 Oct 2022 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664810995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ox4ltjMjfoXYKHNGFlInSfH4y3XOXpGSwEj9RpfYwYs=;
        b=mgK6MXAy/k6wFGXadHPtSB+wzXevm7/vexrn3H+Lo7bwRZayH6CM3fBiWJyKfSUBE/8THl
        jqgRMrmRWAJutopgy8p9d30FQ6TDZwkgU1dJNLLmaOrkLi7fe66/pI9Om3+eoi+VqRgwLT
        I2WOAT3ML2n70l70mMZE18+hiS1EYuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664810995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ox4ltjMjfoXYKHNGFlInSfH4y3XOXpGSwEj9RpfYwYs=;
        b=2NZ2/9eX1UNGVm7/oj+qv6Z0AHUG9aRzBAI6EcnXs4tdoEcUM6EdRd7/nW13YLWgdyTfIu
        y4OC6LFF2LS4nAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 959141332F;
        Mon,  3 Oct 2022 15:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G/L8IvP/OmOdfgAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 03 Oct 2022 15:29:55 +0000
Date:   Mon, 3 Oct 2022 17:29:53 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Daniel Hung-yu Wu <hywu@google.com>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: misc - atmel_captouch does not depend on OF
Message-ID: <20221003172953.30354439@endymion.delvare>
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

The atmel_captouch driver does not actually depend on OF, it includes
a non-OF device ID which could be used to instantiate the device, and
the driver code is already prepared to be built with or without OF. So
drop the unneeded dependency.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Hung-yu Wu <hywu@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
The problem I'm trying to solve here is that "depends on OF ||
COMPILE_TEST" does not make sense since OF can now be enabled on all
architectures. One way to fix this is by removing the dependency
altogether (this patch).

If the driver is known to be needed only on OF-enabled systems then we
could leave the dependency on OF and only drop COMPILE_TEST (and
simplify the driver code accordingly). I have an alternative patch
doing that already. Tell me what you prefer, I'm fine either way.

 drivers/input/misc/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- linux-5.19.orig/drivers/input/misc/Kconfig
+++ linux-5.19/drivers/input/misc/Kconfig
@@ -107,7 +107,6 @@ config INPUT_ATC260X_ONKEY
 
 config INPUT_ATMEL_CAPTOUCH
 	tristate "Atmel Capacitive Touch Button Driver"
-	depends on OF || COMPILE_TEST
 	depends on I2C
 	help
 	  Say Y here if an Atmel Capacitive Touch Button device which


-- 
Jean Delvare
SUSE L3 Support
