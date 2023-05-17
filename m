Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73C706BFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEQPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjEQPAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:00:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3E98690
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:30 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643accc41a5so53133b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684335567; x=1686927567;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDiC9RY1zs37JQzy/xyTqLqcVVdBqmzj5pMMgSLBC2k=;
        b=qAH8dA1MBDw//W5b+cN/DyreQ6vmZocG/5dFnQOttiCARmjK0YdCXVii5SB34CphxF
         t0EWRnE0ucijXh15k5s8O0tia1jN2x38X9PcYH3Y4zVveSxPafkqFQPA98q+y5/vfYNo
         FazWN+SzEkBfdi/4u3XgdYANIAsdEDicFwG0/5hwBoolAhev1nR3DqPyK3VDyKCAU35d
         O3EifEaOZY32H7blE5VyS+nybpP21nHrS4hRx2lYtPmDC+FgDsJVbP4NbQ2r+xhn+UaX
         aTVJNI9fVWPjQeSkEw4Py4XHBB3s27d5AJq0V7LVs36Sh2kfOP5eWe9tmGamPDySW5mz
         9Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335567; x=1686927567;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDiC9RY1zs37JQzy/xyTqLqcVVdBqmzj5pMMgSLBC2k=;
        b=F6yR8qqGLdKuAwo3qVNas0aUA7OYeQQjuG3Uhqk1RbySD76de/N5ta1O/QkeMgAWyW
         zbtEzsI6HH1Esf9nn+6lEoJiP3bt8Hbn20vCled8qZ4/UjMW9ecR673O2TT4lodUkYU3
         Pu36pXL8tvGNBTGBFyiFyeGl/nfBbV38Bt9pxmQCooHOINFzm08qchjnvob+MhQv75py
         g5mKZ3IjfQHjhK9bp4EuRvfJVqdH5jYIpLoZM4Xoa7FfTyCpjzN6I0GlCJftAzmGSx67
         0DLXtTXRueuBNkz0PomkiuUtjHMZfBIIF0pk3ibyp2MBGGU507fyI4p63q3Q20nt637E
         8ShQ==
X-Gm-Message-State: AC+VfDyfabLPrTeC7RZ2o3d0C4ZTQByKTtKoy08bFUHKJoQvtvHdE+f2
        /1fM4WNp6IXW/2iQY1ET69w8L1Kxhu5o
X-Google-Smtp-Source: ACHHUZ7R1CC0OSVS8g/0P1vzZZ3gyexPDHVj5wxcC6YMu764P99A+vF1FR2cVD8xlr3Hp979O/PgNurnppuJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:628b:7e78:d09b:39b])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2daa:b0:63b:8571:8109 with SMTP
 id fb42-20020a056a002daa00b0063b85718109mr429383pfb.3.1684335567322; Wed, 17
 May 2023 07:59:27 -0700 (PDT)
Date:   Wed, 17 May 2023 07:58:02 -0700
In-Reply-To: <20230517145803.559429-1-irogers@google.com>
Message-Id: <20230517145803.559429-23-irogers@google.com>
Mime-Version: 1.0
References: <20230517145803.559429-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 22/23] perf pmus: Avoid repeated sysfs scanning
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Raul Silvera <rsilvera@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
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

perf_pmus__scan will process every directory in sysfs to see if it is
a PMU, attempting to add it if not already in the pmus list. Add two
booleans to record whether this scanning has been done for core or all
PMUs. Skip scanning in the event that scanning has already occurred.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index fcd61bddffc3..331c6ad40504 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -14,6 +14,8 @@
 
 static LIST_HEAD(core_pmus);
 static LIST_HEAD(uncore_pmus);
+static bool read_sysfs_core_pmus;
+static bool read_sysfs_all_pmus;
 
 void perf_pmus__destroy(void)
 {
@@ -29,6 +31,8 @@ void perf_pmus__destroy(void)
 
 		perf_pmu__delete(pmu);
 	}
+	read_sysfs_core_pmus = false;
+	read_sysfs_all_pmus = false;
 }
 
 static struct perf_pmu *pmu_find(const char *name)
@@ -53,6 +57,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 {
 	struct perf_pmu *pmu;
 	int dirfd;
+	bool core_pmu;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -63,8 +68,15 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	if (pmu)
 		return pmu;
 
+	if (read_sysfs_all_pmus)
+		return NULL;
+
+	core_pmu = is_pmu_core(name);
+	if (core_pmu && read_sysfs_core_pmus)
+		return NULL;
+
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_pmus, dirfd, name);
+	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &uncore_pmus, dirfd, name);
 	close(dirfd);
 
 	return pmu;
@@ -73,6 +85,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
+	bool core_pmu;
 
 	/*
 	 * Once PMU is loaded it stays in the list,
@@ -83,7 +96,14 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	if (pmu)
 		return pmu;
 
-	return perf_pmu__lookup(is_pmu_core(name) ? &core_pmus : &uncore_pmus, dirfd, name);
+	if (read_sysfs_all_pmus)
+		return NULL;
+
+	core_pmu = is_pmu_core(name);
+	if (core_pmu && read_sysfs_core_pmus)
+		return NULL;
+
+	return perf_pmu__lookup(core_pmu ? &core_pmus : &uncore_pmus, dirfd, name);
 }
 
 /* Add all pmus in sysfs to pmu list: */
@@ -93,6 +113,9 @@ static void pmu_read_sysfs(bool core_only)
 	DIR *dir;
 	struct dirent *dent;
 
+	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
+		return;
+
 	fd = perf_pmu__event_source_devices_fd();
 	if (fd < 0)
 		return;
@@ -111,6 +134,12 @@ static void pmu_read_sysfs(bool core_only)
 	}
 
 	closedir(dir);
+	if (core_only) {
+		read_sysfs_core_pmus = true;
+	} else {
+		read_sysfs_core_pmus = true;
+		read_sysfs_all_pmus = true;
+	}
 }
 
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
-- 
2.40.1.606.ga4b1b128d6-goog

