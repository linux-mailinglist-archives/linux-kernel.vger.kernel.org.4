Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914406D0DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjC3SjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjC3SjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:39:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840ECDEE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:38:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s4-20020a170902ea0400b001a1f4137086so11643290plg.14
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680201532;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc0WsSKhrfezZG14LM0dWooUum9c0MXHA4o6d0x9y1w=;
        b=h0nf3bWtd92qScL1j9hY2/7NM2m8VITXWJ8OnlSeERxoyrf8IKNHQmqeo8SX+snYD1
         DPJMb44DkDtvYiRLt2v2Cj7qwhc7gHtDsZ/7ZehzjHm6nniACa8+WI53rcESu/5tC3yn
         0+JlKwhxebFRGqjDQvbNLt8Rn/uh6DRAWx9FX8WToSBiXDOsuG7u+CbZbxaehdKwBzNw
         gmB33LiiFiVeK3tMewlqfkBP9y8amM3VVszEjlJEdE1tmgGwGhXaM5EfvGw57G17KeHu
         4g9PYsi00nLM41A14C6NFMOfqh8w5CG7xzzbfVn7K8HosZUFC0T5nzJHQti3x0SUokKm
         c3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201532;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc0WsSKhrfezZG14LM0dWooUum9c0MXHA4o6d0x9y1w=;
        b=4M/33IGiVC5iddU3pV+/hlJ7nyYpjowhaWejZsSVX3upPpVmJas7yABUVirbHg3xkG
         ysYCFQeIoVIFSFSZTN38Rj9iViWc7I/nn8y9er/wirp6/Yx0sSXfNTNnKdYmSSxy4MZL
         9YrNGS+9WEo+ZnXMXzx9fH2SK9+Tgj58N9z1vExH45mmBqcfjo592YuoqzOg8H2GvXKq
         vI0L9HWSwBwmW7rV+IFoerAGlT68CNPRv93e2WJhzc5efIQnOsX4ETIBsmjjq6Yk+50V
         APmlRpm+jvzuN0Mzl6SfH+AVDCvuyajUSSR3pTIKQhickRNMG4vkyrQnSoRK6UKnd9ZH
         eSBQ==
X-Gm-Message-State: AAQBX9drnm9tHExlRUC68sLxHiRthNhBRngKmMGPYvZHEuHIPps982Wb
        RHC0c3w7qqoQh3n2flrUzWKKrVJNTs2K
X-Google-Smtp-Source: AKy350ZDXa8GoDGRrg5g0i86ixFwbwBcMF9K8wp39rBOS2QnXaKFmX4Ua0dg8GzUqhFJTCSDb3Oa+oxeOrUz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a17:90a:600c:b0:240:9d66:cd54 with SMTP id
 y12-20020a17090a600c00b002409d66cd54mr3550317pji.8.1680201532035; Thu, 30 Mar
 2023 11:38:52 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:38:26 -0700
In-Reply-To: <20230330183827.1412303-1-irogers@google.com>
Message-Id: <20230330183827.1412303-2-irogers@google.com>
Mime-Version: 1.0
References: <20230330183827.1412303-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/3] perf block-range: Move debug code behind ifndef NDEBUG
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make good on a comment and avoid a unused-but-set-variable warning.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/block-range.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/block-range.c b/tools/perf/util/block-range.c
index 1be432657501..680e92774d0c 100644
--- a/tools/perf/util/block-range.c
+++ b/tools/perf/util/block-range.c
@@ -11,11 +11,7 @@ struct {
 
 static void block_range__debug(void)
 {
-	/*
-	 * XXX still paranoid for now; see if we can make this depend on
-	 * DEBUG=1 builds.
-	 */
-#if 1
+#ifndef NDEBUG
 	struct rb_node *rb;
 	u64 old = 0; /* NULL isn't executable */
 
-- 
2.40.0.348.gf938b09366-goog

