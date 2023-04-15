Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1626F0B27
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbjD0Rmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244443AbjD0RmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B93F49EF;
        Thu, 27 Apr 2023 10:42:10 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id E386621C33E3;
        Thu, 27 Apr 2023 10:42:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E386621C33E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617330;
        bh=s/kg+M27AkKVchwO9jCgPJL2Mpa/KAVUq2YWw+ZkhKA=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=HfdRi3nzr4I30thtNMUKY+2hg4LdPCEOftLVmSIa9WFvZT7qpe3uvR+IGqMSclfGz
         gQ6zKnodlgKFmd1DSYQWaUhwWFKPOvwgQUdF3CR0NtPrD7+LL+KUNDJZj1g9A09vOk
         Tc5eIwLJOdC7DmIOAZ/lAguWRahJQlVTyF76HQO4=
Subject: [PATCH 3/7] mips: asm/io.h: Expect immutable pointer in
 isa_virt_to_bus prototype
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:36 -0700
Message-ID: <168155745691.13678.14513434425435520788.stgit@skinsburskii.localdomain>
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

These helper function - isa_virt_to_bus - doesn't need the address pointer to
be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘isa_virt_to_bus’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Florian Fainelli <f.fainelli@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: linux-mips@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cc28d207a061..d78ca2e71f8c 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -137,7 +137,7 @@ static inline void * phys_to_virt(unsigned long address)
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
-static inline unsigned long isa_virt_to_bus(volatile void *address)
+static inline unsigned long isa_virt_to_bus(const volatile void *address)
 {
 	return virt_to_phys(address);
 }


