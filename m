Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B66D9D06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjDFQG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjDFQG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:06:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4E9EE8;
        Thu,  6 Apr 2023 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uEPm8dOBZnv4i4WftC68ZDl47ANTw+nTJX9zwRJJnoU=; b=XkVcysRnaHexPtQQr+vU3HjoDA
        V70/R60nM8HX/CGVLtWMa4ZCFfNpJEa5zRclK2NwiTYMKu+hrYtnxUg06CxAwIw+BLnvJyFmzDViR
        rMh10UWLdUPwwdjgiAEmKdTKeAI+bVIxCRc7s7VUi+lgtBc2AR8yOjO0y9j0MhnBEchITnauumCmE
        PHfKDoFTANve/sYDjO2QA63O80nyVjIVttl5ItkZQ5QYn1m+WpvHDQCmnmj0Zq1Deel85nR4YJKiw
        eUJ62iv7bCMvD1VAXjAkIztqFbB5pEZBw0ybNvqb5PT/Kr3G2Mv5bQdecHFtCrUY5bAMbq2pw+x0n
        9F4hS02Q==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkS7T-007wQR-0G;
        Thu, 06 Apr 2023 16:05:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-parport@lists.infradead.org
Subject: [PATCH] parport_pc: don't allow driver for SPARC32
Date:   Thu,  6 Apr 2023 09:05:48 -0700
Message-Id: <20230406160548.25721-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sparc/kernel/ebus.o is only built for SPARC64.
ns87303_lock is only built for SPARC64.
arch/sparc/include/asm/parport.h says that it is for sparc64.
Various documentation on the internet says that ebus is for UltraSPARC
systems (64-bit).

Therefore don't allow PARPORT_PC to be built for SPARC32.

Fixes these build errors on SPARC32:

ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!

Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-parport@lists.infradead.org
---
 drivers/parport/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/parport/Kconfig b/drivers/parport/Kconfig
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -42,7 +42,7 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390 && !SPARC32)
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
