Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DD68B5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFGxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBFGxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:53:10 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F591125A9;
        Sun,  5 Feb 2023 22:53:07 -0800 (PST)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P9H0F1TRJzkXs9;
        Mon,  6 Feb 2023 14:48:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 14:53:03 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <jonathan.cameron@huawei.com>
CC:     <zhangshaokun@hisilicon.com>, <shenyang39@huawei.com>,
        <hejunhao3@huawei.com>, <yangyicong@hisilicon.com>,
        <prime.zeng@huawei.com>, <zhanjie9@hisilicon.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC PATCH v1 1/4] docs: perf: Add documentation for HiSilicon PMCU
Date:   Mon, 6 Feb 2023 14:51:43 +0800
Message-ID: <20230206065146.645505-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230206065146.645505-1-zhanjie9@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the overview and usage of HiSilicon PMCU.

HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
PMU accesses from CPUs, handling the configuration, event switching, and
counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
and multi-PMU-event CPU profiling, in which scenario the current 'perf'
scheme may lose events or drop sampling frequency. With PMCU, users can
reliably obtain the data of up to 240 PMU events with the sample interval
of events down to 1ms, while the software overhead of accessing PMUs, as
well as its impact on target workloads, is reduced.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 Documentation/admin-guide/perf/hisi-pmcu.rst | 183 +++++++++++++++++++
 Documentation/admin-guide/perf/index.rst     |   1 +
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pmcu.rst

diff --git a/Documentation/admin-guide/perf/hisi-pmcu.rst b/Documentation/admin-guide/perf/hisi-pmcu.rst
new file mode 100644
index 000000000000..50d17cbd0049
--- /dev/null
+++ b/Documentation/admin-guide/perf/hisi-pmcu.rst
@@ -0,0 +1,183 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
+HiSilicon Performance Monitor Control Unit
+==========================================
+
+Introduction
+============
+
+HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
+PMU accesses from CPUs, handling the configuration, event switching, and
+counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
+and multi-PMU-event CPU profiling, in which scenario the current ``perf``
+scheme may lose events or drop sampling frequency. With PMCU, users can
+reliably obtain the data of up to 240 PMU events with the sample interval
+of events down to 1ms, while the software overhead of accessing PMUs, as
+well as its impact on target workloads, is reduced.
+
+Each CPU die is equipped with a PMCU device. The PMCU driver registers it as a
+PMU device, named as ``hisi_pmcu_sccl<N>``, where ``<N>`` is the corresponding
+CPU die ID. When triggered, PMCU reads event IDs and pass them to PMUs in all
+CPUs on the CPU die it is on. PMCU then starts the counters for counting
+events, waits for a time interval, and stops them. The PMU counter readings are
+dumped from hardware to memory, i.e. perf AUX buffers, and further copied to
+the ``perf.data`` file in the user space. PMCU automatically switches events
+(when there are more events than available PMU counters) and completes multiple
+rounds of PMU event counting in one trigger.
+
+Hardware overview
+=================
+
+On Kunpeng SoC, each CPU die is equipped with a PMCU device. PMCU acts like an
+assistant to access the core PMUs on its die and move the counter readings to
+memory. An overview of PMCU's hardware organization is shown below::
+
+                                +--------------------+
+                                |       Memory       |
+                                | +------+ +-------+ |
+                   +--------+   | |Events| |Samples| |
+                   |  PMCU  |   | +------+ +-------+ |
+                   +---|----+   +---------|----------+
+                       |                  |
+        =======================================================  Bus
+                   |                         |               |
+        +----------|----------+   +----------|----------+    |
+        | +------+ | +------+ |   | +------+ | +------+ |    |
+        | |Core 0| | |Core 1| |   | |Core 0| | |Core 1| |    |
+        | +--|---+ | +--|---+ |   | +--|---+ | +--|---+ |  (More
+        |    +-----+----+     |   |    +-----+----+     |  clusters
+        | +--|---+   +--|---+ |   | +--|---+   +--|---+ |  ...)
+        | |Core 2|   |Core 3| |   | |Core 2|   |Core 3| |
+        | +------+   +------+ |   | +------+   +------+ |
+        |    CPU Cluster 0    |   |    CPU Cluster 1    |
+        +---------------------+   +---------------------+
+
+On Kunpeng SoC, a CPU die is formed of several CPU clusters and several
+CPUs per cluster. PMCU is able to access the core PMUs in these CPUs.
+The main job of PMCU is to fetch PMU event IDs from memory, make PMUs count the
+events for a while, and move the counter readings back to memory.
+
+Once triggered, PMCU performs a number of loops and processes a number of
+events in each loop. It fetches ``nr_pmu`` events from memory at a time, where
+``nr_pmu`` denotes the number of PMU counters to be used in each CPU. The
+``nr_pmu`` events are passed to the PMU counters of all CPUs on the CPU die
+where PMCU resides. Then, PMCU starts all the counters, waits for a period,
+stops all the counters, and moves the counter readings to memory, before
+handling the next ``nr_pmu`` events if there are more events to process in this
+loop. The number of loops and ``nr_pmu`` are determined by the driver, whereas
+the number of events to process depends on user inputs. The counters are
+stopped when PMCU reads counters and switches events, so there is a tiny time
+window during which the events are not counted.
+
+Usage
+=====
+
+The PMCU driver is designed to operate with the kernel perf_event framework,
+specifically with perf AUX trace buffer to dump sample data faster. User space
+usage of PMCU is supported through the 'perf' tool and root access is required.
+
+Steps:
+
+1. Write PMU event IDs to PMCU's ``sysfs`` event interface. The event IDs should
+   be hexadecimal and separated by whitespaces.
+
+   An example command can be::
+
+        echo "0x10 0x11" > /sys/devices/hisi_pmcu_sccl3/user_events
+
+   Alternatively, users can directly write the ``user_events`` file with a text
+   editor.
+
+   Please note that:
+
+   - As PMCU passes event IDs to core PMUs, any event IDs supported by the core
+     PMU are acceptible.
+   - Users can enter up to 240 events; any events beyond that are ignored.
+   - The event IDs remain unchanged until the next update of the file, such that
+     users do not have to enter the event IDs every time before issuing a
+     ``perf-record`` command for the same events.
+
+2. Profiling with ``perf-record``.
+
+   The command to start the sampling is::
+
+        perf record -e hisi_pmcu_sccl3/<configs>/
+
+   Users can pass the following optional parameters to ``<configs>``:
+
+   - nr_sample: number of samples to take. This defaults to 128.
+   - sample_period_ms: time interval in microseconds for PMU counters to keep
+     counting for each event. This defaults to 3, i.e. 3ms, and its max
+     value is 85,899, i.e. 85 seconds.
+   - pmccfiltr: bits 31-24 of the sysreg PMCCFILTR_EL0, which controls how the
+     cycle counter increments. This defaults to 0x00. Please refer to the
+     "Performance Monitors external register descriptions" of *Arm Architecture
+     Reference Manual for A-profile architecture* on how to configure
+     PMCCFILTR_EL0.
+
+   An example command can be::
+
+        perf record -e hisi_pmcu_sccl3/nr_sample=1000,sample_period_ms=1000/
+
+3. Obtain the sample data
+
+   When the ``perf-record`` command finishes, data will be stored in the AUX
+   area of ``perf.data``. The data can be viewed with ``perf-report`` or
+   ``perf-script`` with the ``-D`` dump trace option, e.g.::
+
+        perf report -D
+
+   Users may search the keyword ``HISI PMCU`` to navigate to the PMCU data
+   section.
+
+   PMCU samples are arranged in the following format::
+
+        +------------+  +- +--------+  +- +-----------+  +- +------------+
+        |AUX buffer 0|->|  |Sample 1|->|  |Subsample 1|->|  |CID1SR      |--+
+        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
+        |AUX buffer 1|  |  |Sample 2|  |  |Subsample 2|  |  |CID2SR      |  |
+        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
+        |...         |  |  |...     |  |  |...        |  |  |Event 0     |  |
+        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
+                        |  |  Gap   |  |  |Subsample N|  |  |Event 1     |  |
+                        +- +--------+  +- +-----------+  |  +------------+  |
+                                                         |  |...         |  |
+                                                         |  +------------+  |
+                                                         |  |Event nr_pmu|  |
+                                                         |  +------------+  |
+                                                         |  |Cycle count |  |
+                                                         +- +------------+  |
+        +-------------------------------------------------------------------+
+        |  +- +------------------+  +- +---------+
+        +->|  |CPU 0 in a cluster|->|  |Cluster 0|
+           |  +------------------+  |  +---------+
+           |  |CPU 1 in a cluster|  |  |Cluster 1|
+           |  +------------------+  |  +---------+
+           |  |CPU 2 in a cluster|  |  |Cluster 2|
+           |  +------------------+  |  +---------+
+           |  |...               |  |  |...      |
+           +- +------------------+  +- +---------+
+
+   The data may contain one or more AUX buffers. An AUX buffer contains many
+   samples, and may probably leave a gap at the buffer tail where there is no
+   space for a complete sample. The number of samples in all AUX buffers sums
+   up to the 'nr_sample' parameter passed from the 'perf-record' command.
+
+   A sample contains the events entered in the ``users_events`` sysfs file. A
+   sample may consist of multiple subsamples if the number of events is more
+   than the number of PMU counters used, i.e. ``nr_pmu``. The number of
+   subsamples in a sample, ``N``, equals to a round up of the number of event
+   divided by ``nr_pmu``.
+
+   A subsample consists of data fields of CID1SR, CID2SR, ``nr_pmu`` event
+   counter readings, and a cycle counter reading. CID1SR and CID2SR are a copy
+   of PMCID1SR and PMCID2SR on capture of the event counters, which reflects
+   the process ID, provided that the kernel compiling configuration
+   ``CONFIG_PID_IN_CONTEXTIDR`` is enabled. The size of CID1SR or CID2SR is 4
+   bytes, whereas the size of an event or cycle count is 8 bytes. A data field
+   has the data from all CPUs. The order of CPUs in a data field is 'CPU ID in
+   a cluster' -> 'cluster ID'. For example, a CPU die with 32 CPUs in 4
+   clusters (8 CPUs per cluster) has the data field ordered in::
+
+       CPU [0,8,16,24],[1,9,17,25],[2,10,18,26],...,[7,15,23,31]
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 793e1970bc05..f132838145f9 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -8,6 +8,7 @@ Performance monitor support
    :maxdepth: 1
 
    hisi-pmu
+   hisi-pmcu
    hisi-pcie-pmu
    hns3-pmu
    imx-ddr
-- 
2.30.0

