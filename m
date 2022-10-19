Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC26053EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJSXaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJSXaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:30:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E47EED999;
        Wed, 19 Oct 2022 16:30:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f22so12742310qto.3;
        Wed, 19 Oct 2022 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sak4Oh1e1cJ8dlXbPzHdj2O5uLPCajM1vqzBSBpbv/s=;
        b=jDjeu0LskJRKP6+vRG3eFZCivE8qj0NpY4siuTODNIATXoMTs9D2f9N7kjkrx6JfeL
         TFNR3FHBBZja7lYHUjh63766dbAaO/sM1hq83O3kee4OX8udW38y6Untf9kRyIiknnBa
         pF5atUTJBEVwTP+Ge15KwWqUGKs327ncVsogzvHEmN70LOi76XiAS36dqlHiXIXSYtHI
         YiJb5UYWJ76yqwZcLHmP61vGAOBuM0nGZBzIyIHzbO8/ZB8HetNRlIwq8+lrvLeHkkjr
         wVn7R9ZsPt9Gg67mYLaTbUWq1Ii46yT4gcd2QeLMxNz542umThkk5hXTJ3z7MYI8maQ8
         XC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sak4Oh1e1cJ8dlXbPzHdj2O5uLPCajM1vqzBSBpbv/s=;
        b=Nxh4moRvos4e3BYqFzm+zGxUsFcJAAhqtUKFj6831coKWtQI5bllYT0QdIGxEKTC57
         1Yr+E4xZF06p3PLGDvWIgIpvx6hCtLnCqy05bSQtuXm3weoMMj3lpeN1U4t99Stz5BqG
         kjPrHAZQHByczq/2hx3E3rQ38LEv7WBTTVA6gejM5nXSMQmJaw4Etdc61uc153u9xbUT
         +FS+lIJ0xooUCjRJl7TAwgMnWSxeE+/ZRomBg5ahOUmKkwVkQh87LNuRvzErz88aL6U2
         wxlso/wiJnxKhHghO5BvbFKC5j5oy5m2vyoBImyWHvn+Tw1M3W6ViWquRJDorlo7WhCf
         xctA==
X-Gm-Message-State: ACrzQf3l6s635kDx6dPCn5XTIFzLrtSaPLUvY2TL8QRQFzali28l7t9d
        ucLovjpsprasVwVZTJOAdeGfZH3qU3s=
X-Google-Smtp-Source: AMsMyM7a+BFIl8Ula//Cpgno2kvMAbZagGqrtNbIlfB7zeJoi/KLUUX8EklAW3xnTdALgVnaI8A/pA==
X-Received: by 2002:a05:622a:1801:b0:39c:e5bf:8132 with SMTP id t1-20020a05622a180100b0039ce5bf8132mr8947606qtc.236.1666222205861;
        Wed, 19 Oct 2022 16:30:05 -0700 (PDT)
Received: from localhost ([162.208.5.36])
        by smtp.gmail.com with ESMTPSA id i3-20020a05622a08c300b0039cc665d60fsm4905676qte.64.2022.10.19.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 16:30:04 -0700 (PDT)
From:   Matt Turner <mattst88@gmail.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jelle van der Waa <jvanderwaa@redhat.com>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2] tools: port perf ui from GTK 2 to GTK 3
Date:   Wed, 19 Oct 2022 19:29:52 -0400
Message-Id: <20221019232952.2212729-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220415050003.3257645-1-mattst88@gmail.com>
References: <20220415050003.3257645-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jelle van der Waa <jvanderwaa@redhat.com>

GTK 2 is a legacy API and the newer version is GTK 3 which changes a few
API functions. gtk_tree_view_set_rules_hint is no longer required since
theme's are now responsible to handle this, gtk_vbox_new is deprecated
and replaced by passing the orientation to gtk_box_new. Apart from these
changes the accessing of the screen changed in GTK which requires using
new functions for getting geometry. Lastly the GTK_STOCK_OK define is
deprecated in GTK 3.

Signed-off-by: Jelle van der Waa <jvanderwaa@redhat.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Originally sent in 2019. I've rebased it and given it a test.

One problem I've noticed is that C++ symbol names are often broken.
E.g.:

(perf:3254940): Gtk-WARNING **: 21:47:46.663: Failed to set text from
markup due to error parsing markup: Error on line 1 char 95:
“std::char_traits<char” is not a valid name: “<”

Presumably we need to call g_markup_escape_text() somewhere, but I
struggled to find the right place.

Without the patch, the GTK-2 version repeatedly segfaults, so this is an
improvement regardless.

v2: Dropped changes to test-all.c. I don't know how to build that
    apparently.

 tools/build/Makefile.feature                  |  5 +++--
 tools/build/feature/Makefile                  | 12 +++++-----
 ...est-gtk2-infobar.c => test-gtk3-infobar.c} |  0
 .../feature/{test-gtk2.c => test-gtk3.c}      |  0
 tools/perf/Documentation/perf-report.txt      |  2 +-
 tools/perf/Makefile                           |  2 +-
 tools/perf/Makefile.config                    | 22 +++++++++----------
 tools/perf/Makefile.perf                      |  6 ++---
 tools/perf/builtin-report.c                   |  2 +-
 tools/perf/builtin-version.c                  |  1 +
 tools/perf/tests/make                         | 12 +++++-----
 tools/perf/ui/gtk/annotate.c                  |  2 +-
 tools/perf/ui/gtk/browser.c                   | 16 ++++++++------
 tools/perf/ui/gtk/hists.c                     |  6 +----
 tools/perf/ui/gtk/progress.c                  |  2 +-
 tools/perf/ui/setup.c                         |  2 +-
 16 files changed, 46 insertions(+), 46 deletions(-)
 rename tools/build/feature/{test-gtk2-infobar.c => test-gtk3-infobar.c} (100%)
 rename tools/build/feature/{test-gtk2.c => test-gtk3.c} (100%)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 57619f240b56..967b8be96b65 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -80,8 +80,8 @@ FEATURE_TESTS_EXTRA :=                  \
          compile-32                     \
          compile-x32                    \
          cplus-demangle                 \
-         gtk2                           \
-         gtk2-infobar                   \
+         gtk3                           \
+         gtk3-infobar                   \
          hello                          \
          libbabeltrace                  \
          libbfd-liberty                 \
@@ -119,6 +119,7 @@ FEATURE_DISPLAY ?=              \
          dwarf                  \
          dwarf_getlocations     \
          glibc                  \
+         gtk3                   \
          libbfd                 \
          libbfd-buildid		\
          libcap                 \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 04b07ff88234..bd96b0628836 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -11,8 +11,8 @@ FILES=                                          \
          test-fortify-source.bin                \
          test-get_current_dir_name.bin          \
          test-glibc.bin                         \
-         test-gtk2.bin                          \
-         test-gtk2-infobar.bin                  \
+         test-gtk3.bin                          \
+         test-gtk3-infobar.bin                  \
          test-hello.bin                         \
          test-libaudit.bin                      \
          test-libbfd.bin                        \
@@ -214,11 +214,11 @@ $(OUTPUT)test-libtracefs.bin:
 $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
-$(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
+$(OUTPUT)test-gtk3.bin:
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-3.0 2>/dev/null)
 
-$(OUTPUT)test-gtk2-infobar.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+$(OUTPUT)test-gtk3-infobar.bin:
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-3.0 2>/dev/null)
 
 grep-libs  = $(filter -l%,$(1))
 strip-libs = $(filter-out -l%,$(1))
diff --git a/tools/build/feature/test-gtk2-infobar.c b/tools/build/feature/test-gtk3-infobar.c
similarity index 100%
rename from tools/build/feature/test-gtk2-infobar.c
rename to tools/build/feature/test-gtk3-infobar.c
diff --git a/tools/build/feature/test-gtk2.c b/tools/build/feature/test-gtk3.c
similarity index 100%
rename from tools/build/feature/test-gtk2.c
rename to tools/build/feature/test-gtk3.c
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 4533db2ee56b..2df20623943f 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -315,7 +315,7 @@ OPTIONS
 	requires a tty, if one is not present, as when piping to other
 	commands, the stdio interface is used.
 
---gtk:: Use the GTK2 interface.
+--gtk:: Use the GTK3 interface.
 
 -k::
 --vmlinux=<file>::
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index f3fe360a35c6..ea3fb4657a91 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -100,7 +100,7 @@ clean:
 # make -C tools/perf -f tests/make
 #
 build-test:
-	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg make_static make_with_gtk2 out
+	@$(MAKE) SHUF=1 -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory tarpkg make_static make_with_gtk3 out
 
 build-test-tarball:
 	@$(MAKE) -f tests/make REUSE_FEATURES_DUMP=1 MK=Makefile SET_PARALLEL=1 --no-print-directory out
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6fd4b1384b97..281fbcb97b58 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -808,20 +808,20 @@ ifndef NO_SLANG
   endif
 endif
 
-ifdef GTK2
-  FLAGS_GTK2=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
-  $(call feature_check,gtk2)
-  ifneq ($(feature-gtk2), 1)
-    msg := $(warning GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev);
-    NO_GTK2 := 1
+ifdef GTK3
+  FLAGS_GTK3=$(CFLAGS) $(LDFLAGS) $(EXTLIBS) $(shell $(PKG_CONFIG) --libs --cflags gtk+-3.0 2>/dev/null)
+  $(call feature_check,gtk3)
+  ifneq ($(feature-gtk3), 1)
+    msg := $(warning GTK3 not found, disables GTK3 support. Please install gtk3-devel or libgtk3.0-dev);
+    NO_GTK3 := 1
   else
-    $(call feature_check,gtk2-infobar)
-    ifeq ($(feature-gtk2-infobar), 1)
+    $(call feature_check,gtk3-infobar)
+    ifeq ($(feature-gtk3-infobar), 1)
       GTK_CFLAGS := -DHAVE_GTK_INFO_BAR_SUPPORT
     endif
-    CFLAGS += -DHAVE_GTK2_SUPPORT
-    GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk+-2.0 2>/dev/null)
-    GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0 2>/dev/null)
+    CFLAGS += -DHAVE_GTK3_SUPPORT
+    GTK_CFLAGS += $(shell $(PKG_CONFIG) --cflags gtk+-3.0 2>/dev/null)
+    GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-3.0 2>/dev/null)
     EXTLIBS += -ldl
   endif
 endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a432e59afc42..056f29ecaef1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -48,7 +48,7 @@ include ../scripts/utilities.mak
 #
 # Define NO_SLANG if you do not want TUI support.
 #
-# Define GTK2 if you want GTK+ GUI support.
+# Define GTK3 if you want GTK+ GUI support.
 #
 # Define NO_DEMANGLE if you do not want C++ symbol demangling.
 #
@@ -403,7 +403,7 @@ ifneq ($(OUTPUT),)
   CFLAGS += -I$(OUTPUT)
 endif
 
-ifdef GTK2
+ifdef GTK3
   ALL_PROGRAMS += $(OUTPUT)libperf-gtk.so
   GTK_IN := $(OUTPUT)gtk-in.o
 endif
@@ -928,7 +928,7 @@ check: $(OUTPUT)common-cmds.h
 
 ### Installation rules
 
-ifdef GTK2
+ifdef GTK3
 install-gtk: $(OUTPUT)libperf-gtk.so
 	$(call QUIET_INSTALL, 'GTK UI') \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8361890176c2..4e0caf3d3061 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1247,7 +1247,7 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
 #endif
 #ifdef HAVE_GTK2_SUPPORT
-	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
+	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK3 interface"),
 #endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index a71f491224da..a35e06ca449d 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -60,6 +60,7 @@ static void library_status(void)
 	STATUS(HAVE_DWARF_SUPPORT, dwarf);
 	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
 	STATUS(HAVE_GLIBC_SUPPORT, glibc);
+	STATUS(HAVE_GTK3_SUPPORT, gtk3);
 #ifndef HAVE_SYSCALL_TABLE_SUPPORT
 	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
 #endif
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index da013e90a945..cb959dccbe9d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -72,8 +72,8 @@ make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
 make_no_newt        := NO_NEWT=1
 make_no_slang       := NO_SLANG=1
-make_no_gtk2        := NO_GTK2=1
-make_no_ui          := NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
+make_no_gtk3        := NO_GTK3=1
+make_no_ui          := NO_NEWT=1 NO_SLANG=1 NO_GTK3=1
 make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
 make_no_libunwind   := NO_LIBUNWIND=1
@@ -93,7 +93,7 @@ make_no_sdt	    := NO_SDT=1
 make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_with_clangllvm := LIBCLANGLLVM=1
 make_with_libpfm4   := LIBPFM4=1
-make_with_gtk2      := GTK2=1
+make_with_gtk3      := GTK3=1
 make_tags           := tags
 make_cscope         := cscope
 make_help           := help
@@ -113,7 +113,7 @@ make_install_prefix_slash := install prefix=/tmp/krava/
 make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
 
 # all the NO_* variable combined
-make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
+make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK3=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
@@ -138,7 +138,7 @@ run += make_no_libpython
 run += make_no_scripts
 run += make_no_newt
 run += make_no_slang
-run += make_no_gtk2
+run += make_no_gtk3
 run += make_no_ui
 run += make_no_demangle
 run += make_no_libelf
@@ -312,7 +312,7 @@ $(run):
 	$(call test,$@) && \
 	rm -rf $@ $$TMP_DEST || (cat $@ ; false)
 
-make_with_gtk2:
+make_with_gtk3:
 	$(call clean)
 	@TMP_DEST=$$(mktemp -d); \
 	cmd="cd $(PERF) && $(MAKE_F) $($@) $(PARALLEL_OPT) $(O_OPT) DESTDIR=$$TMP_DEST"; \
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 0a50e962f9a3..efd380f124aa 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -208,7 +208,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 		if (!pgctx)
 			return -1;
 
-		vbox = gtk_vbox_new(FALSE, 0);
+		vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
 		notebook = gtk_notebook_new();
 		pgctx->notebook = notebook;
 
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 8f3e43d148a8..6fd85b5325ba 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -13,19 +13,21 @@ void perf_gtk__signal(int sig)
 	psignal(sig, "perf");
 }
 
-void perf_gtk__resize_window(GtkWidget *window)
+void perf_gtk__resize_window(GtkWidget *widget)
 {
 	GdkRectangle rect;
-	GdkScreen *screen;
-	int monitor;
+	GdkMonitor *monitor;
+	GdkDisplay *display;
+	GdkWindow *window;
 	int height;
 	int width;
 
-	screen = gtk_widget_get_screen(window);
+	display = gdk_display_get_default();
+	window = gtk_widget_get_window(widget);
 
-	monitor = gdk_screen_get_monitor_at_window(screen, window->window);
+	monitor = gdk_display_get_monitor_at_window(display, window);
 
-	gdk_screen_get_monitor_geometry(screen, monitor, &rect);
+	gdk_monitor_get_geometry(monitor, &rect);
 
 	width	= rect.width * 3 / 4;
 	height	= rect.height * 3 / 4;
@@ -58,7 +60,7 @@ GtkWidget *perf_gtk__setup_info_bar(void)
 	content_area = gtk_info_bar_get_content_area(GTK_INFO_BAR(info_bar));
 	gtk_container_add(GTK_CONTAINER(content_area), label);
 
-	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), GTK_STOCK_OK,
+	gtk_info_bar_add_button(GTK_INFO_BAR(info_bar), "_OK",
 				GTK_RESPONSE_OK);
 	g_signal_connect(info_bar, "response",
 			 G_CALLBACK(gtk_widget_hide), NULL);
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index c83be2d57f7e..5aa2655c7a0a 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -395,8 +395,6 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 		}
 	}
 
-	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
-
 	g_signal_connect(view, "row-activated",
 			 G_CALLBACK(on_row_activated), NULL);
 	gtk_container_add(GTK_CONTAINER(window), view);
@@ -583,8 +581,6 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	perf_gtk__add_hierarchy_entries(hists, &hists->entries, store,
 					NULL, &hpp, min_pcnt);
 
-	gtk_tree_view_set_rules_hint(GTK_TREE_VIEW(view), TRUE);
-
 	g_signal_connect(view, "row-activated",
 			 G_CALLBACK(on_row_activated), NULL);
 	gtk_container_add(GTK_CONTAINER(window), view);
@@ -616,7 +612,7 @@ int evlist__gtk_browse_hists(struct evlist *evlist, const char *help,
 	if (!pgctx)
 		return -1;
 
-	vbox = gtk_vbox_new(FALSE, 0);
+	vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
 
 	notebook = gtk_notebook_new();
 
diff --git a/tools/perf/ui/gtk/progress.c b/tools/perf/ui/gtk/progress.c
index eea6fcde518a..aaa7e7f6e4aa 100644
--- a/tools/perf/ui/gtk/progress.c
+++ b/tools/perf/ui/gtk/progress.c
@@ -13,7 +13,7 @@ static void gtk_ui_progress__update(struct ui_progress *p)
 	char buf[1024];
 
 	if (dialog == NULL) {
-		GtkWidget *vbox = gtk_vbox_new(TRUE, 5);
+		GtkWidget *vbox = gtk_box_new(GTK_ORIENTATION_VERTICAL, 5);
 		GtkWidget *label = gtk_label_new(p->title);
 
 		dialog = gtk_window_new(GTK_WINDOW_TOPLEVEL);
diff --git a/tools/perf/ui/setup.c b/tools/perf/ui/setup.c
index 25ded88801a3..cbcadf4cb288 100644
--- a/tools/perf/ui/setup.c
+++ b/tools/perf/ui/setup.c
@@ -13,7 +13,7 @@ int use_browser = -1;
 
 #define PERF_GTK_DSO "libperf-gtk.so"
 
-#ifdef HAVE_GTK2_SUPPORT
+#ifdef HAVE_GTK3_SUPPORT
 
 static int setup_gtk_browser(void)
 {
-- 
2.37.3

