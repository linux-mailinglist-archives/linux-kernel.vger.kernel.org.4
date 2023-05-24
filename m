Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC60D70FA12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEXP0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjEXP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:26:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12702122;
        Wed, 24 May 2023 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684941999; i=deller@gmx.de;
        bh=+u+YPRciweWPPguaxEgTzruDX0igJ4dkk2Wtadt6QVA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tgq8QwkypsPRETeu+19MR6ZTBDZejuyxcvDSAhNK6C9kPDFZoR+sLoUmYrLp2v0qQ
         Oo+R6oMG/ZhVh9nYB0o6ro85A/Xo8KQNLZvQL4nEvq+lrObnYr5+lObF8oGxIPXJsO
         KrwsLQ8A6uxnCygqj5B8dz2XFfHHfzU7addqr6c0kFUZACz7xFiCyHB8Kxp/ERPjg7
         SqxDyZ6Xly9UkoUTsoAvLoxekB4JFUzsjbgAnBk/dL2E7J1QkVNa2fDDVZsaYIUfSe
         oXNS3i2IQaAIyyKqYQIV/hFGfBwd4eBAbR6jiNv/07fDPECCeq2iD3Qk5ptDn1LqBK
         iBOsESCtXF0rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.4]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1qCC9r3QFB-017m18; Wed, 24
 May 2023 17:26:38 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux@armlinux.org.uk, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH 3/3] parisc: Fix flush_dcache_page() for usage from irq context
Date:   Wed, 24 May 2023 17:26:33 +0200
Message-Id: <20230524152633.203927-4-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524152633.203927-1-deller@gmx.de>
References: <20230524152633.203927-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1nlE0hasgl6gijxKoEdYfyHTI6vIMSOKaK+RqkKBabLx7UsK7Xo
 npxRasd38wBp+V4q8fJGGVe6hCTQhHravYda1JFL6bI2UYwo7iwgzUnZI624CMkgi1y9ue+
 DMb4jU4oy7QsTpmV/pY1WrN/dhtRBMyXkX+fMTt93HK/7yj+1uyp8VTelCIFyk84EKJo4c8
 wlcGYzf8BJ56dyHSvi44A==
UI-OutboundReport: notjunk:1;M01:P0:E+j+R85yQko=;gNHlAFRU0+wZJTeqYwEDvCqffmo
 2TQXCFebAzwn7rcTvYSRGbe7rcv2TP1t59xR9J2ZnolsYc8GYpPMZUrshiTcnz9zt6/hVSTXW
 y/9mX0vPvgIVYE4lN3GZkAbuQaIZo8Qas2zo9VWhsbApwseyT/CM9zuXBqaWUiKCwIVkAeCOL
 lkaSJazdaicSv6XhNQdQii8XiQYwZgDD9ns5STZtIhsia81lXB+B6EBNcIgV0TQroeBzsNQKI
 eVZgI/EcYFw0D4DBOlgbtQWY72Ih8c9g9OnINFZPl/8iUIm8HkrT/doQv7FIFuPP7VdSH7k5I
 1Chk2mTF32RbdNqrd9B7nJsRhWJS+Ve1w9cm0K/JK6oGkXri9fEsra8N8Rb7Um1rAWjXamwDb
 XXrS1eoCMouD60VgjyGlyp+XO7bGHTKLUzA7vcWt6bNJttzIG9uF/LWrmGtn/StjKIhT6K41E
 l3Dv8I07vR1dcXDWf7XQEa/0WJ2XLDxf8uDeYL4FW2PhgD5LgXvU2p7kL+Eo+blOu99AeuLvx
 iIOU85Hm6+wV+XeK5pc4/HAZ+U0LMLTSFuufIiXSPKi8vk39PkdVcA7Z/pMwkfTu7FMXfU+mu
 8qZ1EC++r4mCfgu57JLk91Kj6IS0+mIgwIlzyHZyNjHXFe4Xek5UtgyAtAMk0chC3I8bAWrll
 3L3gAa4B+4288Msyps2+tKmvEie+whjbZgWWuGw5rB+bdlpltrH30NPTR/CIqjhqmkIXpOx73
 s4Cfgfl0WPNKBT9tGJFhlwy12WDrlbYbOiMUx56IoZnDRu8GRlU6yPF/bZU+4Z2qpmy+YiKAw
 uf0VHIK2wgO6WM5qfVq109o/NhPBNGklqaPgWliDRfYKr7EkJ+9iRO77CX6A2tRnMC2oZheGS
 Km7EqyPsRg3GfDa+KuSY27joemHpvNIq02DsOprnqF3ZkH1LAkmwm3CCpHB7otzVkHGyYTiro
 URbiTZsabGRmQoQ30FXhqVpJ8mE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since at least kernel 6.1, flush_dcache_page() is called with IRQs
disabled, e.g. from aio_complete().

But the current implementation for flush_dcache_page() on parisc
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Cc: linux-parisc@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/parisc/include/asm/cacheflush.h | 4 ++++
 arch/parisc/kernel/cache.c           | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/as=
m/cacheflush.h
index 0bdee6724132..c8b6928cee1e 100644
=2D-- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -48,6 +48,10 @@ void flush_dcache_page(struct page *page);

 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages=
)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)

 #define flush_icache_page(vma,page)	do { 		\
 	flush_kernel_dcache_page_addr(page_address(page)); \
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 1d3b8bc8a623..ca4a302d4365 100644
=2D-- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -399,6 +399,7 @@ void flush_dcache_page(struct page *page)
 	unsigned long offset;
 	unsigned long addr, old_addr =3D 0;
 	unsigned long count =3D 0;
+	unsigned long flags;
 	pgoff_t pgoff;

 	if (mapping && !mapping_mapped(mapping)) {
@@ -420,7 +421,7 @@ void flush_dcache_page(struct page *page)
 	 * to flush one address here for them all to become coherent
 	 * on machines that support equivalent aliasing
 	 */
-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		offset =3D (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		addr =3D mpnt->vm_start + offset;
@@ -460,7 +461,7 @@ void flush_dcache_page(struct page *page)
 		}
 		WARN_ON(++count =3D=3D 4096);
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }
 EXPORT_SYMBOL(flush_dcache_page);

=2D-
2.38.1

