Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A0A651BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiLTH2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiLTH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:27:38 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD217AA0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so11234401pjj.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyroKMXkbrC7KLBuW9kdtHrj2LCvgbvHbaCl4XJKm0w=;
        b=RzWa85xp16ahKT8BYmKLizeFGJjcYh214M4gWXHr/BTGRafxhKKmAVlwNLT+ZEN/GA
         1qDOToWo/wBMgTwbWnQ09xZqyazrhaVn48i6iInQH8gYcAdY3XYwCCebYfMurD7oW4fC
         vqWTNzfPplWVDkB4u7LVVi1xTyT30BJ3wEB2Vnn1TYtRnCWoebepvUJiJc41xQcDYVYM
         aPo9CDa9/5/L7J2cSCBw0wUtntyh2UxiQczZ0ZwdrZfgWPmfW1T0uX8u/AVR+Q/end4m
         tjci9bFINZ3mAj6dvfIpyxVwESPZNUSkFxZpnhPHOoVBNWsVbqJiMRMOBUi24P5iB0Qn
         s+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyroKMXkbrC7KLBuW9kdtHrj2LCvgbvHbaCl4XJKm0w=;
        b=vks1Z9OFLwA1allOv83OjnfV4E5ZktxWGhJsoDXqBTJoRR13nfoMj1bdt3CaVsEnPS
         32itTdYO0zcRyMh9jJpOTlLVyPb4huV7Pcm3H/rDso824AhmkPtyT4hfKqgF8CyxeXVu
         2SsSrL3Jb0YxnmyMhzzrxU4Xda++RfoESvuVRsaP/E8l8A6rauD/QNbJ2Yh8S6qUDP6E
         fIvL2I186M5AXICrxj4G1ipd9siuzEPndF+dVCFYyEy+wT+hH0iKo+QOE0ilEcXTSacm
         MGFKR4Nl9NbHXaTW4hyVfb9sUyG93EgW6dfGUixvjeICRNmiq9+zu71EN8IMxJrqvrJF
         X1og==
X-Gm-Message-State: AFqh2kpAxViKZMm9qxZ/WZuPM5si9k2x1obuTva5Zr/QyUOIFXUn/lVz
        fz3QESrESpptHpdPlH4lh64=
X-Google-Smtp-Source: AMrXdXvR+Whir8BM0XxNPZtdjAp5PWidsp1Iwk/5/7RTfWUgUOSkfvbwbfP7/3xDQQEAJ/adupbYiA==
X-Received: by 2002:a05:6a21:3a43:b0:b0:275d:3036 with SMTP id zu3-20020a056a213a4300b000b0275d3036mr11490037pzb.24.1671521207015;
        Mon, 19 Dec 2022 23:26:47 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:46 -0800 (PST)
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
Subject: [PATCH v3 12/14] fs/proc: Support COW PTE with clear_refs_write
Date:   Tue, 20 Dec 2022 15:27:41 +0800
Message-Id: <20221220072743.3039060-13-shiyn.lin@gmail.com>
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

Before clearing the entry in COW-ed PTE, break COW PTE first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 fs/proc/task_mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af00..7d34b036c1b96 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1190,6 +1190,9 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	if (break_cow_pte(vma, pmd, addr) < 0)
+		return 0;
+
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
-- 
2.37.3

