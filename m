Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2EA6DB11C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDGRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDGRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:05:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939D8A42
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:04:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55AEC21D72;
        Fri,  7 Apr 2023 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680887095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OP+WQoqp5N6LD5bTBcxYrhZCAveaV/0KikGNAEyK220=;
        b=Rl5rPqtWZskhI9Ty3Bk7hN3/0M3GBUF9uKToD4wVcKEd0o0uUr9rnL7alvC7FZoYg3J73r
        65nuOW38/cVxkB7kI9TsXHA/xAcLQ3cFCd2U4brzPx1P2s/GaxcX/d3s0HT5HjW97LaFIm
        RJNyNvr0NMtui5s0b4cOHc57dp98NqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680887095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OP+WQoqp5N6LD5bTBcxYrhZCAveaV/0KikGNAEyK220=;
        b=akaAwtwzT4XP6KUz0DCzUUe08sh+JE8HKAjMiuke0R2hFKA2vmj6S7tj3cWabWyxZ4Uorc
        wxtiUUhpCbQChBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B2ED133FE;
        Fri,  7 Apr 2023 17:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hOzGBDdNMGR4PAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 07 Apr 2023 17:04:55 +0000
Date:   Fri, 7 Apr 2023 19:04:53 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH RESEND] mtd: onenand: omap2: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20230407190453.66efdf9d@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
---
Even though this was supposedly accepted a few months ago already, I
can't find this commit, neither upstream nor in the nand/next,
therefore resending.

 drivers/mtd/nand/onenand/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.2.orig/drivers/mtd/nand/onenand/Kconfig
+++ linux-6.2/drivers/mtd/nand/onenand/Kconfig
@@ -25,7 +25,7 @@ config MTD_ONENAND_GENERIC
 config MTD_ONENAND_OMAP2
 	tristate "OneNAND on OMAP2/OMAP3 support"
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on OMAP_GPMC
 	help
 	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC


-- 
Jean Delvare
SUSE L3 Support
