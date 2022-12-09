Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD816647ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiLIAdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLIAdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:33:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463716389
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:33:20 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p6so1257193iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiyNuJAHf+GBcXEoDhMMGdej4ZIve975Owt12C1xWOY=;
        b=QIJA/IvdxNtD2ifQjZjh1vWT8lgLixpDa6sH3oAOZ9zVR2ZMUFQ+mWHrF3Ja3Q2TxA
         ETo0epCN7yLRHcEZMMDhF72fqdZ8+qujQ+vUCJl7MhNWYLyJg+Anm4VUQm8+krvTosq2
         1QG38jXV2jfCPIhKIEhZ4ufzypsRQeh9yOgf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiyNuJAHf+GBcXEoDhMMGdej4ZIve975Owt12C1xWOY=;
        b=WrMpgZCDcqavWX70mWFOAVCyi/DdHqOT6YVaVu8/DGtoicPqd02qwUohCfcoIlLviS
         TlcdkgrJ5NWVCQ3McEGtZWLZ9i7vA6wHGK0RNKo+7dPoLazy/rsWvvofVXlRQUbmPlsD
         WWzzwYK7d0ts0HzgSnFDopkYdeqhJhoLaIvAnLq2W3UHEXBihThtSbNVoYGJ2FkD36Pv
         CitFjjzOWzaxVdo1i/E1ylE+zm/lSUKg97uwh8lCEBGrpWOHQL39j6OicNBi1K7AnYgk
         NXe/Uhu91JpeX7O8NsbGL8cjyYhnCmgjcqFTtc7/VaDIsQZgD9TWfvT51AUq0DOxBtv3
         PJRw==
X-Gm-Message-State: ANoB5plzG8viATAX0JWhw9sB+jn7GNh2rG2jeywnM+GVpssYqlBej/AR
        yVSentjEtQBternKwdVinXmemA==
X-Google-Smtp-Source: AA0mqf73/8GxoZddYwcBQNMBP6mhHQfzLjRxCtz/zeqIJzngff5NphS920nOyg5kynYHkj4f1l7yFw==
X-Received: by 2002:a6b:b741:0:b0:6e0:353d:8c1c with SMTP id h62-20020a6bb741000000b006e0353d8c1cmr2171484iof.13.1670545999667;
        Thu, 08 Dec 2022 16:33:19 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:4662:6e7c:28a0:dd77])
        by smtp.gmail.com with ESMTPSA id f27-20020a056602071b00b0067b75781af9sm56969iox.37.2022.12.08.16.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:33:19 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ross Zwisler <zwisler@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: remove unnecessary trace_trigger ifdef
Date:   Thu,  8 Dec 2022 17:33:10 -0700
Message-Id: <20221209003310.1737039-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221208183945.1de18843@gandalf.local.home>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace_trigger command line option introduced by
commit a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
doesn't need to depend on the CONFIG_HIST_TRIGGERS kernel config option.

This code doesn't depend on the histogram code, and the run-time
selection of triggers is usable without CONFIG_HIST_TRIGGERS.

Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 kernel/trace/trace_events.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3bfaf560ecc4..33e0b4f8ebe6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2796,7 +2796,6 @@ trace_create_new_event(struct trace_event_call *call,
 	return file;
 }
 
-#ifdef CONFIG_HIST_TRIGGERS
 #define MAX_BOOT_TRIGGERS 32
 
 static struct boot_triggers {
@@ -2832,7 +2831,6 @@ static __init int setup_trace_triggers(char *str)
 	return 1;
 }
 __setup("trace_trigger=", setup_trace_triggers);
-#endif
 
 /* Add an event to a trace directory */
 static int
@@ -2850,7 +2848,6 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 		return event_define_fields(call);
 }
 
-#ifdef CONFIG_HIST_TRIGGERS
 static void trace_early_triggers(struct trace_event_file *file, const char *name)
 {
 	int ret;
@@ -2868,9 +2865,6 @@ static void trace_early_triggers(struct trace_event_file *file, const char *name
 			       bootup_triggers[i].event);
 	}
 }
-#else
-static inline void trace_early_triggers(struct trace_event_file *file, const char *name) { }
-#endif
 
 /*
  * Just create a descriptor for early init. A descriptor is required
-- 
2.39.0.rc1.256.g54fd8350bd-goog

