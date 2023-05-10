Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A06FD532
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjEJEoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjEJEny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:43:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94BF40EB
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:43:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a20a56a01so120775387b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683693831; x=1686285831;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgvg6hJeX3BMksFNsRntaPo5LAnqTckLGOVnbotKcuE=;
        b=XSdzuZPhWyo8ejurmvHVm33GJPjVUgijuALNChj5du7O2iYt4Q9Jq2Q59opuXgmszK
         vq4MYv/Ooq0tJSiRkeuI3pPx9DX2hUCIacbsKIYs/Pr4tOgH5bBu2nqMFCUfyb6E02pf
         jBk8Kt3LARkTDDVXin2DqNhLRNsinTPL45U22h6RflNgwq03hTBYZXyT9mTDfKsms4Zh
         4IIRYWo2iyv3RHOXtIB0KC/5A3EJw7nNYEHLsDPx36g0ObzRlzcFoxapfv0z0w7dMYbs
         CoJBrp445oAQqRN0sKHpj5OzjqC03ok8JMyhyd58GQQ6Bw92QvpdqQzmSHjTpSRLST1k
         j19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693831; x=1686285831;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qgvg6hJeX3BMksFNsRntaPo5LAnqTckLGOVnbotKcuE=;
        b=k2VaXXj4IMX/S5r+nliEovK/Rilc1vpSqOCnTximAd+GKrb9g3hafTrfe8SN5OctMO
         EME/Lsa7C0WZwnxuvYsm31XpiLLaKtpcQbUXuPsAEtyQRr0g0U2pQWLL9xZmHktiH2ot
         AfX6TRQBpeAEb58OQIz258GOSEfvKpdZHSlUv32ePeNeD032MhzJcb7RXSkC0lPRSmqF
         xKLEXCai7MTLIJ3lnlRJXSyz6K17onM6juYMkNgESUEpoRsTnDJ0Wyj/PVT24aYxgwiq
         ikqfhyKvN//PF63Ei/m1k1s7oIcLS7MGSMwNXQOmk7h5+yWRbY43LYNDzeHU6ZvsBH24
         XtGg==
X-Gm-Message-State: AC+VfDxS49hCZXxKmNXwwd8xe+wVRQp9JlATNBRp+WlCR5nr42HiOKvf
        cWWquWY0fj8/70a0tnBmWC1EoQ==
X-Google-Smtp-Source: ACHHUZ4VcJ8uys5Wg+XhQi/AqGcqZN5zPbzkOujNssPmQqlmUArRuZ8YDG3LYugsQYwQAHxQcBQMpA==
X-Received: by 2002:a0d:d955:0:b0:55a:ad0a:766 with SMTP id b82-20020a0dd955000000b0055aad0a0766mr17833906ywe.10.1683693830970;
        Tue, 09 May 2023 21:43:50 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p185-20020a0dcdc2000000b0055a72f6a462sm2214413ywd.19.2023.05.09.21.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:43:50 -0700 (PDT)
Date:   Tue, 9 May 2023 21:43:47 -0700 (PDT)
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
Subject: [PATCH 02/23] arm64: allow pte_offset_map() to fail
In-Reply-To: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
Message-ID: <e72f6f3e-a8d4-3ed-2b4-5d3ced41484@google.com>
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
 arch/arm64/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9e0db5c387e3..a58780d5fac4 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -177,6 +177,9 @@ static void show_pte(unsigned long addr)
 			break;
 
 		ptep = pte_offset_map(pmdp, addr);
+		if (!ptep)
+			break;
+
 		pte = READ_ONCE(*ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
-- 
2.35.3

