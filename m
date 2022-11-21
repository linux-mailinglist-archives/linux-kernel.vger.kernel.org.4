Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4316327B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiKUPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKUPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:19:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5CAC4956
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:16:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F93121F27;
        Mon, 21 Nov 2022 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669043784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vHc0JxpY9yELhVEGHl1FGW0cCpd91Wd+NyLrvggT+k8=;
        b=dhq4gIQ2lWK1r5hIaAEBkZkfoMBjGo5wgCG22y07yK7V7/+Nu6sgyuaNLrQfxW1JpPOTtS
        9lF9CyuFh13eA9MG19imYMYyUQbMfHpV8h150OBO7TAhpD4cS6MES03W0El6X7Zm423CNa
        bbDukUEgi+HyS24cqunsx4kBkDyNSOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669043784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vHc0JxpY9yELhVEGHl1FGW0cCpd91Wd+NyLrvggT+k8=;
        b=cIfaTiv4MWMJzs4reAEHh9lP8Jt6NBnBcWNvOFr3+WeTnBgLpTxxnXqrLUmCzW0nQJ0fSt
        cizf00GhLcNruzDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7B0F1376E;
        Mon, 21 Nov 2022 15:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 56ACM0eWe2NAOQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 21 Nov 2022 15:16:23 +0000
Date:   Mon, 21 Nov 2022 16:16:22 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Talel Shenhar <talel@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip/al-fic: Drop obsolete dependency on COMPILE_TEST
Message-ID: <20221121161622.6294a899@endymion.delvare>
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
Cc: Talel Shenhar <talel@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.0.orig/drivers/irqchip/Kconfig
+++ linux-6.0/drivers/irqchip/Kconfig
@@ -86,7 +86,7 @@ config ALPINE_MSI
 
 config AL_FIC
 	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help


-- 
Jean Delvare
SUSE L3 Support
