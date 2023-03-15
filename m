Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2BE6BAB01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjCOIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjCOIoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:44:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1394DE05;
        Wed, 15 Mar 2023 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678869840; x=1710405840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=66xccffM/kZKuCbqonsDdAazYocnMqO4s6g9qZJuaDA=;
  b=Bd0eAMNmZpkXjdfqpwnvMxgDBI7vEz/poSp8+q4V4yjHHz+MiENGtwT7
   p2vpVuLv1IOmSFsReM7Nhnru51GuSsWgygyuUp356DqtZJqE2eHx6AM08
   DX/Z2wYKM2eoRr1uI/HtnslNPnRsZOj1RHI8/8uBHuztxV6w6UBv1L4DC
   UT2LUYkL5noxWugME0hap99Bucbt6SBJspYLFyckNtMWWYosv0Fl1SXg0
   efiTkx7BLHei+IU2iv3Ouey5DpvhQaCG2ekBXQWtM6z7sYxLawKZ7OUfy
   659w7Sq7uDY5U9HhMvECO2vJ0VfNbzKle8mkAcnhEMSDq016Vrkr3EEax
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="318042155"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="318042155"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 01:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="803185989"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="803185989"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.220.200])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 01:43:56 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf script: Fix Python support when no libtraceevent
Date:   Wed, 15 Mar 2023 10:43:21 +0200
Message-Id: <20230315084321.14563-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Python scripting can be used without libtraceevent. In particular,
scripting for Intel PT does not use tracepoints, and so does not need
libtraceevent support.

Alter the build and employ conditional compilation to allow Python
scripting without libtraceevent.

Example:

 Before:

    $ ldd `which perf` | grep -i python
    $ ldd `which perf` | grep -i libtraceevent
    $ perf record -e intel_pt//u uname
    Linux
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.031 MB perf.data ]
    $ perf script intel-pt-events.py |& head -3
      Error: Couldn't find script `intel-pt-events.py'

     See perf script -l for available scripts.

 After:

    $ ldd `which perf` | grep -i python
            libpython3.10.so.1.0 => /lib/x86_64-linux-gnu/libpython3.10.so.1.0 (0x00007f4bac400000)
    $ ldd `which perf` | grep -i libtraceevent
    $ perf script intel-pt-events.py | head
    Intel PT Branch Trace, Power Events, Event Trace and PTWRITE
         Switch In    8021/8021  [000]     11234.097713404     0/0
           perf-exec  8021/8021  [000]     11234.098041726       psb                        offset: 0x0                0 [unknown] ([unknown])
           perf-exec  8021/8021  [000]     11234.098041726       cbr                         45  freq: 4505 MHz  (161%)                0 [unknown] ([unknown])
               uname  8021/8021  [000]     11234.098082170  branches:uH  tr strt                              0 [unknown] ([unknown]) => 7f3a8b9422b0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
               uname  8021/8021  [000]     11234.098082379  branches:uH  tr end                    7f3a8b9422b0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2) => 0 [unknown] ([unknown])
               uname  8021/8021  [000]     11234.098083629  branches:uH  tr strt                              0 [unknown] ([unknown]) => 7f3a8b9422b0 _start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
               uname  8021/8021  [000]     11234.098083629  branches:uH  call                      7f3a8b9422b3 _start+0x3 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2) => 7f3a8b943050 _dl_start+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
               uname  8021/8021  [000]     11234.098083837  branches:uH  tr end                    7f3a8b943060 _dl_start+0x10 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2) => 0 [unknown] ([unknown])  IPC: 0.01 (9/938)
               uname  8021/8021  [000]     11234.098084670  branches:uH  tr strt                              0 [unknown] ([unknown]) => 7f3a8b943060 _dl_start+0x10 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

Fixes: 378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Build                              |  2 +-
 tools/perf/builtin-script.c                   |  2 +-
 tools/perf/scripts/Build                      |  4 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |  2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  4 +
 tools/perf/util/Build                         |  2 +-
 tools/perf/util/scripting-engines/Build       |  2 +-
 .../scripting-engines/trace-event-python.c    | 75 +++++++++++++------
 tools/perf/util/trace-event-scripting.c       |  9 ++-
 9 files changed, 72 insertions(+), 30 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 6dd67e502295..aa7623622834 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -56,6 +56,6 @@ CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 perf-y += util/
 perf-y += arch/
 perf-y += ui/
-perf-$(CONFIG_LIBTRACEEVENT) += scripts/
+perf-y += scripts/
 
 gtk-y += ui/gtk/
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 522226114263..976f8bfe099c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2313,8 +2313,8 @@ static void setup_scripting(void)
 {
 #ifdef HAVE_LIBTRACEEVENT
 	setup_perl_scripting();
-	setup_python_scripting();
 #endif
+	setup_python_scripting();
 }
 
 static int flush_scripting(void)
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 68d4b54574ad..7d8e2e57faac 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,2 +1,4 @@
-perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+ifeq ($(CONFIG_LIBTRACEEVENT),y)
+  perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+endif
 perf-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
index d5fed4e42617..7d0e33ce6aba 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
@@ -1,3 +1,3 @@
-perf-$(CONFIG_LIBTRACEEVENT) += Context.o
+perf-y += Context.o
 
 CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Context.c b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
index 895f5fc23965..b0d449f41650 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Context.c
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Context.c
@@ -59,6 +59,7 @@ static struct scripting_context *get_scripting_context(PyObject *args)
 	return get_args(args, "context", NULL);
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static PyObject *perf_trace_context_common_pc(PyObject *obj, PyObject *args)
 {
 	struct scripting_context *c = get_scripting_context(args);
@@ -90,6 +91,7 @@ static PyObject *perf_trace_context_common_lock_depth(PyObject *obj,
 
 	return Py_BuildValue("i", common_lock_depth(c));
 }
+#endif
 
 static PyObject *perf_sample_insn(PyObject *obj, PyObject *args)
 {
@@ -178,12 +180,14 @@ static PyObject *perf_sample_srccode(PyObject *obj, PyObject *args)
 }
 
 static PyMethodDef ContextMethods[] = {
+#ifdef HAVE_LIBTRACEEVENT
 	{ "common_pc", perf_trace_context_common_pc, METH_VARARGS,
 	  "Get the common preempt count event field value."},
 	{ "common_flags", perf_trace_context_common_flags, METH_VARARGS,
 	  "Get the common flags event field value."},
 	{ "common_lock_depth", perf_trace_context_common_lock_depth,
 	  METH_VARARGS,	"Get the common lock depth event field value."},
+#endif
 	{ "perf_sample_insn", perf_sample_insn,
 	  METH_VARARGS,	"Get the machine code instruction."},
 	{ "perf_set_itrace_options", perf_set_itrace_options,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 918b501f9bd8..4868e3bf7df9 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -78,7 +78,7 @@ perf-y += pmu-bison.o
 perf-y += pmu-hybrid.o
 perf-y += svghelper.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event-scripting.o
+perf-y += trace-event-scripting.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
 perf-$(CONFIG_LIBTRACEEVENT) += trace-event-read.o
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index 2c96aa3cc1ec..c220fec97032 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,7 +1,7 @@
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
   perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
-  perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 endif
+perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
 CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 2c2697c5d025..0f4ef61f2ffa 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -30,7 +30,9 @@
 #include <linux/bitmap.h>
 #include <linux/compiler.h>
 #include <linux/time64.h>
+#ifdef HAVE_LIBTRACEEVENT
 #include <traceevent/event-parse.h>
+#endif
 
 #include "../build-id.h"
 #include "../counts.h"
@@ -87,18 +89,21 @@ PyMODINIT_FUNC initperf_trace_context(void);
 PyMODINIT_FUNC PyInit_perf_trace_context(void);
 #endif
 
+#ifdef HAVE_LIBTRACEEVENT
 #define TRACE_EVENT_TYPE_MAX				\
 	((1 << (sizeof(unsigned short) * 8)) - 1)
 
 static DECLARE_BITMAP(events_defined, TRACE_EVENT_TYPE_MAX);
 
-#define MAX_FIELDS	64
 #define N_COMMON_FIELDS	7
 
-extern struct scripting_context *scripting_context;
-
 static char *cur_field_name;
 static int zero_flag_atom;
+#endif
+
+#define MAX_FIELDS	64
+
+extern struct scripting_context *scripting_context;
 
 static PyObject *main_module, *main_dict;
 
@@ -153,6 +158,26 @@ static PyObject *get_handler(const char *handler_name)
 	return handler;
 }
 
+static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
+{
+	PyObject *retval;
+
+	retval = PyObject_CallObject(handler, args);
+	if (retval == NULL)
+		handler_call_die(die_msg);
+	Py_DECREF(retval);
+}
+
+static void try_call_object(const char *handler_name, PyObject *args)
+{
+	PyObject *handler;
+
+	handler = get_handler(handler_name);
+	if (handler)
+		call_object(handler, args, handler_name);
+}
+
+#ifdef HAVE_LIBTRACEEVENT
 static int get_argument_count(PyObject *handler)
 {
 	int arg_count = 0;
@@ -181,25 +206,6 @@ static int get_argument_count(PyObject *handler)
 	return arg_count;
 }
 
-static void call_object(PyObject *handler, PyObject *args, const char *die_msg)
-{
-	PyObject *retval;
-
-	retval = PyObject_CallObject(handler, args);
-	if (retval == NULL)
-		handler_call_die(die_msg);
-	Py_DECREF(retval);
-}
-
-static void try_call_object(const char *handler_name, PyObject *args)
-{
-	PyObject *handler;
-
-	handler = get_handler(handler_name);
-	if (handler)
-		call_object(handler, args, handler_name);
-}
-
 static void define_value(enum tep_print_arg_type field_type,
 			 const char *ev_name,
 			 const char *field_name,
@@ -379,6 +385,7 @@ static PyObject *get_field_numeric_entry(struct tep_event *event,
 		obj = list;
 	return obj;
 }
+#endif
 
 static const char *get_dsoname(struct map *map)
 {
@@ -906,6 +913,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	return dict;
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static void python_process_tracepoint(struct perf_sample *sample,
 				      struct evsel *evsel,
 				      struct addr_location *al,
@@ -1035,6 +1043,16 @@ static void python_process_tracepoint(struct perf_sample *sample,
 
 	Py_DECREF(t);
 }
+#else
+static void python_process_tracepoint(struct perf_sample *sample __maybe_unused,
+				      struct evsel *evsel __maybe_unused,
+				      struct addr_location *al __maybe_unused,
+				      struct addr_location *addr_al __maybe_unused)
+{
+	fprintf(stderr, "Tracepoint events are not supported because "
+			"perf is not linked with libtraceevent.\n");
+}
+#endif
 
 static PyObject *tuple_new(unsigned int sz)
 {
@@ -1965,6 +1983,7 @@ static int python_stop_script(void)
 	return 0;
 }
 
+#ifdef HAVE_LIBTRACEEVENT
 static int python_generate_script(struct tep_handle *pevent, const char *outfile)
 {
 	int i, not_first, count, nr_events;
@@ -2155,6 +2174,18 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
 
 	return 0;
 }
+#else
+static int python_generate_script(struct tep_handle *pevent __maybe_unused,
+				  const char *outfile __maybe_unused)
+{
+	fprintf(stderr, "Generating Python perf-script is not supported."
+		"  Install libtraceevent and rebuild perf to enable it.\n"
+		"For example:\n  # apt install libtraceevent-dev (ubuntu)"
+		"\n  # yum install libtraceevent-devel (Fedora)"
+		"\n  etc.\n");
+	return -1;
+}
+#endif
 
 struct scripting_ops python_scripting_ops = {
 	.name			= "Python",
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 56175c53f9af..bd0000300c77 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -9,7 +9,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#ifdef HAVE_LIBTRACEEVENT
 #include <traceevent/event-parse.h>
+#endif
 
 #include "debug.h"
 #include "trace-event.h"
@@ -27,10 +29,11 @@ void scripting_context__update(struct scripting_context *c,
 			       struct addr_location *addr_al)
 {
 	c->event_data = sample->raw_data;
+	c->pevent = NULL;
+#ifdef HAVE_LIBTRACEEVENT
 	if (evsel->tp_format)
 		c->pevent = evsel->tp_format->tep;
-	else
-		c->pevent = NULL;
+#endif
 	c->event = event;
 	c->sample = sample;
 	c->evsel = evsel;
@@ -122,6 +125,7 @@ void setup_python_scripting(void)
 }
 #endif
 
+#ifdef HAVE_LIBTRACEEVENT
 static void print_perl_unsupported_msg(void)
 {
 	fprintf(stderr, "Perl scripting not supported."
@@ -186,3 +190,4 @@ void setup_perl_scripting(void)
 	register_perl_scripting(&perl_scripting_ops);
 }
 #endif
+#endif
-- 
2.34.1

