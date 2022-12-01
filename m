Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579B363E70E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLABZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLABZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:25:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94903975F6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pk5DH7G/x9KTP95IkRi4C5JBQ3WWwGoC+AVueVfHSio=; b=SespthigY8G9VWNCp+UTy0ryA8
        3fxpFCtz3lHm0vPwhJfeb4mvc4aF6+diWFXOfkDxKWlNk2O0ys9mdxqowxrWSBQ/kVCts7+enK/bC
        nIbTSQ9Y9cDyvv97f6pH9MLoh1bsnnGDML80yWMSBYlLD/wJUa3QWe2sgQJe+7VJALZJoPWi9g+Y0
        /Zf5kzR3ouTL8eqMtjQbjpa2DBEm87Jfwi4c9tWu8GfxNZH8NZ+638Ml86KoB/g6jSYNbiztUnT0u
        Ob7M73kMxDoul/3iiFB//OalseT4C8uavkwlY0s8GJphLD50Yg7+/GA+zKgszdVBX3EwK0lXIZ2in
        7D5uOTvg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0YKo-00FVtG-47; Thu, 01 Dec 2022 01:25:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Andres Salomon <dilinger@queued.net>,
        linux-geode@lists.infradead.org, Lee Jones <lee@kernel.org>
Subject: [PATCH] mfd: cs5535: don't build on UML
Date:   Wed, 30 Nov 2022 17:25:41 -0800
Message-Id: <20221201012541.11809-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cs5535-mfd driver uses CPU-specific data that is not available
for ARCH=um builds, so don't allow it to be built for UML.

Prevents these build errors:

In file included from ../arch/x86/include/asm/olpc.h:7,
                 from ../drivers/mfd/cs5535-mfd.c:17:
../arch/x86/include/asm/geode.h: In function ‘is_geode_gx’:
../arch/x86/include/asm/geode.h:16:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
   16 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
../arch/x86/include/asm/geode.h:16:46: error: ‘X86_VENDOR_NSC’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
   16 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
../arch/x86/include/asm/geode.h:17:31: error: ‘struct cpuinfo_um’ has no member named ‘x86’
   17 |                 (boot_cpu_data.x86 == 5) &&
../arch/x86/include/asm/geode.h:18:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
   18 |                 (boot_cpu_data.x86_model == 5));
../arch/x86/include/asm/geode.h: In function ‘is_geode_lx’:
../arch/x86/include/asm/geode.h:23:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
   23 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
../arch/x86/include/asm/geode.h:23:46: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
   23 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
../arch/x86/include/asm/geode.h:24:31: error: ‘struct cpuinfo_um’ has no member named ‘x86’
   24 |                 (boot_cpu_data.x86 == 5) &&
../arch/x86/include/asm/geode.h:25:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
   25 |                 (boot_cpu_data.x86_model == 10));

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Cc: Andres Salomon <dilinger@queued.net>
Cc: linux-geode@lists.infradead.org
Cc: Lee Jones <lee@kernel.org>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -15,6 +15,7 @@ config MFD_CS5535
 	tristate "AMD CS5535 and CS5536 southbridge core functions"
 	select MFD_CORE
 	depends on PCI && (X86_32 || (X86 && COMPILE_TEST))
+	depends on !UML
 	help
 	  This is the core driver for CS5535/CS5536 MFD functions.  This is
 	  necessary for using the board's GPIO and MFGPT functionality.
