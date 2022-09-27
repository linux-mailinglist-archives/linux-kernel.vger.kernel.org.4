Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE85EC97C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiI0Q24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiI0Q20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:28:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03212613
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw17so9597264plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4E5FbfG/IuR+E8W1emv8V3grpVK/EnZv9IRpD1bffsk=;
        b=R6qS6gl1BdIlAy4Pc+DF6Tnk7r09A1Hzh3RhF+jg8a3vWDHO/Z8Z0F/8KLFmNT4UZz
         p/zFN3RfTqWi2DRtOVtFciqpCdIdmtpT6DJVVtxBQq6UgU6IFoSyjC2EQZwD12QjI2rP
         N6sKt/2wIihFM0xukfEBIwASir6D+SsWWfgEpZfNYQlep+bU6+y1VL+nU1RUxcpcZbzj
         HDJDak4eIuiXg+OZKVbWp7xuXqSnIxgyQjH4X/XP702GEzT5h+djQNgxeLZCe8y8DeX2
         1QEo27PMnsy6vuvoS48eRrJKETldKeSTA/zrFTpSxL5TIlzzEkP0pCRtT4W1+NWE4eY6
         RLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4E5FbfG/IuR+E8W1emv8V3grpVK/EnZv9IRpD1bffsk=;
        b=MQdP8XC1GQoGKtqs2Bchn22pj3SuAWYohzZFX2VIghs6N7zU1I8K0hHeY3N5ydMNIr
         FoOLZAsOL+vJheLd2Xod24UsFjRU+Bw1lC8jt/viWE0iUcOZbnW3q8CknseO3pfHT9jV
         Q+LPhEYY1jok3/4sCfHkxXmdNer2cjuBokfMawzBCp1CoeB1K338GLTtAODEWWDhS7+T
         IQROBRgBhlkVKUdAglp5qqYV3OcBfGzVbVqu+E/zhtbF+tetL3tzPBGVAKU4BIu++B9E
         ItcApWO57hFNA6xWSfYfjoGysgTitOp4ErwlfAS64kJrznSGdJVqlhORiJnjG0+Gjq1n
         8n+g==
X-Gm-Message-State: ACrzQf3+2nDPeTFqsFG4XqlSsGqGiRjbrrO0vKirMGzHqYVWFVyJLB07
        crv3eJmvi/EHovdYC621jUw=
X-Google-Smtp-Source: AMsMyM4f2hvZ08Sspjy753JXqV501MbKNQc+IDnf+X9RFXObXCyHmtTBbnBpVaxK4l6Y+BwjCYmecg==
X-Received: by 2002:a17:902:ce81:b0:179:f3fe:7fef with SMTP id f1-20020a170902ce8100b00179f3fe7fefmr2502835plg.119.1664296089240;
        Tue, 27 Sep 2022 09:28:09 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id 9-20020a17090a0f0900b001f333fab3d6sm8602360pjy.18.2022.09.27.09.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:28:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 6/9] mm, pgtable: Add COW_PTE_OWNER_EXCLUSIVE flag
Date:   Wed, 28 Sep 2022 00:29:54 +0800
Message-Id: <20220927162957.270460-7-shiyn.lin@gmail.com>
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

For present COW logic (physical page), in some situations (e.g., pinned
page), we cannot share those pages. To make the COW PTE consistent with
current logic, introduce the COW_PTE_OWNER_EXCLUSIVE flag to avoid doing
COW to the PTE table during fork(). The following is a list of the
exclusive flag used.

- GUP pinnig with COW physical page will get in trouble. Currently, it
  will not do COW when GUP works. Follow the rule here.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/pgtable.h | 18 ++++++++++++++++++
 mm/gup.c                | 13 +++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8b497d7d800ed..9b08a3361d490 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -656,6 +656,24 @@ static inline int cow_pte_count(pmd_t *pmd)
 	return page_count(pmd_page(*pmd));
 }
 
+/* Keep the first bit clear. See more detail in the comments of struct page. */
+#define COW_PTE_OWNER_EXCLUSIVE ((pmd_t *) 0x02UL)
+
+static inline void pmd_cow_pte_mkexclusive(pmd_t *pmd)
+{
+	set_cow_pte_owner(pmd, COW_PTE_OWNER_EXCLUSIVE);
+}
+
+static inline bool pmd_cow_pte_exclusive(pmd_t *pmd)
+{
+	return cow_pte_owner_is_same(pmd, COW_PTE_OWNER_EXCLUSIVE);
+}
+
+static inline void pmd_cow_pte_clear_mkexclusive(pmd_t *pmd)
+{
+	set_cow_pte_owner(pmd, NULL);
+}
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
diff --git a/mm/gup.c b/mm/gup.c
index 5abdaf4874605..4949c8d42a400 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -634,6 +634,11 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		mark_page_accessed(page);
 	}
 out:
+	/*
+	 * We don't share the PTE when any other pinned page exists. And
+	 * let the exclusive flag stick around until the table is freed.
+	 */
+	pmd_cow_pte_mkexclusive(pmd);
 	pte_unmap_unlock(ptep, ptl);
 	return page;
 no_page:
@@ -932,6 +937,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 	pte = pte_offset_map(pmd, address);
 	if (pte_none(*pte))
 		goto unmap;
+	pmd_cow_pte_clear_mkexclusive(pmd);
 	*vma = get_gate_vma(mm);
 	if (!page)
 		goto out;
@@ -2764,8 +2770,11 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
 					 PMD_SHIFT, next, flags, pages, nr))
 				return 0;
-		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
-			return 0;
+		} else {
+			if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
+				return 0;
+			pmd_cow_pte_mkexclusive(&pmd);
+		}
 	} while (pmdp++, addr = next, addr != end);
 
 	return 1;
-- 
2.37.3

