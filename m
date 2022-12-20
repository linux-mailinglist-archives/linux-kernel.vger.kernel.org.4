Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1394651B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiLTH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiLTH0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:26:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6DF327
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:30 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f9so7777995pgf.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJ2p4kzRZQx2M+uHMuQF7vBRM0anRv9EBumcihg3PQc=;
        b=BBqm0Mh4ePRByKmrLfvCwkScNbWATyCDynwf1JxizlYMlSLRoxUJrIiVqjr2xr4xeM
         dmXraAU1naXOkExZXTq2HDWn1prL9xIFcS7HvM38W6tUrv6fZxpiarjsNpU32ymNLIQr
         1HTwmj84kS7nDjMjYHgpU6TL4ka5SbrZPgwfjoq37iHoJJ51q0qV5SBZnfIY4Sob7Kaj
         IINB5xEwVrLOVXzzDrayCqBRJ+fzoXCVnctZ8OeeV9k357WHdx8XMkir3f9v6g+4S1ji
         kEFwAKqEguWLqCHDeSOnPuATmQFixsk2ZArf6QhMk5xYmzSmirPCclh4X9xne4SlPwtn
         3JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ2p4kzRZQx2M+uHMuQF7vBRM0anRv9EBumcihg3PQc=;
        b=OwxTFswTlHXzb3njO/InGtoiNFM1zx+zzC5C2VaU7cqTiXT4B1XTW8RNGbzOgXtNH4
         8WLlgB6tDBKBD3OSl2+/JiPqNaaKCXDnJkSZtqbBVC6AIVvYheax21SVkFVZ818iRSPu
         1tlr1aJ3ZDMomhDnRQHK80z9k+QOEVLuT5Wd3KnoLca9QhO/LvkBPcK/jnMnVaDraw7q
         ajtKOq66Ci192MBi9DNqjTbZ5WhzGv1OPKEYMMRezBNr1XULASgm01Zy/qFkEKYZFnHo
         6jLrPCgBUnqUAvOck/KFxflhPYvVBhZJl3qkyG42fsa57tbsH3vePLOD+awEEnj8TxVl
         2DcA==
X-Gm-Message-State: AFqh2kpG+rzDZ3p63f+zyx2RfXIjRS0U3cFe2XlfVuF3m8q/8Bd+QJ9T
        ESpDYL5NoYJzjKQGZvssleM=
X-Google-Smtp-Source: AMrXdXtfjmPeOLI9E+pbL9c2dP4v9DUaY59cThOKU2xu/3lwgRPb90rNOhO2dbkDkDN2F6VXbNEsrA==
X-Received: by 2002:aa7:874b:0:b0:57e:c106:d50c with SMTP id g11-20020aa7874b000000b0057ec106d50cmr13197565pfo.17.1671521189678;
        Mon, 19 Dec 2022 23:26:29 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:28 -0800 (PST)
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
Subject: [PATCH v3 10/14] mm/userfaultfd: Support COW PTE
Date:   Tue, 20 Dec 2022 15:27:39 +0800
Message-Id: <20221220072743.3039060-11-shiyn.lin@gmail.com>
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

If uffd fills the zeropage or installs to COW-ed PTE, break it first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/userfaultfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 650ab6cfd5f49..4ee21c0d42d90 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -69,6 +69,9 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	struct inode *inode;
 	pgoff_t offset, max_off;
 
+	if (break_cow_pte(dst_vma, dst_pmd, dst_addr) < 0)
+		return -ENOMEM;
+
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	_dst_pte = pte_mkdirty(_dst_pte);
 	if (page_in_cache && !vm_shared)
@@ -227,6 +230,9 @@ static int mfill_zeropage_pte(struct mm_struct *dst_mm,
 	pgoff_t offset, max_off;
 	struct inode *inode;
 
+	if (break_cow_pte(dst_vma, dst_pmd, dst_addr) < 0)
+		return -ENOMEM;
+
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
-- 
2.37.3

