Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB66D0BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjC3QuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjC3Qtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:49:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3B10257;
        Thu, 30 Mar 2023 09:48:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnTm4688zz67CtD;
        Fri, 31 Mar 2023 00:44:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 17:48:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 5/5] docs: perf: Minimal introduction the the CXL PMU device and driver
Date:   Thu, 30 Mar 2023 17:45:56 +0100
Message-ID: <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very basic introduction to the device and the current driver support
provided. I expect to expand on this in future versions of this patch
set.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
v4: No change
---
 Documentation/admin-guide/perf/cxl.rst   | 65 ++++++++++++++++++++++++
 Documentation/admin-guide/perf/index.rst |  1 +
 2 files changed, 66 insertions(+)

diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
new file mode 100644
index 000000000000..46235dff4b21
--- /dev/null
+++ b/Documentation/admin-guide/perf/cxl.rst
@@ -0,0 +1,65 @@
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
+The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
+
+    /sys/bus/cxl/device/cpmu<id>
+
+The associated PMU is registered as
+
+   /sys/bus/event_sources/devices/cpmu<id>
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
+  cpmu0/clock_ticks/                                 [Kernel PMU event]
+  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
+  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
+  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
+  -----------------------------------------------------------
+
+  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
+
+Vendor specific events may also be available and if so can be used via
+
+  $# perf stat -e cpmu0/vid=VID,gid=GID,mask=MASK/
+
+The driver does not support sampling. So "perf record" and attaching to
+a task are unsupported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9de64a40adab..f60be04e4e33 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -21,3 +21,4 @@ Performance monitor support
    alibaba_pmu
    nvidia-pmu
    meson-ddr-pmu
+   cxl
-- 
2.37.2

