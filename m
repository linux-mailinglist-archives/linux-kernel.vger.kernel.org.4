Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2543E614566
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 09:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiKAIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 04:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 04:01:44 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7136590
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 01:01:43 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:cd8a:284a:a448:1949])
        by baptiste.telenet-ops.be with bizsmtp
        id ew1g2800U2kye1T01w1gU2; Tue, 01 Nov 2022 09:01:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1opmDM-002G44-GS; Tue, 01 Nov 2022 09:01:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1opmCu-0039Q2-Rv; Tue, 01 Nov 2022 09:01:12 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] staging: octeon: cvmx_ptr_to_phys() should return physaddr_t
Date:   Tue,  1 Nov 2022 09:01:11 +0100
Message-Id: <20221101080111.750748-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit without physical address extensions (e.g. sh-allmodconfig):

    drivers/staging/octeon/ethernet-mem.c: In function ‘cvm_oct_free_hw_memory’:
    ./arch/sh/include/asm/io.h:239:32: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
      239 | #define phys_to_virt(address) ((void *)(address))
	  |                                ^
    drivers/staging/octeon/ethernet-mem.c:123:18: note: in expansion of macro ‘phys_to_virt’
      123 |    fpa = (char *)phys_to_virt(cvmx_ptr_to_phys(fpa));
	  |                  ^~~~~~~~~~~~

Fix this by making cvmx_ptr_to_phys() return physaddr_t instead of
uint64_t.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only (sh, mips allmodconfig, mips
allmodconfig+CONFIG_CAVIUM_OCTEON_=y)
---
 arch/mips/include/asm/octeon/cvmx.h   | 4 ++--
 drivers/staging/octeon/octeon-stubs.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index 25854abc95f8a2cd..72e775bf31e6008b 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -154,13 +154,13 @@ static inline uint64_t cvmx_build_bits(uint64_t high_bit,
 
 /**
  * Convert a memory pointer (void*) into a hardware compatible
- * memory address (uint64_t). Octeon hardware widgets don't
+ * memory address (phys_addr_t). Octeon hardware widgets don't
  * understand logical addresses.
  *
  * @ptr:    C style memory pointer
  * Returns Hardware physical address
  */
-static inline uint64_t cvmx_ptr_to_phys(void *ptr)
+static inline phys_addr_t cvmx_ptr_to_phys(void *ptr)
 {
 	if (sizeof(void *) == 8) {
 		/*
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 3f8e5713b8a850f0..7a02e59e283fbae8 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1212,7 +1212,7 @@ static inline void *cvmx_phys_to_ptr(uint64_t physical_address)
 	return (void *)(uintptr_t)(physical_address);
 }
 
-static inline uint64_t cvmx_ptr_to_phys(void *ptr)
+static inline phys_addr_t cvmx_ptr_to_phys(void *ptr)
 {
 	return (unsigned long)ptr;
 }
-- 
2.25.1

