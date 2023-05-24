Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38A70FA15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbjEXP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbjEXP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:26:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3D10B;
        Wed, 24 May 2023 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684941998; i=deller@gmx.de;
        bh=+7ESBTMnHGzg+BKexPIHQjMLlUGjKMaqw4IK8630UvE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VUgJ0nXppL2cSoQPfPaZ9sFoxXNPq3sAWnlS2eRSnwHoGM5lbpghuqTKcBqWr9TDX
         RUsG/RFliWFIYSrqEI05t/eIeRWNPqVyrZAwx7GxnoLF3fVr6lvlCthH4DJZ/Jhb16
         669t/7BzI8s69lwdGSilAdF6c/JFoe+j3AmbP7hUwxdxd3hJMkd932eketQdzP9NY5
         GTWCklCGS+Wuiu3nbXe4y25H6BVN8GkQXkvVxr8sgJXYEQXm8cgWhNN2AIpbAYEotr
         HjdIl7dnTtbp8S72+y+7QGsAZt2Czp3J9+AE0y2dMQFVN+NHtJBvFPjvDKmU77XqSi
         HYRkvFP580uLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.4]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1qS4a526J1-00j47c; Wed, 24
 May 2023 17:26:38 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux@armlinux.org.uk, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm: Fix flush_dcache_page() for usage from irq context
Date:   Wed, 24 May 2023 17:26:31 +0200
Message-Id: <20230524152633.203927-2-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524152633.203927-1-deller@gmx.de>
References: <20230524152633.203927-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tUOwkAD2Hwce0F7HpGXdFvczL1Vky+pJRPAudFb5SqpMeggqADn
 B/fQ3hYtCFp2le+aYewHIkulKDk774tIryq4+2qkyw3mjaF0HIG659O24ZDTrNfPlyMck6t
 dO6+9pQO60addIt/pr8QsTme9dFEhBQBJSZ3/xQRtY8INuwR+D0OVhig/RM7AWJKaCTkUjk
 zXnUkLghltylQ/1QDAHXA==
UI-OutboundReport: notjunk:1;M01:P0:x5fMiYGFG/Y=;QxAs8oUyx99ZIokWpAiA7fEQnee
 mG3XQQGTRp0m0H8wQATcLxS6FSwRgYHVbRC7IahhpHsH0eToisxnnlA/6blF72C7sWn+lemem
 9S7u2P4gKqzJnKVw2SifzUlVrKyPsXC3YP1p04CZGvjVZ1HeUJLrDZFkohNFfS6q/NbpD2kFT
 p8V6sRTxxqJ6RslEGOssl56LSUxpFNQiGWpc/t4ausZGt5jc4dC/7OKL9FNsPoejR4tVu31Qd
 06+Sgd2jzwXfNi1rST8rzNDaXfRbJ4iqK32ctzf5GWJfT1BKtQ7RSWPntt5I64DaUk99d4vt1
 SInwnAqiXHonKeEOB7B/hqS9ZvQA/BYtLF+cGf1YJm56ZLEV/G8UVTDZo+eQkKyjai+OxP1AS
 ZmWWQP6PT4BaQ1pDffWQ4Hd2/XE8Sr0LoOr5USvmzUbhaxJv35Hw+2Wb3Ov40d8dZTYFgeBen
 cTlNnyalUGAt3R+uNeFsXsYCSliyCb8AtMRrbZ0BB5fi2nLUetg3xIHccqLgR+Y7v+CIgCW9S
 aAOSWzjX2XZ5wwKRKfEpJirlsEyDg8KJBud3VfSB60QP7JsDQyoKDhcQNDSxNzIAe9Mf1CzRp
 hbks40j1tb/w4bZ665MgamCQr1GNdllwUtOISrD2uKpczgm+cJ3Fwuvji+yfX00+YqgiZVk60
 GGkGOeR7z2fOa43Y6nRrXVoDpotPHPIRs4RpLwoEqXURg75iCHsIwryEbOPyko/bkyXZpZwPl
 S0f6O8GTTrgSe+DSd258j5WNIjxczc1XtsP62zkiO2bfWDYgbrXseHRRIuWBgmxLqYCEho5ZQ
 8D7MCYvCRF+ygs+4f5sB2h5QUCyeZfNP4hFA3+lhEE/jpj0JW9IZUvZbsJNWbZhb6nh5fWldN
 BVMdtXDy+hURct4nW5J+dP2pJAkzNEirnzmL/krZZRQH4+kG3eoiHRRj1fOh1yWItxVY0QKHy
 fYBNzn82UH+cn1smT46PEofvVmM=
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

But the current implementation for flush_dcache_page() on ARM
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Cc: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/arm/include/asm/cacheflush.h | 4 ++++
 arch/arm/mm/flush.c               | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cach=
eflush.h
index a094f964c869..5b8a1ef0dc50 100644
=2D-- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -315,6 +315,10 @@ static inline void flush_anon_page(struct vm_area_str=
uct *vma,

 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages=
)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)

 /*
  * We don't appear to need to do anything here.  In fact, if we did, we'd
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 7ff9feea13a6..d57ec9165520 100644
=2D-- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -238,6 +238,7 @@ static void __flush_dcache_aliases(struct address_spac=
e *mapping, struct page *p
 {
 	struct mm_struct *mm =3D current->active_mm;
 	struct vm_area_struct *mpnt;
+	unsigned long flags;
 	pgoff_t pgoff;

 	/*
@@ -248,7 +249,7 @@ static void __flush_dcache_aliases(struct address_spac=
e *mapping, struct page *p
 	 */
 	pgoff =3D page->index;

-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		unsigned long offset;

@@ -262,7 +263,7 @@ static void __flush_dcache_aliases(struct address_spac=
e *mapping, struct page *p
 		offset =3D (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
 		flush_cache_page(mpnt, mpnt->vm_start + offset, page_to_pfn(page));
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }

 #if __LINUX_ARM_ARCH__ >=3D 6
=2D-
2.38.1

