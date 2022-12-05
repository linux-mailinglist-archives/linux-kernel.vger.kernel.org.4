Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317A6438D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiLEXAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbiLEXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191BF1E3CA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:00:27 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 187-20020a250dc4000000b006f8cd26bfcfso12382055ybn.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJd3unxth988O4ChzrsMI/KkhK+0qKkYIwY6FEhWnkw=;
        b=FRqWAbY73AhNd8V+YTBgN6yaWg8iUzX4pU80v+SCHpgI/CTXgfdrQ3K6fT+cpHj3uK
         EN5s0GjjgdzS3hy6tkwp/DWOzWu+WGEE2iu2CtwpTOxyXZvJlrJAR2lxwYo/kuruMZDo
         wXqcmeVWRRne58FdQ0dMiMTDtw4d25znA2BSldV2h539ICJgz5EFcbcAWd47VKBxVWHh
         vb1IRENH3hhu4plY23kCwlQSIOeMOPcxCGTPNVPZfP0cZyczVVfL/MnAW1TT2q0pMdvn
         NVnISfXhPsjcX8e5ezltJY7owSrNOQW6J8CidR0+9LbOp8S0MHg6xScCsZFP4rKQX0uq
         dgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJd3unxth988O4ChzrsMI/KkhK+0qKkYIwY6FEhWnkw=;
        b=E1GmPvQvMdKYeJbfmOm5ov8uDrZdlTh8Pc+JImMvzga2LwHEwCw83Z4u3NpJa09H8H
         soetsPyP9Y0YfwrucCcb5KtesYtNYP5uDbzd37cKNnr1ydecu4OWU24RvysyT75Ot5NI
         aM6FEi/EajH67y8fttnp9DMkYbcTmgKSZjYc4m4uLGG/s57SEWEQRr7TKJZQ+g0tSTCX
         7D2MGzpX+Rr/hkcd7VV9Pg5fJ4XCtW6nRUpm2veOn8PjVvNoWQz9ySfVeUStq9DjtSSJ
         WJkewqtG9IwfeYKG2+OlseA61mZ0hlEH5J1pP/NA+3bJPAB6/GVTIad934NGH84Iiuy0
         bp9g==
X-Gm-Message-State: ANoB5pkg3/8bIcPjpqPJDQ1egWGE5z74YAYBLE0Fd+100JrgvZL9Ohk8
        gu//btzNFJFCmMddmVLFOXKEK66QfRx+
X-Google-Smtp-Source: AA0mqf6kYPN63s6r/LmOIdeoVrRTHGNcj1Yc84GK+j2U35wrcRGViI6T6nHPkyENWehvnR8R/w7RcTbddD1g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d2ab:5fbb:e81a:9151])
 (user=irogers job=sendgmr) by 2002:a25:d906:0:b0:6f9:bd14:f0b4 with SMTP id
 q6-20020a25d906000000b006f9bd14f0b4mr26845398ybg.408.1670281226358; Mon, 05
 Dec 2022 15:00:26 -0800 (PST)
Date:   Mon,  5 Dec 2022 14:59:38 -0800
In-Reply-To: <20221205225940.3079667-1-irogers@google.com>
Message-Id: <20221205225940.3079667-2-irogers@google.com>
Mime-Version: 1.0
References: <20221205225940.3079667-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH 1/3] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index a17a6ea85e81..6689f644782f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
 
 install-traceevent-plugins: libtraceevent_plugins
 	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
-		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
+		DESTDIR=$(DESTDIR_SQ)$(prefix) prefix= \
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
2.39.0.rc0.267.gcb52ba06e7-goog

