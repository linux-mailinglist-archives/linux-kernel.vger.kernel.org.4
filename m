Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83AF6A589D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjB1Lxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjB1LxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:53:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4BAD0C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so9327691pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qPpo+oY5O/BDs1mflsxepNoS0s2AHA0SFXfRV7gRd8=;
        b=F3Hrc/dfyL0SKl06Ta0DkwHwNwoxHmWJmtRuhfp5yyuirCSi58Gzt888BoXwIuXIKf
         bFzgdYXA8OdQqqNdX1QX3kMMh6YJh2eraYUjs4/qfJsdBZVQpdAh2PL+tzILFLefP+oF
         7BltMZOxlXNvPLWStyZOIEhieBIBKRnvs7A/kEHgEEHo79iajV+2z8nBy7Xpi6cxJsvu
         DjLUF3yoPppRoC01f+vns8ySHQegP1FzSLylCw4cUMBPq1JsAiOs5pgwhpFG0W/86L0K
         bDN9Sfp5/ggcYEUd3fvxSqySIcOHH1dT+BkpvS2OVSL/ZxQBJUUJE7/6b3XEq2cSAyEP
         HfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qPpo+oY5O/BDs1mflsxepNoS0s2AHA0SFXfRV7gRd8=;
        b=PffApDO2cQAzxJL0d8/EJr00TwQvIfP3xSzH8vF/j8s6+lVL+tTRIoN3zIJtFVOPe1
         WkruIKwhcezXGc6H6Uw4zkaaEVzBdyB6sdVvfHbAbfsLKtqfTpeA4ZUVMC8MSfnFuVBW
         66DC4ARRZSRpHHsehkXaMXn5/dMxeO9ndUI3evWdmZPVnMZIU29H1RLZ1MTH183JrSV7
         e6W2bSOhTFQ/y68ifBaL5QmoCt4PS+Cz1s+pH2KDToDPE4GQo8QkBPKcTmbR5un/H/u9
         M4MAPPmUQXhzVtTtzd/DmCVkVvhDBc2rAk/rsjkaFTotwu2e1HGsIDhzfUPGZvGhWByK
         boeA==
X-Gm-Message-State: AO0yUKWS2aqQzgC7qN14OPUlYkXjeDdhK4IWqCC+xcgLctxAx8j2GAC0
        9Nl60Fqugi2ckTqL814ZvZ88dg==
X-Google-Smtp-Source: AK7set9026OmaeUu0M+xNbPPNjFxI4ilA39NBi+Ll60xREmie+Hu2gD4zYvnLJ3vn4JhBb1BmqJGnw==
X-Received: by 2002:a17:90a:1d1:b0:234:d78:9b4c with SMTP id 17-20020a17090a01d100b002340d789b4cmr2981089pjd.18.1677585192166;
        Tue, 28 Feb 2023 03:53:12 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:53:11 -0800 (PST)
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
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 04/14] perf kvm: Use subtraction for comparison metrics
Date:   Tue, 28 Feb 2023 19:51:15 +0800
Message-Id: <20230228115125.144172-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: James Clark <james.clark@arm.com>
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

