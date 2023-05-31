Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC7717D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjEaLDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjEaLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:03:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F462E7B;
        Wed, 31 May 2023 04:02:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWRC14Bmsz6D905;
        Wed, 31 May 2023 19:01:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 12:02:42 +0100
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
Subject: [PATCH v8 5/5] docs: perf: Minimal introduction the the CXL PMU device and driver
Date:   Wed, 31 May 2023 12:00:11 +0100
Message-ID: <20230531110011.13963-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
References: <20230531110011.13963-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very basic introduction to the device and the current driver support
provided. I expect to expand on this in future versions of this patch
set.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v7
- Added explict -a to command line examples to make it obvious the
  counters apply only to all CPUs (no per thread or per process).
---
 Documentation/admin-guide/perf/cxl.rst   | 68 ++++++++++++++++++++++++
 Documentation/admin-guide/perf/index.rst |  1 +
 MAINTAINERS                              |  1 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
new file mode 100644
index 000000000000..9233ea0d0b10
--- /dev/null
+++ b/Documentation/admin-guide/perf/cxl.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+CXL Performance Monitoring Unit (CPMU)
+======================================
+
+The CXL rev 3.0 specification provides a definition of CXL Performance
+Monitoring Unit in section 13.2: Performance Monitoring.
+
+CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
+any number of CPMU instances. CPMU capabilities are fully discoverable from
+the devices. The specification provides event definitions for all CXL protocol
+message types and a set of additional events for things commonly counted on
+CXL devices (e.g. DRAM events).
+
+CPMU driver
+===========
+
+The CPMU driver registers a perf PMU with the name pmu_mem<X>.<Y> on the CXL bus
+representing the Yth CPMU for memX.
+
+    /sys/bus/cxl/device/pmu_mem<X>.<Y>
+
+The associated PMU is registered as
+
+   /sys/bus/event_sources/devices/cxl_pmu_mem<X>.<Y>
+
+In common with other CXL bus devices, the id has no specific meaning and the
+relationship to specific CXL device should be established via the device parent
+of the device on the CXL bus.
+
+PMU driver provides description of available events and filter options in sysfs.
+
+The "format" directory describes all formats of the config (event vendor id,
+group id and mask) config1 (threshold, filter enables) and config2 (filter
+parameters) fields of the perf_event_attr structure.  The "events" directory
+describes all documented events show in perf list.
+
+The events shown in perf list are the most fine grained events with a single
+bit of the event mask set. More general events may be enable by setting
+multiple mask bits in config. For example, all Device to Host Read Requests
+may be captured on a single counter by setting the bits for all of
+
+* d2h_req_rdcurr
+* d2h_req_rdown
+* d2h_req_rdshared
+* d2h_req_rdany
+* d2h_req_rdownnodata
+
+Example of usage::
+
+  $#perf list
+  cxl_pmu_mem0.0/clock_ticks/                        [Kernel PMU event]
+  cxl_pmu_mem0.0/d2h_req_rdshared/                   [Kernel PMU event]
+  cxl_pmu_mem0.0/h2d_req_snpcur/                     [Kernel PMU event]
+  cxl_pmu_mem0.0/h2d_req_snpdata/                    [Kernel PMU event]
+  cxl_pmu_mem0.0/h2d_req_snpinv/                     [Kernel PMU event]
+  -----------------------------------------------------------
+
+  $# perf stat -a -e cxl_pmu_mem0.0/clock_ticks/ -e cxl_pmu_mem0.0/d2h_req_rdshared/
+
+Vendor specific events may also be available and if so can be used via
+
+  $# perf stat -a -e cxl_pmu_mem0.0/vid=VID,gid=GID,mask=MASK/
+
+The driver does not support sampling so "perf record" is unsupported.
+It only supports system-wide counting so attaching to a task is
+unsupported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9de64a40adab..f60be04e4e33 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -21,3 +21,4 @@ Performance monitor support
    alibaba_pmu
    nvidia-pmu
    meson-ddr-pmu
+   cxl
diff --git a/MAINTAINERS b/MAINTAINERS
index 976b3e982d3a..5388b5c2e5bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5195,6 +5195,7 @@ COMPUTE EXPRESS LINK PMU (CPMU)
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/perf/cxl.rst
 F:	drivers/perf/cxl_pmu.c
 
 CONEXANT ACCESSRUNNER USB DRIVER
-- 
2.39.2

