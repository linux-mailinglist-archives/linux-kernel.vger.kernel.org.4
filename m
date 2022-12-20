Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0483651B99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiLTH0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbiLTHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:25:57 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF35AE64
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s196so7792985pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyF9JuxS6b1bMIxmIDmo5YIppyUDgtVjeA/J5ZBy/Sg=;
        b=bZlL202+3g/lBUVxaTio6INJ4AnCFIK4K1tm95ryvusKHLN4qgv8Xdg9fQcsvNbRgY
         HuZ3lt2jYcmxhGdFgyZxc5l7Rqj/TwgybpEfpzllnB3CohJAJsellYQL5vo3f924l65W
         A7zJKiwVcGRuKChNh49XsLYRRty/AZrL4S8mxYRVyK6u1kHnTOdMkohZkYsHZzbi/RqH
         PMjn3PNK/k/rhQCAVgVR1xUvQizCi83l55O3/YvA0tfLQuotemf78cIKorMHrcrJEFgj
         hwGPkM0YbCUspKAISFNqg2mZCsXi1CY6Ia82TlREDiqt/JcEwXq353qv9J09cDq3UAfh
         wzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyF9JuxS6b1bMIxmIDmo5YIppyUDgtVjeA/J5ZBy/Sg=;
        b=R6h4tSbh3trfw+Ll6ApXCokOw4uFWda+UI0ArS/yA53Z/gvaK47yceXZsHaVN6Yy7G
         7FcX7CmeMhaicMusqJJc3gzc8XkjZ3jXLRA5UMUTb4N37WYYHW6KlF+CoCW7Nylu8RQz
         5gmlLsIdr1T0I1AIcc5WUzgjHPxDuwYf5fxJbuWmQAAEPgpjb4TpAzFEJkAIOM5XNmko
         iPurRDfJBovqPY2IBYVJi8cMiDyUjIt63EvXQoJapk4wKbE4j6u8N0GepcQkd2uIKUrW
         JAUCtEPcDmJWhchV9bsWfqWRFoc9l0pz3dVx9WKZAbnEhi2YjWoT0P+IRoer3wW+Xgpd
         hkug==
X-Gm-Message-State: ANoB5pntsqK7RlY9LCC0teRLQ4iChT5CHTJC5GR5Sa3liDjnnlqdiIuY
        ykkBegjSaSR+FXLdCIF/2lU=
X-Google-Smtp-Source: AA0mqf5HNABnkdJTVab5ykwjMWNSwkewL4JhDHIv8ftE7XKfaXPk26d71RZVeX1DPtdPy2jxjzxsXw==
X-Received: by 2002:aa7:82d7:0:b0:575:a4f5:7812 with SMTP id f23-20020aa782d7000000b00575a4f57812mr45041888pfn.4.1671521155748;
        Mon, 19 Dec 2022 23:25:55 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:25:54 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Brian Geffon <bgeffon@google.com>, Yu Zhao <yuzhao@google.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Barret Rhoden <brho@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v3 06/14] mm/ksm: Break COW PTE before modify shared PTE
Date:   Tue, 20 Dec 2022 15:27:35 +0800
Message-Id: <20221220072743.3039060-7-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221220072743.3039060-1-shiyn.lin@gmail.com>
References: <20221220072743.3039060-1-shiyn.lin@gmail.com>
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

Break COW PTE before merge the page that reside in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/ksm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index c19fcca9bc03d..896a14c44a858 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1017,7 +1017,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 			      pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
+	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, PVMW_BREAK_COW_PTE);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
@@ -1136,6 +1136,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	barrier();
 	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
 		goto out;
+	if (break_cow_pte(vma, pmd, addr) < 0)
+		goto out;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
-- 
2.37.3

