Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536037251AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbjFGBpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbjFGBoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA31BCC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso10968034276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102260; x=1688694260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bW22iCLcnVyG17q+hwah70giVeTouideHDH1/wLqBpY=;
        b=aFQ/niTlITlS0QHgpkIO4ZJNtfMNL1ZyImv8FujmhGVqrXbHCuHjixy7pYcWVDwLtX
         EESJo5+1Z/5U8SBB6Yso2vxQn+62FD3d4BVd4pUdzPUl/Vbb0A/eOx3LpWEyv6JS5z0l
         HSGRf9Selc9MDGFlD6egPA9p7KH1GSMqWebfFYtTflOyJvcMq6sf8jfYpF2PmIgnxzw4
         Jjk2AY+AdVoMYg+xmVej7G56Oh8rHYUzKN8hPmDgmgGc3hYQWMN3U7E+ZNyLjklUxEPH
         yAWgka4n1uI/JipYFDmymISKonqOQukFL2EmJkYvwnhJ8E7n2cUPY5dk8naMg0DViGUh
         /Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102260; x=1688694260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW22iCLcnVyG17q+hwah70giVeTouideHDH1/wLqBpY=;
        b=VkM+rpJUUMwwjgAXy1jbCTVSCLFcyCrB/kqChsB8YBlmhmyTFdUlp21nSAu4hSsx0d
         e98yesNtMSKVA4PJmZ4OIQrfBNWM+Nq6yFN2opek1NTTBg7WgnrE9aEGbIfPNTtvaW5o
         MaTym/k1jqKTR9KO2dNKLOb6/JxLXXboMxeq+Wv59sShE0jv39vDPXPJ+OBj5YdAKnG0
         G5PP7Y3WrvYlDTae/89f454iLrUoU6HD4qFU1edAF7PkDfyDyy+yLkjfJm2pUliCoqjQ
         e1tATxc7xWvvYQ22sWhdgntxLDf4Bhv2PSxK9FXmJtPiOEy8Tf2JpYZfTP+Tbe4fL4Wg
         kNOw==
X-Gm-Message-State: AC+VfDz42RH9HmQvfUQP96741JUtwwXeoFhqr1qswlaN9hPNsgymG21K
        L/e5lfGBJ2BSR2R0mTPfEbZ+zIl3xeS7
X-Google-Smtp-Source: ACHHUZ6c65OKRcKO6UJad2m9aYS6PWtV0IlaruzdBw13waRl7Sr6HFY4DQ0FXFgFRItwhGBY1lopT/Rzd+ha
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a25:2446:0:b0:b9a:703d:e650 with SMTP id
 k67-20020a252446000000b00b9a703de650mr1392677ybk.7.1686102259875; Tue, 06 Jun
 2023 18:44:19 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:37 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-5-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 04/20] perf maps: Make delete static, always use put
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
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
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

Address/leak sanitizer with reference count checking can identify the
location of leaks, so use put rather than delete to avoid free-ing
memory when the reference count is >1. Add maps__zput to ensure the
variable is cleared.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c   | 2 +-
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/maps.c    | 2 +-
 tools/perf/util/maps.h    | 9 ++++++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 8c0eb5cf8bb5..5bb1123a91a7 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -140,7 +140,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	ret = check_maps(merged3, ARRAY_SIZE(merged3), maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	maps__delete(maps);
+	maps__zput(maps);
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5d34d60a0045..8972c852d3bd 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -248,7 +248,7 @@ void machine__exit(struct machine *machine)
 		return;
 
 	machine__destroy_kernel_maps(machine);
-	maps__delete(machine->kmaps);
+	maps__zput(machine->kmaps);
 	dsos__exit(&machine->dsos);
 	machine__exit_vdso(machine);
 	zfree(&machine->root_dir);
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index 5ae6379a1b42..5206a6433117 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -171,7 +171,7 @@ struct maps *maps__new(struct machine *machine)
 	return result;
 }
 
-void maps__delete(struct maps *maps)
+static void maps__delete(struct maps *maps)
 {
 	maps__exit(maps);
 	unwind__finish_access(maps);
diff --git a/tools/perf/util/maps.h b/tools/perf/util/maps.h
index d2963456cfbe..83144e0645ed 100644
--- a/tools/perf/util/maps.h
+++ b/tools/perf/util/maps.h
@@ -57,13 +57,20 @@ struct kmap {
 };
 
 struct maps *maps__new(struct machine *machine);
-void maps__delete(struct maps *maps);
 bool maps__empty(struct maps *maps);
 int maps__clone(struct thread *thread, struct maps *parent);
 
 struct maps *maps__get(struct maps *maps);
 void maps__put(struct maps *maps);
 
+static inline void __maps__zput(struct maps **map)
+{
+	maps__put(*map);
+	*map = NULL;
+}
+
+#define maps__zput(map) __maps__zput(&map)
+
 static inline struct rb_root *maps__entries(struct maps *maps)
 {
 	return &RC_CHK_ACCESS(maps)->entries;
-- 
2.41.0.rc0.172.g3f132b7071-goog

