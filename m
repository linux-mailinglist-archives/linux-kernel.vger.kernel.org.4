Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48671717D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjEaLAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjEaLAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:00:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E8107;
        Wed, 31 May 2023 04:00:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWR8449PVz67hPh;
        Wed, 31 May 2023 18:58:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 12:00:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Namhyung Kim <namhyung@gmail.com>,
        Liang Kan <kan.liang@linux.intel.com>,
        <linux-cxl@vger.kernel.org>, <peterz@infradead.org>
CC:     <mingo@reresetdhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v8 0/5] perf: CXL 3.0 Performance Monitoring Unit support
Date:   Wed, 31 May 2023 12:00:06 +0100
Message-ID: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v8:
 - Typo fixes (thanks Namhyung Kim)
 - Question around allowing reading of uncore events from anywhere in
   the system left as future work as suggested.

Dan Williams has expressed that he is happy to take this through the CXL
tree once drivers/perf reviewers are happy with the perf aspects.

Will Deacon replied to v6 to say that whilst he and Mark Rutland try to
review as much as possible under drivers/perf/ in this case they are happy
for the code to go through the CXL tree to avoid them becoming a bottleneck.

Obviously any additional review is still welcome, but if time doesn't
allow, Dan, can you pick this up through CXL for 6.5?

Patch 1/5 is also present in the series:
[PATCH 00/32] Add parents to struct pmu -> dev
which may merge first.

Updated introduction

The CXL rev 3.0 specification introduces a CXL Performance Monitoring
Unit definition. CXL components may have any number of these blocks. The
definition is highly flexible, but that does bring complexity in the
driver. All instances are self describing, though for vendor defined
events we expect mapping from numeric values to counter names to be
performed in userspace tooling. In common with many CXL features,
this driver precedes any announced hardware (that I'm aware of anyway!).  

Supported features are:
- Devices that allow counters to be written when frozen (allows
  a single register write to start / stop all counters).
- Fixed purpose counters
- Configurable counters
- CXL specification defined events + HDM filters.

This initial series covers a useful subset of functionality and is
expected to be followed by patch series addressing:
* Discoverability beyond fine grained events. This will cover both
  vendor defined events and providing perf tool with the visibility
  to be able construct 'summed' events.  For example if a single
  counter can cover all host to device read traffic.
  Perf tool patches will use this information and appropriate schema
  to present a richer set of countable events.
* CXL PMU instances on Upstream and Downstream CXL switch ports
  and root ports.
* Free running counters. Often used for vendor defined debug type
  events and error counters.  Likely to appear on real devices.
* Devices without interrupt support for overflow.
* Devices that don't support freeze (counters need to be enabled
   individually).

Exact priority order for the above features will depend on early
hardware though (a) will definitely be top of the list as any
likely hardware will be able to take advantage of that feature.

Notes.

1) The QEMU model against which this was developed needs tidying up.
   Latest tree at https://gitlab.com/jic23/qemu branch cxl-2023-02-28
   It's backed up behind other series that I plan to upstream first.
2) V1 led to a discussion of how to handle the self describing
   and extensible nature of the CPMU counters.  That is likely to involve
   a description in the "caps" sysfs directory and perf tool code that is
   aware of the different event combinations that make sense and can
   establish which sets are available on a given device.
   That is likely to take a while to converge on, so as the driver is useful
   in the current state, I'm looking to upstream this first and deal with
   the more complex handling later.
3) There is a lot of other functionality that can be added in future
   include allowing for simpler hardware implementations that may not
   support the minimum level of features currently required by the driver
   (freeze, overflow interrupts etc).
4) Adding support for ports will require solving msi/msix vector requests
   from portdrv and how to pass those to the CXL port drivers. (or some
   other way to instantiate the CXL PMU devices.) RFC on that to follow.

CXL rev 3.0 specification available from https://www.computeexpresslink.org

Jonathan Cameron (5):
  perf: Allow a PMU to have a parent
  cxl: Add functions to get an instance of / count regblocks of a given
    type
  cxl/pci: Find and register CXL PMU devices
  perf: CXL Performance Monitoring Unit driver
  docs: perf: Minimal introduction the the CXL PMU device and driver

 Documentation/admin-guide/perf/cxl.rst   |  68 ++
 Documentation/admin-guide/perf/index.rst |   1 +
 MAINTAINERS                              |   7 +
 drivers/cxl/Kconfig                      |  13 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   1 +
 drivers/cxl/core/pmu.c                   |  68 ++
 drivers/cxl/core/port.c                  |   2 +
 drivers/cxl/core/regs.c                  |  75 +-
 drivers/cxl/cxl.h                        |  16 +
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/pci.c                        |  26 +-
 drivers/cxl/pmu.h                        |  28 +
 drivers/perf/Kconfig                     |  13 +
 drivers/perf/Makefile                    |   1 +
 drivers/perf/cxl_pmu.c                   | 990 +++++++++++++++++++++++
 include/linux/perf_event.h               |   1 +
 kernel/events/core.c                     |   1 +
 18 files changed, 1306 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/pmu.c
 create mode 100644 drivers/cxl/pmu.h
 create mode 100644 drivers/perf/cxl_pmu.c

-- 
2.39.2

