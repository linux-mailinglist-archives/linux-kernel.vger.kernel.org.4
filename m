Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627355BB1CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 19:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIPR7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIPR7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 13:59:11 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F6CB6D0A;
        Fri, 16 Sep 2022 10:59:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v1so22130458plo.9;
        Fri, 16 Sep 2022 10:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=FfVxaA/NFL5K4dZMYV/uqZ4exzRsWeYDxGfoCMaxpz4=;
        b=JXmEK+aHvnZ6zy9+8Y2UAmlN29y9xIeMY53W8Vi6Q/b9fxdQ3Xp9j/GBt3sdWXVNBB
         UrDgEBeMMdUChtDEzVyAXNiT97EksUFChk2bktu+45X8LxfLdpeEslesD+x3ubc1+Hgm
         xpsOLJwin47cieM4PS1jxJGRxyvcxTZ1jRHv1oB2Wgw/EmjCDsJ/ncfaIXxJidgw5Cxz
         CgI67NDDHa6A7zNrh//42AsKWGJZ1k4dEwaeNUGPkxNhMfvrrYLBu63GCXLPu3QXYB6U
         aCMVYOZc8F+u3bywLkAtgKGICrVs93kQ5nP+i4ITm03FVQ188TPtkJ3i8oNlf/WrWuKH
         X05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=FfVxaA/NFL5K4dZMYV/uqZ4exzRsWeYDxGfoCMaxpz4=;
        b=bOci3s+pDHeyiEDMJ84ivARcvB7ogQ+o+5HQ39It79R9ts313FYCsZpKr+NR7SodMz
         Z9pUjzav5yNwb6GP3lH0+ZpE8pKWiBoVbQ3ag8Bw4UQTpzC7T37Ciajuchr/g4HtDnOl
         u9r2PNBDOBygrvLYWAPie/ggZaRKq3vKW6ALLOYj0w0erLLqLlygvHDRuFrSc/uU4025
         VLQ62zKXKecYSgmLUBHa1LXEtr4OmOuEu/j4bcJge3J0CO0L8xBJ9wTWiU+JRL4nR4fd
         uag+rNERoMj8cU8o1CTAPXGt++ZZwKbZekOLmX3UrcPH8cvlDTU5EbPXzWN1o+adPlRz
         pU7Q==
X-Gm-Message-State: ACrzQf3fPxVjnuqHayYmMjBcbXg8dKyRQValOIBWP+7+1nL4KetGu2m1
        idBt1gPZWdWqTdrqLQVuPVY=
X-Google-Smtp-Source: AMsMyM6SyudhJbNymixudRa6ddJbRpMbzogNk8I1XknUU4oSXlRHB0Bjr6JMqCkh8sN/hoRvERXmew==
X-Received: by 2002:a17:90b:194a:b0:202:e6eb:4b62 with SMTP id nk10-20020a17090b194a00b00202e6eb4b62mr17921863pjb.33.1663351148686;
        Fri, 16 Sep 2022 10:59:08 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id jo21-20020a170903055500b001767f6f04efsm15059458plb.242.2022.09.16.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 10:59:08 -0700 (PDT)
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
Subject: [PATCH 3/4] perf record: Save DSO build-ID for synthesizing
Date:   Fri, 16 Sep 2022 10:59:01 -0700
Message-Id: <20220916175902.1155177-4-namhyung@kernel.org>
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

When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
it has no idea if it's done already.  Maintain a dsos to check that and skip
the file access if possible.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9d4f5dacd154..e6978b2dee8f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -4,6 +4,7 @@
 #include "util/data.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/dsos.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/machine.h"
@@ -47,12 +48,25 @@
 
 unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
 
+static bool synth_init_done;
+static struct dsos synth_dsos;
+
 void perf_event__synthesize_start(void)
 {
+	if (synth_init_done)
+		return;
+
+	dsos__init(&synth_dsos);
+
+	synth_init_done = true;
 }
 
 void perf_event__synthesize_stop(void)
 {
+	if (!synth_init_done)
+		return;
+
+	dsos__exit(&synth_dsos);
 }
 
 int perf_tool__process_synth_event(struct perf_tool *tool,
@@ -374,26 +388,47 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
 static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 					     bool is_kernel)
 {
-	struct build_id bid;
+	struct build_id _bid, *bid = &_bid;
+	struct dso *dso = NULL;
+	struct dso_id id;
 	int rc;
 
-	if (is_kernel)
-		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
-	else
-		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
+	if (is_kernel) {
+		rc = sysfs__read_build_id("/sys/kernel/notes", bid);
+		goto out;
+	}
+
+	id.maj = event->maj;
+	id.min = event->min;
+	id.ino = event->ino;
+	id.ino_generation = event->ino_generation;
 
+	dso = dsos__findnew_id(&synth_dsos, event->filename, &id);
+	if (dso && dso->has_build_id) {
+		bid = &dso->bid;
+		rc = 0;
+		goto out;
+	}
+
+	rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
+
+out:
 	if (rc == 0) {
-		memcpy(event->build_id, bid.data, sizeof(bid.data));
-		event->build_id_size = (u8) bid.size;
+		memcpy(event->build_id, bid->data, sizeof(bid->data));
+		event->build_id_size = (u8) bid->size;
 		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
 		event->__reserved_1 = 0;
 		event->__reserved_2 = 0;
+
+		if (dso && !dso->has_build_id)
+			dso__set_build_id(dso, bid);
 	} else {
 		if (event->filename[0] == '/') {
 			pr_debug2("Failed to read build ID for %s\n",
 				  event->filename);
 		}
 	}
+	dso__put(dso);
 }
 
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
-- 
2.37.3.968.ga6b4b080e4-goog

