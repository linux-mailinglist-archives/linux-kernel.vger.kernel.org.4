Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62015728BDA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbjFHXbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjFHXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E3B3A8B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a66a5d84so15734087b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266996; x=1688858996;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGUf69TvsdEnNaIsR3ddGXV6UHIPZliOJXiSi9AkMd8=;
        b=pj+cfLWhmvN+fFVnoiQM42+qIryqDUimhVDEqfmtvHnlEMal5DUHbUXirbPSFWbrXl
         TVxKULuQgeyTD8ezUOpRIuKywDDAPZ8xE0fFiawIFwduHPH9FORZrnn6WUXqVFweowYF
         ehf8+d1JTUDjZgUFYCGWN2yKCSFLiLgosTtMM/ZBrrlBbSh1AesSWwqpYkBaNx5UgBEl
         bf3jN2Y+kOmSQ0gOGeCvq6cHlWjE2fKo5bzeUGhJU5DZy9UNpmCWwcYxZ1p2q9PHq1dx
         SEDb6U4MeNf7OqW2QvuRJ262VrHkjKsRUyHli3nBlXxIkbyqp99m569COtsbWx0pwBIQ
         thMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266996; x=1688858996;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGUf69TvsdEnNaIsR3ddGXV6UHIPZliOJXiSi9AkMd8=;
        b=P64KFamc8u2Clkp5liu9WZaoaQo9VHyDCB+qhEUeGqC23UUqKdjfKEB76xQCNXSX1Q
         0iaU7fFNMWbagOIQKS+hdtI3X+bnNiaExpxBzHr9XXtjLhIPuAZUY6hDOVF82GIqrEer
         j5oWhKJzf8JgciAFxJ0MVKUcSLY/GzcZuiBRKNg5uC/X4vO6KwzoH467KzQde/FntYhR
         NryTpDvGnxmOH6GAjbqWbOrq7oJ2CZVY65THgY55sjd4QoaVxt2MAWjhxe5hVJCexFIT
         D/k1twAH8fSKaXaUIKzXZoZ/vkBVfTPYXOReFixe/jFSoiKTOfHpkoS13n3r9Q6iRIG/
         N5GQ==
X-Gm-Message-State: AC+VfDxg7Bbls8DfalDUZrvOLmUKLl3brIwRdjL6NFjM3xtiguHZ4VkO
        Vn2cJVN4PBiTacpTmlnc0PqOUltvVoMs
X-Google-Smtp-Source: ACHHUZ7M+koLA/Ia+fdnv+WBR7V4mfq9IowZ5DMaWuIoGfb9NIMwoa5UssIGW7+f/lEvCFDdeBHQIZHNM5Mp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:cf02:0:b0:555:cd45:bc3a with SMTP id
 u2-20020a81cf02000000b00555cd45bc3amr656760ywi.9.1686266996318; Thu, 08 Jun
 2023 16:29:56 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:15 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-19-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 18/26] perf machine: Fix leak of kernel dso
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
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
2.41.0.162.gfafddb0af9-goog

