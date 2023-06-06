Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4997250DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjFFXie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbjFFXi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:38:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E711712;
        Tue,  6 Jun 2023 16:38:20 -0700 (PDT)
Date:   Tue, 06 Jun 2023 23:38:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686094698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Equul31tyb3rOZreGt/tUeXVvhpBwBra9uCHyHhfYvY=;
        b=BTs02gl/3qbZ9L9+y0j9rD2S+Y3iEGId2wdyCJfg2cxMEl22dN7Z5aD/uIltoE64VELgay
        GRC6SHnJY4zuOFkfrA/9bCHga8j6lymr5CSwFixQZbzhek/AxzKf2mIRq30cAOk1vsf2XN
        p/rSobeYErXcVsDTmvAjNVbXdUP97tn5CMQwOASCr36bALcorWOyPUB11ykLuWoPeEq50T
        xMJwlVv6rP1wUiJZLcKGHYQQ/f4bHPjhkPMhHpk+KdfCJI9QToh1XptxUCO36x8R74KMnV
        xCn7BYhEBXKnYxEpULqWVgDDYgM8b+pAsU7o/H9TPqf7Or9SIGYQ7OLQ42IN8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686094698;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Equul31tyb3rOZreGt/tUeXVvhpBwBra9uCHyHhfYvY=;
        b=b3WtUVf21vNP6qD6s8I5fJCKk+s56ha0WzUgL7lRXLUaZnCeE/kn4sPCVN92KP8wJAklav
        06GIH7Y60/sefJBg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mm: Fix enc_status_change_finish_noop()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168609469763.404.15773231678482556597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     94142c9d1bdf1c18027a42758ceb6bdd59a92012
Gitweb:        https://git.kernel.org/tip/94142c9d1bdf1c18027a42758ceb6bdd59a92012
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 06 Jun 2023 12:56:22 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 06 Jun 2023 16:24:27 -07:00

x86/mm: Fix enc_status_change_finish_noop()

enc_status_change_finish_noop() is now defined as always-fail, which
doesn't make sense for noop.

The change has no user-visible effect because it is only called if the
platform has CC_ATTR_MEM_ENCRYPT. All platforms with the attribute
override the callback with their own implementation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/all/20230606095622.1939-4-kirill.shutemov%40linux.intel.com
---
 arch/x86/kernel/x86_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index f230d4d..6466431 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -131,7 +131,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 static void default_nmi_init(void) { };
 
 static bool enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool enc) { return true; }
-static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return false; }
+static bool enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return true; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
 static bool is_private_mmio_noop(u64 addr) {return false; }
