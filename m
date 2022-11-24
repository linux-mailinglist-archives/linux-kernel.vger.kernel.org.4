Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B2637CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKXPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:17:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5270316E8D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:16:21 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 112C621AAE;
        Thu, 24 Nov 2022 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669302980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lFWIP7ovUYBT8Xkxu4psBSN8B2MwPFxyKnu9NZvDse8=;
        b=h5dS5qqvRG1CQZDiISI0EJAo07yH6fMI3KCARQnzvdnaSo1MajGwR1WnW1+vNnhUZuzjwT
        rR8XHJ19Wy+/a7Aclkw3rdlQ9bPu+4ZzeckQYUamOzpB3pgbALzPxafyyofxqqDyDRTnNC
        DNtp6V//zgSlRXcPXuQsVjjJ0Fu3j3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669302980;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lFWIP7ovUYBT8Xkxu4psBSN8B2MwPFxyKnu9NZvDse8=;
        b=iostWWR3qeJpqnrd2mviUerTNOOPeK0J82ozf4ZChq+tCpDONx/7rVFfpJseDGFv6Dqgj9
        0DXiTBNxRP+NFrDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D567B13488;
        Thu, 24 Nov 2022 15:16:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZE2HMsOKf2PzYwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 24 Nov 2022 15:16:19 +0000
Date:   Thu, 24 Nov 2022 16:16:18 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH] drivers/soc/litex: drop obsolete dependency on COMPILE_TEST
Message-ID: <20221124161618.34ca07b3@endymion.delvare>
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

As a minor optimization, this also lets us drop of_match_ptr() and
ifdef-guarding, as we now know what they will resolve to, we might as
well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Karol Gugala <kgugala@antmicro.com>
Cc: Mateusz Holenko <mholenko@antmicro.com>
Cc: Gabriel Somlo <gsomlo@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 drivers/soc/litex/Kconfig          |    2 +-
 drivers/soc/litex/litex_soc_ctrl.c |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-6.0.orig/drivers/soc/litex/Kconfig
+++ linux-6.0/drivers/soc/litex/Kconfig
@@ -7,7 +7,7 @@ config LITEX
 
 config LITEX_SOC_CONTROLLER
 	tristate "Enable LiteX SoC Controller driver"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	depends on HAS_IOMEM
 	select LITEX
 	help
--- linux-6.0.orig/drivers/soc/litex/litex_soc_ctrl.c
+++ linux-6.0/drivers/soc/litex/litex_soc_ctrl.c
@@ -82,13 +82,11 @@ static int litex_reset_handler(struct no
 	return NOTIFY_DONE;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id litex_soc_ctrl_of_match[] = {
 	{.compatible = "litex,soc-controller"},
 	{},
 };
 MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
-#endif /* CONFIG_OF */
 
 static int litex_soc_ctrl_probe(struct platform_device *pdev)
 {
@@ -131,7 +129,7 @@ static int litex_soc_ctrl_remove(struct
 static struct platform_driver litex_soc_ctrl_driver = {
 	.driver = {
 		.name = "litex-soc-controller",
-		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
+		.of_match_table = litex_soc_ctrl_of_match,
 	},
 	.probe = litex_soc_ctrl_probe,
 	.remove = litex_soc_ctrl_remove,


-- 
Jean Delvare
SUSE L3 Support
