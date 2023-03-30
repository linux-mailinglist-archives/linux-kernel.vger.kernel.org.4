Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EA6D0B92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjC3Qp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjC3Qpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:45:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81290CDE7;
        Thu, 30 Mar 2023 09:45:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnTlW2xy2z6J7Kb;
        Fri, 31 Mar 2023 00:44:07 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 17:45:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>
CC:     <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 0/5] CXL 3.0 Performance Monitoring Unit support
Date:   Thu, 30 Mar 2023 17:45:51 +0100
Message-ID: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
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

Changes since v3: Kan Liang gave feedback on v2 incorporated here.
- All updates in patch 4, see details there.

Updated cover letter.

The CXL rev 3.0 specification introduces a CXL Performance Monitoring
Unit definition. CXL components may have any number of these blocks. The
definition is highly flexible, but that does bring complexity in the
driver.

Notes.

1) The QEMU model against which this was developed needs tidying up.
   Latest tree at https://gitlab.com/jic23/qemu branch cxl-2023-02-28
   It's backed up behind other series that I plan to upstream first.
2) There are quite a lot of corner cases that will need working through
   with variants of the model, or I'll have to design a pathological
   set of CPMUs to hit all the corner cases in one go. So whilst I believe
   the driver should be fine for what it supports we may find issues
   as those corners of what is allowed are explored.
3) I'm not sure it makes sense to hang this of the cxl/pci driver but
   couldn't really figure out where else in the current structure we could
   make it fit cleanly.
4) Driver location. In past perf maintainers have requested perf drivers
   for PCI etc be under drivers/perf. That would require moving some
   CXL headers to be more generally visible, but is certainly possible
   if there is agreement between CXL and perf maintainers on the correct
   location.
5) Patch 1 led to a discussion of how to handle the self describing
   and extensible nature of the CPMU counters.  That is likely to involve
   a description in the "caps" sysfs directory and perf tool code that is
   aware of the different event combinations that make sense and can
   establish which sets are available on a given device.
   That is likely to take a while to converge on, so as the driver is useful
   in the current state, I'm looking to upstream this first and deal with
   the more complex handling later.
6) There is a lot of other functionality that can be added in future
   include allowing for simpler hardware implementations that may not
   support the minimum level of features currently required by the driver
   (freeze, overflow interrupts etc).

CXL rev 3.0 specification available from https://www.computeexpresslink.org


Jonathan Cameron (5):
  cxl: Add function to count regblocks of a given type
  perf: Allow a PMU to have a parent
  cxl/pci: Find and register CXL PMU devices
  cxl: CXL Performance Monitoring Unit driver
  docs: perf: Minimal introduction the the CXL PMU device and driver

 Documentation/admin-guide/perf/cxl.rst   |  65 ++
 Documentation/admin-guide/perf/index.rst |   1 +
 drivers/cxl/Kconfig                      |  13 +
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   1 +
 drivers/cxl/core/cpmu.c                  |  72 ++
 drivers/cxl/core/pci.c                   |   2 +-
 drivers/cxl/core/port.c                  |   4 +-
 drivers/cxl/core/regs.c                  |  50 +-
 drivers/cxl/cpmu.c                       | 940 +++++++++++++++++++++++
 drivers/cxl/cpmu.h                       |  56 ++
 drivers/cxl/cxl.h                        |  17 +-
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/pci.c                        |  27 +-
 include/linux/perf_event.h               |   1 +
 kernel/events/core.c                     |   1 +
 17 files changed, 1245 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/cpmu.c
 create mode 100644 drivers/cxl/cpmu.c
 create mode 100644 drivers/cxl/cpmu.h

-- 
2.37.2

