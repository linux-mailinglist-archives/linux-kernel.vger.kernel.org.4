Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920871441D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjE2GSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjE2GR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:17:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280211A
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:17:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso4322751276.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685341050; x=1687933050;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=PnX8u4a7nFzrI9AMI1PfJ2JIEBsc/6HUoh5hn/jeCJld2cHVyPh5B3mpoBHYP4HlDt
         huCzuvd10XbNys3q964U8F3Pwm5I1086lfw4K2KXsSdCwoHho0iYP2E/vuoTg9TJPXAw
         9Ao+OBlyjIf+ii9nemOKDnm34wjGWTWJPqiOtaDLYpgSbKG3NeKVJfh7S3pXb1pULdQN
         cjURL7J2sqlVPM4/ao36PpQzMPvierIr1dk2aTiiL2s04dhzXCN3987Ah17CrCgicXI7
         uLzuDFZr6ZrjJPk0lh0dr69aYCwSbUbiqg2JiJfrZxUW7xsSohaWtB46bIclcU6whmCj
         +nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685341050; x=1687933050;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ3N9RNUACQk0rp/xTQEOUK2bEy9LceuxJNDbuu7Hdo=;
        b=ayc/u27ZpsiP91RHSmP2vvjmiz1I5Qy30y1tTw99/+NOSYMX6EdswNwG8RvTWZsBLQ
         s1LIWd0G+hfTjbs8Z99y6dGjwXu8+khyASBP+lAa7hql1wb2QoRV10tfON6fBwYYMbPI
         3Lfihv+H4hoJGMljWpdHCKcBjvQ3je8qkADInNP1I30NzAxQ+hzIK4m1+RsXQPxbfUTx
         ubvmo8CqaQ69eDEKPVcSVDvDxa6LHmCZMNF7zdG+FB5GA61SP6S5rFtdyKTaWylTna2U
         VPV9SwPq8CPFTJwMCs4Fu6unDrlGFGKSMd1q2KNL3HH1tHbXhAeEF16MEkivkK08SYLv
         pkDw==
X-Gm-Message-State: AC+VfDzUVvm9WwCa8NJkUfb7qz6ld9Tz3LjYXtgilBATWoD4fSo0X6Ta
        tt4hzqP8ALP7YZzB36OhyRrRmQ==
X-Google-Smtp-Source: ACHHUZ6g2ncsiViAbUymnL1kKwlhN1cywz3Q5/8UINRdk6/z7ELyukBfTa2iPWzHzMx63rqo3lZAZA==
X-Received: by 2002:a25:fc19:0:b0:ba1:e06b:bc57 with SMTP id v25-20020a25fc19000000b00ba1e06bbc57mr9201429ybd.64.1685341049679;
        Sun, 28 May 2023 23:17:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t62-20020a814641000000b0054f8b201c70sm3381110ywa.108.2023.05.28.23.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:17:29 -0700 (PDT)
Date:   Sun, 28 May 2023 23:17:25 -0700 (PDT)
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
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 03/12] arm: adjust_pte() use pte_offset_map_nolock()
In-Reply-To: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
Message-ID: <94c2ebe1-6b23-1cee-4aae-22cb835776ff@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
in adjust_pte(): because it gives the not-locked ptl for precisely that
pte, which the caller can then safely lock; whereas pte_lockptr() is not
so tightly coupled, because it dereferences the pmd pointer again.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/arm/mm/fault-armv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index ca5302b0b7ee..7cb125497976 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -117,11 +117,10 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	 * must use the nested version.  This also means we need to
 	 * open-code the spin-locking.
 	 */
-	pte = pte_offset_map(pmd, address);
+	pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
 	if (!pte)
 		return 0;
 
-	ptl = pte_lockptr(vma->vm_mm, pmd);
 	do_pte_lock(ptl);
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
-- 
2.35.3

