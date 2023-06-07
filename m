Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B877251BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbjFGBq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjFGBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F21FE9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56552a72cfbso112364007b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102291; x=1688694291;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zgqIPituhIYk4GIizxY3KBqP+afAEkk8xXOmxl125Mk=;
        b=HnLdkuQtOLiT90PWkVp4H9hTUlBzohal9FoA0h1VTSuaG0fk5pvARqH4bvHgys/ylI
         nRsDZkK7TbfaLa8CUo2/C5PtEdnHu+x93qHzuLuXBVAVvhcTk4ugH7TzHwkPsje7MQC4
         gyzjNrEuroULpjcc2kN6XN5N6DNIGFBfuvplwllQvVv60KGWc6FaGoe3uRrquPJvUCFi
         uTj7M3KS3Jz1dtq4uxgDXKw5v8Ja6aV3pdnAmjBirRk+3PJIwvv5jd20AmeaNLWMTYh9
         AURpNFIOcEe1ZqcFMqR4LBjq1xATPfqV+ZOdQ6TXjDkwjd0prtLgRPgsK3uJH3pue1cz
         sXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102291; x=1688694291;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgqIPituhIYk4GIizxY3KBqP+afAEkk8xXOmxl125Mk=;
        b=c6YKCXqSUg2Px22I8ueVdfZopsig7Xt51sFl6BMXibAs6ljUxzHlUmiX8t4+JVRf3d
         EfGUnhMoOroIh3h1KaxWgAlu86ZyROs2AKLAb73u0VgL9Q8QjQIFUlKXXJKjvQBdLuYV
         tmVE4O4/81lydSu2PYD6Wgi3wteZ8diPOtqsjUgclc+lwuxFXLDaR8LwukVyrR6zBPFM
         qR/Fxj9SseC4YlxE69w8faCGDm9G0r5l8khZQaD+c7JsNNQc1kwSYkv0CoKgz9MIlav5
         Drz8svKwAagQy6JLAcPoP2aPHXhvDwoTfIHw5TOzHUMapInlgSn+as26HjfyYATX9cWT
         f5Ww==
X-Gm-Message-State: AC+VfDyMaE7AK+G0ZuzuY0f19XUiAGhGGIAKFc2EMqnzc+IXJwxT+bM8
        yBawHMRXBVEQRSaFM/H68z6mNjJiGVdt
X-Google-Smtp-Source: ACHHUZ4O6AqHNMvW/AUh8p8vB2lzYbCObW6eg5wkLZW8uV+HB7fb+IhNsrmQhwAoI3a975hTDPdyJQX5bokn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:4112:0:b0:54f:93c0:4ba8 with SMTP id
 o18-20020a814112000000b0054f93c04ba8mr2061450ywa.2.1686102290861; Tue, 06 Jun
 2023 18:44:50 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:51 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-19-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 18/20] perf machine: Fix leak of kernel dso
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel dso may be found by searching dsos or allocating if not
found. The allocation returns with a reference count of 2, once for
the dsos list and once for the returned value. The list search has a
reference count of 1, once for the dsos list. To make the reference
counts consistent, increase the dsos list search reference count to 2
with a dso__get, and do a put when the scope ends for either the
allocated or found dso.

This issue was found with leak sanitizer and reference count checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 46af5e9748c9..f8e6c07f0048 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1868,7 +1868,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 				continue;
 
 
-			kernel = dso;
+			kernel = dso__get(dso);
 			break;
 		}
 
@@ -1913,6 +1913,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			 */
 			dso__load(kernel, machine__kernel_map(machine));
 		}
+		dso__put(kernel);
 	} else if (perf_event__is_extra_kernel_mmap(machine, xm)) {
 		return machine__process_extra_kernel_map(machine, xm);
 	}
-- 
2.41.0.rc0.172.g3f132b7071-goog

