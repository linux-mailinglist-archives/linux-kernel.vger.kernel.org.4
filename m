Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4A651BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiLTH2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiLTH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:27:50 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA8517AAA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:56 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 21so7933674pfw.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNIdCDWNwkrih/VXKM4PFxJFrGROnp7zsY1kJg/1Z4M=;
        b=gz1nFEL3YX0f+2Ug9WMH010mYn/MV/3KGNNouFO6lfF7BH9Ve3+BLXxeFDAJuISZBj
         B3Z1Fsk/aVHyfQMxzLEqeLGhKCpu2JVWiw4EuNZnCyCXlGcn7N9jc7zsDFgb191Gf86q
         j0/cfv87RORRD7VqFxu293jwGkwCB/EH/aCw6e1z2N2XToOWJQvQMB7JcxygpBVhHxxp
         954CNvUu7r70gJBapgsoa93wOWSmimAkNHfZOOUcLvxDwc8FQEsgP8/UIz+S2dsZ0/Ha
         XfISSvcnATb8mG3jzngNjLEWua9Pe+d2e+I4iDBl5Xr7H232pYSLjqZOw/RzwUt4XB0r
         Lwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNIdCDWNwkrih/VXKM4PFxJFrGROnp7zsY1kJg/1Z4M=;
        b=kTY2kebefOqYykQNO11iCYoJZzowzpG+hMh+OM+mpUJKuZNdhA4rY/USppZyXb1apR
         pn+C0jIfsSsICxpeXji2D96GzQosw2HNqM1MdiKWkbXHYs6e/1F20aES2mQZt9iRVlNz
         cQammwtcMRoi/cfNeU/yElPLr17ghyCPBQ2dalEuSEHUU/I8LeR6w9497X2Fje64KK5D
         JlSEJzl6FmtLWudgaXSeT/k4ECmzkbsS7VZwvKZsQKA05+3e6kfdcDyaTHKmc6K/59Yz
         4mFWI8SOr/3rk5M8jobsesj5++YvLNLXpC7xa7CUyKdmRxUe4oEsXnKhd06vnQ5zYILX
         z8QQ==
X-Gm-Message-State: AFqh2koRqWP9BtvxRSQSJ0stSeSC36gICSLyx+jY2ygaaY3P8qt+2twy
        2kQbq6xq461+RZ9Pj7qBhiI=
X-Google-Smtp-Source: AA0mqf7f1ezLfkTLN/HA7kNFS1SqVBkEd8L8aWm+KL4xeaHkvPNKNWao+2auP5GeoK2czvTXY8A3RA==
X-Received: by 2002:aa7:9f88:0:b0:57d:56f1:6ae7 with SMTP id z8-20020aa79f88000000b0057d56f16ae7mr23753731pfr.33.1671521215509;
        Mon, 19 Dec 2022 23:26:55 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:54 -0800 (PST)
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
Subject: [PATCH v3 13/14] events/uprobes: Break COW PTE before replacing page
Date:   Tue, 20 Dec 2022 15:27:42 +0800
Message-Id: <20221220072743.3039060-14-shiyn.lin@gmail.com>
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

Break COW PTE if we want to replace the page which
resides in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c9..2956a53da01a1 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -157,7 +157,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	struct folio *old_folio = page_folio(old_page);
 	struct folio *new_folio;
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, PVMW_BREAK_COW_PTE);
 	int err;
 	struct mmu_notifier_range range;
 
-- 
2.37.3

