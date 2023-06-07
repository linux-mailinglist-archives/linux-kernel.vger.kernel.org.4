Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46D7251B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbjFGBpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbjFGBoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BCE1FC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so4733590276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102271; x=1688694271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XFoL/xuCUqBe6BRwc8N7Y7v2osWnOEnxNVa+GsqUQcs=;
        b=F/hf2xJpuFbBnqzOCSxP+6hubVmkxHcfSvWf/6t21kJcuX8IOLOzHlAOhAfMcS4fG5
         NFfkSLsK+5Msb8DZcgdpXkYbmqE7+IrWHWygJRAFZql+aE31oAp4u6ORYQaUBbWrxJg+
         qd/SCHqCjPPpYoJ4LxpFLw/A7vzTqR1WPpAOvKdZPQRujZnNRLT4OBHZK4sAoXZjNHvv
         qUUCLuSNjxx1oDgyVkS2WMbipMCmJe5rblNq4sJNbKeCEI+zJ6cgtOsZ0Kp978ukpWv3
         JrpBtEKUnFz0/FodQzyI6hWWjr8F4xdGu6R7EU1ktwi93V8MnC+5tdsT7dM9wA85tQux
         fpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102271; x=1688694271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFoL/xuCUqBe6BRwc8N7Y7v2osWnOEnxNVa+GsqUQcs=;
        b=AxGJG4IUZHgN2ZbfDOpHSUAU4ZmzcXx0aXPu5rv/16OaJD1aivm6eaJQnqZJa1PtxR
         eCcYLhXOxL57ZjK2ZIMZ1s//A4kunIsxzmzAPnwBk6mFI+bM5udMa4glt4S7DaYb5y3E
         WVvP6E4i6csrLP2htUBJUdRh0F2/TYwwFpn3XDqwdtPGhgNxDCfYh52Zwab3M3YIs3TH
         fWY6W7PZQ9uqgxZW09GoFS0kpxgio718D+oYs5G4DVzCXQsiYfufGAsV3U1pCRohhgFj
         vD36GWp0YempRNI04JH2rhE5h2+S1b4TdPLgAc53f5DiE2qQY4G6flGllJCnS3RLM2sQ
         ZSwA==
X-Gm-Message-State: AC+VfDzkneLKK2cGKX17QwWTxnBAdLdw1205kF6DxMTJLVXSxO3BRm7o
        zcCpKbqlOUIaOoUILRsAntoC0xgxzAjt
X-Google-Smtp-Source: ACHHUZ6jLd3U3GKM8c0LzAbwO1WZdEQj04VxGpecn9buyGhUqUJs7lzhngE26F+XSZYUAtVSCJ7WAxNcP+M2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a25:8d86:0:b0:ba8:b828:c8ff with SMTP id
 o6-20020a258d86000000b00ba8b828c8ffmr1379977ybl.10.1686102270906; Tue, 06 Jun
 2023 18:44:30 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:42 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-10-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 09/20] perf report: Avoid thread leak
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        "Shawn M. Chapla" <schapla@codeweavers.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Caught with address sanitizer and reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0b091a8983a5..a31a23af5547 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -839,6 +839,7 @@ static struct task *tasks_list(struct task *task, struct machine *machine)
 		return ERR_PTR(-ENOENT);
 
 	parent_task = thread__priv(parent_thread);
+	thread__put(parent_thread);
 	list_add_tail(&task->list, &parent_task->children);
 	return tasks_list(parent_task, machine);
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

