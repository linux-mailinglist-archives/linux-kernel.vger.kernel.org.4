Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3D163E67A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLAA1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLAA1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBF5803E;
        Wed, 30 Nov 2022 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669854448; x=1701390448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DNX3WxwJVVhAyY+gP2btOneyIgKiZaVH8GpVBETvHjA=;
  b=Dfcq9Q10pAEQfwS8BJnBJEuMsq3ie7XQtfG6zdhUInOQTjqmH3CwZEr5
   EOoNsesLHUXjGY+4N1HW0cjpUtbEm0Djqv3+THPW8G74faavEC6HNqjcM
   fTithaxwyQFugmT413/Y/Y4F9FtS3d8aIDIYQGraKnPrfEgMWbldtMiie
   e3kwGUqyrT9UGDM+yWKxZum90BzotHR3jwp+sRakgLh6wDgHMDMxLCtXW
   rJOOES/B2t0VC6IHB4SLGQYipBVzKK4Iv1apHFC8FUKw9NyCJXflewVrM
   8rKuNA7ssAoeypixVYw/Z0+UnogQsvPRTjq6VGTiU6wT1n6ziPHmc5UiK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="317400816"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="317400816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="622085198"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="622085198"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.251.1.240])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:27:25 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V2 00/11] CXL: Process event logs
Date:   Wed, 30 Nov 2022 16:27:08 -0800
Message-Id: <20221201002719.2596558-1-ira.weiny@intel.com>
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

Changes from V1
	Address comments, from Jonathan, Dave, and Alison
		Main comment was to allow for a full payload size number of
		event records to be processed on each Get event cyle.
	Pick up tags


This code has been tested with a newer qemu which allows for more events to be
returned at a time as well ad additional QMP event and interrupt injection.
Thos patches will follow once they have been cleaned up.

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
 drivers/cxl/core/mbox.c         | 260 +++++++++++++++++
 drivers/cxl/cxl.h               |   7 +
 drivers/cxl/cxlmem.h            | 188 ++++++++++++
 drivers/cxl/cxlpci.h            |   6 +
 drivers/cxl/pci.c               | 155 ++++++++++
 include/trace/events/cxl.h      | 486 ++++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h    |   4 +
 tools/testing/cxl/test/Kbuild   |   2 +-
 tools/testing/cxl/test/events.c | 362 ++++++++++++++++++++++++
 tools/testing/cxl/test/events.h |   9 +
 tools/testing/cxl/test/mem.c    |  35 +++
 12 files changed, 1514 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/cxl.h
 create mode 100644 tools/testing/cxl/test/events.c
 create mode 100644 tools/testing/cxl/test/events.h


base-commit: aae703b02f92bde9264366c545e87cec451de471
-- 
2.37.2

