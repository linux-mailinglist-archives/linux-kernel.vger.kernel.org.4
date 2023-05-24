Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2C70FA13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjEXP0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjEXP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:26:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7DD119;
        Wed, 24 May 2023 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684941998; i=deller@gmx.de;
        bh=lapEzOcX0STqTt0KmKBhtPzemZ35g1ecV7VM6duHiTw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hZZAhGz1sczisgM/+s2NHhe0zQZMv9rY+98uxQlySChUAYyXqSpBTJY1mHhr2e4JG
         WtV4Dr1dYxuG12zH0uzGXnFVt4tygu8cfk0eae70buOBrPO9cX+Yp5m7oLM6m5JgIs
         YzFDOewJUhZnnpRVYgYKv/+FvNPDLV6krnPDRuiIlRSZRyDbgO5q4sjfHM/MMbE4li
         4XHmoQhP7yWFfhmRKo8qxTaxAfEpNtEMzmGaNryxpOsjCEGysTRYhgh3eFjYeJpJD1
         BxMYMaiirHtVPfvP8GWzWVW7YMozKTnErCUnInHYOlhqTpuIkXvGn3nOBMfpovSQ/L
         szijpurACVAXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.4]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1qauHl2mzD-00aEQy; Wed, 24
 May 2023 17:26:38 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux@armlinux.org.uk, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH 2/3] nios2: Fix flush_dcache_page() for usage from irq context
Date:   Wed, 24 May 2023 17:26:32 +0200
Message-Id: <20230524152633.203927-3-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524152633.203927-1-deller@gmx.de>
References: <20230524152633.203927-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QLHFTCIICHSorhJDOatdKxoLujOmIrGuhR+nU+2cO2Tj/+9N1+U
 sdfGNkXhs84pGZ8IYSv8Oftaz+5ZVFPaHHYms9/Yw54FGkOkCbIjet876UBKlxSJDDVpV5x
 0pnQF306dPo02Y1cRDhq8prqXAsDhIFw2Ax3XvoHqPwcF+6bBK92XXV43/3pLS/ag2+4Muh
 ONcSqjEkiIb1J48NuPaPg==
UI-OutboundReport: notjunk:1;M01:P0:n11iHDnCaMg=;Z0dNwCBAlxUepCgQC5fSPrKhciR
 MtbyPa8KjyDmG+FSfa+A/Lhf58F5POAGhLIziU4sUG6N/s2mGTaonOnHzYyHQLRjTDLoxLtGb
 fzD9/y6h+kFJgLX5uq8Ln7IZXI+xM4rqV79G1DKiEol4GhlEvwnII0p4nTYYTPQfqI4cxJxAu
 6/usoOSDBhpGS3aktfdxW8lzoZ/lhEU+fTG1H5nHvwPENVFTTPWLv5gDQfW+/E9txUvu9UlZ2
 IGYUEqZuEpvLTKklDfJRNpUNGN9txPH8nUNFASdy9bBnznSgA2ZC1K1+JLBLMArdgqcCsdQ2E
 5YG5JduZaA5ENMICJbYRLuwdlSQAF7nTPam76fcpIAvJNkGjwaT3LCSbm4UocvYa8oWb2R0Bw
 Hl7MJyEm/oCgAvaJ2R80+O86vmlBdwMzDO+qX+HtGFIWDAcWqxxMCICstMvxJT87WbCaQGbyQ
 J1rMCCHNfSVG+i63RNbFXO9OYLxfz5gg4VFD5wyQkDBRTBrvVrfRA4p74QV7xPwi8pjmxeXey
 A7nAYqB20EgP6VVchbsenQXiip0v4+arOaT1E5T51vCIesVhrwRQFCQjaW+CUOyaxOTJirTHL
 eTVdc7mIteUXNWCZiJCd/Re0Damrj+rgX0YI/pbtRrZHAfMaCYj2kkIOH+XmOOYX07T+YqnE6
 XPmHry5qC8g/PLq9JyAUeqWS4m/okg25Gelx4CtSDMEkcwVUYH1elyTEKSTOnj4XM96lamd21
 gdBL98vM02WmY/q9x103JOt0Iiyer3FOwC0VHUmLjwjv+yW8kjFUC43IruXB/+RFq2HWoE1hh
 +WfV+UgNKVtAP3mluVNqtUEWoAQpYz6PkMU9VgiuqWntDUdVBIOzIcwjvHrRjXK8IBL4meZMw
 z1vWPKL/+1rLG84oDsJa4jIDYwmb9e9mvl4UJxEIOM8fu2QxtAGaCKzKvKb8Uqw/aUMWdvGEE
 OYdnIg==
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

But the current implementation for flush_dcache_page() on NIOS2
unintentionally re-enables IRQs, which may lead to deadlocks.

Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
for the flush_dcache_mmap_*lock() macros instead.

Cc: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 arch/nios2/include/asm/cacheflush.h | 4 ++++
 arch/nios2/mm/cacheflush.c          | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/=
cacheflush.h
index d0b71dd71287..a37242662809 100644
=2D-- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -48,5 +48,9 @@ extern void invalidate_dcache_range(unsigned long start,=
 unsigned long end);

 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages=
)
+#define flush_dcache_mmap_lock_irqsave(mapping, flags)		\
+		xa_lock_irqsave(&mapping->i_pages, flags)
+#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)	\
+		xa_unlock_irqrestore(&mapping->i_pages, flags)

 #endif /* _ASM_NIOS2_CACHEFLUSH_H */
diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
index 6aa9257c3ede..35f3b599187f 100644
=2D-- a/arch/nios2/mm/cacheflush.c
+++ b/arch/nios2/mm/cacheflush.c
@@ -75,11 +75,12 @@ static void flush_aliases(struct address_space *mappin=
g, struct page *page)
 {
 	struct mm_struct *mm =3D current->active_mm;
 	struct vm_area_struct *mpnt;
+	unsigned long flags;
 	pgoff_t pgoff;

 	pgoff =3D page->index;

-	flush_dcache_mmap_lock(mapping);
+	flush_dcache_mmap_lock_irqsave(mapping, flags);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		unsigned long offset;

@@ -92,7 +93,7 @@ static void flush_aliases(struct address_space *mapping,=
 struct page *page)
 		flush_cache_page(mpnt, mpnt->vm_start + offset,
 			page_to_pfn(page));
 	}
-	flush_dcache_mmap_unlock(mapping);
+	flush_dcache_mmap_unlock_irqrestore(mapping, flags);
 }

 void flush_cache_all(void)
=2D-
2.38.1

