Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48C26B592A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCKHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 02:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCKHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 02:00:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251C11F6B8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-538116920c3so76957287b3.15
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwWoTjR86AKucZnLsGNUcUMK7gNda6D+/S/cfRQfBgg=;
        b=eElZEpPqgYjQPT+2OgFJo3tJTboFaG9WiNPK5qqArvz4zn9dLkynGNEg6xMvjQpfsB
         8VIgGN8gT1K2LA+1w7FACJ0oeu6GJzCk6x/Vt4K39kUe3JaWwQa4UIkDfsMp/3+5GeZD
         POGSCqaKPVtzV1MJgMTx/ERlkg8AW6eJHa0x4KZ9NvMfRLGV/n6sIZSu/Rc1VFz/zCw2
         RPvH3408SaVcFcAVh7ctiB/PTEKu9bWodiOA/MRIf7PQJt3QfR1SCsRAPLFDcGxQ1lZK
         2+TirLZ0YCwlUl+CgZIoAF0cdAF0x2AJwBmMMewK3EFLb1duc+Sk7cL+Xd3VtmemShtt
         1XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517980;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwWoTjR86AKucZnLsGNUcUMK7gNda6D+/S/cfRQfBgg=;
        b=rsbagphUnC75h6R6ZDlfJSWXJZelurU5tg8CpB3XSUWjYFdn+60xbdGdBQuHjhmv0S
         zoCirN9yBf4xu1ojWQ/a7ezwHB30bcHDoMn+AYPqQmUDm90DySHj0q0ugGfiiJACuLMF
         kc2NxYu7aBCoHp2M6evw2+cZc1UBQKTLbj/ClITFxW9rMmpWYDy5MvXg8l9j7DOUh93o
         ySCa6+Zwzjd8SYJNfKzET/lrfUt2WYRvdv/uwMwCYVxLaNTwqbeoIpmIIuuVaoolJmoM
         u/UO14Mvb3dv2BO7c7vkggCb6CZ8GkBu3UYlXoGAMs5nWqBN3zffy3Pd74rXzcnw9Rbh
         45cQ==
X-Gm-Message-State: AO0yUKVjBCzhkLSDtJNnTlqqTAJBNlx5I2bHRGofyBhwznr70Cvhe3pZ
        Lyd1PbFAfp9Im2wLBv6JzmeNuFvwj7tw
X-Google-Smtp-Source: AK7set8Vrv9NAbTX9LeVvPN5FFdwJH1Tgz4a3yXybmJZZZuxkA7pyjWm68DJOp93hT5QF5cnEQsir9bGAKm4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ed06:0:b0:540:e6c5:5118 with SMTP id
 k6-20020a81ed06000000b00540e6c55118mr1450560ywm.2.1678517980596; Fri, 10 Mar
 2023 22:59:40 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:51 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-12-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 11/13] perf build: If libtraceevent isn't present error the build
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
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
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

If libtraceevent isn't present, the build will warn and continue. This
disables a number of features and so isn't desirable. This change
makes the build error for this case. The build can still be made to
happen by adding NO_LIBTRACEEVENT=1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9754218bd418..1b598c5e68eb 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1156,7 +1156,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
   else
-    dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev/libtraceevent-devel)
+    dummy := $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel or build with NO_LIBTRACEEVENT=1)
   endif
 
   $(call feature_check,libtracefs)
-- 
2.40.0.rc1.284.g88254d51c5-goog

