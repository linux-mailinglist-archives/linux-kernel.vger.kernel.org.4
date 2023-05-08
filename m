Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37076FB4AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjEHQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjEHQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:05:29 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5472B5596
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:05:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:6a18:41e7:fcfe:24c0])
        by albert.telenet-ops.be with bizsmtp
        id uG5R290052WBekD06G5RXE; Mon, 08 May 2023 18:05:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw3MU-001XSl-9n;
        Mon, 08 May 2023 18:05:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pw3Mb-00BTFB-0a;
        Mon, 08 May 2023 18:05:25 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] ARM: perf: Mark all accessor functions inline
Date:   Mon,  8 May 2023 18:05:18 +0200
Message-Id: <3a7d9bc7470aa2d85696ee9765c74f8c03fb5454.1683561482.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1683561087.git.geert+renesas@glider.be>
References: <cover.1683561087.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When just including <asm/arm_pmuv3.h>:

    arch/arm/include/asm/arm_pmuv3.h:110:13: error: ‘write_pmevtypern’ defined but not used [-Werror=unused-function]
      110 | static void write_pmevtypern(int n, unsigned long val)
	  |             ^~~~~~~~~~~~~~~~
    arch/arm/include/asm/arm_pmuv3.h:103:13: error: ‘write_pmevcntrn’ defined but not used [-Werror=unused-function]
      103 | static void write_pmevcntrn(int n, unsigned long val)
	  |             ^~~~~~~~~~~~~~~
    arch/arm/include/asm/arm_pmuv3.h:95:22: error: ‘read_pmevcntrn’ defined but not used [-Werror=unused-function]
       95 | static unsigned long read_pmevcntrn(int n)
	  |                      ^~~~~~~~~~~~~~

Fix this by adding the missing "inline" keywords to the three accessor
functions that lack them.

Fixes: 009d6dc87a568db6 ("ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/include/asm/arm_pmuv3.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 78d3d4b82c6c2598..f4db3e75d75f024e 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -92,7 +92,7 @@
 
 #define RETURN_READ_PMEVCNTRN(n) \
 	return read_sysreg(PMEVCNTR##n)
-static unsigned long read_pmevcntrn(int n)
+static inline unsigned long read_pmevcntrn(int n)
 {
 	PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
 	return 0;
@@ -100,14 +100,14 @@ static unsigned long read_pmevcntrn(int n)
 
 #define WRITE_PMEVCNTRN(n) \
 	write_sysreg(val, PMEVCNTR##n)
-static void write_pmevcntrn(int n, unsigned long val)
+static inline void write_pmevcntrn(int n, unsigned long val)
 {
 	PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
 }
 
 #define WRITE_PMEVTYPERN(n) \
 	write_sysreg(val, PMEVTYPER##n)
-static void write_pmevtypern(int n, unsigned long val)
+static inline void write_pmevtypern(int n, unsigned long val)
 {
 	PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
 }
-- 
2.34.1

