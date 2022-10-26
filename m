Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F6B60DEFA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiJZKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiJZKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D43B986;
        Wed, 26 Oct 2022 03:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06D84B82191;
        Wed, 26 Oct 2022 10:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA19BC433D7;
        Wed, 26 Oct 2022 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666781095;
        bh=Eb5H+bJ/4uuaxSdyPmeE6S4n+j6m4pwFeLE6n5RVXwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVggyV/KKzOgs8ngNAlg3yb3juRT6t4t93rNyKexk6ldK54d4xLhaN1+bwf0ZnxYZ
         DfiuFNQmwRjhzrDRJeH9FAwx5QRDylQX9Aw/taA5cyxztXLcorFuhv2zwTfq1DDgbT
         +jNFlYqIXk/dr0yWAg1rLC2wrfZ4xug16aKC401XmXGX5SHOFSdHquVfEv/2C0faAm
         bYamuwYnQPyDvgiGAVlCwxuNPSHCJjRcmzgepON/4t/Nge03mn7DeAgsnbPwKNONO5
         bhneXeQ43kkbX2Y81fWF0Kv4NyS56u4uUg4lx94GkGxSWvp0fWfBU0kQm5rK7RiCT0
         jUV/n0Vuhf7lw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] rv: Add rv tool
Date:   Wed, 26 Oct 2022 12:44:39 +0200
Message-Id: <4bbed6320b2f3fdc28dff3810091d668ec02dff1.1666776642.git.bristot@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666776642.git.bristot@kernel.org>
References: <cover.1666776642.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the (user-space) runtime verification tool, named rv.

This tool aims to be the interface for in-kernel rv monitors, as
well as the home for monitors in user-space (online asynchronous),
and in *eBPF.

The tool receives a command as the first argument, the current
commands are:

  list	- list all available monitors
  mon	- run a given monitor

Each monitor is an independent piece of software inside the
tool and can have their own arguments.

There is no monitor implemented in this patch, it only
adds the basic structure of the tool, based on rtla.

  # rv --help
    help

    usage: rv command [-h] [command_options]

	-h/--help: print this menu

	command: run one of the following command:
	  list: list all available monitors
	  mon:  run a monitor

	[command options]: each command has its own set of options
		           run rv command -h for further information

*dot2bpf is the next patch set, depends on this, doing cleanups.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/verification/rv/Makefile        | 119 ++++++++++++++++++
 tools/verification/rv/README.txt      |  38 ++++++
 tools/verification/rv/include/rv.h    |  12 ++
 tools/verification/rv/include/trace.h |  16 +++
 tools/verification/rv/include/utils.h |   8 ++
 tools/verification/rv/src/rv.c        | 174 ++++++++++++++++++++++++++
 tools/verification/rv/src/trace.c     | 128 +++++++++++++++++++
 tools/verification/rv/src/utils.c     |  46 +++++++
 8 files changed, 541 insertions(+)
 create mode 100644 tools/verification/rv/Makefile
 create mode 100644 tools/verification/rv/README.txt
 create mode 100644 tools/verification/rv/include/rv.h
 create mode 100644 tools/verification/rv/include/trace.h
 create mode 100644 tools/verification/rv/include/utils.h
 create mode 100644 tools/verification/rv/src/rv.c
 create mode 100644 tools/verification/rv/src/trace.c
 create mode 100644 tools/verification/rv/src/utils.c

diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
new file mode 100644
index 000000000000..1de111ac2641
--- /dev/null
+++ b/tools/verification/rv/Makefile
@@ -0,0 +1,119 @@
+NAME	:=	rv
+# Follow the kernel version
+VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
+
+# From libtracefs:
+# Makefiles suck: This macro sets a default value of $(2) for the
+# variable named by $(1), unless the variable has been set by
+# environment or command line. This is necessary for CC and AR
+# because make sets default values, so the simpler ?= approach
+# won't work as expected.
+define allow-override
+  $(if $(or $(findstring environment,$(origin $(1))),\
+            $(findstring command line,$(origin $(1)))),,\
+    $(eval $(1) = $(2)))
+endef
+
+# Allow setting CC and AR, or setting CROSS_COMPILE as a prefix.
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+$(call allow-override,AR,$(CROSS_COMPILE)ar)
+$(call allow-override,STRIP,$(CROSS_COMPILE)strip)
+$(call allow-override,PKG_CONFIG,pkg-config)
+$(call allow-override,LD_SO_CONF_PATH,/etc/ld.so.conf.d/)
+$(call allow-override,LDCONFIG,ldconfig)
+
+INSTALL	=	install
+MKDIR	=	mkdir
+FOPTS	:=	-flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong \
+		-fasynchronous-unwind-tables -fstack-clash-protection
+WOPTS	:= 	-Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+
+TRACEFS_HEADERS	:= $$($(PKG_CONFIG) --cflags libtracefs)
+
+CFLAGS	:=	-O -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(TRACEFS_HEADERS) $(EXTRA_CFLAGS) -I include
+LDFLAGS	:=	-ggdb $(EXTRA_LDFLAGS)
+LIBS	:=	$$($(PKG_CONFIG) --libs libtracefs)
+
+SRC	:=	$(wildcard src/*.c)
+HDR	:=	$(wildcard src/*.h)
+OBJ	:=	$(SRC:.c=.o)
+DIRS	:=	src
+FILES	:=	Makefile README.txt
+CEXT	:=	bz2
+TARBALL	:=	$(NAME)-$(VERSION).tar.$(CEXT)
+TAROPTS	:=	-cvjf $(TARBALL)
+BINDIR	:=	/usr/bin
+DATADIR	:=	/usr/share
+MANDIR	:=	$(DATADIR)/man
+LICDIR	:=	$(DATADIR)/licenses
+SRCTREE	:=	$(or $(BUILD_SRC),$(CURDIR))
+
+LIBTRACEEVENT_MIN_VERSION = 1.5
+LIBTRACEFS_MIN_VERSION = 1.3
+
+.PHONY:	all warnings show_warnings
+all:	warnings rv
+
+TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_LIBTRACEEVENT)", "n")
+WARNINGS = show_warnings
+MISSING_LIBS += echo "**   libtraceevent version $(LIBTRACEEVENT_MIN_VERSION) or higher";
+MISSING_PACKAGES += "libtraceevent-devel"
+MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/ ";
+endif
+
+TEST_LIBTRACEFS = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEFS_MIN_VERSION) libtracefs > /dev/null 2>&1 || echo n")
+ifeq ("$(TEST_LIBTRACEFS)", "n")
+WARNINGS = show_warnings
+MISSING_LIBS += echo "**   libtracefs version $(LIBTRACEFS_MIN_VERSION) or higher";
+MISSING_PACKAGES += "libtracefs-devel"
+MISSING_SOURCE += echo "**  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/ ";
+endif
+
+define show_dependencies
+	@echo "********************************************";				\
+	echo "** NOTICE: Failed build dependencies";					\
+	echo "**";									\
+	echo "** Required Libraries:";							\
+	$(MISSING_LIBS)									\
+	echo "**";									\
+	echo "** Consider installing the latest libtracefs from your";			\
+	echo "** distribution, e.g., 'dnf install $(MISSING_PACKAGES)' on Fedora,";	\
+	echo "** or from source:";							\
+	echo "**";									\
+	$(MISSING_SOURCE)								\
+	echo "**";									\
+	echo "********************************************"
+endef
+
+show_warnings:
+	$(call show_dependencies);
+
+ifneq ("$(WARNINGS)", "")
+ERROR_OUT = $(error Please add the necessary dependencies)
+
+warnings: $(WARNINGS)
+	$(ERROR_OUT)
+endif
+
+rv: $(OBJ)
+	$(CC) -o rv $(LDFLAGS) $(OBJ) $(LIBS)
+
+.PHONY: install
+install:
+	$(MKDIR) -p $(DESTDIR)$(BINDIR)
+	$(INSTALL) rv -m 755 $(DESTDIR)$(BINDIR)
+	$(STRIP) $(DESTDIR)$(BINDIR)/rv
+
+.PHONY: clean tarball
+clean:
+	@test ! -f rv || rm rv
+	@test ! -f $(TARBALL) || rm -f $(TARBALL)
+	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
+
+tarball: clean
+	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
+	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
+	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
+	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
+	rm -rf $(NAME)-$(VERSION)
diff --git a/tools/verification/rv/README.txt b/tools/verification/rv/README.txt
new file mode 100644
index 000000000000..e96be0dfff59
--- /dev/null
+++ b/tools/verification/rv/README.txt
@@ -0,0 +1,38 @@
+RV: Runtime Verification
+
+Runtime Verification (RV) is a lightweight (yet rigorous) method that
+complements classical exhaustive verification techniques (such as model
+checking and theorem proving) with a more practical approach for
+complex systems.
+
+The rv tool is the interface for a collection of monitors that aim
+analysing the logical and timing behavior of Linux.
+
+Installing RV
+
+RV depends on the following libraries and tools:
+
+ - libtracefs
+ - libtraceevent
+
+It also depends on python3-docutils to compile man pages.
+
+For development, we suggest the following steps for compiling rtla:
+
+  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
+  $ cd libtraceevent/
+  $ make
+  $ sudo make install
+  $ cd ..
+  $ git clone git://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git
+  $ cd libtracefs/
+  $ make
+  $ sudo make install
+  $ cd ..
+  $ cd $rv_src
+  $ make
+  $ sudo make install
+
+For further information, please see rv manpage and the kernel documentation:
+  Runtime Verification:
+    Documentation/trace/rv/runtime-verification.rst
diff --git a/tools/verification/rv/include/rv.h b/tools/verification/rv/include/rv.h
new file mode 100644
index 000000000000..770fd6da3610
--- /dev/null
+++ b/tools/verification/rv/include/rv.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define MAX_DESCRIPTION 1024
+#define MAX_DA_NAME_LEN	24
+
+struct monitor {
+	char name[MAX_DA_NAME_LEN];
+	char desc[MAX_DESCRIPTION];
+	int enabled;
+};
+
+int should_stop(void);
diff --git a/tools/verification/rv/include/trace.h b/tools/verification/rv/include/trace.h
new file mode 100644
index 000000000000..8d89e8c303fa
--- /dev/null
+++ b/tools/verification/rv/include/trace.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <tracefs.h>
+
+struct trace_instance {
+	struct tracefs_instance		*inst;
+	struct tep_handle		*tep;
+	struct trace_seq		*seq;
+};
+
+int trace_instance_init(struct trace_instance *trace, char *name);
+int trace_instance_start(struct trace_instance *trace);
+void trace_instance_destroy(struct trace_instance *trace);
+
+int collect_registered_events(struct tep_event *event, struct tep_record *record,
+			      int cpu, void *context);
diff --git a/tools/verification/rv/include/utils.h b/tools/verification/rv/include/utils.h
new file mode 100644
index 000000000000..f24ae8282bd2
--- /dev/null
+++ b/tools/verification/rv/include/utils.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define MAX_PATH		1024
+
+void debug_msg(const char *fmt, ...);
+void err_msg(const char *fmt, ...);
+
+extern int config_debug;
diff --git a/tools/verification/rv/src/rv.c b/tools/verification/rv/src/rv.c
new file mode 100644
index 000000000000..91d37b682917
--- /dev/null
+++ b/tools/verification/rv/src/rv.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * rv tool, the interface for the Linux kernel RV subsystem and home of
+ * user-space controlled monitors.
+ *
+ * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+
+#include <trace.h>
+#include <utils.h>
+
+static int stop_session;
+
+/*
+ * stop_rv - tell monitors to stop
+ */
+static void stop_rv(int sig)
+{
+	stop_session = 1;
+}
+
+/**
+ * should_stop - check if the monitor should stop.
+ */
+int should_stop(void)
+{
+	return stop_session;
+}
+
+/*
+ * rv_list - list all available monitors
+ */
+static void rv_list(int argc, char **argv)
+{
+	int i;
+	static const char *const usage[] = {
+		"",
+		"  usage: rv list [-h]",
+		"",
+		"	list all avaibale monitors",
+		"",
+		"	-h/--help: print this menu",
+		NULL,
+	};
+
+	if (argc > 1) {
+		/* more than 1 is always usage */
+		for (i = 0; usage[i]; i++)
+			fprintf(stderr, "%s\n", usage[i]);
+
+		/* but only -h is valid */
+		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+			exit(0);
+		else
+			exit(1);
+	}
+
+	exit(0);
+}
+
+/*
+ * rv_mon - try to run a monitor passed as argument
+ */
+static void rv_mon(int argc, char **argv)
+{
+	char *monitor_name;
+	int i, run;
+
+	static const char *const usage[] = {
+		"",
+		"  usage: rv mon [-h] monitor [monitor options]",
+		"",
+		"	run a monitor",
+		"",
+		"	-h/--help: print this menu",
+		"",
+		"	moninor [monitor options]: the monitor, passing",
+		"	the arguments to the [monitor options]",
+		NULL,
+	};
+
+	/* requires at least one argument */
+	if (argc == 1) {
+		for (i = 0; usage[i]; i++)
+			fprintf(stderr, "%s\n", usage[i]);
+		exit(1);
+	} else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
+		for (i = 0; usage[i]; i++)
+			fprintf(stderr, "%s\n", usage[i]);
+		exit(0);
+	}
+
+	monitor_name = argv[1];
+	/*
+	 * Call all possible monitor implementations, looking
+	 * for the [monitor].
+	 */
+
+	if (!run)
+		err_msg("rv: monitor %s does not exist\n", monitor_name);
+	exit(!run);
+}
+
+static void usage(int exit_val, const char *fmt, ...)
+{
+	char message[1024];
+	va_list ap;
+	int i;
+
+	static const char *const usage[] = {
+		"",
+		"  usage: rv command [-h] [command_options]",
+		"",
+		"	-h/--help: print this menu",
+		"",
+		"	command: run one of the following command:",
+		"	  list: list all available monitors",
+		"	  mon:  run a monitor",
+		"",
+		"	[command options]: each command has its own set of options",
+		"		           run rv command -h for further information",
+		NULL,
+	};
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "  %s\n", message);
+
+	for (i = 0; usage[i]; i++)
+		fprintf(stderr, "%s\n", usage[i]);
+
+	exit(exit_val);
+}
+
+/*
+ * main - select which main sending the command
+ *
+ * main itself redirects the arguments to the sub-commands
+ * to handle the options.
+ *
+ * subcommands should exit.
+ */
+int main(int argc, char **argv)
+{
+	if (geteuid())
+		usage(1, "%s needs root permission", argv[0]);
+
+	if (argc <= 1)
+		usage(1, "%s requires a command", argv[0]);
+
+	if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+		usage(0, "help");
+
+	if (!strcmp(argv[1], "list"))
+		rv_list(--argc, &argv[1]);
+
+	if (!strcmp(argv[1], "mon")) {
+		/*
+		 * monitor's main should monitor should_stop() function.
+		 * and exit.
+		 */
+		signal(SIGINT, stop_rv);
+
+		rv_mon(argc - 1, &argv[1]);
+	}
+
+	/* invalid sub-command */
+	usage(1, "%s does not know the %s command, old version?", argv[0], argv[1]);
+}
diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/src/trace.c
new file mode 100644
index 000000000000..2639f1b1cdf1
--- /dev/null
+++ b/tools/verification/rv/src/trace.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace helpers.
+ *
+ * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#define _GNU_SOURCE
+#include <sys/sendfile.h>
+#include <tracefs.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <rv.h>
+#include <trace.h>
+#include <utils.h>
+
+/*
+ * create_instance - create a trace instance with *instance_name
+ */
+static struct tracefs_instance *create_instance(char *instance_name)
+{
+	return tracefs_instance_create(instance_name);
+}
+
+/*
+ * destroy_instance - remove a trace instance and free the data
+ */
+static void destroy_instance(struct tracefs_instance *inst)
+{
+	tracefs_instance_destroy(inst);
+	tracefs_instance_free(inst);
+}
+
+/*
+ * collect_registered_events - call the existing callback function for the event
+ *
+ * If an event has a registered callback function, call it.
+ * Otherwise, ignore the event.
+ */
+int
+collect_registered_events(struct tep_event *event, struct tep_record *record,
+			  int cpu, void *context)
+{
+	struct trace_instance *trace = context;
+	struct trace_seq *s = trace->seq;
+
+	if (should_stop())
+		return 1;
+
+	if (!event->handler)
+		return 0;
+
+	event->handler(s, record, event, context);
+
+	return 0;
+}
+
+/*
+ * trace_instance_destroy - destroy and free a rv trace instance
+ */
+void trace_instance_destroy(struct trace_instance *trace)
+{
+	if (trace->inst) {
+		destroy_instance(trace->inst);
+		trace->inst = NULL;
+	}
+
+	if (trace->seq) {
+		free(trace->seq);
+		trace->seq = NULL;
+	}
+
+	if (trace->tep) {
+		tep_free(trace->tep);
+		trace->tep = NULL;
+	}
+}
+
+/*
+ * trace_instance_init - create an trace instance
+ *
+ * It is more than the tracefs instance, as it contains other
+ * things required for the tracing, such as the local events and
+ * a seq file.
+ *
+ * Note that the trace instance is returned disabled. This allows
+ * the tool to apply some other configs, like setting priority
+ * to the kernel threads, before starting generating trace entries.
+ */
+int trace_instance_init(struct trace_instance *trace, char *name)
+{
+	trace->seq = calloc(1, sizeof(*trace->seq));
+	if (!trace->seq)
+		goto out_err;
+
+	trace_seq_init(trace->seq);
+
+	trace->inst = create_instance(name);
+	if (!trace->inst)
+		goto out_err;
+
+	trace->tep = tracefs_local_events(NULL);
+	if (!trace->tep)
+		goto out_err;
+
+	/*
+	 * Let the main enable the record after setting some other
+	 * things such as the priority of the tracer's threads.
+	 */
+	tracefs_trace_off(trace->inst);
+
+	return 0;
+
+out_err:
+	trace_instance_destroy(trace);
+	return 1;
+}
+
+/*
+ * trace_instance_start - start tracing a given rv instance
+ */
+int trace_instance_start(struct trace_instance *trace)
+{
+	return tracefs_trace_on(trace->inst);
+}
diff --git a/tools/verification/rv/src/utils.c b/tools/verification/rv/src/utils.c
new file mode 100644
index 000000000000..59ffc05cd225
--- /dev/null
+++ b/tools/verification/rv/src/utils.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * util functions.
+ *
+ * Copyright (C) 2022 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+#include <stdarg.h>
+#include <stdio.h>
+
+#include <utils.h>
+
+#define MAX_MSG_LENGTH	1024
+int config_debug;
+
+/*
+ * err_msg - print an error message to the stderr
+ */
+void err_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
+
+/*
+ * debug_msg - print a debug message to stderr if debug is set
+ */
+void debug_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	if (!config_debug)
+		return;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
-- 
2.37.3

