Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2B664EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjAJWU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAJWUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:20:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E87D63F48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:20:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c8e781bc0aso91860487b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+OL21tRhOI5FC8OP8rOHe4TMF297jaFfbFeRu1wlqg=;
        b=pAopMpFhTfX0jzenqkNBx67vQjfjd9TY0dEwmq4dnUUW/5FoxhH/tVN7EA6o41wxrx
         rsUBnMfLZxm5PQ3Gm0Z5qpVo9n/Dnw2t+GjNw3fXdMd4EbvEybnsF61808WRKPLXGEPX
         BP/2/BT6IOMQEJFjn/Laru90RARJ4roIZIz7Einhd/Z0P1NaLFrKvEfC1eWc4LMqSZvs
         b0T7fdriG8IC3vY8yB0wM/np9pfhaT10oOvYNSasEBMAIwRVJOVL3zjz2LA6Lhv6zmQq
         XBNkFoUi1yjwG7YzAhVBeRgAhvFBI7sfazm/WV9x3buWT4x5HgobueNTp6jLXWkx3t0D
         8dBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+OL21tRhOI5FC8OP8rOHe4TMF297jaFfbFeRu1wlqg=;
        b=q7FuZWm0llHgxwGtaxK3J9j2wrYY4Ycsnn8508DEATVf9xzzStNyIMiPUXlAwFHKPQ
         SvXiMOm4VgksSGEm0UeNUyStP1l4cogJ54/vApZyC+nFNtVWMryWeEIW5surjjTs9bOm
         JG5TOhVg9MMdEX7ySnOQ4hLeOKWeZfmJZdEmc2i7NEeZ1TWhQqj/4g44EHgYtM/9CEii
         /5OMeqlRxPV7HFoDgFZ+cF4LCr/MwbjxlqShOXC8zf0V3/f9J1PhslCah0hq8oY3wKen
         oyspVRg0+qesbYWhAtLrucJHDVnIIXwsUOBC3wkCX2bB/XlLugsg3T9GPrdx7GxwCJ0H
         Nn0Q==
X-Gm-Message-State: AFqh2kpaOaJc9B4Q2KEvMq7xp7B19sVYUDZztvk97dRZPQ4GlkvtZUF+
        Px+GH+JiIehVSGCKN0oJ+TiwqoqFtWOH
X-Google-Smtp-Source: AMrXdXulQqaqr6Cu/NW8mUaEtU/19rWhPKAZID8kQpT+uofH5KiblfeW6JI4Cfz9L3ukAKsgfkHBgFGgaTTP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:804:0:b0:767:3057:9533 with SMTP id
 4-20020a250804000000b0076730579533mr8371214ybi.454.1673389244250; Tue, 10 Jan
 2023 14:20:44 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:19:59 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-4-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 3/7] tools lib subcmd: Add run_command_strbuf
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Often a command wants to be run in a shell with stdout placed in a
string. This API mimics that of stdio's popen, running the given
command (not argv array) with "/bin/sh -c" then appending the output
from stdout to the buf argument.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/Makefile      | 32 +++++++++++++++++++++++++++++---
 tools/lib/subcmd/run-command.c | 30 ++++++++++++++++++++++++++++++
 tools/lib/subcmd/run-command.h | 14 ++++++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index b87213263a5e..23174d013519 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -13,6 +13,7 @@ CC ?= $(CROSS_COMPILE)gcc
 LD ?= $(CROSS_COMPILE)ld
 AR ?= $(CROSS_COMPILE)ar
 
+MKDIR = mkdir
 RM = rm -f
 
 MAKEFLAGS += --no-print-directory
@@ -55,6 +56,17 @@ CFLAGS += -I$(srctree)/tools/include/
 
 CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 
+LIBAPI_DIR      = $(srctree)/tools/lib/api/
+ifneq ($(OUTPUT),)
+  LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
+else
+  LIBAPI_OUTPUT = $(CURDIR)/libapi
+endif
+LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
+LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
+LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
+CFLAGS += -I$(LIBAPI_OUTPUT)/include
+
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
 ifeq ($(LP64), 1)
@@ -76,7 +88,9 @@ include $(srctree)/tools/build/Makefile.include
 
 all: fixdep $(LIBFILE)
 
-$(SUBCMD_IN): FORCE
+prepare: $(LIBAPI)
+
+$(SUBCMD_IN): FORCE prepare
 	@$(MAKE) $(build)=libsubcmd
 
 $(LIBFILE): $(SUBCMD_IN)
@@ -113,10 +127,22 @@ install_headers: $(INSTALL_HDRS)
 
 install: install_lib install_headers
 
-clean:
+$(LIBAPI_OUTPUT):
+	$(Q)$(MKDIR) -p $@
+
+$(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
+	$(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
+		DESTDIR=$(LIBAPI_DESTDIR) prefix= \
+		$@ install_headers
+
+$(LIBAPI)-clean:
+	$(call QUIET_CLEAN, libapi)
+	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
+
+clean: $(LIBAPI)-clean
 	$(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
 	find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*.o.d | xargs $(RM)
 
 FORCE:
 
-.PHONY: clean FORCE
+.PHONY: clean FORCE prepare
diff --git a/tools/lib/subcmd/run-command.c b/tools/lib/subcmd/run-command.c
index 5cdac2162532..e90b285b6720 100644
--- a/tools/lib/subcmd/run-command.c
+++ b/tools/lib/subcmd/run-command.c
@@ -7,6 +7,7 @@
 #include <linux/string.h>
 #include <errno.h>
 #include <sys/wait.h>
+#include <api/strbuf.h>
 #include "subcmd-util.h"
 #include "run-command.h"
 #include "exec-cmd.h"
@@ -227,3 +228,32 @@ int run_command_v_opt(const char **argv, int opt)
 	prepare_run_command_v_opt(&cmd, argv, opt);
 	return run_command(&cmd);
 }
+
+int run_command_strbuf(const char *cmd, struct strbuf *buf)
+{
+	const char *argv[4] = {
+		"/bin/sh",
+		"-c",
+		cmd,
+		NULL
+	};
+	struct child_process child = {
+		.argv = argv,
+		.out = -1,
+	};
+	int err;
+	ssize_t read_sz;
+
+	err = start_command(&child);
+	if (err)
+		return err;
+
+	read_sz = strbuf_read(buf, child.out, 0);
+
+	err = finish_command(&child);
+	close(child.out);
+	if (read_sz < 0)
+		return (int)read_sz;
+
+	return err;
+}
diff --git a/tools/lib/subcmd/run-command.h b/tools/lib/subcmd/run-command.h
index 17d969c6add3..1f7a2af9248c 100644
--- a/tools/lib/subcmd/run-command.h
+++ b/tools/lib/subcmd/run-command.h
@@ -58,4 +58,18 @@ int run_command(struct child_process *);
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
 
+struct strbuf;
+/**
+ * run_command_strbuf() - Run cmd using /bin/sh and place stdout in strbuf.
+ * @cmd: The command to run by "/bin/sh -c".
+ * @buf: The strbuf appended to by reading stdout.
+ *
+ * Similar to popen with fread, run the given command reading the stdout output
+ * to buf. As with popen, stderr output goes to the current processes stderr but
+ * may be redirected in cmd by using "2>&1".
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int run_command_strbuf(const char *cmd, struct strbuf *buf);
+
 #endif /* __SUBCMD_RUN_COMMAND_H */
-- 
2.39.0.314.g84b9a713c41-goog

