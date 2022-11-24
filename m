Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E516378F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKXMhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXMhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:37:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E921FCE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:37:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A4E631F74A;
        Thu, 24 Nov 2022 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669293459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uX6LAJqwTA1Rqk87eeq2dDV+YZjLOprsaYhch3PZdaI=;
        b=Wy36XfSsBMcTmPDWph0AnKTca7TSqX8k9Nvr2ih9N2KQwZvT6rSsNiRUqXPrp6RFIE5An5
        G8R8ueFPqHtDKnPZWPpQb/1WV82gHBAfqQ1SdmSXU3/BEzvl1EN6VPllpMBa6gFnFwX5EA
        ek70VpfWWcj3UH1lGWfibCE2yMRMCnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669293459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uX6LAJqwTA1Rqk87eeq2dDV+YZjLOprsaYhch3PZdaI=;
        b=ZaDgDtPtaU7KVVrokplVDTkV2IZfY8zqChuaHPo+8gjigr8gZvkHMXHBkHZgdl2FiciQ8A
        E3fbY2f0+spXJmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8522613488;
        Thu, 24 Nov 2022 12:37:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QqXNHpNlf2MUCQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 24 Nov 2022 12:37:39 +0000
Date:   Thu, 24 Nov 2022 13:37:37 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mux: mmio: drop obsolete dependency on COMPILE_TEST
Message-ID: <20221124133737.659429ce@endymion.delvare>
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

As a minor optimization, this also lets us drop of_match_ptr(), as we
now know what it will resolve to, we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig |    2 +-
 drivers/mux/mmio.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-6.0.orig/drivers/mux/Kconfig
+++ linux-6.0/drivers/mux/Kconfig
@@ -47,7 +47,7 @@ config MUX_GPIO
 
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
--- linux-6.0.orig/drivers/mux/mmio.c
+++ linux-6.0/drivers/mux/mmio.c
@@ -131,7 +131,7 @@ static int mux_mmio_probe(struct platfor
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
-		.of_match_table	= of_match_ptr(mux_mmio_dt_ids),
+		.of_match_table	= mux_mmio_dt_ids,
 	},
 	.probe = mux_mmio_probe,
 };


-- 
Jean Delvare
SUSE L3 Support
