Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA9686E0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBASfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjBASfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:35:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB227F692;
        Wed,  1 Feb 2023 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276524; x=1706812524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m8lj5D4ewZeXHvV9EGTjWwSj8HiD530yrHpf7fXqADE=;
  b=nGYOszuzb9L/fdd4PW0uN/QD4XZga0AnlqlDvD/51S8SfrJjkQOoXWGz
   ALZqOOD0D0G8A9UpO5NjAi8PS4+483QrGKi7Yja2HQGaP5LWLJOj9+NeY
   8HmYgdJwrgnmunxarLKMZaXxnsLERvGJb48fSMccDHJeqYxLe2hKuB20b
   kR4cw2Hb7Uwguk6/JwjmhYl6fuD19Dto4iHcA/+kurjN3hZar1TbWe/LX
   IUaTD3YnXPxEj2V7fLxcJ6gKECZvV+3ElewSD1Bzv1yvbQIP50KRqLYHg
   sl8iRIxNBICX9ltTdzWsKw63pOtPyc0Gg1uiFlUXM7vGkBNCTnXlNw0CG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414440434"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414440434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667014251"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667014251"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2023 10:28:55 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 0/4] Use idle_inject framework for intel_powerclamp
Date:   Wed,  1 Feb 2023 10:28:50 -0800
Message-Id: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Dropped the per core idle injection patch from this series. Hence the
subject of this series is changed. Now it is just for using
idle inject framework for intel_powerclamp.
Add additionl patch for module paramters to set cpumask and max idle percent.

The old cover letter:
This series introduces per CPU idle injection. In preparation for this
enhance the existing powercap/idle_inject and modify intel_powerclamp
to use this. Then add per core idle injection driver.

v5:
- additionl patch for module paramters to set cpumask and max idle percent
- One fix for update callback
- Rebased on top of patch 
 "thermal: intel_powerclamp: Fix cur_state for multi package system"

v4:
- Dropped the per core idle inject patch

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
  thermal/drivers/intel_powerclamp: Add additional module params

 .../driver-api/thermal/intel_powerclamp.rst   |  22 +
 drivers/powercap/idle_inject.c                |  57 +-
 drivers/thermal/intel/Kconfig                 |   2 +
 drivers/thermal/intel/intel_powerclamp.c      | 512 ++++++++++--------
 include/linux/idle_inject.h                   |   3 +
 5 files changed, 367 insertions(+), 229 deletions(-)

-- 
2.39.1

