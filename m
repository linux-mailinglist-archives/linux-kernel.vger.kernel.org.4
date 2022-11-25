Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89CF763847A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKYHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKYHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:31:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD332EF22;
        Thu, 24 Nov 2022 23:31:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15EE31FD6A;
        Fri, 25 Nov 2022 07:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669361476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ImTHg8wp1YuWBD1u/zKh5wMZcbvJBeWeRc4u2kWfZ0=;
        b=KZ5zA6j6enxVMk9kJL/P2SkmkBHJI6x3TixF7VexpB2x+/wUKjQ0uxkUpo2/OpkjEHPTvo
        4CDsYBLXB/KPZ9xIUcMFQWK62791iWHlfAF6a87RPBvPR7LMRoc0S6YvGx6dLkvm5rmhTC
        uxFtMSfn7cosRM14SrOvLDgHDnA5q+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669361476;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ImTHg8wp1YuWBD1u/zKh5wMZcbvJBeWeRc4u2kWfZ0=;
        b=Ckc/7vyNb4POxJJZBB3qajXdQwMTz3NSSyoTvMIrAd5UMnq41pisSgTZPWUqGPBZtzYng4
        Qdht/XBPh/KyhqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E351E1361C;
        Fri, 25 Nov 2022 07:31:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +hTeNUNvgGN7DQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Fri, 25 Nov 2022 07:31:15 +0000
Date:   Fri, 25 Nov 2022 08:31:14 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     linux-spi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: cadence: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221125083114.67e7f83c@endymion.delvare>
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
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig            |    2 +-
 drivers/spi/spi-cadence-xspi.c |    4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

--- linux-6.0.orig/drivers/spi/Kconfig
+++ linux-6.0/drivers/spi/Kconfig
@@ -241,7 +241,7 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on (OF || COMPILE_TEST) && HAS_IOMEM
+	depends on OF && HAS_IOMEM
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
--- linux-6.0.orig/drivers/spi/spi-cadence-xspi.c
+++ linux-6.0/drivers/spi/spi-cadence-xspi.c
@@ -609,7 +609,6 @@ static int cdns_xspi_probe(struct platfo
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
@@ -617,9 +616,6 @@ static const struct of_device_id cdns_xs
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
-#else
-#define cdns_xspi_of_match NULL
-#endif /* CONFIG_OF */
 
 static struct platform_driver cdns_xspi_platform_driver = {
 	.probe          = cdns_xspi_probe,


-- 
Jean Delvare
SUSE L3 Support
