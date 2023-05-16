Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAFB70579E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjEPTlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjEPTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE454494;
        Tue, 16 May 2023 12:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF0F5635A1;
        Tue, 16 May 2023 19:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D0C433EF;
        Tue, 16 May 2023 19:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684266009;
        bh=8n2CvzDo289ObcDnbgcLUxlNv6SunFRuUSz2MeWdEMM=;
        h=From:To:Cc:Subject:Date:From;
        b=PPja12+jUDGrCbIzpFocVLXHKNfRllVRa/7kobiZhwTwubGr2MFZw3y/5/bvrEThA
         6WGO5HuaTDWe0pTkZTYjFic6nTQPW1y6R0j7/qko/z2uhI8mzQuFlE+F8v0jV5ZA3E
         kmoXEWxYtS7L2k2x0Q0sOCBdMiYZgIwHHyxmgtABBeENRgim1TWHxLzFiK9At1lMYJ
         bAMffkM6q+jFgAxDo7kq6qiANwmEeUEKDR/6i9YugWrRPujT0/sTlnRmOpckxiq6Vr
         gtFoFG6xUDZrBqapU28gMi80jXfo4h54UuTP/g20HqiPcM3vdS0rL2jF0zX2p0IFAA
         OGpcDJsH+d8vQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mips: provide unxlate_dev_mem_ptr() in asm/io.h
Date:   Tue, 16 May 2023 21:39:42 +0200
Message-Id: <20230516194000.548487-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The unxlate_dev_mem_ptr() function has no prototype on the mips
architecture, which does not include asm-generic/io.h, so gcc warns
about the __weak definition:

drivers/char/mem.c:94:29: error: no previous prototype for 'unxlate_dev_mem_ptr' [-Werror=missing-prototypes]

Since everyone else already gets the generic definition or has a custom
one, there is not really much point in having a __weak version as well.

Remove this one, and instead add a trivial macro to the mips header.
Once we convert mips to use the asm-generic header, this can go away
again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/io.h | 1 +
 drivers/char/mem.c         | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cc28d207a061..affd21e9c20b 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -554,6 +554,7 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
  * access
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
+#define unxlate_dev_mem_ptr(p, v) do { } while (0)
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index f494d31f2b98..94eff6a2a7b6 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -90,13 +90,6 @@ static inline int range_is_allowed(unsigned long pfn, unsigned long size)
 }
 #endif
 
-#ifndef unxlate_dev_mem_ptr
-#define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
-void __weak unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
-{
-}
-#endif
-
 static inline bool should_stop_iteration(void)
 {
 	if (need_resched())
-- 
2.39.2

