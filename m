Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A63694351
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjBMKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBMKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:43:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21416AC8;
        Mon, 13 Feb 2023 02:43:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6047F60FA7;
        Mon, 13 Feb 2023 10:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E406AC43339;
        Mon, 13 Feb 2023 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676284996;
        bh=roctf62/yqPkgEsUS/nfvm5p+4sye80U1pGQ8NLWzxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/NB3Z35oO3xp7BNUVdB8aBYC1V46+hJx6gbi9JYyG+4X5Z+ddU0Ifejx1SVieXbd
         R51bU8IKULnwV0dtRZ6CcTBpcnr+dFODpNe97S38ulqotmTtAaX+oQkYd5+0r81vUC
         BYl/RR7/lEdqCx++k1z99YPxZ/5KTHghRhvNzlgersrMmzz5u50pA/5uiaTOamVHtB
         vZfQflnwHXGVFt1FvJBedMI6JEEW/fHg64E9Nxhc5EaEsHhq5zZ6O5NBdGCFghBRzG
         1rTD6y3ujNixCWL5oB9/jPEkADHit36hBJhKLm4n8oMjS1HDmWJw2FJHHiz1/rFbKq
         uQ0lDTo6NIFrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pRWJb-0004Wp-Vx; Mon, 13 Feb 2023 11:44:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v6 12/20] x86/ioapic: Use irq_domain_create_hierarchy()
Date:   Mon, 13 Feb 2023 11:42:54 +0100
Message-Id: <20230213104302.17307-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213104302.17307-1-johan+linaro@kernel.org>
References: <20230213104302.17307-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the irq_domain_create_hierarchy() helper to create the hierarchical
domain, which both serves as documentation and avoids poking at
irqdomain internals.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/x86/kernel/apic/io_apic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index a868b76cd3d4..1f83b052bb74 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2364,9 +2364,8 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENODEV;
 	}
 
-	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
-						 (void *)(long)ioapic);
-
+	ip->irqdomain = irq_domain_create_hierarchy(parent, 0, hwirqs, fn, cfg->ops,
+						    (void *)(long)ioapic);
 	if (!ip->irqdomain) {
 		/* Release fw handle if it was allocated above */
 		if (!cfg->dev)
@@ -2374,8 +2373,6 @@ static int mp_irqdomain_create(int ioapic)
 		return -ENOMEM;
 	}
 
-	ip->irqdomain->parent = parent;
-
 	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
 	    cfg->type == IOAPIC_DOMAIN_STRICT)
 		ioapic_dynirq_base = max(ioapic_dynirq_base,
-- 
2.39.1

