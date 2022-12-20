Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508F5651BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbiLTH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiLTH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:28:04 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554DF167DF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:27:04 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 21so7933866pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOFwABHyEQomQ1BAaOhC3aSTvtto13Wh1TP7RdkKGVE=;
        b=QnipYX8r/cNxeA/VcnjSW/OSh/9P8UNJuqQNtxcvn2GyxEmaZw9iQabvRE1dwc3IsR
         dAuFzZZSQzfKXY8pwrONKqRlExpvyWNEEsnwOOsEFk8OM76ZgWJfE5+Pm/D85D6rLtW3
         Q9Uig/Noj0FXSt2AVzDvVG5SlyyDuU1JFt7gyRzHkSbSziPG0wdVLdfYwo3VpTPPazVd
         +pikE3ai8HaktWHADnbHo51lZ0dczhIifhyThwjVXSQCiEmVGod8pYv8ZVMXJ/vQQlZX
         eWhrMJgRDJUqm/f0KPO3VCs6J2V65fgNZVsZZxuLUtYnBItYK9U4Esqgrg1J0+rzfRhY
         Y+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOFwABHyEQomQ1BAaOhC3aSTvtto13Wh1TP7RdkKGVE=;
        b=BTJvYS4spxawqClPZN3JsF5BIQur69dzc90zuaFE6cJJCiJZrUzmmtEjfU6YgIC4Z6
         AJGWICq80lXPLJTaCpEry0jEUsI55tWgfpMcY7Wpv4XramshiAeqtFLbBFtRkBDlkbOh
         BJfwA0UsEXWPhCKOxLbLHZOGf+frofbiJa6ledrcZ7r9xq60C5PFgdDlRizjaJt3KDNH
         fzJCs43P7v4qrH/fhzaPtY7sIlBHV6+rpY17IhFoLBsMBX+1hjVTmbmlmnlG+V69jsxQ
         SvmJILou60+0PH+KkLNkER3GvgXXnCIY2cxkxML5eb4a+ppQO9KxkRjc8dW14FV2BBCj
         tHzA==
X-Gm-Message-State: AFqh2krG3eOY2N1S2whT1jEN2oCVqBDtTx2PImWJebHTKpEFZFrWB5He
        aKJ78XnHUCKTvWbNUMc487o=
X-Google-Smtp-Source: AMrXdXtiyKeI7TFFv6WMGqX0SE+95zDp3DgcU0JzPCjOSWZyo1MAwEssYqWeR06tsKbgCRIzVkuWew==
X-Received: by 2002:a05:6a00:2dc:b0:57e:866d:c095 with SMTP id b28-20020a056a0002dc00b0057e866dc095mr18317032pft.25.1671521223915;
        Mon, 19 Dec 2022 23:27:03 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:27:03 -0800 (PST)
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
Subject: [PATCH v3 14/14] mm: fork: Enable COW PTE to fork system call
Date:   Tue, 20 Dec 2022 15:27:43 +0800
Message-Id: <20221220072743.3039060-15-shiyn.lin@gmail.com>
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

This patch enables the Copy-On-Write (COW) mechanism to the PTE table
in fork system call. To let the process do COW PTE fork, use
prctl(PR_SET_COW_PTE), it will set the MMF_COW_PTE_READY flag to the
process for enabling COW PTE during the next time of fork.

It uses the MMF_COW_PTE flag to distinguish the normal page table
and the COW one. Moreover, it is difficult to distinguish whether all
the page tables is out of COW state. So the MMF_COW_PTE flag won't be
disabled after setup.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 kernel/fork.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d5..ef3d27577aa43 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2668,6 +2668,11 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace = 0;
 	}
 
+	if (current->mm && test_bit(MMF_COW_PTE_READY, &current->mm->flags)) {
+		clear_bit(MMF_COW_PTE_READY, &current->mm->flags);
+		set_bit(MMF_COW_PTE, &current->mm->flags);
+	}
+
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
-- 
2.37.3

