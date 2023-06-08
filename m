Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160E27288B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjFHTfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbjFHTfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:35:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90172D51
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:35:14 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-390723f815fso41003b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686252914; x=1688844914;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr0PEHV5OnE+EEUWt8DnaCebmsfgt0XKMU/SCuO3z3o=;
        b=IGMMSO5mseD7tMe+rRtOIzITR5LLF6gSj6DDkJB5GA4sfv+l0xQcNm+4SRn9cSTA+K
         bzPDoNl4QAtanNBNtw4EO4Jh9TOBqBvtAeMzqVR0kpqSUA/L/bvTchhidEBh3MP4oHsE
         7zzo3x/NewiOg3sZOatxsUi0TcVM8A38QB4oSQfrmI5m9Mp6eOh1v9F27aPIV0BM3Y9m
         jqm85o0LQ0rhNRucFZ0i7HQcaeWJpsz64iPtGPt0XsZOnDRNlY3xajIra5PnrJSK9OoE
         jKjJyQ6PxwcJN3nFoobZxXBieXcQTT3OQ2VZ4F5eEeV/iMRllpjt6DpnkAeaktGC324Y
         dn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686252914; x=1688844914;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kr0PEHV5OnE+EEUWt8DnaCebmsfgt0XKMU/SCuO3z3o=;
        b=N3SH54DnlCPlG7hklAlvtv91NHn7yWujypfq8D/o8rUYseOHoUG6vH3M9o6nErTWJ0
         NzDYglXGsZ+fto08ddKlH0oNkqmPOo5wwcjdHFWXhQSF44tfmxGnw/AG7zSxFNDmP4Xm
         KCWyumnkwbaZzyU4+ivRWdR33cmHDHSFMJIyox5mx8kjlP0vuIe08/kKGH/Xqd1d5dgj
         7EwppJ06U8Q53UlS8gpF5AIQ3TkQnucM/9TEjFmaE7nFHaewxRJibVGR1npCIn+1SMBp
         vo743TuMYHZs9UIclG/U3/B6KiXRCqgZktRdW8xRKfPtjXu/AC5kzz+MfLf04xI1Eiz8
         goxA==
X-Gm-Message-State: AC+VfDxIWCL2LsC/XcwhEViIY54gKjEuj1KQ8C1wyyfgYM43c9qJKhBb
        ppg3vBXx6iwlF4j2Zu5jEN9UZQ==
X-Google-Smtp-Source: ACHHUZ7gdIjuH/6E76ySqRN8WufhpANLQ+j2jIa26lg+ERfDlrQvd+huECUh9/LluoEXiOqTeuRs9w==
X-Received: by 2002:a05:6808:cd:b0:39a:519c:2a6a with SMTP id t13-20020a05680800cd00b0039a519c2a6amr6836715oic.43.1686252914190;
        Thu, 08 Jun 2023 12:35:14 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g137-20020a0ddd8f000000b0055d8768408dsm108055ywe.105.2023.06.08.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:35:13 -0700 (PDT)
Date:   Thu, 8 Jun 2023 12:35:09 -0700 (PDT)
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
Subject: [PATCH v2 21/23] x86: Allow get_locked_pte() to fail
In-Reply-To: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
Message-ID: <b7fa8547-4f28-ec82-9893-1b2eb58e40b4@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/ldt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..adc67f98819a 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -367,8 +367,10 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 
 		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
 		ptep = get_locked_pte(mm, va, &ptl);
-		pte_clear(mm, va, ptep);
-		pte_unmap_unlock(ptep, ptl);
+		if (!WARN_ON_ONCE(!ptep)) {
+			pte_clear(mm, va, ptep);
+			pte_unmap_unlock(ptep, ptl);
+		}
 	}
 
 	va = (unsigned long)ldt_slot_va(ldt->slot);
-- 
2.35.3

