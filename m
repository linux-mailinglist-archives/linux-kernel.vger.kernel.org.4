Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A046FD5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjEJFCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjEJFCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:02:39 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793410E5
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:02:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-55c939fb24dso62526927b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683694956; x=1686286956;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuPIUnxI15Nal18dmzcm2R5Hbe23rg/L/N54Quf1VSM=;
        b=MZLldLeoTchJRg8ULRaH6L2y47XhBLxMJs1Go7faNFAGJ60D+vvC/iJb0Buc77Bpr6
         JAiUBm+hO4tciOyskyTHDu8zHoxcS+nRd9yRDDrgu8RadfICeTJTrI6xGxTJWG3gg8GE
         GihvOxn2/FrCq9mvWrB4PViVv+smaQj46irSMOCeG8hhbs3XZFgG9gfnNhAREX7BTIuo
         FwBNusKFw2CdGBlovtbF9aK1ipGeDHjgN+1rN8m5K9X1QHfWeGyfS7n8ZLK61yxirERs
         wzLOW0oOQaCrKrTFBkqyll9ZBkBC8WcWqedcyO11Xuqtw+I5+Pp9ph9gkiqNZDE1+7z0
         OmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683694956; x=1686286956;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuPIUnxI15Nal18dmzcm2R5Hbe23rg/L/N54Quf1VSM=;
        b=UwMEHonRehrrNUBBiWhDiqkCKmq/NJcI6Gpidv11Gj48PTXfHtumE6vvJPrTHd3NPp
         l8zc90id385t5w9FE++RT6a3vLkMQ6e6yhd+7wv2PLFpcO11ozM7yZ2NvNYtGixKB9ff
         IBbQq3dCFYZZ5qCWMEaCWLkkmko0MufLev2IRYtwgAZaFvrrPpHNV7fIys8iRuYNlVaK
         s30VRa7BDP4qYvSccuW9FosCFaDeNUynOCe6HTXz60oytBYJfrHTA7uw9wr52IvCFcXQ
         tDpAzdLAgWEAUS/Zg9GjTbW7giGJodML8KcRX5gFJOwpiGEtTagUhlesiGKJOeJRL/sY
         oh6A==
X-Gm-Message-State: AC+VfDzATnRafN/rmCUvn0yVqtuj9zCQ+CI4uPfWyVnSFeNQ6v1xLi73
        zdQZFUzapuHMrPNCjB0fm4a3iw==
X-Google-Smtp-Source: ACHHUZ4mq7HDDHYHVt/QFmXvmAJMqlmdCFbymB1fCkEy74WyI9jP3Nyoly+MUZg8u6u5wehMYgk8Zg==
X-Received: by 2002:a0d:c4c2:0:b0:556:d398:870f with SMTP id g185-20020a0dc4c2000000b00556d398870fmr16786959ywd.47.1683694956234;
        Tue, 09 May 2023 22:02:36 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v133-20020a81618b000000b00545b02d4af5sm3822297ywb.48.2023.05.09.22.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:02:35 -0700 (PDT)
Date:   Tue, 9 May 2023 22:02:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 16/23] s390: gmap use pte_unmap_unlock() not spin_unlock()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <5579873-d7b-65e-5de0-a2ba8a144e7@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pte_alloc_map_lock() expects to be followed by pte_unmap_unlock(): to
keep balance in future, pass ptep as well as ptl to gmap_pte_op_end(),
and use pte_unmap_unlock() instead of direct spin_unlock() (even though
ptep ends up unused inside the macro).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/mm/gmap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index d198fc9475a2..638dcd9bc820 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -895,12 +895,12 @@ static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
 
 /**
  * gmap_pte_op_end - release the page table lock
- * @ptl: pointer to the spinlock pointer
+ * @ptep: pointer to the locked pte
+ * @ptl: pointer to the page table spinlock
  */
-static void gmap_pte_op_end(spinlock_t *ptl)
+static void gmap_pte_op_end(pte_t *ptep, spinlock_t *ptl)
 {
-	if (ptl)
-		spin_unlock(ptl);
+	pte_unmap_unlock(ptep, ptl);
 }
 
 /**
@@ -1011,7 +1011,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 {
 	int rc;
 	pte_t *ptep;
-	spinlock_t *ptl = NULL;
+	spinlock_t *ptl;
 	unsigned long pbits = 0;
 
 	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
@@ -1025,7 +1025,7 @@ static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
 	pbits |= (bits & GMAP_NOTIFY_SHADOW) ? PGSTE_VSIE_BIT : 0;
 	/* Protect and unlock. */
 	rc = ptep_force_prot(gmap->mm, gaddr, ptep, prot, pbits);
-	gmap_pte_op_end(ptl);
+	gmap_pte_op_end(ptep, ptl);
 	return rc;
 }
 
@@ -1154,7 +1154,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 				/* Do *NOT* clear the _PAGE_INVALID bit! */
 				rc = 0;
 			}
-			gmap_pte_op_end(ptl);
+			gmap_pte_op_end(ptep, ptl);
 		}
 		if (!rc)
 			break;
@@ -1248,7 +1248,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 			if (!rc)
 				gmap_insert_rmap(sg, vmaddr, rmap);
 			spin_unlock(&sg->guest_table_lock);
-			gmap_pte_op_end(ptl);
+			gmap_pte_op_end(ptep, ptl);
 		}
 		radix_tree_preload_end();
 		if (rc) {
@@ -2156,7 +2156,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 			tptep = (pte_t *) gmap_table_walk(sg, saddr, 0);
 			if (!tptep) {
 				spin_unlock(&sg->guest_table_lock);
-				gmap_pte_op_end(ptl);
+				gmap_pte_op_end(sptep, ptl);
 				radix_tree_preload_end();
 				break;
 			}
@@ -2167,7 +2167,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 				rmap = NULL;
 				rc = 0;
 			}
-			gmap_pte_op_end(ptl);
+			gmap_pte_op_end(sptep, ptl);
 			spin_unlock(&sg->guest_table_lock);
 		}
 		radix_tree_preload_end();
@@ -2495,7 +2495,7 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long bitmap[4],
 				continue;
 			if (ptep_test_and_clear_uc(gmap->mm, vmaddr, ptep))
 				set_bit(i, bitmap);
-			spin_unlock(ptl);
+			pte_unmap_unlock(ptep, ptl);
 		}
 	}
 	gmap_pmd_op_end(gmap, pmdp);
-- 
2.35.3

