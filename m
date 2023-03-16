Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEA6BD0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCPNhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCPNg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5672495BCC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678973763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdTy8LwQuT1vM/sjRa73k8MF8G/jzq0/puVjW8AQsjs=;
        b=VYiFMr1MbvyFdDyLRxgVa7gUUdsHCyOjhIsNFjeTVYeVBlRcan5Zq4/jJDX3McRk0j//zB
        t9jsWIi+L8Ox0cExatTKT6vHLe15QrmeVMQRnl2L4+GsPhdQoxoCFqUaFxqU7GjGeCkr9Z
        7yS0Me6VlTlw8j2KMDSrnQMqoWVbPyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-omBRmILINZ2kA6aNpWWwYA-1; Thu, 16 Mar 2023 09:36:01 -0400
X-MC-Unique: omBRmILINZ2kA6aNpWWwYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66730185A792;
        Thu, 16 Mar 2023 13:36:00 +0000 (UTC)
Received: from shodan.usersys.redhat.com (unknown [10.43.17.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B74E2A68;
        Thu, 16 Mar 2023 13:36:00 +0000 (UTC)
Received: by shodan.usersys.redhat.com (Postfix, from userid 1000)
        id 030911C00F9; Thu, 16 Mar 2023 14:35:58 +0100 (CET)
From:   Artem Savkov <asavkov@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 1/1] perf report: append inlines to non-dwarf callchains
Date:   Thu, 16 Mar 2023 14:35:57 +0100
Message-Id: <20230316133557.868731-2-asavkov@redhat.com>
In-Reply-To: <20230316133557.868731-1-asavkov@redhat.com>
References: <20230316133557.868731-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append information about inlined functions to fp and lbr callchains
from dwarf debuginfo when available. Do so by calling append_inlines()
from add_callchain_ip(). This requires append_inlies to  be moved up a
bit.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/perf/util/machine.c | 82 ++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 803c9d1803dd..2dd46b9f0083 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2249,6 +2249,45 @@ struct iterations {
 	u64 cycles;
 };
 
+static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip)
+{
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+	int ret = 1;
+
+	if (!symbol_conf.inline_name || !map || !sym)
+		return ret;
+
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
+
+	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
+		if (!inline_node)
+			return ret;
+		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		struct map_symbol ilist_ms = {
+			.maps = ms->maps,
+			.map = map,
+			.sym = ilist->symbol,
+		};
+		ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
+					      NULL, 0, 0, 0, ilist->srcline);
+
+		if (ret != 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
 			    struct symbol **parent,
@@ -2322,6 +2361,10 @@ static int add_callchain_ip(struct thread *thread,
 	ms.maps = al.maps;
 	ms.map = al.map;
 	ms.sym = al.sym;
+
+	if (append_inlines(cursor, &ms, ip) == 0)
+		return 0;
+
 	srcline = callchain_srcline(&ms, al.addr);
 	return callchain_cursor_append(cursor, ip, &ms,
 				       branch, flags, nr_loop_iter,
@@ -3008,45 +3051,6 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	return 0;
 }
 
-static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip)
-{
-	struct symbol *sym = ms->sym;
-	struct map *map = ms->map;
-	struct inline_node *inline_node;
-	struct inline_list *ilist;
-	u64 addr;
-	int ret = 1;
-
-	if (!symbol_conf.inline_name || !map || !sym)
-		return ret;
-
-	addr = map__map_ip(map, ip);
-	addr = map__rip_2objdump(map, addr);
-
-	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
-	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
-		if (!inline_node)
-			return ret;
-		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
-	}
-
-	list_for_each_entry(ilist, &inline_node->val, list) {
-		struct map_symbol ilist_ms = {
-			.maps = ms->maps,
-			.map = map,
-			.sym = ilist->symbol,
-		};
-		ret = callchain_cursor_append(cursor, ip, &ilist_ms, false,
-					      NULL, 0, 0, 0, ilist->srcline);
-
-		if (ret != 0)
-			return ret;
-	}
-
-	return ret;
-}
-
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
-- 
2.39.2

