Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E1708B44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjERWDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjERWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E9E50;
        Thu, 18 May 2023 15:03:14 -0700 (PDT)
Date:   Thu, 18 May 2023 22:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MUhHIVpNKMfsr4vAu1zcl65zCaPE030dJd0GyCGtTjA=;
        b=AkCZkv0xQVl2PJvJPWVmAlg/a/soO10Tj7ip4LidmduQOGjcCY5MzYLg3IYtFNhiK75oW2
        bAIGgB9ML2KBQfKaFly2gzlBolsv6nsVLIgEEQmURSmKbt4utFtC2VMy5RIKWEZyvYAjN2
        cqcv9fhx9fag8iAakfGqYNuRNt+Ivc/uNBpfZ1uorTOli4mLcf2MctO8FXxUkPeZ+AMHDQ
        ebxcYY71TjrUCr0MAtEz6EJQspTUGSpnLAFH4sIpq8CRs33eordZA7U14Pg6Dhp/OxHEG2
        PFl+eNTnSkjek+S3Mg/X/f05PdVn+Ymd+dP9XGkm3awq19qcWlPaQUN7MrMM/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684447392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MUhHIVpNKMfsr4vAu1zcl65zCaPE030dJd0GyCGtTjA=;
        b=dRKKHLQwu3LUuQWBDKrpNgBt334oz+j8zrm8Y8xe0cBFpRvwJ9MvwTcHOIUxiAy1AAFIas
        eFxn40FGxbc93jAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Add early_memremap_pgprot_adjust() prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168444739205.404.4531976933473275474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4d312ac057da57b4a844ec8af14236e74b652efe
Gitweb:        https://git.kernel.org/tip/4d312ac057da57b4a844ec8af14236e74b652efe
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 21:35:47 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 18 May 2023 11:56:18 -07:00

x86/mm: Add early_memremap_pgprot_adjust() prototype

early_memremap_pgprot_adjust() is a __weak function with a local
prototype, but x86 has a custom implementation that does not
see the prototype, causing a W=1 warning:

arch/x86/mm/ioremap.c:785:17: error: no previous prototype for 'early_memremap_pgprot_adjust' [-Werror=missing-prototypes]

Move the declaration into the global linux/io.h header to avoid this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-19-arnd%40kernel.org
---
 include/linux/io.h | 5 +++++
 mm/internal.h      | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index 308f4f0..7304f2a 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -68,6 +68,11 @@ void *devm_memremap(struct device *dev, resource_size_t offset,
 		size_t size, unsigned long flags);
 void devm_memunmap(struct device *dev, void *addr);
 
+/* architectures can override this */
+pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
+					unsigned long size, pgprot_t prot);
+
+
 #ifdef CONFIG_PCI
 /*
  * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
diff --git a/mm/internal.h b/mm/internal.h
index 68410c6..e6029d9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -179,12 +179,6 @@ extern unsigned long highest_memmap_pfn;
 #define MAX_RECLAIM_RETRIES 16
 
 /*
- * in mm/early_ioremap.c
- */
-pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
-					unsigned long size, pgprot_t prot);
-
-/*
  * in mm/vmscan.c:
  */
 bool isolate_lru_page(struct page *page);
