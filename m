Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68EC5EC977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiI0Q2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiI0Q2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA48DCEA8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f193so9909501pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=qop4kS7tfgVAWONSShTjlSwOzcS5SD4NChZjNU/F2nQ=;
        b=bdViRXIQLD0mZYILY5hdkcVtOxo8rJzC8pDOup5INaReSB1+OZFg6CNzWUIE5BoKlO
         dIfOAa7OJkvup0fHXtjsFxciDPdJadIVweVlvWKGvO2J76yDUKyS7/4vW/gC7WkYZs+z
         DjMDXYiEJKmynMd3aq1VffDohQY92eIALGOII45QcStOgx2Njh9+LvLHMKgwnYac70o8
         UEWJq/Mfz6mKV0ZjGssEda6J8o3Kkm3c9ViszcnWDOV9ZkMgxvOEeA9nediWg8YVLG+i
         UyaB5tsMUGqhRx+froXMyrEMO+198iLRw+fWEwE2kkwxAU7DSzokRX22Ez3PAJf2iINy
         Xq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qop4kS7tfgVAWONSShTjlSwOzcS5SD4NChZjNU/F2nQ=;
        b=AphDjZJAPXtTaanakdjAovQD2GR9LFAmHk4hVYT/1s+TqCokJ1f05y1622NPHQq6g8
         Z9XDymnwv+ppAGGzo3YiJU709wGGElBdLcUGp0dCdGpwPEkQq3Dy1MIG3NciWZFdrzAy
         wK6ftGai2URI3bkIDvg/W43c5TLoMWvwYxkeYngFd7oOfbTDJCxvcJlWueASFt4B5nsV
         Q8sj5dhXR9fwzbKrsY869Ixw8xYgYaIqVZxStrix6ONxZdp1laXffEpJ3FB+1YWpraMB
         4AO3fF8ZQpa9RUExrY4sS3IUo9enkZ11G5CeIVcS0cbAz8lH5DytZ6HXDE+ZZveXfODC
         bKvw==
X-Gm-Message-State: ACrzQf1hb/J65newZgNjgJKUmaKi/2FdIdTuFUfutr2sGwZKJSNyQtF7
        KcBVPij2MnxE4iFEneKgDM0=
X-Google-Smtp-Source: AMsMyM7VMvbPQOTjzD9+Ao59BdB9ZhHh61sNAq/kZfwKTlLP+8k0zXC+njFiksYsSQsqL75utiqfnA==
X-Received: by 2002:a63:3c5:0:b0:43c:8455:d67d with SMTP id 188-20020a6303c5000000b0043c8455d67dmr15487199pgd.73.1664296072465;
        Tue, 27 Sep 2022 09:27:52 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:27:51 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>, Nadav Amit <namit@vmware.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [RFC PATCH v2 3/9] mm, pgtable: Add ownership to PTE table
Date:   Wed, 28 Sep 2022 00:29:51 +0800
Message-Id: <20220927162957.270460-4-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927162957.270460-1-shiyn.lin@gmail.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the ownership to the PTE table. It uses the address of PMD
index to track the ownership to identify which process can update
their page table state from the COWed PTE table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h |  5 ++++-
 include/linux/pgtable.h  | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd3..965523dcca3b8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2289,6 +2289,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
+	page->cow_pte_owner = NULL;
 	return true;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda2..42798b59cec4e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -152,7 +152,10 @@ struct page {
 			struct list_head deferred_list;
 		};
 		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
+			union {
+				unsigned long _pt_pad_1; /* compound_head */
+				pmd_t *cow_pte_owner; /* cow pte: pmd */
+			};
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
 			unsigned long _pt_pad_2;	/* mapping */
 			union {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index d03d01aefe989..9dca787a3f4dd 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -615,6 +615,16 @@ static inline int pte_unused(pte_t pte)
 }
 #endif
 
+static inline void set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
+{
+	smp_store_release(&pmd_page(*pmd)->cow_pte_owner, owner);
+}
+
+static inline bool cow_pte_owner_is_same(pmd_t *pmd, pmd_t *owner)
+{
+	return smp_load_acquire(&pmd_page(*pmd)->cow_pte_owner) == owner;
+}
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
-- 
2.37.3

