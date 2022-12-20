Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37816651BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiLTH1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiLTH0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:26:24 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B779C1705B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o12so11539778pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuRQqb4yRAJ4FEZaEUwyqkhOJuLTRzxeOhNcE74yoH4=;
        b=JZbpM26wcX2ho4irepvHJdt5UeqQwiPyu7R+jVVSgN5Gcct1FWav/0nKIlEGG7Wr/t
         qOCuZ4KF6aR1ag3SCCwiU8Vx74XEDaTYbFrHlL+VmTd9OSwgmj3qg0WHtHlkcvJVyGVY
         jcyc8LwsTH+EyYQYCEN7cGXRKdGr8E9C2eodr+Tz89EQJprNi2IGMJmxjRy9UrNDymKa
         /3vyx/6zVl+r9inx3sFkNw4NvkktYhsqVCdfZIPrVzwFpF0IxxP+1hlsaTujxBYl7qa0
         YM2TgNkL0USPA/hjL9mRvBEL2I8mlnA1r6IwEUnQVcz1Bdj7gjAMPYEqQMc3o44RT+Lh
         xCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuRQqb4yRAJ4FEZaEUwyqkhOJuLTRzxeOhNcE74yoH4=;
        b=cbJDtP4uSmmh1KWtgWYRQ7GQxbeyfcStl7e61xPrGynxppVwEqYwk6z+s81hP+EXkt
         K52yHrkgeeAgP86KtT5KAFcZ0CdsxLXHqKwHHprNR54synVjuphzGKTgpMgDyo96cDQB
         fk7Ncs70N0umkB8lonLXiZIB6sbvGdtjngVIXHVeQrTeKvueeVCDm9rJAMVEzVREJwae
         047XVq+G+yIXFEb+L6MhjLgaCXRMmlxn75fFAY2DL4gVFYj+KXkyMEM3aQhBF5n/C4ez
         K+eW39eE1xvfKqDJkTHVvC3zYClM6m6HUBzaDztE/kKNI8yqFYoSWh2kSSEACwHmAZvK
         AvzQ==
X-Gm-Message-State: ANoB5plaoMZvZRHynsM0ynaV0qvv6fIU7Ylsr0Rvx5pOcWZlir2HyxcK
        UX94KvMrIzWy9EfDYS0Xduo=
X-Google-Smtp-Source: AA0mqf69bc1ZsvE4df0dFC152fE872Y/xXYRuYjW42k/aHXL1ec2lj+lXh051FmPTEXUg4pStZbx8A==
X-Received: by 2002:a05:6a20:7b1b:b0:ae:e972:72a4 with SMTP id s27-20020a056a207b1b00b000aee97272a4mr26568218pzh.36.1671521181236;
        Mon, 19 Dec 2022 23:26:21 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:20 -0800 (PST)
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
Subject: [PATCH v3 09/14] mm/mprotect: Break COW PTE before changing protection
Date:   Tue, 20 Dec 2022 15:27:38 +0800
Message-Id: <20221220072743.3039060-10-shiyn.lin@gmail.com>
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

If the PTE table is COW-ed, break it before changing the protection.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/mprotect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 668bfaa6ed2ae..119116ec8f5e5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -95,6 +95,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	if (break_cow_pte(vma, pmd, addr) < 0)
+		return 0;
+
 	/*
 	 * The pmd points to a regular pte so the pmd can't change
 	 * from under us even if the mmap_lock is only hold for
@@ -305,6 +308,12 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 		return 1;
 	if (pmd_trans_huge(pmdval))
 		return 0;
+	/*
+	 * If the entry point to COW-ed PTE, it's write protection bit
+	 * will cause pmd_bad().
+	 */
+	if (!pmd_write(pmdval))
+		return 0;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
 		return 1;
-- 
2.37.3

