Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A464A7F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiLLTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLLTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:15:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22706BE09
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670872526; x=1702408526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3ZEqmPkVhAhSXJdoNWMQHZcXSadpWO7gm0BzI46hw6M=;
  b=Vky8SBywnXTsxlEwVSXZum7kosoCs68s9+6IznI1q+m0IAagNi0a/2ET
   V0l8kdksiTQ76DvidatX1wfmqJMQpMkdtDf5xCjTavV7fRuux2a/bySQg
   tQuXHcwg1l9rLyxR/EobiTKrKGk/xL0g5R6uNTwXTWdwb4fMZUsoTzLAt
   6G60UMTl++9upv/KHxVDPuoT561XzQpYRoPBe6Lxw54MvNXq5rXv+TcBN
   x1xqKbBxf+ViM8AxWTKZ00i4bNIDtK99YEP0WbAlZ+evBmRUClChVSFFM
   2oMjjkC0//I7T9ActtFmTL6jbLo1ArutZUwGLkT3VD1lWAp3ZZFfAWhF+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="319800683"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="319800683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 11:15:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="680784943"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="680784943"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2022 11:15:25 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT PULL] x86/tdx for 6.2
Date:   Mon, 12 Dec 2022 11:15:25 -0800
Message-Id: <20221212191525.553266-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/tdx changes for v6.2.

This includes a single chunk of new functionality for TDX guests
which allows them to talk to the trusted TDX module software and
obtain an attestation report.  This report can then be used to
prove the trustworthiness of the guest to a third party and get
access to things like storage encryption keys.

--

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.2

for you to fetch changes up to 00e07cfbdf0b232f7553f0175f8f4e8d792f7e90:

  selftests/tdx: Test TDX attestation GetReport support (2022-11-17 11:04:28 -0800)

----------------------------------------------------------------
Add TDX guest attestation infrastructure and driver

----------------------------------------------------------------
Kuppuswamy Sathyanarayanan (3):
      x86/tdx: Add a wrapper to get TDREPORT0 from the TDX Module
      virt: Add TDX guest driver
      selftests/tdx: Test TDX attestation GetReport support

 Documentation/virt/coco/tdx-guest.rst        |  52 +++++++++
 Documentation/virt/index.rst                 |   1 +
 Documentation/x86/tdx.rst                    |  43 +++++++
 arch/x86/coco/tdx/tdx.c                      |  40 +++++++
 arch/x86/include/asm/tdx.h                   |   2 +
 drivers/virt/Kconfig                         |   2 +
 drivers/virt/Makefile                        |   1 +
 drivers/virt/coco/tdx-guest/Kconfig          |  10 ++
 drivers/virt/coco/tdx-guest/Makefile         |   2 +
 drivers/virt/coco/tdx-guest/tdx-guest.c      | 102 +++++++++++++++++
 include/uapi/linux/tdx-guest.h               |  42 +++++++
 tools/testing/selftests/Makefile             |   1 +
 tools/testing/selftests/tdx/Makefile         |   7 ++
 tools/testing/selftests/tdx/config           |   1 +
 tools/testing/selftests/tdx/tdx_guest_test.c | 163 +++++++++++++++++++++++++++
 15 files changed, 469 insertions(+)
 create mode 100644 Documentation/virt/coco/tdx-guest.rst
 create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
 create mode 100644 drivers/virt/coco/tdx-guest/Makefile
 create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
 create mode 100644 include/uapi/linux/tdx-guest.h
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/config
 create mode 100644 tools/testing/selftests/tdx/tdx_guest_test.c
