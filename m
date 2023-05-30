Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205997159D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjE3JUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjE3JUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:20:06 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45111D;
        Tue, 30 May 2023 02:19:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vjt6nxN_1685438375;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vjt6nxN_1685438375)
          by smtp.aliyun-inc.com;
          Tue, 30 May 2023 17:19:40 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v3 0/7] Add JSON metrics for arm CMN and Yitian710 DDR
Date:   Tue, 30 May 2023 17:19:27 +0800
Message-Id: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Refact cmn identifier and use model and revision to form identifier.
- Let "Compat" support matching multiple identifier.
- Improved the ali_drw PMU event alias Brief Description.
- Update ali_drw PMU metric usage in documentation.

Changes since RFC:
- Refact arm-cmn PMU identifier.
- Not add arm-cmn PMU aliasing currently because it's Eventcode is
  difficult to define.
- Rename ali_drw PMU identifier and Unit name.
- Divide ali_drw PMU metric and aliasing into two patches.

Add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
allow userspace to identify the specific implementation of the device,
so that the perf tool can match the corresponding uncore events and
metrics through the identifier. Then added several general CMN metrics
and yitian710 soc DDR metrics and events alias.


$perf list:
...
ali_drw:
  chi_rxdat
       [A packet at CHI RXDAT interface (write data). Unit: ali_drw]
  chi_rxrsp
       [A packet at CHI RXRSP interface. Unit: ali_drw]
  chi_txdat
       [A packet at CHI TXDAT interface (read data). Unit: ali_drw]
  chi_txreq
       [A packet at CHI TXREQ interface (request). Unit: ali_drw]
  cycle
       [The ddr cycle. Unit: ali_drw]
...
arm_cmn:
  mc_message_retry_rate
       [The memory controller request retries rate indicates whether the memory controller is the bottleneck. Unit: arm_cmn ]
  rni_actual_read_bandwidth.all
       [This event measure the actual bandwidth(MB/sec) that RN-I bridge sends to the interconnect. Unit: arm_cmn ]
  rni_actual_write_bandwidth.all
       [This event measures the actual write bandwidth(MB/sec) at RN-I bridges. Unit: arm_cmn ]
  rni_retry_rate
       [RN-I bridge retry rate indicates whether the memory controller is the bottleneck. Unit: arm_cmn ]
  sbsx_actual_write_bandwidth.all
       [sbsx actual write bandwidth(MB/sec). Unit: arm_cmn ]
  sf_hit_rate
       [Snoop filter hit rate can be used to measure the Snoop Filter efficiency. Unit: arm_cmn ]
  slc_miss_rate
       [The system level cache miss rate include. Unit: arm_cmn ]
ali_drw:
  ddr_read_bandwidth.all
       [The ddr read bandwidth(MB/s). Unit: ali_drw ]
  ddr_write_bandwidth.all
       [The ddr write bandwidth(MB/s). Unit: ali_drw ]
...

$perf stat -M ddr_read_bandwidth.all ./test

Performance counter stats for 'system wide':

            38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
     1,000,957,941 ns   duration_time

       1.000957941 seconds time elapsed

Jing Zhang (7):
  driver/perf: Add identifier sysfs file for CMN
  perf metric: Event "Compat" value supports matching multiple
    identifiers
  perf vendor events: Add JSON metrics for CMN
  driver/perf: Add identifier sysfs file for Yitian 710 DDR
  perf jevents: Add support for Yitian 710 DDR PMU aliasing
  perf vendor events: Add JSON metrics for Yitian 710 DDR
  docs: perf: Update metric usage for Alibaba's T-Head PMU driver

 Documentation/admin-guide/perf/alibaba_pmu.rst     |   5 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
 drivers/perf/arm-cmn.c                             |  79 ++++-
 .../pmu-events/arch/arm64/arm/cmn/sys/metrics.json |  74 ++++
 .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
 .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
 tools/perf/pmu-events/jevents.py                   |   2 +
 tools/perf/util/metricgroup.c                      |  24 +-
 8 files changed, 595 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

-- 
1.8.3.1

