Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D9F727A47
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjFHIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbjFHIpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494026B2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686213864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3gAyEuwafL/hxITBiKfoUbav1sLZb6lLFuGPfJnHhTI=;
        b=EJff4ujyXLTVtUMLSTjN4jlMZOp2ue8wzqMMB6HihZQOODDCUEhkucmyKjR+833xSPiMQo
        O5Uep+NcGwl8ZYkfAmM+0VYFUvG+smtJrwqs+6LTWbJ9AzGsJG14XC8x2SFQ/zSEDHnJeM
        6gd/sbcTz0awjOZMDQdMH/1wFM9xUaM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-cx6GekNUMTCtxgoAxaBUuw-1; Thu, 08 Jun 2023 04:44:23 -0400
X-MC-Unique: cx6GekNUMTCtxgoAxaBUuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49D738037AD;
        Thu,  8 Jun 2023 08:44:22 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACC9340CFD46;
        Thu,  8 Jun 2023 08:44:20 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH v2 1/2] perf util: move symbol__new_unresolved() to util/symbol.c
Date:   Thu,  8 Jun 2023 10:44:06 +0200
Message-Id: <20230608084407.140323-2-asavkov@redhat.com>
In-Reply-To: <20230608084407.140323-1-asavkov@redhat.com>
References: <20230608084407.140323-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make symbol__new_unresolved() available through util/symbol.h
so it can be later used from builtin-c2c.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 22 ----------------------
 tools/perf/util/symbol.c       | 22 ++++++++++++++++++++++
 tools/perf/util/symbol.h       |  1 +
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 69c81759a64f9..10d2243d27504 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2471,28 +2471,6 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
 	return 0;
 }
 
-static struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
-{
-	struct annotated_source *src;
-	struct symbol *sym;
-	char name[64];
-
-	snprintf(name, sizeof(name), "%.*" PRIx64, BITS_PER_LONG / 4, addr);
-
-	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
-	if (sym) {
-		src = symbol__hists(sym, 1);
-		if (!src) {
-			symbol__delete(sym);
-			return NULL;
-		}
-
-		dso__insert_symbol(map__dso(map), sym);
-	}
-
-	return sym;
-}
-
 static int
 add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct popup_action *act, char **optstr,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6b9c55784b56a..297a903f72777 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -294,6 +294,28 @@ void maps__fixup_end(struct maps *maps)
 	up_write(maps__lock(maps));
 }
 
+struct symbol *symbol__new_unresolved(u64 addr, struct map *map)
+{
+	struct annotated_source *src;
+	struct symbol *sym;
+	char name[64];
+
+	snprintf(name, sizeof(name), "%.*" PRIx64, BITS_PER_LONG / 4, addr);
+
+	sym = symbol__new(addr, ANNOTATION_DUMMY_LEN, 0, 0, name);
+	if (sym) {
+		src = symbol__hists(sym, 1);
+		if (!src) {
+			symbol__delete(sym);
+			return NULL;
+		}
+
+		dso__insert_symbol(map__dso(map), sym);
+	}
+
+	return sym;
+}
+
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
 {
 	size_t namelen = strlen(name) + 1;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 7558735543c25..4d47748716627 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -176,6 +176,7 @@ void symbol__exit(void);
 void symbol__elf_init(void);
 int symbol__annotation_init(void);
 
+struct symbol *symbol__new_unresolved(u64 addr, struct map *map);
 struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name);
 size_t __symbol__fprintf_symname_offs(const struct symbol *sym,
 				      const struct addr_location *al,
-- 
2.40.1

