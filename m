Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93800651B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiLTH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiLTH0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:26:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D31277D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c13so7926033pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do3acUsDb4bseCZZAAdCXOeb3zH5cpjKCNiCZshpYgw=;
        b=Jbm+ZDETl/xq5MthImH8BHHm9GBXQRsQVT3uhHj94LaQ8kg9xI0a4zaGCVg+cefzXk
         D5EG8JXUc/rT2JguGIYDN8cOKuwJv0wmeQi/ty+upc1PhBOmLL1OAFiJmY4QIEr3FV+u
         vkQIFqHEDKKxAt6NsvFG4EgYacTY5Kj73Kwv2ZtPwUgZQ+kat+enQ+Byyx4iHWoBBgQq
         lEBuUXzYINS4qMKwlgv7tZLpRkvuEoM9LlnJJp3/9ckZy1AN0k3HxjzcvUXMV91kEWB2
         h8WeyuZsX4oE7ylWWH1LyNtoUaYvUmkYlnxbVpO/i5rxyaGkS28mf01HC/XLRtY7UuUs
         ZTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do3acUsDb4bseCZZAAdCXOeb3zH5cpjKCNiCZshpYgw=;
        b=tC04kCc9hvHsf4h34hBKTqu9xNL+TougYhzRpRni+syB8xqqJ5OsRy2RYml0HQaSs9
         raO6+4nf4ONgjKiqziJmwTdAlYqTGjK+NTnLQYyAY4csO+j70yu+M60gqJ9CIQs/5+oY
         Usmu8CCvZEVCPMnZmeXPNFsBzb8hS80vDJGQYNO0bYO5z1mEXLaTlsSaFGhVdmJ6kB0J
         wMjEo5A6NIEAcTFFU5Wyh0hcbintwToxMVPY9Bzvu3Tqk7G87qpMOIXD5E5FnGPqlMEe
         suflmDFxjyVrtgRd349olXm5RLHCUhES+ceIgaakI2QICsK18P6/Yzr7rV6uUmpLiWHT
         /xgQ==
X-Gm-Message-State: ANoB5plyY1pSYH6BMK4S5A23rY5sj4nnwfDmz1n4khT146M/TyMXX6OA
        dLJcnFLJP+2kiTRXtmAbBTo=
X-Google-Smtp-Source: AA0mqf4sXbpc959lO3xaruJ/7JwWbqHNxobqwVmkT0oSHM0O93U4eYrT6K7YtNCEihfb5iqOzV5xyA==
X-Received: by 2002:aa7:8190:0:b0:575:62f8:be3 with SMTP id g16-20020aa78190000000b0057562f80be3mr45051940pfi.23.1671521172728;
        Mon, 19 Dec 2022 23:26:12 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:11 -0800 (PST)
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
Subject: [PATCH v3 08/14] mm/gup: Break COW PTE in follow_pfn_pte()
Date:   Tue, 20 Dec 2022 15:27:37 +0800
Message-Id: <20221220072743.3039060-9-shiyn.lin@gmail.com>
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

In most of cases, GUP will not modify the page table,
excluding follow_pfn_pte(). To deal with COW PTE, break
COW PTE in follow_pfn_pte().

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index fe195d47de74a..cd72010ba0e6d 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -476,6 +476,8 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
 		entry = pte_mkyoung(entry);
 
 		if (!pte_same(*pte, entry)) {
+			if (break_cow_pte(vma, NULL, address) < 0)
+				return -ENOMEM;
 			set_pte_at(vma->vm_mm, address, pte, entry);
 			update_mmu_cache(vma, address, pte);
 		}
-- 
2.37.3

