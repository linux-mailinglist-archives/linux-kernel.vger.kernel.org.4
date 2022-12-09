Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946F0648361
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiLIOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiLIOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:05:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0766D75BCA;
        Fri,  9 Dec 2022 06:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB426226A;
        Fri,  9 Dec 2022 14:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D964CC4332C;
        Fri,  9 Dec 2022 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670594713;
        bh=WgkN5Je4cNOPVZ/hkI2lCqO1EkpEAYkIqXZpsz/aHt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt/0JpLZVVFNgMrMfpluMRkkS1efDFdyD9NG2ZAWI0Yy86pZT9zhcPVjSD6Q5JhQC
         VOhYIkAxut3lwd51nXIxbqzhfnpeeOraosktgApMH6WlqmkxwkGBA45z8IlaLPjz5F
         /7OsANSOCDKqf6/C0788t7x6G/3JNYbCsRtXsFXd3q9N6dOdlRfcOhyRCsDtpdZpRY
         596PPCham19J1eMFCGq3Xd7G8daWN9xx9UI3vLCYwKDmnx528mpZvoGzMSgBQWhvOI
         KQNBEB3XnMIPDhOs9rx//GTKhS8q15YLJl8NktAiHzRTPSqaJhDl0AXmIEpl/gGbDa
         ubTCupgoJr0qg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p3e0J-0000Rs-5E; Fri, 09 Dec 2022 15:05:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 11/19] x86/ioapic: Use irq_domain_create_hierarchy()
Date:   Fri,  9 Dec 2022 15:01:42 +0100
Message-Id: <20221209140150.1453-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221209140150.1453-1-johan+linaro@kernel.org>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a868b76cd3d4..9cc4c8e0c3c4 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2364,9 +2364,9 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENODEV;
 	}
 
-	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
-						 (void *)(long)ioapic);
-
+	ip->irqdomain = irq_domain_create_hierarchy(parent, 0, hwirqs, fn,
+						    cfg->ops,
+						    (void *)(long)ioapic);
 	if (!ip->irqdomain) {
 		/* Release fw handle if it was allocated above */
 		if (!cfg->dev)
@@ -2374,8 +2374,6 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
 
-	ip->irqdomain->parent = parent;
-
 	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
 	    cfg->type == IOAPIC_DOMAIN_STRICT)
 		ioapic_dynirq_base = max(ioapic_dynirq_base,
-- 
2.37.4

