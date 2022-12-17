Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667264FBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLQS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLQSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7D10B7D;
        Sat, 17 Dec 2022 10:55:35 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dApqMKl2xsD3ucsCOdsZ6oYT0fYa/78y/uWMGa5ShYc=;
        b=q0QqYMz8beerO8pNOWHJm3gthEyOnHU7wEczTGjT+GVyZ4ULWWT4PXxKA52nvz2m3uncY3
        chwHUnd1MU9lZusNFtRd7zHW/C0mkIuW3VIreyh3Z1qo6KLZhDRxpM3B4svxjsHEFKR+di
        uYtUkDZDZFuBfBVYoH1sHYDBAyJ0w/aJhvdo69cUirKkaw8+FTVqBTQoVBe/RqyOv/KTlM
        n8+DVacBybGECHmf3x5q5Eq86QrdIfcIbSX1pkfrlP00AFqqJE/sUshl8QDkzW7zW88VYg
        TfK4GznNpNKpFVuBX7ofnZgkATBEbbIl/8IsfBfq6iNe0+YUuVkJkK/qAVX1QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dApqMKl2xsD3ucsCOdsZ6oYT0fYa/78y/uWMGa5ShYc=;
        b=KXjv6TffSdgNWrXLmrndbYOJv0NcDpA28CaDaRPzhqBAJli7yhMQbMqrFceSGx0X3EPHeY
        Ba9j4FncAhK/TGDA==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix CR3_ADDR_MASK
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Alexander Potapenko <glider@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333123.4906.2814725328778322721.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     80d0969aa7832bfeb287cb22563a1ad08fea937d
Gitweb:        https://git.kernel.org/tip/80d0969aa7832bfeb287cb22563a1ad08fea937d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:25 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:28 -08:00

x86/mm: Fix CR3_ADDR_MASK

The mask must not include bits above physical address mask. These bits
are reserved and can be used for other things. Bits 61 and 62 are used
for Linear Address Masking.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20221109165140.9137-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/processor-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 02c2cbd..a7f3d91 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -35,7 +35,7 @@
  */
 #ifdef CONFIG_X86_64
 /* Mask off the address space ID and SME encryption bits. */
-#define CR3_ADDR_MASK	__sme_clr(0x7FFFFFFFFFFFF000ull)
+#define CR3_ADDR_MASK	__sme_clr(PHYSICAL_PAGE_MASK)
 #define CR3_PCID_MASK	0xFFFull
 #define CR3_NOFLUSH	BIT_ULL(63)
 
