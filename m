Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588975BB1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIPR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIPR7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:59:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C262B6D26;
        Fri, 16 Sep 2022 10:59:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so366082pjo.2;
        Fri, 16 Sep 2022 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=3Z1UBNkQWWSj81b1Nj/BZaCfVqWCpu/WDo7Z4K3NP2o=;
        b=Ioi27MsEZ7IT0HFQdqUMcEN+Nw1807kWs1WHf5FBaT/8JBbigpHd7GdbYm2gUZsTfp
         r/FD/MSLwbXQcz9U6XKPxfRGYKwCWNcpOPhNCsJU+4WbzTgFU+OSb138eYvOLbiU05IM
         h73v1L451m4iC21zyLw5zeul3Xe6HiF4tWDSVtwSAEPNpp1NiT+LIKVJ1JSVk33lPCvq
         Lhr0DLV6q/VBbJ//MivNcA9yHgD34NN/RZ43cm2qKahXjRcR2VhqoY9qoikCjv/y17Gx
         /H2zzG/pM3iYNxhN9AlZqNQA6pRInMDQGyqNB/GdCKnAKz9BuFTPhGoHDyh4cmuMyU8R
         KdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=3Z1UBNkQWWSj81b1Nj/BZaCfVqWCpu/WDo7Z4K3NP2o=;
        b=QphvRHIMFz6I0G5hiNdiIGCwFi3tmcNv+FfQB6HpOuhFsiZEsXaUNLvE7BYY9OV3Uy
         rLmFv4GliHp0ZWBu50pMMjraT5vTJTjtaaJddGcru+LLr+EJkeWB+p/HgKwG7q6T+gMQ
         qszqAj3N8zEECDUCDzmRufJO9u0Od1bmq16DxlC4CubW6l0jHBeefZ+thZb+kL91ejLA
         xwK9+3oIpzowGZvXG0/uQVt2XDnr4tRbMWszgI4Kc7N9ePtlMTchCFuQiUjWkMhpx/Hb
         O6oNL8F23Pp9Rpc8OYNF2OlPg4KPansVWxw84R8z+8pE+IaXz+y2cpT+O9MX+bt0Qi+o
         tnlA==
X-Gm-Message-State: ACrzQf32/sMdJextk4cdVnYe33MXhgUmj5tA4KueDegDitxNROOqzAb8
        pAVIV+7vKrye/gRrAmbJUcY=
X-Google-Smtp-Source: AMsMyM4EpAw+rk2ysa2xBRmNCS5vPVVHP4+vjjzX5yAo/4130TLMippq88eB+rRFFCpKSM1Kxp/Q8Q==
X-Received: by 2002:a17:90b:1e49:b0:203:38c:365a with SMTP id pi9-20020a17090b1e4900b00203038c365amr17922997pjb.133.1663351146601;
        Fri, 16 Sep 2022 10:59:06 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170903055500b001767f6f04efsm15059458plb.242.2022.09.16.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:59:06 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] perf tools: Move dsos functions to util/dsos.c
Date:   Fri, 16 Sep 2022 10:58:59 -0700
Message-Id: <20220916175902.1155177-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916175902.1155177-1-namhyung@kernel.org>
References: <20220916175902.1155177-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dsos.c    | 29 +++++++++++++++++++++++++++++
 tools/perf/util/dsos.h    |  3 +++
 tools/perf/util/machine.c | 29 -----------------------------
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 2bd23e4cf19e..90a800625110 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,35 @@
 #include <symbol.h> // filename__read_build_id
 #include <unistd.h>
 
+void dsos__init(struct dsos *dsos)
+{
+	INIT_LIST_HEAD(&dsos->head);
+	dsos->root = RB_ROOT;
+	init_rwsem(&dsos->lock);
+}
+
+static void dsos__purge(struct dsos *dsos)
+{
+	struct dso *pos, *n;
+
+	down_write(&dsos->lock);
+
+	list_for_each_entry_safe(pos, n, &dsos->head, node) {
+		RB_CLEAR_NODE(&pos->rb_node);
+		pos->root = NULL;
+		list_del_init(&pos->node);
+		dso__put(pos);
+	}
+
+	up_write(&dsos->lock);
+}
+
+void dsos__exit(struct dsos *dsos)
+{
+	dsos__purge(dsos);
+	exit_rwsem(&dsos->lock);
+}
+
 static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
 	if (a->maj > b->maj) return -1;
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 5dbec2bc6966..49f448f106f8 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -21,6 +21,9 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
+void dsos__init(struct dsos *dsos);
+void dsos__exit(struct dsos *dsos);
+
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2a16cae28407..4c5540f5c753 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -50,13 +50,6 @@ static struct dso *machine__kernel_dso(struct machine *machine)
 	return machine->vmlinux_map->dso;
 }
 
-static void dsos__init(struct dsos *dsos)
-{
-	INIT_LIST_HEAD(&dsos->head);
-	dsos->root = RB_ROOT;
-	init_rwsem(&dsos->lock);
-}
-
 static void machine__threads_init(struct machine *machine)
 {
 	int i;
@@ -181,28 +174,6 @@ struct machine *machine__new_kallsyms(void)
 	return machine;
 }
 
-static void dsos__purge(struct dsos *dsos)
-{
-	struct dso *pos, *n;
-
-	down_write(&dsos->lock);
-
-	list_for_each_entry_safe(pos, n, &dsos->head, node) {
-		RB_CLEAR_NODE(&pos->rb_node);
-		pos->root = NULL;
-		list_del_init(&pos->node);
-		dso__put(pos);
-	}
-
-	up_write(&dsos->lock);
-}
-
-static void dsos__exit(struct dsos *dsos)
-{
-	dsos__purge(dsos);
-	exit_rwsem(&dsos->lock);
-}
-
 void machine__delete_threads(struct machine *machine)
 {
 	struct rb_node *nd;
-- 
2.37.3.968.ga6b4b080e4-goog

