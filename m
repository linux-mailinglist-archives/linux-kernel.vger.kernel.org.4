Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640B36BD402
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjCPPis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCPPia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:38:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540BE1FF8;
        Thu, 16 Mar 2023 08:36:44 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678980938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CMpJA9CnAQbYjqPq7Brlq3mMVZeSNU9fjtUmomY0bN0=;
        b=lEqeWHw9pgk4oPSMTQm2vWEmPyaVdmrwUm3ROwRZilzhHjRTIGk/o22drfh2Hyc1rv6/dP
        B+ggbC4RAygfHF96TlIEsvgni923Cjnkh40SARrvNAnPCY+AH9NnySUlPAs+AYqXMzsZog
        D4/vmSy4ZaFaMpwrVP8euktSO+gDAwP4aKCTnPqT1K6EmUQ9XsETfP8k6WsV8FBms//vKO
        oZUCaF34hD0dCIG2px9o+O2FQa1oWdSub51TbI9pSRur6wTRtSN47JYeA1Bsw4VgWk7LWW
        H9G8OyrB8LrA1MWM0ekhLZw4k6Qur3Eh/OegN4PpfpRzPq0H1Eac+7klpi9D3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678980938;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CMpJA9CnAQbYjqPq7Brlq3mMVZeSNU9fjtUmomY0bN0=;
        b=mPU8trPZ3fG7UbuICx6vNy+JDRhafYbnXA3ZWqCY7YEsZ9FvPMQ6mxHyqgeP16qfD24leC
        tdEbTBw9K2QnsVDQ==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Remove memcpy_page_flushcache()
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167898093734.5837.6665906842521706513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b9da86e3aade0cd8c8b60a0f6356e7730fc90d5d
Gitweb:        https://git.kernel.org/tip/b9da86e3aade0cd8c8b60a0f6356e7730fc90d5d
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Wed, 15 Mar 2023 16:20:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 08:27:57 -07:00

x86/uaccess: Remove memcpy_page_flushcache()

Commit 21b56c847753 ("iov_iter: get rid of separate bvec and xarray
callbacks") removed the calls to memcpy_page_flushcache().

In addition, memcpy_page_flushcache() uses the deprecated
kmap_atomic().

Remove the unused x86 memcpy_page_flushcache() implementation and
also get rid of one more kmap_atomic() user.

[ dhansen: tweak changelog ]

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20221230-kmap-x86-v1-1-15f1ecccab50%40intel.com
---
 arch/x86/include/asm/uaccess_64.h |  2 --
 arch/x86/lib/usercopy_64.c        |  9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index d13d71a..c6b1dcd 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -62,8 +62,6 @@ extern long __copy_user_nocache(void *dst, const void __user *src,
 				unsigned size, int zerorest);
 
 extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
-extern void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-			   size_t len);
 
 static inline int
 __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 6c1f8ac..f515542 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -136,13 +136,4 @@ void __memcpy_flushcache(void *_dst, const void *_src, size_t size)
 	}
 }
 EXPORT_SYMBOL_GPL(__memcpy_flushcache);
-
-void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
-		size_t len)
-{
-	char *from = kmap_atomic(page);
-
-	memcpy_flushcache(to, from + offset, len);
-	kunmap_atomic(from);
-}
 #endif
