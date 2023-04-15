Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A96F0B23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbjD0Rm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbjD0RmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B40EA3584;
        Thu, 27 Apr 2023 10:42:04 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1256821C33E2;
        Thu, 27 Apr 2023 10:42:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1256821C33E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617324;
        bh=y5FKETkcR5bJeA05EuMUf08/uW3fzemI0xL6hftJZ0w=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=I81ONq4flDFybAHDmcdEBwB18AgoI8OINU6R4Az6WvVIVzocvmY/pieHzLajTdhKo
         HA0Dp+jT2ScUGmry+Oi6xup26Stlv/BVUUj8EZqzcf+c26o+ieBPHo+PXorzzsW/Y4
         ltVQ+ERLydTb/l5zHlX3TcVCAlUq35bKUAjZ5cSk=
Subject: [PATCH 2/7] alpha: asm/io.h: Expect immutable pointer in
 virt_to_phys/isa_virt_to_bus prototypes
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:31 -0700
Message-ID: <168155745118.13678.3878958755096151716.stgit@skinsburskii.localdomain>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

These two helper functions - virt_to_phys and isa_virt_to_bus - don't need the
address pointer to be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Richard Henderson <richard.henderson@linaro.org>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: Matt Turner <mattst88@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-alpha@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/alpha/include/asm/io.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 7aeaf7c30a6f..0e2016537bd3 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -56,7 +56,7 @@ extern inline void set_hae(unsigned long new_hae)
  * Change virtual addresses to physical addresses and vv.
  */
 #ifdef USE_48_BIT_KSEG
-static inline unsigned long virt_to_phys(volatile void *address)
+static inline unsigned long virt_to_phys(const volatile void *address)
 {
 	return (unsigned long)address - IDENT_ADDR;
 }
@@ -66,7 +66,7 @@ static inline void * phys_to_virt(unsigned long address)
 	return (void *) (address + IDENT_ADDR);
 }
 #else
-static inline unsigned long virt_to_phys(volatile void *address)
+static inline unsigned long virt_to_phys(const volatile void *address)
 {
         unsigned long phys = (unsigned long)address;
 
@@ -104,7 +104,7 @@ static inline void * phys_to_virt(unsigned long address)
 extern unsigned long __direct_map_base;
 extern unsigned long __direct_map_size;
 
-static inline unsigned long __deprecated isa_virt_to_bus(volatile void *address)
+static inline unsigned long __deprecated isa_virt_to_bus(const volatile void *address)
 {
 	unsigned long phys = virt_to_phys(address);
 	unsigned long bus = phys + __direct_map_base;


