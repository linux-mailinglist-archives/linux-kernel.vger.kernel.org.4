Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E1728BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbjFHXbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbjFHXbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:31:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48623A81
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:30:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561ceb5b584so16142307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686267013; x=1688859013;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivPelAwC3y4XSVWu/g/woCSsh93mZn6kVLmUE8y8n1c=;
        b=o/8C7MEPCtvtxe0KTNOp2hvuO21OtSyIqnCUGXCxoDBVZ1hM0UTDfOuLLu9wmXoDgU
         NupUf/lsgNze0GEP6mGhpeYIvSgXIly86oh9z2Em05rAYNrvq4FCzwyKmNFSaIShua41
         3weNIDbvhelyAr+f3kRdO8Kq/ZZkpbKIZI84VAmPVqEsnlWzKcNR4rEVotPszMSNakud
         XJQHVny/tO6wTL5odn0Z71wVTEZQYhdd7EYfW3ZZqN05eddIHrVyDKXC7K5eGqyv8S1W
         IJV79rf3qBoAK0LtD2+roC7xthkMZNkAG9KPPjPL2yN6WYDofyTHc6lW29zb02e60YCU
         aADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686267013; x=1688859013;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivPelAwC3y4XSVWu/g/woCSsh93mZn6kVLmUE8y8n1c=;
        b=W3XnYYZSkWR2BJPN4rnFVxXkpfm8EQA1L9UOOTnezfDiYEUSLi41GAZWvLfyZYlLGW
         5QDaq+IALCT1e7b94983g+MdtrBcd6IkNAThUjkDVlJZa9hFen8ApdPggtlWRBSHKa/e
         TCyn2+SSZCWgj0m18HG6LYBklkdO/aiQ2cpn3wu7RWbtO19p1Joj9lCgEi4ukvvRC8o/
         BJQc+BoPJOtWox/DItKEdAFkCPxLbqxHD3kWv41Nu4aD7NOxgrgAnfFl6a4YaJKvaURQ
         KNYi4hHqsR6nhz5VWaHbDaygHwxgKIFIePAhDpHJbiVYzCq3HgeaELOJgn4uoiQ3AclF
         sl6w==
X-Gm-Message-State: AC+VfDyT+W0PeMUP3UT8xsksLDlC3narHFFmQxjFair2yGHJNSXj38yy
        73kdXxzxJLaJnd5j8/Njs/EuAFk2OXNx
X-Google-Smtp-Source: ACHHUZ62wofB/jabYpP+aum/UbQ9ZFFxwtAKK2GM4KUJZ12ge6l2beqKO3P18e/K5xM1ekEKjDs0EnsTUyPv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ac4b:0:b0:565:c0e3:d2d7 with SMTP id
 z11-20020a81ac4b000000b00565c0e3d2d7mr697104ywj.1.1686267013537; Thu, 08 Jun
 2023 16:30:13 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:22 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-26-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 25/26] perf srcline: Change free_srcline to zfree_srcline
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use after free more unlikely.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c    |  4 ++--
 tools/perf/util/annotate.c   |  2 +-
 tools/perf/util/block-info.c |  4 ++--
 tools/perf/util/hist.c       |  6 +++---
 tools/perf/util/map.c        |  2 +-
 tools/perf/util/srcline.c    | 15 ++++++++++-----
 tools/perf/util/srcline.h    |  2 +-
 7 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ca39657ee407..eec89567ae48 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1387,8 +1387,8 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
 			  bi->start, bi->end, block_he->diff.cycles);
 	}
 
-	free_srcline(start_line);
-	free_srcline(end_line);
+	zfree_srcline(&start_line);
+	zfree_srcline(&end_line);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fc5f44535ebe..58fc5fa00ecd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1196,7 +1196,7 @@ static void annotation_line__init(struct annotation_line *al,
 
 static void annotation_line__exit(struct annotation_line *al)
 {
-	free_srcline(al->path);
+	zfree_srcline(&al->path);
 	zfree(&al->line);
 }
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index 16a7b4adcf18..08279b1b65e5 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -305,8 +305,8 @@ static int block_range_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			  bi->start, bi->end);
 	}
 
-	free_srcline(start_line);
-	free_srcline(end_line);
+	zfree_srcline(&start_line);
+	zfree_srcline(&end_line);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
 }
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4004c0915e4f..77cb2cc83bb9 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1317,8 +1317,8 @@ void hist_entry__delete(struct hist_entry *he)
 	if (he->branch_info) {
 		map__zput(he->branch_info->from.ms.map);
 		map__zput(he->branch_info->to.ms.map);
-		free_srcline(he->branch_info->srcline_from);
-		free_srcline(he->branch_info->srcline_to);
+		zfree_srcline(&he->branch_info->srcline_from);
+		zfree_srcline(&he->branch_info->srcline_to);
 		zfree(&he->branch_info);
 	}
 
@@ -1336,7 +1336,7 @@ void hist_entry__delete(struct hist_entry *he)
 
 	zfree(&he->res_samples);
 	zfree(&he->stat_acc);
-	free_srcline(he->srcline);
+	zfree_srcline(&he->srcline);
 	if (he->srcfile && he->srcfile[0])
 		zfree(&he->srcfile);
 	free_callchain(he->callchain);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ae1d54d4880a..c77e2fce6a37 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -498,7 +498,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 		char *srcline = map__srcline(map, addr, NULL);
 		if (strncmp(srcline, SRCLINE_UNKNOWN, strlen(SRCLINE_UNKNOWN)) != 0)
 			ret = fprintf(fp, "%s%s", prefix, srcline);
-		free_srcline(srcline);
+		zfree_srcline(&srcline);
 	}
 	return ret;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index cfca03abd6f8..b8e596528d7e 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -804,10 +804,15 @@ char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line)
 	return NULL;
 }
 
-void free_srcline(char *srcline)
+void zfree_srcline(char **srcline)
 {
-	if (srcline && strcmp(srcline, SRCLINE_UNKNOWN) != 0)
-		free(srcline);
+	if (*srcline == NULL)
+		return;
+
+	if (strcmp(*srcline, SRCLINE_UNKNOWN))
+		free(*srcline);
+
+	*srcline = NULL;
 }
 
 char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
@@ -880,7 +885,7 @@ void srcline__tree_delete(struct rb_root_cached *tree)
 		pos = rb_entry(next, struct srcline_node, rb_node);
 		next = rb_next(&pos->rb_node);
 		rb_erase_cached(&pos->rb_node, tree);
-		free_srcline(pos->srcline);
+		zfree_srcline(&pos->srcline);
 		zfree(&pos);
 	}
 }
@@ -903,7 +908,7 @@ void inline_node__delete(struct inline_node *node)
 
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
-		free_srcline(ilist->srcline);
+		zfree_srcline(&ilist->srcline);
 		/* only the inlined symbols are owned by the list */
 		if (ilist->symbol && ilist->symbol->inlined)
 			symbol__delete(ilist->symbol);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index b11a0aaaa676..a15c7db9058e 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -15,7 +15,7 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		  bool show_sym, bool show_addr, bool unwind_inlines,
 		  u64 ip);
-void free_srcline(char *srcline);
+void zfree_srcline(char **srcline);
 char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line);
 
 /* insert the srcline into the DSO, which will take ownership */
-- 
2.41.0.162.gfafddb0af9-goog

