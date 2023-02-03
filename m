Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFB688CA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBCBkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBCBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:40:31 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5548715F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:40:30 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-50660dd3263so37211077b3.19
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 17:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MyChsJPTVsY2fOwG/RI8qO+kUTadsY5ao3Rn6oLubwI=;
        b=q2Lfvwgba5mI01dB8lALvFJm9eJ5L6qh+bqk0DX7YFrZLVCPPEc4ohuNsRgVz/DWoa
         45p4NxjS5Tc1u5rhYtkOxutMSFfev883SPN6LLMTF+pVdMycr5bePuiA4UIRHQz5bmMG
         zRiiSUVv2IaBHwMxrZbglAbdEKlQmmqfuwY5AFdTVPB9cpJ0EZxRn/4K85quJOTCZpi5
         HE78n6XyxSyGucpzxCPCE77mwn66EGwiwRzQEtgwgENOIvH68rrdkfdOIYL+WWSM3dAE
         t4gePGaLe1+Ey+the2P/FX3skvPyNc0yYktf4Ltxq559JXe8PAfMYwDOsSj+u3GdckiS
         ay/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MyChsJPTVsY2fOwG/RI8qO+kUTadsY5ao3Rn6oLubwI=;
        b=6n0ZTwAjTnovaniXh9TjJo0oixbdlNV/XMRfMZNEKweTYljvpOuH156LwRG25EWg3i
         VnK05pqk6mZt2nhCxHlfMWnr8pI3cS388Hi6WIGI/mEI2i7wG5+oWpa2uXu3McXZLi88
         Qq7DjIykO/XKtIXLADm84draQ5Z7J609L11x0RsrOd8ndJupfx6mLHrUwINFYpXNDn6U
         oSyYlgjbCESOqJz3mnlDa8nHG7o+ltUzJriXhgjdfRKPJT5ZsCBEzIslryKuDLQnJv9N
         6cK80ZXTMX4OOIB2WJ4G1TcH7BcjAjb1PDPqO96TmsuAZN4q1P4RzlQGxxI6UudrQFRp
         9yJw==
X-Gm-Message-State: AO0yUKWTF0vcQztEA0IkqKpSzzx32CAKluTSDVF3UXVNWFhTlxhZ4S0k
        ZEvGOZDw3Zj8vhgPNgKlwN/E75y/e5r5
X-Google-Smtp-Source: AK7set+0if6+qdzHg851jcAQ62KbEMrh7klQns415GjdzZzFFKMRMIpJ8w8d4/avuCsLvwLct18dnu+GKXDH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bb5:4c1f:1143:605])
 (user=irogers job=sendgmr) by 2002:a25:d749:0:b0:833:79ab:566a with SMTP id
 o70-20020a25d749000000b0083379ab566amr906826ybg.27.1675388429315; Thu, 02 Feb
 2023 17:40:29 -0800 (PST)
Date:   Thu,  2 Feb 2023 17:40:14 -0800
Message-Id: <20230203014014.75720-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] perf pmu: Fix aarch64 build
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 overrides a weak function but a previous change had broken the
build.

Fixes: 8cefeb8bd336 ("perf pmu-events: Introduce pmu_metrics_table")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 2779840d8896..fa143acb4c8d 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -22,6 +22,8 @@ static struct perf_pmu *pmu__find_core_pmu(void)
 			return NULL;
 
 		return pmu;
+	}
+	return NULL;
 }
 
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
-- 
2.39.1.519.gcb327c4b5f-goog

