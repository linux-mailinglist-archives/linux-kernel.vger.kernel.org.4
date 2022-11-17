Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9328062DAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiKQM30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiKQM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:01 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD871F27
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668688127; x=1700224127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DtN4CkXkt6eq5LzrsmnWO65yn0Pr82pVWRG0Hofj8BI=;
  b=LuHt3y6tyG4ZqnmAmTIJiVtJOxXtvjv1cV7KX1a5hAhlb5l/RjhomErS
   GG8r+1GWhGo1hY8q3Ez2vK/od7eKvMH4SMNm2uoPhEiIn+OSi3H9wenww
   QOpPRcExiYpjBmcIAr+02Mb3qCJwyLB+lbLC8GEb08knq27ZGnZrhR135
   bpZwYuB/oGRCqfy2Wf8+Hn5h8esHdmiLCLcW7Nz+vNvSC/AGjmsBK0RsN
   X+XnugG7JLxWnmfFzmiAHTVg+QsUvKPblBnAI2eNHV/wAdSIWIDb8V1z7
   lQ5OrmJclV7VQfC6l4edq2h0r8V0Wj2SQOGR3mN97qCWNB4XOnfwS4u+T
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296199865"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296199865"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 04:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590604550"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590604550"
Received: from jfdev013vml03.jf.intel.com ([10.23.26.52])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2022 04:28:46 -0800
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     kan.liang@linux.intel.com, alexey.v.bayduraev@linux.intel.com,
        alexander.antonov@linux.intel.com
Subject: [PATCH 00/11] UPI topology discovery for SKX/ICX/SPR
Date:   Thu, 17 Nov 2022 12:28:22 +0000
Message-Id: <20221117122833.3103580-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Starting with the Intel Xeon Scalable family, Intel processors use a
coherent interconnect for scaling to multiple sockets, known as Intel
Ultra Path Interconnect (Intel UPI). The Intel UPI technology provides
a cache-coherent socket-to-socket external communication interface between
processors.

Unfortunately, users have little idea on how sockets are connected to
each other. This patchset extends the current mapping implementation by
adding sysfs attributes for UPI PMON blocks in the same manner as was
done for IIO blocks. These attributes reveal the topology of the system
by showing which how sockets and UPI controllers are connected to each
other.

Example for a 4-socket Sapphire Rapids server:

# tail /sys/devices/uncore_upi_*/die*
==> /sys/devices/uncore_upi_0/die0 <==
upi_1,die_1

==> /sys/devices/uncore_upi_0/die1 <==
upi_0,die_3

==> /sys/devices/uncore_upi_0/die2 <==
upi_1,die_3

==> /sys/devices/uncore_upi_0/die3 <==
upi_0,die_1

==> /sys/devices/uncore_upi_1/die0 <==
upi_1,die_2

==> /sys/devices/uncore_upi_1/die1 <==
upi_0,die_0

==> /sys/devices/uncore_upi_1/die2 <==
upi_1,die_0

==> /sys/devices/uncore_upi_1/die3 <==
upi_0,die_2

==> /sys/devices/uncore_upi_2/die0 <==
upi_2,die_3

==> /sys/devices/uncore_upi_2/die1 <==
upi_2,die_2

==> /sys/devices/uncore_upi_2/die2 <==
upi_2,die_1

==> /sys/devices/uncore_upi_2/die3 <==
upi_2,die_0

The following output:
# cat /sys/devices/uncore_upi_X/dieY
upi_Z,die_W
means that UPI link number X on die Y is connected to UPI link Z on die W.

Changes are splitted into two separate parts:
1. kernel part - adds and fills new sysfs attributes for UPI PMON blocks
2. perf-tool part - enables UPI topology info and per-link UPI metrics for
'perf iostat' mode. See example below.

The 'perf iostat list' will be extend to show IIO and UPI mappings, for example:

# perf iostat list
S0-uncore_iio_0<0000:00>
S1-uncore_iio_0<0000:80>
S0-uncore_iio_1<0000:17>
S1-uncore_iio_1<0000:85>
S0-uncore_iio_2<0000:3a>
S1-uncore_iio_2<0000:ae>
S0-uncore_iio_3<0000:5d>
S1-uncore_iio_3<0000:d7>
UPI Link 0 on Socket 0 -> UPI Link 1 on Socket 1
UPI Link 0 on Socket 1 -> UPI Link 1 on Socket 0
UPI Link 1 on Socket 0 -> UPI Link 0 on Socket 1
UPI Link 1 on Socket 1 -> UPI Link 0 on Socket 0

The 'perf iostat upi' mode will be added to show per-link UPI metrics:
# perf iostat upi
                                            link            Outgoing Data(GB)      Outgoing Non-Data(GB)
UPI Link 0 on Socket 0 -> UPI Link 1 on Socket 1                    0                      0
UPI Link 0 on Socket 1 -> UPI Link 1 on Socket 0                    0                      0
UPI Link 1 on Socket 0 -> UPI Link 0 on Socket 1                    0                      0
UPI Link 1 on Socket 1 -> UPI Link 0 on Socket 0                    0                      0

       1.437023089 seconds time elapsed

Alexander Antonov (11):
  perf/x86/intel/uncore: Generalize IIO topology support
  perf/x86/intel/uncore: Introduce UPI topology type
  perf/x86/intel/uncore: Clear attr_update properly
  perf/x86/intel/uncore: Disable I/O stacks to PMU mapping on ICX-D
  perf/x86/intel/uncore: Generalize get_topology() for SKX PMUs
  perf/x86/intel/uncore: Enable UPI topology discovery for Skylake
    Server
  perf/x86/intel/uncore: Get UPI NodeID and GroupID
  perf/x86/intel/uncore: Enable UPI topology discovery for Icelake
    Server
  perf/x86/intel/uncore: Enable UPI topology discovery for Sapphire
    Rapids
  perf/x86/intel/uncore: Update sysfs-devices-mapping file
  perf/x86/intel/uncore: Make set_mapping() procedure void

 .../ABI/testing/sysfs-devices-mapping         |  30 +-
 arch/x86/events/intel/uncore.h                |  24 +-
 arch/x86/events/intel/uncore_snbep.c          | 492 +++++++++++++++---
 3 files changed, 480 insertions(+), 66 deletions(-)


base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
-- 
2.25.1

