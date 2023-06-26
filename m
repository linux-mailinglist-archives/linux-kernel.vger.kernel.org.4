Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59C073ED44
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjFZVv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjFZVuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:50:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9E826B5;
        Mon, 26 Jun 2023 14:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421DB60F77;
        Mon, 26 Jun 2023 21:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BC8C433C0;
        Mon, 26 Jun 2023 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816220;
        bh=cFMmXvQNbb6yvUi5XSAWf1L2Px7SoAgfvJyeuNc0xCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBT7tLEnrvN1VqtbhB4ombwAqvFddCTKy2DOaeE4M4l/UdVyk2JUSIkJUjEsiEx1L
         ktKO0HBBCtidb4wjW/6CftMQeu8d1ilN2IbUz5iQ/OWgKffqXMmVK6f5XFotx+dRW6
         mSOEGZFHw1bBkkN7e3FtGT20w+f/eIICWm8ca4I3/JjFj7o4W12zUllrZpXvtE8hka
         sqe8/6xi+8OUF4iCHJiXj5veIUF045aJmO2QzoHBVx3s9+a91h2GTJCGqNKqpYFHL/
         3M+W+VtjuTm6BHWr6ttRWAmD61wGLvLcsD2gIysP9kP6iWhsNS4LOTLFhzoOAeJhJt
         wVqKJxyWDONJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        david@redhat.com, rppt@kernel.org, arnd@arndb.de,
        chenfeiyang@loongson.cn, wangkefeng.wang@huawei.com,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 13/16] LoongArch: Let pmd_present() return true when splitting pmd
Date:   Mon, 26 Jun 2023 17:49:53 -0400
Message-Id: <20230626214956.178942-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626214956.178942-1-sashal@kernel.org>
References: <20230626214956.178942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongchen Zhang <zhanghongchen@loongson.cn>

[ Upstream commit ddc1729b07cc84bb29f577698b8d2e74a4004a6e ]

When we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
return true, otherwise it would be treated as a swap pmd.

This is the same as arm64 does in commit b65399f6111b ("arm64/mm: Change
THP helpers to comply with generic MM semantics"), we also add a new bit
named _PAGE_PRESENT_INVALID for LoongArch.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/include/asm/pgtable-bits.h | 2 ++
 arch/loongarch/include/asm/pgtable.h      | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 8b98d22a145b1..de46a6b1e9f11 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -22,12 +22,14 @@
 #define	_PAGE_PFN_SHIFT		12
 #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
 #define	_PAGE_PFN_END_SHIFT	48
+#define	_PAGE_PRESENT_INVALID_SHIFT 60
 #define	_PAGE_NO_READ_SHIFT	61
 #define	_PAGE_NO_EXEC_SHIFT	62
 #define	_PAGE_RPLV_SHIFT	63
 
 /* Used by software */
 #define _PAGE_PRESENT		(_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
+#define _PAGE_PRESENT_INVALID	(_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
 #define _PAGE_WRITE		(_ULCAST_(1) << _PAGE_WRITE_SHIFT)
 #define _PAGE_ACCESSED		(_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
 #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index d28fb9dbec596..9a9f9ff9b7098 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
 static inline int pmd_present(pmd_t pmd)
 {
 	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
-		return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
+		return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
 
 	return pmd_val(pmd) != (unsigned long)invalid_pte_table;
 }
@@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 
 static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 {
+	pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
 	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
 
 	return pmd;
-- 
2.39.2

