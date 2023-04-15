Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC606F0B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbjD0RnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbjD0Rmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:42:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64E76449A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 10:42:27 -0700 (PDT)
Received: from skinsburskii.localdomain (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
        by linux.microsoft.com (Postfix) with ESMTPSA id BE5D621C33DF;
        Thu, 27 Apr 2023 10:42:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE5D621C33DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682617346;
        bh=lbHi5s+Eft8kCcVZxoCtTZ7X0binDj0JHmqe0h+9dEs=;
        h=Subject:From:Cc:Date:In-Reply-To:References:From;
        b=OzkmcOKuax2YnA3bhoej74/6EDZuvfZ0Inv7NG/hTtmTtzHerkqwO1WE2jzjkssq6
         RFiLLepRAcL1SMfIEGdWinCDvpJfwr2hWfpxojZMTXR6mzZ7ogYovV8C8OeeB1lfQu
         HyWtbtNrXC+BzfVMUO9Yj8zBeTY/z9GWcsc0nnJI=
Subject: [PATCH 6/7] powerpc: asm/io.h: Expect immutable pointer in
 virt_to_phys prototype
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 15 Apr 2023 04:17:53 -0700
Message-ID: <168155747391.13678.10634415747614468991.stgit@skinsburskii.localdomain>
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

These helper function - virt_to_phys - doesn't need the address pointer to
be mutable.

In the same time expecting it to be mutable leads to the following build
warning for constant pointers:

  warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type

Signed-off-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>
CC: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 arch/powerpc/include/asm/io.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index f1e657c9bbe8..c287eeb9536f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -959,7 +959,7 @@ extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
  *	almost all conceivable cases a device driver should not be using
  *	this function
  */
-static inline unsigned long virt_to_phys(volatile void * address)
+static inline unsigned long virt_to_phys(const volatile void * address)
 {
 	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
 


