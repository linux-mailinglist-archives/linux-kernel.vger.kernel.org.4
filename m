Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7563C86A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiK2Taq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiK2TaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:30:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283825D2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:29:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n16-20020a25da10000000b006f2b5bc99f9so12186325ybf.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0IUlOBzNYwGwCi/kB8Fps4nNnJDZbsGKlmWKEqCDmL4=;
        b=XvfjvKZWRz3BpkA0IL/xKRzPSSQ0ZNVzAKAZwUyMZTFds48yAOihgfktestrOPCJIG
         5g3Z2g9OzLAOUqkmej5idDjZa8WFQJ2XzhSqKsbP63Bm3EGjgX+nGmuiB0BN0q4JyPFp
         51035iIhlvXvBLbMP+V9tvW2cOexrSnsm+Ogh78MtAezWX5UBLaU+HDC/uHDFXFRARqE
         6mFhSwMQcDTHCXaz7fzxV6O1YE4TDyZYpfuYDYJcqegrb3GZVxK5ESl6DAlQ5j6f7CE4
         WdsB7MIoGBsYPG+kLF3nd7hGmS9QD2GMbeXI8LgSr80S+HBLyum+k0sT1QCAXyAGX8IA
         BhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IUlOBzNYwGwCi/kB8Fps4nNnJDZbsGKlmWKEqCDmL4=;
        b=FzNMrCpByTEI2KCluntTwWrI0rmya63SYTQamhzwajI8kWwcMqrBssAJrkgzY97qS+
         9wiu5njKewyu49ICFQ2VxkG0I/Ye3wWm+fBsMXEkgnaNpd5Hc5VfNxfU49hbnuY8I3vn
         g/UYeQl97cVbcsltnqwQVjHzUmFwEOVXFiiD5bLh7D/VhIiyWQvP1RFRRy8P0q5D7SVN
         OXmJQoU66RGeeXhhr5NF+therCUYEB/sfZ7eqMC1j4EwccNjQmm6iAhO/TmXsP+UFSjg
         q+ikpyS0/xYWqbRh/s0bSauQOtB7g6y+TUCwBEtvCBB48uf3gZNmHtNaewGv0dbYusxE
         camw==
X-Gm-Message-State: ANoB5plru5vHIK/iA0Qt/UPK4Y8f5zL+C6lkdTu/CNYrbKgjHb1szcBk
        I3NIA+IYs6T5ddsG35rPxguu9fWnPSI7
X-Google-Smtp-Source: AA0mqf4kxsZ4UL67ZqkI8S97E4rFaKUqDzyi+0fTNj/ukTeJjZ8XZ8ob+aIirVIuSDmzsxW8PfYgat8up1oy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:788c:ccf4:3670:3362])
 (user=irogers job=sendgmr) by 2002:a25:8e82:0:b0:6d2:70d5:3ed0 with SMTP id
 q2-20020a258e82000000b006d270d53ed0mr56790224ybl.457.1669750173767; Tue, 29
 Nov 2022 11:29:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:29:24 -0800
Message-Id: <20221129192924.1580537-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
the plugins. If disabled correct DESTDIR so that the plugins are
installed under <lib>/traceevent/plugins.

Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when building")
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a17a6ea85e81..f4cd946fe91a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
 
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		DESTDIR=$(DESTDIR_SQ) prefix= \
 		$(LIBTRACEEVENT_FLAGS) install
 endif
 
@@ -1093,7 +1093,11 @@ install-tests: all install-gtk
 		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
 	$(Q)$(MAKE) -C tests/shell/coresight install-tests
 
-install-bin: install-tools install-tests install-traceevent-plugins
+install-bin: install-tools install-tests
+
+ifndef LIBTRACEEVENT_DYNAMIC
+install-bin: install-traceevent-plugins
+endif
 
 install: install-bin try-install-man
 
-- 
2.38.1.584.g0f3c55d4c2-goog

