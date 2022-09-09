Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E5F5B3BE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiIIPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIIPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:30:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EBDF58DF8;
        Fri,  9 Sep 2022 08:30:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26601688;
        Fri,  9 Sep 2022 08:28:35 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.17.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E8E63F73D;
        Fri,  9 Sep 2022 08:28:27 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v9 02/13] perf test: Add build infra for perf test tools for CoreSight tests
Date:   Fri,  9 Sep 2022 16:27:52 +0100
Message-Id: <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

This adds the initial build infrastructure (makefiles maintainers
information) for adding follow-on tests for CoreSight.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 MAINTAINERS                                   |  1 +
 tools/perf/Makefile.config                    |  2 ++
 tools/perf/Makefile.perf                      | 15 +++++++++--
 tools/perf/tests/shell/coresight/Makefile     | 25 +++++++++++++++++++
 .../tests/shell/coresight/Makefile.miniconfig | 14 +++++++++++
 5 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/tests/shell/coresight/Makefile
 create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d7f64dc0efe..c8ae5a6638b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2029,6 +2029,7 @@ F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
 F:	include/linux/coresight*
 F:	samples/coresight/*
+F:	tools/perf/tests/shell/coresight/*
 F:	tools/perf/arch/arm/util/auxtrace.c
 F:	tools/perf/arch/arm/util/cs-etm.c
 F:	tools/perf/arch/arm/util/cs-etm.h
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0661a1cf9855..e3e28b3481f9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1291,6 +1291,8 @@ perf_examples_instdir_SQ = $(subst ','\'',$(perf_examples_instdir))
 STRACE_GROUPS_INSTDIR_SQ = $(subst ','\'',$(STRACE_GROUPS_INSTDIR))
 tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
 
+export perfexec_instdir_SQ
+
 # If we install to $(HOME) we keep the traceevent default:
 # $(HOME)/.traceevent/plugins
 # Otherwise we install plugins into the global $(libdir).
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e5921b347153..cef2a06c8f54 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -629,7 +629,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
 $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
 	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
 
-all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
+TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
+
+tests-coresight-targets: FORCE
+	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
+
+tests-coresight-targets-clean:
+	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
+
+all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
 
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
@@ -1007,6 +1015,9 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
+		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
+	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
 install-bin: install-tools install-tests install-traceevent-plugins
 
@@ -1077,7 +1088,7 @@ endif # BUILD_BPF_SKEL
 bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
new file mode 100644
index 000000000000..3fee05cfcb0e
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+include ../../../../../tools/scripts/Makefile.include
+include ../../../../../tools/scripts/Makefile.arch
+include ../../../../../tools/scripts/utilities.mak
+
+SUBDIRS =
+
+all: $(SUBDIRS)
+$(SUBDIRS):
+	$(Q)$(MAKE) -C $@
+
+INSTALLDIRS = $(SUBDIRS:%=install-%)
+
+install-tests: $(INSTALLDIRS)
+$(INSTALLDIRS):
+	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
+
+CLEANDIRS = $(SUBDIRS:%=clean-%)
+
+clean: $(CLEANDIRS)
+$(CLEANDIRS):
+	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
+
+.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
new file mode 100644
index 000000000000..5f72a9cb43f3
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+ifndef DESTDIR
+prefix ?= $(HOME)
+endif
+
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+INSTALL = install
+INSTDIR_SUB = tests/shell/coresight
+
+include ../../../../../scripts/Makefile.include
+include ../../../../../scripts/Makefile.arch
+include ../../../../../scripts/utilities.mak
-- 
2.32.0

