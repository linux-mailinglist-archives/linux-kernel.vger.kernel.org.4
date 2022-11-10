Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1257624A39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKJTFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiKJTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:05:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C91554EE;
        Thu, 10 Nov 2022 11:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668107108; x=1699643108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZQwrSB2+X62I7GSPlrHhddgBpmpr5maLKI6XtqxGQXw=;
  b=Jx/+/do6Cs7AheSVwiwMjgTLZdTkPiTP81+Fd+eJ5fmeur/lx2qde+pV
   wAzFNSHQiLIkq0jNsjF2nBjJvNpRvctDdfKywtoruL0x+ANWirygGxUeI
   ohmd5P8MpGAmDW4QdlTIJvDU4J4NgrhRA45NJVhVpQ1XgLHDecWW/QsSy
   C8a+NwaYuPBdfsGS5elJlZPaPSYkV7vxqKnbblDuTp7as0Jb19G7mgGYY
   G8JKPa326SxdMtjJQjuct6olofs9LCS+C26DZGYtkQQGEVnm7RQof4vzs
   6GkySvUv22P7YFcJmLimB8/oW+d6cr1h6fitaqk1At+CIXGBmTBMR0Nyc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375662045"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="375662045"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882473394"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="882473394"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.6.223])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 10:58:04 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH 00/11] CXL: Process event logs
Date:   Thu, 10 Nov 2022 10:57:47 -0800
Message-Id: <20221110185758.879472-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


This code is well tested with the changes to Qemu I've made (See Below).

The series is in 5 parts:

	0) Davidlohrs irq patch modified for 16 vectors
	1) Base functionality
	2) Parsing specific events (Dynamic Capacity Event Record is defered)
	3) Event interrupt support
	4) cxl-test infrastructure for basic tests

While I believe this entire series is ready to be merged I realize that the
interrupt support may still have some discussion around it.  Therefor parts 1,
2, and 4 could be merged without irq support as cxl-test provides testing for
that.  Interrupt testing requires Qemu but it too is fully tested and ready to
go.


Changes from RFC v2
	Integrated Davidlohr's irq patch, allocate up to 16 vectors, and base
		my irq support on modifications to that patch.
	Smita
		Check event status before reading each log.
	Jonathan
		Process more than 1 record at a time
		Remove reserved fields
	Steven
		Prefix trace points with 'cxl_'
	Davidlohr
		PUll in his patch

Changes from RFC v1
	Add event irqs
	General simplification of the code.
	Resolve field alignment questions
	Update to rev 3.0 for comments and structures
	Add reserved fields and output them

Event records inform the OS of various device events.  Events are not needed
for any kernel operation but various user level software will want to track
events.

Add event reporting through the trace event mechanism.  On driver load read and
clear all device events.

Enable all event logs for interrupts and process each log on interrupt.


TESTING:

Testing of this was performed with additions to QEMU in the following repo:

	https://github.com/weiny2/qemu/tree/ira-cxl-events-latest

Changes to this repo are not finalized yet so I'm not posting those patches
right away.  But there is enough functionality added to further test this.

	1) event status register
	2) additional event injection capabilities
	3) Process more than 1 record at a time in Get/Clear mailbox commands

Davidlohr Bueso (1):
  cxl/pci: Add generic MSI-X/MSI irq support

Ira Weiny (10):
  cxl/mem: Implement Get Event Records command
  cxl/mem: Implement Clear Event Records command
  cxl/mem: Clear events on driver load
  cxl/mem: Trace General Media Event Record
  cxl/mem: Trace DRAM Event Record
  cxl/mem: Trace Memory Module Event Record
  cxl/mem: Wire up event interrupts
  cxl/test: Add generic mock events
  cxl/test: Add specific events
  cxl/test: Simulate event log overflow

 MAINTAINERS                     |   1 +
 drivers/cxl/core/mbox.c         | 219 ++++++++++++++
 drivers/cxl/cxl.h               |   8 +
 drivers/cxl/cxlmem.h            | 191 +++++++++++++
 drivers/cxl/cxlpci.h            |   6 +
 drivers/cxl/pci.c               | 167 +++++++++++
 include/trace/events/cxl.h      | 487 ++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h    |   4 +
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 329 +++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 +
 tools/testing/cxl/test/mem.c    |  35 +++
 12 files changed, 1457 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/cxl.h
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h


base-commit: aae703b02f92bde9264366c545e87cec451de471
-- 
2.37.2

