Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98FA7251B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjFGBqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbjFGBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:44:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82219AC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 18:44:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso11090954276.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686102277; x=1688694277;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w532lnbGp5anOsc290HQqo7yKb1jpgu9WE3T8mTec4I=;
        b=4Ah77oIcW1fhi4PUaWNVyQCtlDy0ODJswvsNp12X68m9YC8jPYB0wJjfd6u9Nes/qM
         WyyQujj/FsWMFXlvbodKx9omh3hxJTA8Uzg3HFoKmEIM/4ZXwapKkMv/J4GriQEMoMxK
         YH6zmrmTRduNvHTbQI16cu3VXzfSd+04P8SdbixqbWrtaMQm+DPgD8pGSVIx6KnvG12E
         /LsrP+9Ui0xoiwCUGBT8mDlfuLWX+nI5VPmXw+d4/M5gvRf4ahFqHPMpDTdJjkqfjB4r
         lVY40iPLtZBNOI6+2oGaNs8iPKdw3FbkJaZxO/havOEgdW4CiJu+WhvCcJduPdjNd8TX
         3Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686102277; x=1688694277;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w532lnbGp5anOsc290HQqo7yKb1jpgu9WE3T8mTec4I=;
        b=jzrXznnJboGC7Kh2BDwSiD1UG98HmXaKLo42hU0bg43BXZ9b8Fwf8oK3pjaC4JXmat
         yuiNOVUOKGKT+bxZ38yS1R4yUXWEhf4LSbi1rZU8KIeLMiyPMgO4oKnrZr7Y9rQlkVba
         OeGyIKp1MzGnSbyurHZSxUQ0sIPvRX1Swr0soGKfCWh1O9jNxYSbVu2rQ2w/vq3CJnjZ
         mpOIHvvNo9MRWnOw0yUox5V6DmdpEu5pr4XP54qXHov5QAOj9Z/3Epq0ErFeh717gNDy
         UXrah0YRQG0Ipicq1RNe7hXgMkcPuc2KQb3Dojthh9ByqPWToY2VXUTxMkcHh0cwTU0j
         JNGg==
X-Gm-Message-State: AC+VfDy7tLIFMzYCbhbg2xqUKNbepN1ujOcamT9p2Ar3lTSgBMirJGga
        /gIfKh0u1VTjcPDSdNOscbvMnxyjVIXm
X-Google-Smtp-Source: ACHHUZ5K3q2BRZQ3BVaY4x+Gz/kg1NLcmTS5uYFGmWeNZGZJl9FEpVaiPom/EYkG6lni3/0N8BD8dY+UkiA/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:bac:f582:ef18 with SMTP
 id s4-20020a056902120400b00bacf582ef18mr2308600ybu.5.1686102277621; Tue, 06
 Jun 2023 18:44:37 -0700 (PDT)
Date:   Tue,  6 Jun 2023 18:43:45 -0700
In-Reply-To: <20230607014353.3172466-1-irogers@google.com>
Message-Id: <20230607014353.3172466-13-irogers@google.com>
Mime-Version: 1.0
References: <20230607014353.3172466-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 12/20] perf intel-pt: Fix missed put and leak
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

Add missing put and free, detected with leak sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/intel-pt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 783ce61c6d25..dbf0bc71a63b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1280,6 +1280,7 @@ static void intel_pt_add_br_stack(struct intel_pt *pt,
 				     pt->kernel_start);
 
 	sample->branch_stack = pt->br_stack;
+	thread__put(thread);
 }
 
 /* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
@@ -3580,6 +3581,7 @@ static void intel_pt_free(struct perf_session *session)
 	zfree(&pt->chain);
 	zfree(&pt->filter);
 	zfree(&pt->time_ranges);
+	zfree(&pt->br_stack);
 	free(pt);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

