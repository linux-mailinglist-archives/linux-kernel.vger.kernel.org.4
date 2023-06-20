Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B310D7377BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFTXB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFTXBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369DCD;
        Tue, 20 Jun 2023 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687302113; x=1718838113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3scmrHiO9Vv1GlTgKaHXVhjTGp+yDjWKCxzKgtQ9CBo=;
  b=em8Bvp1+sR1/lj2BeIGdGBJ1MOZjKWAQKNULhedM3cFIx3QGZl6kHU9i
   kXPP5nIhsJjHYxEFi1B5O2N+76JIEqsqEnW+7rgkq/fXlHjzXU49nIMTo
   +AlRHnKh9fAj57T8U5qNUdS5KZpK2Lb9dvChrNZu7sO8UhTKYiu/8Twk/
   nQANR2ZJHn/25ezcZN5KSxcixqNjw3e3WrlfG8ZssqP3Q1bRSCf6IyVx5
   pzTf51mM8LvSb1br4SgGufMfvWfHYENUotx9F6JDzwi+p6IL9qI8d9C0h
   WiQjfBdO4XobZhNFHMApU/s4H9cel/uDULcXupVVLPhai5JAn6Qm88qqQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340347267"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340347267"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044465303"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="1044465303"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 16:01:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/7] thermal: processor_thermal: Suport workload hint
Date:   Tue, 20 Jun 2023 16:01:43 -0700
Message-Id: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Meteor Lake workload hints. Before adding this support,
some reorganization and clean up is required.
First four changes are for clean up and to reorganize code to add
support for workload hint. The last patch adds a test program as part
of self tests.

Srinivas Pandruvada (7):
  thermal: int340x: processor_thermal: Move mailbox code to common
    module
  thermal: int340x: processor_thermal: Add interrupt configuration
  thermal: int340x: processor_thermal: Use non MSI interrupts
  thermal/drivers/int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for
    Meteor Lake
  thermal: int340x: processor_thermal: Add workload type hint
  thermal/drivers/int340x: Support workload hint interrupts
  selftests/thermel/intel: Add test to read workload hint

 .../driver-api/thermal/intel_dptf.rst         |  38 +++
 .../thermal/intel/int340x_thermal/Makefile    |   2 +
 .../processor_thermal_device.c                |  17 +-
 .../processor_thermal_device.h                |  21 +-
 .../processor_thermal_device_pci.c            |  76 ++++--
 .../processor_thermal_device_pci_legacy.c     |   3 +-
 .../int340x_thermal/processor_thermal_mbox.c  | 179 ++++---------
 .../processor_thermal_wlt_hint.c              | 239 ++++++++++++++++++
 .../processor_thermal_wlt_req.c               | 137 ++++++++++
 .../testing/selftests/thermal/intel/Makefile  |  16 ++
 .../thermal/intel/workload_hint_test.c        | 114 +++++++++
 11 files changed, 680 insertions(+), 162 deletions(-)
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_hint.c
 create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_wlt_req.c
 create mode 100644 tools/testing/selftests/thermal/intel/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint_test.c

-- 
2.38.1

