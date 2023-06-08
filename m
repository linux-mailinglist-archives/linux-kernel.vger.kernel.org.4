Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCE728876
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFHT3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFHT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:29:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC562113
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:29:19 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b2b7ca1c5eso58482a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252558; x=1688844558;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htP458HkQOxv1YJRD6pA18DA04i7K6/u04f92CnMfB0=;
        b=WqCUQyh4fb72P3Kw38oeD34IYgDMZUJWpeeOOH7KwWFkTIkJBfiV3ibZz3gZzYLVxl
         lU1gDOTGIJCl22/qWpu3I54yHV8hXoWsW3bLvMizUe696eD4+w5NMItSw+ZsMJ2if+3a
         8lw8VtiSVvPlHQ/Z7+Qgoipy0NwOKSeRkxeZtlOJSgMtgwHhJFZs8ezKvYFf04NNKV0B
         o9SvBbVJSNYcgeP1FcAifK+xGopk05Di+EjON5dZeXWscPS5ozLfdvYQvh8DkNTWidtB
         R65qDn5ks7oQgy0HqDzv818p/gf4omkafkLcO+z9CO+/iNtMlszDRH4pSfFhaygbIVXY
         l7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252558; x=1688844558;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htP458HkQOxv1YJRD6pA18DA04i7K6/u04f92CnMfB0=;
        b=gclMxU0Pxq/0/HAXLqxeS685cIQiGMv2GLex5yHL82e1qhE3PJWbrFqJJW1vW/Bp+S
         XjsiQ00p9MtDLs35d0E8CBkj9EimFK5hNrc4KaTJAj43IUeDodqKgERKSaWcUnprK1pw
         +TcVInsIsu8UxYqNDFf1rkWcjXDE9W4NGEeR0kh2xJHMq6dHl9mFfv6oINeaMOgeW9ci
         GQMQwztLgM02/ghqFdfPlJ6ZBio8IfzqySw5ekVuRX5GQii4zS+8nzRCWyqAS2azoGgS
         rSm2IUgD4sPuePKh4MhSDrdxNheFQsg5N80sUxO0tNwPhwpszf38Al4ujVzAR8BYmG8F
         IFfQ==
X-Gm-Message-State: AC+VfDz5q9347ED5MWxxma0GsgC/mv73WrLKdQifohgSgYCTWAHBOwVJ
        bOza2bcQa1LXk3tauF2/gf2Ffg==
X-Google-Smtp-Source: ACHHUZ6Glpn+/SneQe2ShIc4+J53+hKNrejmkpSzC+zjJkZt31rnqX9eMZTl3ydPFwIMIfpDuEYaQQ==
X-Received: by 2002:a05:6830:86:b0:6b2:94a2:2236 with SMTP id a6-20020a056830008600b006b294a22236mr9332824oto.29.1686252558452;
        Thu, 08 Jun 2023 12:29:18 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o199-20020a2573d0000000b00bb09977b0basm455193ybc.6.2023.06.08.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:29:17 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:29:13 -0700 (PDT)
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
        Peter Zijlstra <peterz@infradead.org>,
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
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: [PATCH v2 16/23] s390: gmap use pte_unmap_unlock() not
 spin_unlock()
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <78873af-e1ec-4f9-47ac-483940ac6daa@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
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
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 3a2a31a15ea8..f4b6fc746fce 100644
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

