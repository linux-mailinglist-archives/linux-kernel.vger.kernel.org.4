Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC1662E23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAISIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjAISIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:08:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509BC43D89;
        Mon,  9 Jan 2023 10:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC02D61248;
        Mon,  9 Jan 2023 18:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73EDC433EF;
        Mon,  9 Jan 2023 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673287633;
        bh=ZWdxpeiZHLTpLcVujmkkgIPXWQwv7zdlyirYfgXnknU=;
        h=Date:From:To:Cc:Subject:From;
        b=UZ2t+25RuXg7tpdjJxEWIZVod9m8JKmzYtK1znW3OX0lEkT2EA1z7EEpoPzzCetb6
         XqVRPvcEermbKfgpS3cq0u2Cn1ws3F+iqsy2FCCnqc23dkYG+gTdgrH+IH9Ncov28Z
         SO0zN4FseYSfuX70IwTUspYMjzVMbMeUrKfBTv68a3yDQ+/Hgtf69S1crq3RhOE6mW
         7TS4AM/dIPuFoEtMf8SW8P0DH1ykvnGx3Yzvn2jAvdg8tgaWStzX3G4kDvzjWLuHmQ
         bFHRtokcNXl98HrB5GJpt1+fY3wvM0S1XvgcR/uy/8tMwAMJbZ7xuJdaHUK56VlmsY
         t9Fbp1G9tDVvw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1599440468; Mon,  9 Jan 2023 15:07:11 -0300 (-03)
Date:   Mon, 9 Jan 2023 15:07:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf tools: Don't install libtraceevent plugins as its
 not anymore in the kernel sources
Message-ID: <Y7xXz+TSpiCbQGjw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing 'make -C tools/perf build-test' one can notice error
messages while trying to install libtraceevent plugins, stop doing that
as libtraceevent isn't anymore a homie.

These are the warnings dealt with:

   make_install_prefix_slash_O: make install prefix=/tmp/krava/
    failed to find: /tmp/krava/etc/bash_completion.d/perf
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_cfg80211.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_scsi.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_xen.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_function.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_sched_switch.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_mac80211.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kvm.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_kmem.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_hrtimer.so
    failed to find: /tmp/krava/lib64/traceevent/plugins/plugin_jbd2.so

Fixes: 4171925aa9f3f7bf ("tools lib traceevent: Remove libtraceevent")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config |  8 --------
 tools/perf/tests/make      | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c2504c39bdcb8992..156440ea019143f8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1314,14 +1314,6 @@ tip_instdir_SQ = $(subst ','\'',$(tip_instdir))
 
 export perfexec_instdir_SQ
 
-# If we install to $(HOME) we keep the traceevent default:
-# $(HOME)/.traceevent/plugins
-# Otherwise we install plugins into the global $(libdir).
-ifdef DESTDIR
-plugindir=$(libdir)/traceevent/plugins
-plugindir_SQ= $(subst ','\'',$(plugindir))
-endif
-
 print_var = $(eval $(print_var_code)) $(info $(MSG))
 define print_var_code
     MSG = $(shell printf '...%40s: %s' $(1) $($(1)))
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 05e818a8bbad11a4..009d6efb673ce828 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -222,19 +222,7 @@ installed_files_bin := bin/perf
 installed_files_bin += etc/bash_completion.d/perf
 installed_files_bin += libexec/perf-core/perf-archive
 
-installed_files_plugins := $(lib)/traceevent/plugins/plugin_cfg80211.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_scsi.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_xen.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_function.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_sched_switch.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_mac80211.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_kvm.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_kmem.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_hrtimer.so
-installed_files_plugins += $(lib)/traceevent/plugins/plugin_jbd2.so
-
 installed_files_all := $(installed_files_bin)
-installed_files_all += $(installed_files_plugins)
 
 test_make_install       := $(call test_dest_files,$(installed_files_all))
 test_make_install_O     := $(call test_dest_files,$(installed_files_all))
-- 
2.39.0

