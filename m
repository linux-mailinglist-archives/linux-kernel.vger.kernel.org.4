Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDE6B762E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCMLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCMLlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:41:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573096510A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l1so11704856pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678707659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/nbi3g1G7blTIc7EqTO9R+UAXnIBnoxcjmSOAZ7Xck=;
        b=evWDaAHRTVMrCXo8odtG+XiiUQi/tIoaxy/YK2dWKYAJKc1YsgTzVcGbRMwl/jK+A2
         se7zCOxQLs0/AMm0R/Hhi+RHruUbuxn1oDGZPAGOfRrzGKFTMfkzP5AJ1vrEY24SqPj6
         U8QlLyFEj/m6hPLsidBw0kiRmNFqGEVPs0lrJSV2ii0F/aNS05n+LoTzlWtrKf9cVICX
         nxxlfGv8wfAiU5rqfpRciQ3k/egPgubfloC8K9Pq+dvRgpUbfugeEwPme8sOHuBvXGuC
         D1LMKU1U44tgTYfVr/K7MSsq73F/9BaP+WfFwm0fORwzQ+LDfFh+u4/B+dSRQoGTJG1o
         /mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/nbi3g1G7blTIc7EqTO9R+UAXnIBnoxcjmSOAZ7Xck=;
        b=YKfvWqUhu+tFZLyVKM5F1amV+Y1jOdrA33dw0TZn4PPGPs0wqJtgnx8+I0kKSZ8Y94
         lm2eFSQsr2uR/SSusxRV6XQRJ8lqE41JnaAigFhAXrYglIL0WJr+4njjlc9d8zpJMZce
         WUiJATAJ6+JmQkOzeZhqLTaHfTMk27R7IcK37rLARKAWGc9/iZBNZw/j184W1/dkNcMI
         fWmYAx/wHJ+2xShfEEVLU3ZEfKDUP2WCDy2687PvPOtVPJfYQ+GtBTms2h/TWB5p761B
         8+74NpM3jWUiA90ntLDrC/YnOVsrVtvZZhNh7e9MyfamKiiEn3N9H9TKqhIQSfpm32yB
         PGHw==
X-Gm-Message-State: AO0yUKUXiROfUob2LxAqf/CdAsMALULWHWmbDwiA8JxaBtTuu0BR3G5+
        +Ejr5M460/3TDooaPU7UAjx+EA==
X-Google-Smtp-Source: AK7set8teySbue549QBMEg2WXUd64gS+oeeOqp2p0guknoK0bwSJzOLunt6prvsrWSje1dQr+Go6YQ==
X-Received: by 2002:a17:90a:94c7:b0:23d:2b11:b39b with SMTP id j7-20020a17090a94c700b0023d2b11b39bmr34239pjw.31.1678707658713;
        Mon, 13 Mar 2023 04:40:58 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.236.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090a2e1500b0022335f1dae2sm4281625pjd.22.2023.03.13.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:40:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 04/16] perf kvm: Use subtraction for comparison metrics
Date:   Mon, 13 Mar 2023 19:40:06 +0800
Message-Id: <20230313114018.543254-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313114018.543254-1-leo.yan@linaro.org>
References: <20230313114018.543254-1-leo.yan@linaro.org>
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
be used by histograms sorting.  Since the subtraction result is u64
type, we change the function return type from int to int64_t to avoid
overflow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9..4e9519390da6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -63,10 +63,10 @@ static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
 
 #define COMPARE_EVENT_KEY(func, field)					\
 GET_EVENT_KEY(func, field)						\
-static int cmp_event_ ## func(struct kvm_event *one,			\
+static int64_t cmp_event_ ## func(struct kvm_event *one,		\
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

