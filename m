Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66BA6EC5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjDXF4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjDXFzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:55:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475A49FC;
        Sun, 23 Apr 2023 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682315700; x=1713851700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6xleu/fOnIC7s6yeyC8yL6FZe/msxx+96HNpJqwRSLo=;
  b=RubeAxwNwpy/S5M3HUZD7Du+dmhBPM+0rLUJOTjfzfBUNAMW994XVBOV
   KedbyYzG1MBmRlwkUN+dSh4AtaAIAAiY9irZrOOHGD7FfTr/MhccUXbiM
   PdPfOjYeO6vLCnBtiPGKJhcLoj+EYQjWPVklL3UZpMh5mos7m3voknAjk
   v0OezSgTMHzfTLbPrZc5oiZtFi1K7sOQLNnCV+K1EfgmE703dFIoyfghQ
   W33Anvy4k6uUpy9RBLR4xOFUHyiG3Ed7l2uDDqUqXGD3ma/EHH/wCRB03
   HK3+HCgd5NiMKXE82u+tlCbIaa3bVkiSC2UM51YayQos4mZa0iXiRBTrR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="325972517"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="325972517"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686669275"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="686669275"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.58.217])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:51:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 2/2] perf script: Refine printing of dso offset (dsoff)
Date:   Mon, 24 Apr 2023 08:51:07 +0300
Message-Id: <20230424055107.12105-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424055107.12105-1-adrian.hunter@intel.com>
References: <20230424055107.12105-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print dso offset only for object files, and in those cases force using the
dso->long_name if the dso->name starts with '[' or the dso is kcore, in
order to avoid special names such as [vdso], or mixing up kcore with
vmlinux.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/dso.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h |  2 ++
 tools/perf/util/map.c | 23 +++++++++++++++++++----
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a86614599269..046fbfcfdaab 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -67,6 +67,39 @@ char dso__symtab_origin(const struct dso *dso)
 	return origin[dso->symtab_type];
 }
 
+bool dso__is_object_file(const struct dso *dso)
+{
+	switch (dso->binary_type) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+		return false;
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return true;
+	}
+}
+
 int dso__read_binary_type_filename(const struct dso *dso,
 				   enum dso_binary_type type,
 				   char *root_dir, char *filename, size_t size)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index dfc4cf3de7a8..b23a157c914d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -396,6 +396,8 @@ static inline bool dso__is_kallsyms(const struct dso *dso)
 	return dso->kernel && dso->long_name[0] != '/';
 }
 
+bool dso__is_object_file(const struct dso *dso);
+
 void dso__free_a2l(struct dso *dso);
 
 enum dso_type dso__type(struct dso *dso, struct machine *machine);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 8c96ce6bfc51..4d9944bbf5e4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -431,14 +431,21 @@ size_t map__fprintf(struct map *map, FILE *fp)
 		       map__start(map), map__end(map), map__pgoff(map), dso->name);
 }
 
-size_t map__fprintf_dsoname(struct map *map, FILE *fp)
+static bool prefer_dso_long_name(const struct dso *dso, bool print_off)
+{
+	return dso->long_name &&
+	       (symbol_conf.show_kernel_path ||
+		(print_off && (dso->name[0] == '[' || dso__is_kcore(dso))));
+}
+
+static size_t __map__fprintf_dsoname(struct map *map, bool print_off, FILE *fp)
 {
 	char buf[symbol_conf.pad_output_len_dso + 1];
 	const char *dsoname = "[unknown]";
 	const struct dso *dso = map ? map__dso(map) : NULL;
 
 	if (dso) {
-		if (symbol_conf.show_kernel_path && dso->long_name)
+		if (prefer_dso_long_name(dso, print_off))
 			dsoname = dso->long_name;
 		else
 			dsoname = dso->name;
@@ -452,13 +459,21 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 	return fprintf(fp, "%s", dsoname);
 }
 
+size_t map__fprintf_dsoname(struct map *map, FILE *fp)
+{
+	return __map__fprintf_dsoname(map, false, fp);
+}
+
 size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
 {
+	const struct dso *dso = map ? map__dso(map) : NULL;
 	int printed = 0;
 
+	if (print_off && (!dso || !dso__is_object_file(dso)))
+		print_off = false;
 	printed += fprintf(fp, " (");
-	printed += map__fprintf_dsoname(map, fp);
-	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
+	printed += __map__fprintf_dsoname(map, print_off, fp);
+	if (print_off)
 		printed += fprintf(fp, "+0x%" PRIx64, addr);
 	printed += fprintf(fp, ")");
 
-- 
2.34.1

