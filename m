Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9665266D411
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjAQCHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjAQCHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:07:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394121DBB6;
        Mon, 16 Jan 2023 18:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673921264; x=1705457264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y3pbHN8oR8Ss/CjfYgIVnl6zLlkVOcDj6XOXMbxqTPc=;
  b=lgCBPqVVBhkKFoL7OMQfYhCFx6POFGHW3J5RwY9xn7ZkkMuMCnWwzSI9
   /IycMouzk6LTm9DwBFKfcIZh8V0Omotv4OU9QmtMG5Q2aRWM5UaUVFBBU
   EvZHVgxbNj84Dxqp6alwm9BygOFLH27VahwsHhF6TXZY1GNmlwGH5N0wB
   RA0hHMcgsl9Matab+vUzfcmln2rrXRiAUKZZhOPk7KDSRa3YFFtFIlzr9
   ROqtUrVmD/ttJwDKFKDVIewVs1DHIJIKcOb51DuDflynu4AQdgjQbjvRT
   hN0xNrV+ubBmagqwlAiJTOSgW1ew5niBsEgRlgGKDSNf0pB9z9+6Xj3C0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323287627"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323287627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:07:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636703083"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="636703083"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2023 18:07:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 0/4] Per CPU idle injection
Date:   Mon, 16 Jan 2023 18:07:38 -0800
Message-Id: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
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

This series introduces per CPU idle injection. In preparation for this
enhance the existing powercap/idle_inject and modify intel_powerclamp
to use this. Then add per core idle injection driver.

v3
- Change callback from per CPU to per device and use in intel_powerclamp
- Remove unused var in per cpu idle injection module

v2
- Update based on feedback from Rafael on patch 2/4
- Kconfig dependency issue
Reported-by: kernel test robot <lkp@intel.com>

Srinivas Pandruvada (4):
  powercap: idle_inject: Export symbols
  powercap: idle_inject: Add update callback
  thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
  thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle
    cooling driver

 drivers/powercap/idle_inject.c                |  57 ++-
 drivers/thermal/intel/Kconfig                 |  12 +
 drivers/thermal/intel/Makefile                |   1 +
 .../thermal/intel/intel_cpu_idle_cooling.c    | 259 ++++++++++++++
 drivers/thermal/intel/intel_powerclamp.c      | 328 +++++++-----------
 include/linux/idle_inject.h                   |   3 +
 6 files changed, 443 insertions(+), 217 deletions(-)
 create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c

-- 
2.31.1

