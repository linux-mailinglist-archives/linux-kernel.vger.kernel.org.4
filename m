Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAB86A2E20
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBZEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBZEVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:24 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDEACA04
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ky4so3555044plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=QLCZOXZA8bJOvg/e431jWcUuatC2M0BATcQlATzrxK/OSsLRVFfdDyj1Eeien+oMt9
         6/+coTMUrO1gUQZbBlgoa1XDp/TxsSqW1AMGKb1+24q8M7IC43f8GITQ1D0PeK4ZGkTm
         vBjiMeFkdDt0DSZOzhHfzpehFxRRM+3xlsXQcS4n1gmM0YHTbu7geqhO20FWcfuzt6ed
         b1RjfsSpBz4ZerZq5To3SCcuJCDyuz87hWAedKW2Y0/HX7w7aLhz+/72RXBOWSVpP272
         EYem2JG8n4ZCGTHUgNyZ1x/Eo93Ty9tepoF5PP47tIE4cdiE2x5cJ3dY36Pmeg5nmSIn
         4+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIt7hyoJVmNy/7vg+PJWYd0GZkeRWV7lG6iYd+8Wqps=;
        b=kqo4wydjqp+FutuaTSEzJHmH63yQJjrSqoeyuLHK6RzeF/nlybuSdw+09LQuTU5Ug3
         u5oQRiLKHJ+SZ2DhaizTxju9/Ffn13uNWadgC4r0nsdyGUe8W5rNQ1UaVjvAzhL5ZLw4
         0EnOIWAIE6d+VFgz8s1e9t94VmzSf1nwDveAdE3yXHY4oWCOYyHsHCfMhDtsjIm6Q0/w
         uevNEQEJZHgqAenTtISXcKX3R/5VcFLltKTz7xPMjK5KzZ19MkW/hbNTm5UmvnxA24ti
         KTIqldHrem3sA03ferkKPBjTFrn7MA6fgHUWv0l0WcXwAHb1daJEajBc9hXThJyAG7Nl
         KrXQ==
X-Gm-Message-State: AO0yUKVEe5nUhM1qrDOaeZ9cckIKnHF6x3OQSrM2a0VXKxAcOep068UX
        ITUZNfGNxkxcWJ3+8hN6Vc0OmA==
X-Google-Smtp-Source: AK7set8NFJnLKgBe2EBgoB7Mof6k4BnAkRsqRlxzF43EeTJawxXOGdih/wiXHA78FRAElhuOG0bPEw==
X-Received: by 2002:a17:902:db10:b0:19c:dbce:dce8 with SMTP id m16-20020a170902db1000b0019cdbcedce8mr6942908plx.15.1677385281289;
        Sat, 25 Feb 2023 20:21:21 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:20 -0800 (PST)
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
Subject: [PATCH v1 04/14] perf kvm: Use subtraction for comparison metrics
Date:   Sun, 26 Feb 2023 12:20:43 +0800
Message-Id: <20230226042053.1492409-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226042053.1492409-1-leo.yan@linaro.org>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
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

