Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535CA6A5498
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjB1Ims (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjB1Ima (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:30 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983022BED7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:21 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so5131452pgh.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=mS2P4aAtqjsWhcUJddXr23ZsJdr/sh+N0IF0kJbGeCvOX2S9jFSXWRTXzjCaYH5oOe
         cBtzrnH+LdZBzYFn1ZDiWpdnMFutST9mW4rYGVw8aMLDQRDeghAKpGtA+KIWlxM1Inz6
         4jmgEfEMaZYRHMIJ524Hkafcy80SxQc8AvmvBz/ofCWvXKmQJHJOSB85boiZhosuiHNE
         AvSOY5Tk2mGKZH+W0z8kCgQJRKy/v4hgW+jUDZlxoLW8fUTEzBIktHtK9n1t8mAkHvg9
         kgOPOJastla6hp0mZRj4BrtEjLjDTp3NxHnqTRdJcyZFfbIEStS8ELECfgjTlwLSqZpx
         4jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=GI7ehtAXNW7J5iC16sWG5LJk9ema8dGApHfxy1ykashF0w+n/bChj0mJNV4CsHhmRs
         WEcpdgLlIAwWMksk9u+R6T2PWNNkAZPKgtnQjfEIigFKTMSFC4e9uiyGlEg2OVKUqc0n
         j5vyh2Nh77BQIN/m0P2UenDicUR7WDY43YiE8wYM/0Z2WMxta4Zi1D86Oj651lFq3q5j
         yywgT1SyX8JU4r6R+jWrmlbqFXqFsP596VgBd/s8TUI1T4IN3cg8qBj4nt9alsyVPJ2B
         FSs07hK+LXhtqLt/LIdVQ42M3oezlXXHojywBfXlgKI4sZ1773rparrcym9253skhbqp
         9wJw==
X-Gm-Message-State: AO0yUKW61iOM6RrAim+KnEn9hwGJZj2CL+NZqwLCsRimv63Tg0Zw6oCw
        h1Zk0n90MD5/1yFCczLymfyBrg==
X-Google-Smtp-Source: AK7set/NrRxAzFchpNLziAy94c5DDBN/Q3U+Nn3NEMEEStq+wEfwWgcLPLfOaCiLBsFaQpTYbXUDZA==
X-Received: by 2002:a62:4dc1:0:b0:5dd:3f84:7d32 with SMTP id a184-20020a624dc1000000b005dd3f847d32mr1845280pfb.1.1677573741035;
        Tue, 28 Feb 2023 00:42:21 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:20 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 04/14] perf kvm: Use subtraction for comparison metrics
Date:   Tue, 28 Feb 2023 16:41:37 +0800
Message-Id: <20230228084147.106167-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228084147.106167-1-leo.yan@linaro.org>
References: <20230228084147.106167-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the metrics comparison uses greater operator (>), it returns
the boolean value (0 or 1).

This patch changes to use subtraction as comparison result, which can
be used by histograms sorting.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9..6eec0db2dda6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -66,7 +66,7 @@ GET_EVENT_KEY(func, field)						\
 static int cmp_event_ ## func(struct kvm_event *one,			\
 			      struct kvm_event *two, int vcpu)		\
 {									\
-	return get_event_ ##func(one, vcpu) >				\
+	return get_event_ ##func(one, vcpu) -				\
 	       get_event_ ##func(two, vcpu);				\
 }
 
@@ -523,7 +523,7 @@ static void insert_to_result(struct rb_root *result, struct kvm_event *event,
 		p = container_of(*rb, struct kvm_event, rb);
 		parent = *rb;
 
-		if (bigger(event, p, vcpu))
+		if (bigger(event, p, vcpu) > 0)
 			rb = &(*rb)->rb_left;
 		else
 			rb = &(*rb)->rb_right;
-- 
2.34.1

