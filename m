Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21596632456
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKUNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKUNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:52:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F401D66F;
        Mon, 21 Nov 2022 05:52:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7513A220C2;
        Mon, 21 Nov 2022 13:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669038724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RVEFgUtZmQXpynz9nXU2lTDmNFxoHkG7RXWPsOzqluA=;
        b=YoqJBlfmYMvDRAXgt7cews3hBtfZezJsKPFYj9peNazbzBw9zPPOQP4343b2nOBtHbsU3n
        gF60VzHAySFEgqKVuO3JmYHx4IlWDLPD4CVOyjbmG2q1WhmGZyOFGoFQjT7Dy2C0MMm6dy
        Lx6zpAvrfqbHavuw95oH9ORw3aVy/Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669038724;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RVEFgUtZmQXpynz9nXU2lTDmNFxoHkG7RXWPsOzqluA=;
        b=4lbOvuY+M3guHsXDCjx3VjcuH2EVxUEodFlmqtmjd2fqAQ0taVaxy7kHkymiiOfFfS+scV
        Plff/h7hpTIBvlBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E9901377F;
        Mon, 21 Nov 2022 13:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pwl8EYSCe2NfCAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 21 Nov 2022 13:52:04 +0000
Date:   Mon, 21 Nov 2022 14:52:03 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: stmpe-ts - drop obsolete dependency on COMPILE_TEST
Message-ID: <20221121145203.1efb0c08@endymion.delvare>
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

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.0.orig/drivers/input/touchscreen/Kconfig
+++ linux-6.0/drivers/input/touchscreen/Kconfig
@@ -1241,7 +1241,7 @@ config TOUCHSCREEN_STMFTS
 config TOUCHSCREEN_STMPE
 	tristate "STMicroelectronics STMPE touchscreens"
 	depends on MFD_STMPE
-	depends on (OF || COMPILE_TEST)
+	depends on OF
 	help
 	  Say Y here if you want support for STMicroelectronics
 	  STMPE touchscreen controllers.


-- 
Jean Delvare
SUSE L3 Support
