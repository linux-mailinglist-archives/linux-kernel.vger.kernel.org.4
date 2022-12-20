Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B23651BA1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiLTH1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLTH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:27:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FCA175BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:38 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id e190so3335492pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwVOI/UUu1ABuS2KCRqzKXC5K7Q/+T6ANJVcDug2ZfE=;
        b=BrhX07zrzIpvGLJX0fQwCopam6mGHXBowlolWZ0TNNwJxoVszhbWaofdn/qtuBfm/c
         OlW0Dl05bnhzU2G9MaRprfM6XJ1G41VZB7EZmJuTs/Qff+kX2r5AGV2rV8O04MXC9Fbz
         u1gsRw5xqriQjCIKIwyk3uyFEFIh4qY8bmnDuQikfTU/5eBgAA+wJVelu3IMIr/d73ya
         nRFL6I3cmj1aAjNAsAHd2zJm8NXgJHG7Aq6ltHfeEruRr1lmX74hfCu+3wBFF1fVwxlp
         yeISuWe9bh9Uh8PpP8bB5ff/C9et2/ft7OTjy0w5wUF48dg9LnjeFtP8dK9MlTSBidIH
         NrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwVOI/UUu1ABuS2KCRqzKXC5K7Q/+T6ANJVcDug2ZfE=;
        b=HwMlmDh9qLzqX4Q+3g5I+MGOV7mQOzA+DdSx4CezeSEcLOOYzPmfNAT2F6zBBc7uoI
         3cRA1BvJ8xbD3tNEhSwKGvTYV4fvaO2T0XOxG08iV7kv/Fb7qVQU8TcrGFHvYdFKjAhY
         DyFoZww6CzsPq0o7ob6kcJiKxaKkNax6a752XF4CdKVn9O1Jblnu0w/ENxVYkF/Fr6PZ
         gtk9dEOK3QXo00WZuGJcliEl39USU3PAzzjfhdUDow80oUNuFlvnH7g5C401OJbItNM4
         OlynlyFmLfFDeDm/I4e5IfshEvjuwhHCjk+yV3NZZcIhXag205xG5TmYmUgDDfUpN1mk
         YeYg==
X-Gm-Message-State: ANoB5plt3txPASL9h8BzbiC+OYp1XZL+L40h5ia6+JW9hhWCUy834GRH
        Fxxr0a4rvc9ah8II1NcA4N0=
X-Google-Smtp-Source: AA0mqf6YqNZk4ITPJSCpg7CeWUIx50XL/iBuxra6VL+g21vXDtDQwTBItG+8v2X3J92lZ1TFysHKmA==
X-Received: by 2002:a05:6a00:1e:b0:576:e704:d8c3 with SMTP id h30-20020a056a00001e00b00576e704d8c3mr43783857pfk.23.1671521198441;
        Mon, 19 Dec 2022 23:26:38 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id q15-20020aa7982f000000b00576f9773c80sm7865544pfl.206.2022.12.19.23.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 23:26:37 -0800 (PST)
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
Subject: [PATCH v3 11/14] mm/migrate_device: Support COW PTE
Date:   Tue, 20 Dec 2022 15:27:40 +0800
Message-Id: <20221220072743.3039060-12-shiyn.lin@gmail.com>
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

Break COW PTE before collecting the pages in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/migrate_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 721b2365dbca9..f6d67bd9629f5 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -106,6 +106,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		}
 	}
 
+	if (!break_cow_pte_range(vma, pmdp, start, end))
+		return migrate_vma_collect_skip(start, end, walk);
 	if (unlikely(pmd_bad(*pmdp)))
 		return migrate_vma_collect_skip(start, end, walk);
 
-- 
2.37.3

