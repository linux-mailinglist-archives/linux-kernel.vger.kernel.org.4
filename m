Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B43F6FD5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjEJFIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjEJFIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:08:45 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D0525A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:08:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso8883689276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695321; x=1686287321;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTtpK1Un44XLqqGJYzxkLaX59Gadt3u8x45iMKydYoY=;
        b=xhQbPYpkUzDX8XU9iKlY3Y4428jn5y6GTm9xV45/y6OmNC04/3wNqkNgSXK3AJIxCv
         nf/3Kcyf7jXHraRNp8V/ThTGssm80Jrj1vFIVRl/eHnHIKGHX0llNwJFmswFPBKeszPS
         4ERvsVZvFaG63Gj8ZvkLnyoFsbatfd0tOGpnHcmb7QKy8F/PI1niiK9/bIJQ3clEICAC
         OKKiuKdx+Nga+KesCEIBcMETZuPReDAYyeYXYun87fEO018ylr/CbkSFeoHJtNA1RKEB
         SehH79xiSdMYH54KoBHTNvBbumLZBWgNKrjc9IJ4jvy2Xlbglq/VfxJ2yKtHyPoLu9Db
         naUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695321; x=1686287321;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTtpK1Un44XLqqGJYzxkLaX59Gadt3u8x45iMKydYoY=;
        b=h0sQRQPAg9yBfSKRbdF7gT8nN4tjYyCDrDvLyo/4TZiIHkBkODXSV1GsIMHvFNtSey
         OICQN7C3ww/AX/ECvtfCR0fwyEwiUmpqyncBSLvc2jBKYgL0Hv0L60jH0uxEO3A3v8K4
         yQveLCmW4wTn9rmPuBbpIO4/KFVFtwXnVxRPk2Efay2BcCx8t+GBznuKdbKj2SL9JZwP
         X1Lg8joWNPM2JVffnkgXAeQxX7VjwU03m+dxuniw9WXAxiNV/uoxu6BSatRlfoUjOfkS
         Yuhx5X6c2eiI5b5tqb3NGpD7cZpBK8gYAVQhydrPqEzP6fSy67eJiT/0+vQSNRwMPbmB
         v9vw==
X-Gm-Message-State: AC+VfDyf75FlzpkAcWHBn+JDixMz5bfMxARMDyduQh4e0DS8e6n+Wmb/
        EONC6oVOnWT6EuQ5Ywq6c5Z70Q==
X-Google-Smtp-Source: ACHHUZ4Nr7JCTjKD9JrQLs38TYvzUeemCSYHOU0HaXL9Z0TKs+cs2kkX5Dm1CGmBCetCdz6AhjKuwg==
X-Received: by 2002:a25:b228:0:b0:b92:2e22:aba5 with SMTP id i40-20020a25b228000000b00b922e22aba5mr17628224ybj.11.1683695321141;
        Tue, 09 May 2023 22:08:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 7-20020a250a07000000b00b9dcd17cc2dsm3512897ybk.46.2023.05.09.22.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:08:40 -0700 (PDT)
Date:   Tue, 9 May 2023 22:08:37 -0700 (PDT)
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
Subject: [PATCH 21/23] x86: Allow get_locked_pte() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <eba2b72f-2180-498b-c8bd-ce8f717fc78a@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offset_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/ldt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 525876e7b9f4..eb844549cd83 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -367,8 +367,10 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 
 		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
 		ptep = get_locked_pte(mm, va, &ptl);
-		pte_clear(mm, va, ptep);
-		pte_unmap_unlock(ptep, ptl);
+		if (ptep) {
+			pte_clear(mm, va, ptep);
+			pte_unmap_unlock(ptep, ptl);
+		}
 	}
 
 	va = (unsigned long)ldt_slot_va(ldt->slot);
-- 
2.35.3

