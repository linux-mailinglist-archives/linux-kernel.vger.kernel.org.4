Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BA463E2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiK3Vz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiK3Vz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:55:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797407615A;
        Wed, 30 Nov 2022 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IYRKxi+onLBFbh4zY0bg9jQRkT3TX2p808M3H7FEIdk=; b=goeggzxiVtspFRe1gCJYV2AjAY
        3Ien6lK0K0BV9wiAGtv//wzGWz+O8fXUKPwpErcqh4Hc6va6uoVte449UkPeVtdFBUyvgfz1CBA3h
        WupqZvb7OgIQcJ3wjHdpYFVenXpiwYuYrQ+l9BRsQqbZjWQRJaptQaYsgH3WqLWeiWEJnPLEOBcE2
        cJfLGab+Am3K/zwPuvgF/nkLtN1lnsFmdyi5fSWpGDDKkM3523z4ASMf/QcQ+tuiXzAprfodEI+Qf
        Ix0WXRT0AG4kIZnHJnSzyVCRWbLkmAZlngq3lZ4WCsNSzwoV9vtu2K8SizYZkDWZe/Wb0iRRc0qh2
        qVUd31gA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0V3d-00FKCY-3n; Wed, 30 Nov 2022 21:55:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andres Salomon <dilinger@queued.net>,
        linux-geode@lists.infradead.org
Subject: [PATCH 1/2] fbdev: geode: don't build on UML
Date:   Wed, 30 Nov 2022 13:55:44 -0800
Message-Id: <20221130215544.28497-1-rdunlap@infradead.org>
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

The geode fbdev driver uses struct cpuinfo fields that are not present
on ARCH=um, so don't allow this driver to be built on UML.

Prevents these build errors:

In file included from ../arch/x86/include/asm/olpc.h:7:0,
                 from ../drivers/mfd/cs5535-mfd.c:17:
../arch/x86/include/asm/geode.h: In function ‘is_geode_gx’:
../arch/x86/include/asm/geode.h:16:24: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
../arch/x86/include/asm/geode.h:16:39: error: ‘X86_VENDOR_NSC’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
  return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
../arch/x86/include/asm/geode.h:17:17: error: ‘struct cpuinfo_um’ has no member named ‘x86’
   (boot_cpu_data.x86 == 5) &&
../arch/x86/include/asm/geode.h:18:17: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
   (boot_cpu_data.x86_model == 5));
../arch/x86/include/asm/geode.h: In function ‘is_geode_lx’:
../arch/x86/include/asm/geode.h:23:24: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
../arch/x86/include/asm/geode.h:23:39: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
  return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
../arch/x86/include/asm/geode.h:24:17: error: ‘struct cpuinfo_um’ has no member named ‘x86’
   (boot_cpu_data.x86 == 5) &&
../arch/x86/include/asm/geode.h:25:17: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
   (boot_cpu_data.x86_model == 10));

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Andres Salomon <dilinger@queued.net>
Cc: linux-geode@lists.infradead.org
---
 drivers/video/fbdev/geode/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/video/fbdev/geode/Kconfig b/drivers/video/fbdev/geode/Kconfig
--- a/drivers/video/fbdev/geode/Kconfig
+++ b/drivers/video/fbdev/geode/Kconfig
@@ -5,6 +5,7 @@
 config FB_GEODE
 	bool "AMD Geode family framebuffer support"
 	depends on FB && PCI && (X86_32 || (X86 && COMPILE_TEST))
+	depends on !UML
 	help
 	  Say 'Y' here to allow you to select framebuffer drivers for
 	  the AMD Geode family of processors.
