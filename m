Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54C6A9DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCCRu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjCCRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:50:28 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EC028206;
        Fri,  3 Mar 2023 09:50:25 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSwRZ3R0Fz6J9fR;
        Sat,  4 Mar 2023 01:47:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 17:50:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] CXL 3.0 Performance Monitoring Unit support
Date:   Fri, 3 Mar 2023 17:50:18 +0000
Message-ID: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was some interest in CPMU support on the monthly sync call, so
time to revisit this. The general CXL driver interrupt handling question
has now been resolved, so this is pretty separable from everything else
going on in CXL land.

Since RFC v3: 
 - Simplified registration as no longer need the dynamic interrupt
   discovery dance as upstream driver is just enabling lots of interrupts :)
 - Various minor things (I forgot to take note).

Updated cover letter:

The CXL rev 3.0 specification introduces a CXL Performance Monitoring
Unit definition. CXL components may have any number of these blocks. The
definition is highly flexible, but that does bring complexity in the
driver.

One big question - how do we expose discoverable counters when we don't know
what they are? (just VID, Group ID and Mask)

A few things to note.

1) The QEMU model against which this was developed needs tidying up and
   review for correctness. Latest tree at
   https://gitlab.com/jic23/qemu branch cxl-2023-02-28
   It's backed up behind other series that I plan to upstream first.
2) There are quite a lot of corner cases that will need working through
   with variants of the model, or I'll have to design a pathological
   set of CPMUs to hit all the corner cases in one go.  So whilst I 'think'
   the driver should be fine for what it supports, I may have missed
   something.
3) I'm not sure it makes sense to hang this of the cxl/pci driver but
   couldn't really figure out where else in the current structure we could
   make it fit cleanly.
4) I'm not sure how to expose to user space the sets of events that may
   be summed (given by a mask in the Counter Event Capabilities registers).
   For now the driver advertises the individual events. Each individual
   event may form part of multiple overlapping groups for example.
   It may be a case of these allowed combinations only being discoverable
   by requesting a combination and checking for errors on start.
5) Related to that, how do we deal with the discoverable nature of vendor
   defined events?  The CPMU is fully discoverable down to a VID / Group ID
   and mask that sets which group elements can be used. I can't find any
   similar drivers.
6) Driver location. In past perf maintainers have requested perf drivers
   for PCI etc be under drivers/perf. That would require moving some
   CXL headers to be more generally visible, but is certainly possible
   if there is agreement between CXL and perf maintainers on the correct
   location.
7) Documentation needs improving, but I didn't want to spend too much
   time on that whilst we have so many open questions.  I'll separately
   raise the question about pmu->dev parenting which is mentioned in the
   Docs patch introduction. (oops - haven't done that yet)

CXL rev 3.0 specification available from https://www.computeexpresslink.org

Based on mainline as of earlier today.

Jonathan Cameron (4):
  cxl: Add function to count regblocks of a given type.
  cxl/pci: Find and register CXL PMU devices
  cxl: CXL Performance Monitoring Unit driver
  docs: perf: Minimal introduction the the CXL PMU device and driver.

 Documentation/admin-guide/perf/cxl.rst   |  65 ++
 Documentation/admin-guide/perf/index.rst |   1 +
 drivers/cxl/Kconfig                      |  12 +
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   3 +
 drivers/cxl/core/cpmu.c                  |  69 ++
 drivers/cxl/core/pci.c                   |   2 +-
 drivers/cxl/core/port.c                  |   4 +-
 drivers/cxl/core/regs.c                  |  50 +-
 drivers/cxl/cpmu.c                       | 943 +++++++++++++++++++++++
 drivers/cxl/cxl.h                        |  17 +-
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/pci.c                        |  27 +-
 14 files changed, 1188 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/cpmu.c
 create mode 100644 drivers/cxl/cpmu.c

-- 
2.37.2

