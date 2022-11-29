Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998063CBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiK2Xeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiK2Xeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:34:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D1A13F5A;
        Tue, 29 Nov 2022 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669764875; x=1701300875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e1iv5i1NQTAnPCTMMmGxu0W1tfFxO0P7ZDyUjFAJ0+Q=;
  b=aKHbEzzSkCLFq4n5mECXHA9L9gSwuWfNPkkVGlPysV0qr/osJx0EQHHv
   y81XK6+pZlYCrSW/UEp3evJAci72CYgbHAPLUZyIcjJj+ZnFXzlEyD07G
   QZG6kTlwFlw59mchDtT2H1JfDHtolyn5KHyS5nB7oI9T7XAFhrAQ3fK7e
   C5y+yRz7QgGpHFQYANCSl3zqKFflKVZpIECszB6Hl+84wUa+Hfz3HLUoj
   oX9+kng+52tCfTEYsUMc7DunDpezi+pmkapu8aJ1qqo0iuB4gDSIVTzMD
   CJijZ4ecqrSd28JBp5yBh4Bk2asf8iEzYCJGtLnabCOgRKYx72Yvc8DV1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342178165"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="342178165"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 15:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768617596"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768617596"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 15:34:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 0/4] Per CPU idle injection
Date:   Tue, 29 Nov 2022 15:34:15 -0800
Message-Id: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces per CPU idle injection. In preparation for this
enhance the existing powercap/idle_inject and modify intel_powerclamp
to use this. Then add per core idle injection driver.

v2
- Update based on feedback from Rafael on patch 2/4
- Kconfig dependency issue
Reported-by: kernel test robot <lkp@intel.com>

Srinivas Pandruvada (4):
  powercap: idle_inject: Export symbols
  powercap: idle_inject: Add prepare/complete callbacks
  thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
  thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle
    cooling driver

 drivers/powercap/idle_inject.c                |  69 ++++-
 drivers/thermal/intel/Kconfig                 |  12 +
 drivers/thermal/intel/Makefile                |   1 +
 .../thermal/intel/intel_cpu_idle_cooling.c    | 261 ++++++++++++++++
 drivers/thermal/intel/intel_powerclamp.c      | 292 ++++++++----------
 include/linux/idle_inject.h                   |   4 +
 6 files changed, 467 insertions(+), 172 deletions(-)
 create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c

-- 
2.31.1

