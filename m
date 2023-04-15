Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A596F0B21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244478AbjD0RmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbjD0RmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D52F19F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:41:59 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4F94A21C33E1;
        Thu, 27 Apr 2023 10:41:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F94A21C33E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617318;
        bh=XSS94wog701zQLpD7y0CmSI6sjOskvST2v9WTZpXSuw=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=KC6ZwgtqC9euOjJ5w0tehDfyKXGSp1Mqj6NgboJFVNtYflzT8mCJPM/l4lIbnzDGk
         p7DdAzi8m//mycqsRrgF/e3gc9kFS0xufP0H+9XvT9HkhLJ7sT7OYTTkOt5qFxYMCw
         uvRl10ZdIMspxR6L3Q5lEKo4Pl6ssgQhmuAqRTq0=
Subject: [PATCH 1/7] x86: asm/io.h: Expect immutable pointer in
 virt_to_phys/isa_virt_to_bus prototypes
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Helge Deller <deller@gmx.de>, Omar Sandoval <osandov@fb.com>,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:25 -0700
Message-ID: <168155744546.13678.7653611641170146532.stgit@skinsburskii.localdomain>
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
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Chris Down <chris@chrisdown.name>
CC: Helge Deller <deller@gmx.de>
CC: Omar Sandoval <osandov@fb.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/io.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e9025640f634..0e6f5b48f517 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -128,7 +128,7 @@ extern int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
  *	this function
  */
 
-static inline phys_addr_t virt_to_phys(volatile void *address)
+static inline phys_addr_t virt_to_phys(const volatile void *address)
 {
 	return __pa(address);
 }
@@ -163,7 +163,7 @@ static inline void *phys_to_virt(phys_addr_t address)
  * However, we truncate the address to unsigned int to avoid undesirable
  * promotions in legacy drivers.
  */
-static inline unsigned int isa_virt_to_bus(volatile void *address)
+static inline unsigned int isa_virt_to_bus(const volatile void *address)
 {
 	return (unsigned int)virt_to_phys(address);
 }


