Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705D728BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbjFHXbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjFHXah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:30:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC09F3592
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:29:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso1648318276.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686266999; x=1688858999;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkToW/IxAxIJSXDgl3LW19tfDO+EnTd79xT+CYyJZYQ=;
        b=ePUYqN7ZPxjl/iomWSLKPkhrn5dsM9dC2KVd28TGs3cL6teDeifYm9LxIGIKjrkZl9
         BlV/0s3aD9lr9ZuGvZyfqd1lG3pKdJInvG28YBH7LQOlWwvYUdbo3BBKD9CeGAFtobIR
         zG+MK/W+kqJLQ+UY7cv7Z6RyZ25OSeLp+kvE0hYaTsSdRu9Hc+FR/1Q9+uc43YG+QYi/
         VN6cgDX6cbI4P7pKQeRHEmb+q4LFZO5aVbVIYm7TL15AwTwKMtl5GnWYKXfn9m/v/PLY
         ZopqDHGQq1KlHwKMmX8ens3+2sZP/wlvgK6rTBCndAz8G+J+TsKDaDYFA4qrEUT+eyXd
         UnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266999; x=1688858999;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkToW/IxAxIJSXDgl3LW19tfDO+EnTd79xT+CYyJZYQ=;
        b=fEMhH62JjYdV04JF3LkjW1+nupVi+bqPk9U1oTJa8TEqUmH0Xoi96oeWCQIBj8dLuI
         BpilNF1vNY1PHPnQGNg0wjg0Ishq9yISVzKg/juPD+JitfPIKMFxp5BpOK2jzt90bNuD
         TWbrO8TZn+bPOhZPkWxYPUCb/LbTtio7BLbRg/7TSOlvvdBPwlhSFkWeWC/5Z/A2ixg2
         X8aBKynxJzEVG4ZFgcKYZgX0U8jIQijRCBTuX3ms9LUw2U8m2s1ARgTa/Mt53Gz9GtDi
         7uqIpcdsyFMQtYWa2nJU/Vai7QBAfIHwMksURPvrFDolC4IpNrBdQtG0lVAjuG/xbanO
         DYFA==
X-Gm-Message-State: AC+VfDyTYoFqVLU43bDW5n7G8PEkXbx70b1sVsCRTPhDeeqBHEIPAxtw
        a2yP1kHmEJuyPLvrTqjsQRo/GcAIWEvZ
X-Google-Smtp-Source: ACHHUZ5tPuMIGgflPqSJvwXISvhb5nmU8SoragnEA/O5sf2CLUp8sLIrrQXOwOYy3OBX9Za0AGMnCWLsX7EO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a25:ad8e:0:b0:bb1:f26d:b18d with SMTP id
 z14-20020a25ad8e000000b00bb1f26db18dmr584028ybi.13.1686266999057; Thu, 08 Jun
 2023 16:29:59 -0700 (PDT)
Date:   Thu,  8 Jun 2023 16:28:16 -0700
In-Reply-To: <20230608232823.4027869-1-irogers@google.com>
Message-Id: <20230608232823.4027869-20-irogers@google.com>
Mime-Version: 1.0
References: <20230608232823.4027869-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 19/26] perf machine: Don't leak module maps
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine__addnew_module_map requires a put on its result. Add this and
narrow the scope of map to make the correctness more obvious. This
leak was caught with leak sanitizer and the reference count checker.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f8e6c07f0048..359ef6b4e840 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1797,7 +1797,6 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 					      struct extra_kernel_map *xm,
 					      struct build_id *bid)
 {
-	struct map *map;
 	enum dso_space_type dso_space;
 	bool is_kernel_mmap;
 	const char *mmap_name = machine->mmap_name;
@@ -1823,8 +1822,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	}
 	if (xm->name[0] == '/' ||
 	    (!is_kernel_mmap && xm->name[0] == '[')) {
-		map = machine__addnew_module_map(machine, xm->start,
-						 xm->name);
+		struct map *map = machine__addnew_module_map(machine, xm->start, xm->name);
+
 		if (map == NULL)
 			goto out_problem;
 
@@ -1833,6 +1832,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (build_id__is_defined(bid))
 			dso__set_build_id(map__dso(map), bid);
 
+		map__put(map);
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = xm->name + strlen(mmap_name);
 		/*
-- 
2.41.0.162.gfafddb0af9-goog

