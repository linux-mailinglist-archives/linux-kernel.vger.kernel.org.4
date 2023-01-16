Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0ED66C052
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjAPNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjAPNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF8B21966;
        Mon, 16 Jan 2023 05:50:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FC13B80F97;
        Mon, 16 Jan 2023 13:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B838C43329;
        Mon, 16 Jan 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673877041;
        bh=AK3VCepyLTeOpIFmxwgh5xFJYCJU4/85AqeI5PyR5Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTchXNWY+z/sxVHLzD4M9BdaWIAa7SmM3hr6/+6zJyYYXMI2sIrT+/r0hUfT89Npw
         LaH72M9fgR+oYmIuQYQuQwisq5c4J9r6sQb9RHYhYz+XZaDa1ZLerMd8v1fGI7tOv0
         qx6WvR9CvBoci06yw9LLcxtLas/vfUw40VTU6YJ1pdAtvCGQHgp78iMFaxV/YLB1bb
         Mq4sDq3xphF15PvtMC6HwRHussdS4e6ZR1WgWMgI+qhvgFPg+l1zljkLT1b9p1TLEB
         f7/83DUqXVmnFnGpQTOIuWQAKR4vDmnB6ezPxzKbPx0AShuc5s8fM5nP1atvhZ8d/d
         Z0KqzFzrSbEVw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pHPt6-0003vD-FM; Mon, 16 Jan 2023 14:51:00 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Subject: [PATCH v4 11/19] x86/ioapic: Use irq_domain_create_hierarchy()
Date:   Mon, 16 Jan 2023 14:50:36 +0100
Message-Id: <20230116135044.14998-12-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230116135044.14998-1-johan+linaro@kernel.org>
References: <20230116135044.14998-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
Tested-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
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
2.38.2

