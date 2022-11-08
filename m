Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA01C620727
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiKHDEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiKHDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95A175A5;
        Mon,  7 Nov 2022 19:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667876647; x=1699412647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RSCSyC3+0rPXVEykyJ8qRmybLJBkbh35zjfMk+l0FmI=;
  b=YmHia5Ian7/wfgRJwx0K6x6H5kz5NaNL4ikFR27gUPtcVsBdEeUspPOJ
   CK8ZEcq9IjWSniJ66LviVY60QLWbtHKBUQRRmh3LS7j15Y+tZVBbIjyAy
   G0XN6U/Y1llUUJhq/PvDPnV9Cgi5LxD+3KWhu3FqXf1KtImUI9+/CFmoQ
   tFyEa6L4G6ZpXlE2MVib/XKbXBgTJf0krL0kkM+hhWtSHHy13kh1EwIBf
   QZlleDsCjY75gaH7+TKcn0cZp5fZGuOMm5XLy4IhbOxTs+hlr+9VnGFtU
   cH1cfm+6cKcRSd20Dh4XGSMFUk3iVOkszQb3wOXXbjzh5mt26kPh45W0I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337310746"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337310746"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:04:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638612669"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638612669"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 19:04:06 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/4] Per CPU idle injection
Date:   Mon,  7 Nov 2022 19:03:38 -0800
Message-Id: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
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

Srinivas Pandruvada (4):
  powercap: idle_inject: Export symbols
  powercap: idle_inject: Add begin/end callbacks
  thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
  thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle
    cooling driver

 drivers/powercap/idle_inject.c                |  26 +-
 drivers/thermal/cpuidle_cooling.c             |   2 +-
 drivers/thermal/intel/Kconfig                 |  11 +
 drivers/thermal/intel/Makefile                |   1 +
 .../thermal/intel/intel_cpu_idle_cooling.c    | 262 ++++++++++++++++
 drivers/thermal/intel/intel_powerclamp.c      | 293 ++++++++----------
 include/linux/idle_inject.h                   |   4 +-
 7 files changed, 428 insertions(+), 171 deletions(-)
 create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c

-- 
2.37.3

