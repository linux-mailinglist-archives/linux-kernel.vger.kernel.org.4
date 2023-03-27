Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A776C99AF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjC0Cqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0Cq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:46:27 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581144B1;
        Sun, 26 Mar 2023 19:46:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VeeqFMD_1679885175;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VeeqFMD_1679885175)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 10:46:23 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH RFC 0/4] Add JSON metrics for arm CMN and Yitian710 DDR
Date:   Mon, 27 Mar 2023 10:46:08 +0800
Message-Id: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
allow userspace to identify the specific implementation of the device,
so that the perf tool can match the corresponding uncore events and
metrics through the identifier. Then added several general CMN700 metrics
and yitian710 soc DDR metrics.

Since the eventid of cmn700 events is different from other events, it
can't be specified by "EventCode" or "ConfigCode", so in the cmn.json
file of cmn700, no "EventCode" and "ConfigCode" are added for these
events. For example, the eventid of "arm_cmn_0/hnf_sf_hit is/":
cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_sf_hit
type=0x5,eventid=0x6

In addition, both cmn700 and ddr PMU can count the information in a die,
but the same SoC can also be configured with different numbers of dies,
so it is dificult to design a general expression to obtain metrics in
different dies. The current yitian710 ddr bandwidth metric describes the
sum of all dies bandwidth. I would like to ask you, is there any general
expression can obtain metrics for die? Add an option to specify die?

Thanks,
Jing

Jing Zhang (4):
  driver/perf: Add identifier sysfs file for CMN
  perf vendor events: Add JSON metrics for cmn700
  driver/perf: Add identifier sysfs file for Yitian 710 DDR
  perf vendor events: Add JSON metrics for Yitian 710 DDR

 drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
 drivers/perf/arm-cmn.c                             |  43 +++
 .../pmu-events/arch/arm64/arm/cmn700/sys/cmn.json  | 188 +++++++++++
 .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
 .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
 .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
 tools/perf/pmu-events/jevents.py                   |   2 +
 7 files changed, 727 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json

-- 
1.8.3.1

