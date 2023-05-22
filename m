Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12270B48E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjEVF3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVF3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:29:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECAA8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:29:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-55db055b412so46112237b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733351; x=1687325351;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=++qSmbn7bhjg3RT15iglmwv4R1gESGfbvlyrc9z9nPg=;
        b=KUYquKPQFLz686sxc05IvSA2pptVmZo25juuDJPh5PU0X8mcUoMX85X6dQWcuCeLiy
         uZgK8UCVFiR0+JLDfI+BG2fZ4jpaUFacf9y4wexEGbBLRrMU7EGQ2WyCANVks/wifwjW
         WIWR1uH1YZ2eCpYGacQpMGZqDG1Rast16Vhqw6loQySVQm459lCNaPM2V4pX8ejuYDHJ
         iWokAPVtiNyJ1VEM+GanV1g70rryZ2Zn0pEeEaFvrZDQKTZaXrD5lh2IK6/6AvLj649e
         dxMB/Rriy/3qD/arXkivaOaOUE1co2k6CyJ03pNexh99nj5a3n2SbOmvYztGkHfCQKXx
         DWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733351; x=1687325351;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=++qSmbn7bhjg3RT15iglmwv4R1gESGfbvlyrc9z9nPg=;
        b=QELWOKdeHEuDJWAOisdqC+w+lPOSfvHFt/6s7MecIq25umeWB3gmwYSCSrl6UeL2WM
         8w47JIWszwxeeKrcc9ajh7mpv8/KYf56FxbWGBc5AIHVanxt/a4n2ajTz/JAx+9K3H7q
         yTmcJoiykV37qKxefOkxQf3opfaLp4G8suwmP+PdWRZc5PONlY0v66nKSrJSkNeAXG77
         aaSuUHleZOaAcudZjj2UtqnUI+kbmrL5jUi46dRLtvQYLWaD8iXqOxSPN8XIrKTWYdOn
         qst6A3E4e5pzRRJtR8vavdLfgUcPPYM6BulqniH1sbJ1gYTo44bGayg8dckJon3hGtXc
         v5CA==
X-Gm-Message-State: AC+VfDymliUZORtXohisVzO4clPzDIrtjSYzRcN4XKo7leDoH7709+Lr
        DnSInEH8YzUrHIAKQcoaMeRuUA==
X-Google-Smtp-Source: ACHHUZ58DrOuEAqS21o31T6NkFTUrmPfkTQChFezlC+fyR5u9eV8KPIJhLKCfEeaQKdNd4WYmfpBlw==
X-Received: by 2002:a0d:cac7:0:b0:55a:2084:9e05 with SMTP id m190-20020a0dcac7000000b0055a20849e05mr10730696ywd.23.1684733350763;
        Sun, 21 May 2023 22:29:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x67-20020a81a046000000b0054fcbf35b94sm1832465ywg.87.2023.05.21.22.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:29:10 -0700 (PDT)
Date:   Sun, 21 May 2023 22:29:07 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 31/31] perf/core: Allow pte_offset_map() to fail
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <a4616d9b-20d-fdd7-ae7a-7c8af451a1a@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

In rare transient cases, not yet made possible, pte_offset_map() and
pte_offet_map_lock() may not find a page table: handle appropriately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
This is a perf patch, not an mm patch, and it will want to go in through
the tip tree in due course; but keep it in this series for now, so that
it's not missed, and not submitted before mm review.

 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index db016e418931..174be710f3b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7490,6 +7490,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
+again:
 	pmd = pmdp_get_lockless(pmdp);
 	if (!pmd_present(pmd))
 		return 0;
@@ -7498,6 +7499,9 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pmd_leaf_size(pmd);
 
 	ptep = pte_offset_map(&pmd, addr);
+	if (!ptep)
+		goto again;
+
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
 		size = pte_leaf_size(pte);
-- 
2.35.3

