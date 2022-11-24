Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5766376FD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKXK7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKXK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:59:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076478481D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:59:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD2781F38D;
        Thu, 24 Nov 2022 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669287587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gzt8jTwR+NxgS/gIm8RH0/+q5NKPvkljd3y17tGlyoE=;
        b=R+7hpGQSN7xUv298CcH34JqHZDvEupABZykW3XFGobD5J9IZltFKz5f5xcdEegA/oStsYw
        2it0RpnRmQneDb0N7BW0PWKBpzcG0hNxwSeqimE/oE8H3U/HNRlqxA7xTx0OEizUopjX6/
        Gn0P01XvEaEQ3jSisw9Gmfg+w4jMPdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669287587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gzt8jTwR+NxgS/gIm8RH0/+q5NKPvkljd3y17tGlyoE=;
        b=EPBS1H7c9Zp9eZJxBb02FuHKQB9hwssIERiC/nNYOk7erunsduRHIXYzwNLm29kAqsnTp7
        Kjv0dm3GlOmO45AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DD9113B4F;
        Thu, 24 Nov 2022 10:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GVwVGaNOf2NlUwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 24 Nov 2022 10:59:47 +0000
Date:   Thu, 24 Nov 2022 11:59:46 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: [PATCH] mtd: rawnand: Drop obsolete dependencies on COMPILE_TEST
Message-ID: <20221124115946.5edb771c@endymion.delvare>
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
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
 drivers/mtd/nand/raw/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-6.0.orig/drivers/mtd/nand/raw/Kconfig
+++ linux-6.0/drivers/mtd/nand/raw/Kconfig
@@ -435,7 +435,7 @@ config MTD_NAND_PLATFORM
 
 config MTD_NAND_CADENCE
 	tristate "Support Cadence NAND (HPNFC) controller"
-	depends on (OF || COMPILE_TEST) && HAS_IOMEM
+	depends on OF && HAS_IOMEM
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
 	  controller.
@@ -450,7 +450,7 @@ config MTD_NAND_ARASAN
 
 config MTD_NAND_INTEL_LGM
 	tristate "Support for NAND controller on Intel LGM SoC"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	help
 	  Enables support for NAND Flash chips on Intel's LGM SoC.
@@ -470,7 +470,7 @@ config MTD_NAND_ROCKCHIP
 
 config MTD_NAND_PL35X
 	tristate "ARM PL35X NAND controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on PL353_SMC
 	help
 	  Enables support for PrimeCell SMC PL351 and PL353 NAND


-- 
Jean Delvare
SUSE L3 Support
