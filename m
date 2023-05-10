Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6C6FD5FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbjEJFKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbjEJFJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:09:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8944D4EE3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:09:55 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-559f1819c5dso101998077b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683695395; x=1686287395;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmemeLuI+WpEQXgz9TQT0mwehV8FTU9BDTa5EhoH+Rw=;
        b=ceZayvLcQzK/jEmDGFktdiBeLmAfZAcJomtj6b8LZ7UVBhK1PGvRLGtv3raaIkoA69
         8du4wIfy3LTg4noNW6T56a8rTdYN7Kpn5/bm4yjB4emMMTggN1PcgpP7ET0zc6Ogox7V
         PacpXMb40YNuRMAqf3IboaGbQzDmk/4AhKXM1jLiRZe7o3tGAOJ6z3OSnXWDEM8MmOjy
         leDcr9V/CMd1mPfM2iHPwMwcuDGyHWo5yaj5bkj6ZD28Zg+yk0+3HzvQJBuo9qxnWea2
         qCcGWwBxF4a0/bB7X0FeLhxKH1U3vpEQVW9dVdnIidnAwcXxE3l++8L3bRK0NJ7IyPS8
         JZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683695395; x=1686287395;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmemeLuI+WpEQXgz9TQT0mwehV8FTU9BDTa5EhoH+Rw=;
        b=TmAWhsAZPQK0rkrmverZ3Z/krFCZe+A1B7B9U5qTxy10lGSIYgQbzKCG5cAIQV/0/p
         +DDkcfFxOvloyJD898SSE5DH3XdCtpvrSdPUZSUSIkP62LyUtdLe1CA0qGNx8izNAPU2
         uKEsta6fM71vyVxtf6BnTKa1z7zpOyZX3W48tY/OtE7RYCp7V2HAS44VsmsE0HZG8GmL
         7FYMDFJC58JB9xyNzRCr/67qkQbRYIpAZMmictBVbkt/ZxMsSyWSsGEls98gTm1+kIG3
         A01iHkI4oIRhXAiF7lSMp0ISQpAj0gqLBNSC28pT4zyd0pwhd605/pWmuznHEMC2HgBW
         I60w==
X-Gm-Message-State: AC+VfDzmGpEtCMn0vU/71JwoVmlse2SzTYdxzm5nMuh9s4QzRu7/YWCE
        aGY+KcFi9rf/u1WjB7e2krTYvA==
X-Google-Smtp-Source: ACHHUZ6AHFxady081B2wan1G2AdvRI+je11F7XC2fK+PaWqaZjZVH5+mul53az7NeaRbK79eLrDOFQ==
X-Received: by 2002:a81:92d7:0:b0:55a:4828:182a with SMTP id j206-20020a8192d7000000b0055a4828182amr18309481ywg.36.1683695394676;
        Tue, 09 May 2023 22:09:54 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l64-20020a0dc943000000b0055aad7d3f34sm3766659ywd.142.2023.05.09.22.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:09:54 -0700 (PDT)
Date:   Tue, 9 May 2023 22:09:50 -0700 (PDT)
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
Subject: [PATCH 22/23] x86: sme_populate_pgd() use pte_offset_kernel()
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <6d75e7f-2266-1dda-8a70-c52c27f44da7@google.com>
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

sme_populate_pgd() is an __init function for sme_encrypt_kernel():
it should use pte_offset_kernel() instead of pte_offset_map(), to avoid
the question of whether a pte_unmap() will be needed to balance.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/mm/mem_encrypt_identity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index c6efcf559d88..a1ab542bdfd6 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -188,7 +188,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	if (pmd_large(*pmd))
 		return;
 
-	pte = pte_offset_map(pmd, ppd->vaddr);
+	pte = pte_offset_kernel(pmd, ppd->vaddr);
 	if (pte_none(*pte))
 		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
-- 
2.35.3

