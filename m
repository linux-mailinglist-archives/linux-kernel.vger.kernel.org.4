Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57D6E04CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDMCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjDMCn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:43:59 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC6A975B;
        Wed, 12 Apr 2023 19:42:23 -0700 (PDT)
X-UUID: d4484bf074f34390b299ccb99f0e623c-20230413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e0c32863-e873-45c1-8f99-234f217fd3d2,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.22,REQID:e0c32863-e873-45c1-8f99-234f217fd3d2,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:120426c,CLOUDID:769dc9ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230413104130W0VYEQ1F,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d4484bf074f34390b299ccb99f0e623c-20230413
X-User: zenghao@kylinos.cn
Received: from zdzh5-qitianm428-a376.. [(116.128.244.169)] by mailgw
        (envelope-from <zenghao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 135028584; Thu, 13 Apr 2023 10:41:28 +0800
From:   Hao Zeng <zenghao@kylinos.cn>
To:     linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, james.clark@arm.com,
        suzuki.poulose@arm.com, ravi.bangoria@amd.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, Hao Zeng <zenghao@kylinos.cn>
Subject: [PATCH] perf pmu: Fix resource leaks in pmu_cpumask()
Date:   Thu, 13 Apr 2023 10:41:25 +0800
Message-Id: <20230413024125.3082418-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_pmu__open_file() and perf_cpu_map__read()
are called to process the file,but the file is not closed,
which may cause a file handle leak.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 tools/perf/util/pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c256b29defad..3b4d2f531d83 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -583,6 +583,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 		if (!file)
 			continue;
 		cpus = perf_cpu_map__read(file);
+		fclose(file);
 		if (cpus)
 			return cpus;
 	}
-- 
2.37.2


No virus found
		Checked by Hillstone Network AntiVirus
