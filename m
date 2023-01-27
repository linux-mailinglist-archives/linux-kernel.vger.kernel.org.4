Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACF367EF75
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjA0UVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjA0UU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:20:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5071751B7;
        Fri, 27 Jan 2023 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674850857; x=1706386857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u6MpzPbX664ez0Ky4XTyLndB/xCrayjarXRpIpUFxhE=;
  b=ShwA5t33oBbUhynOLU/7dtTV2knF55nZWGpubYMFlUWMAXUTMO5guAeB
   EE81bpoZ9Ol4Kn0pmZ0W5mRoa8Om/P55W8NtZghXmS5g3Ha8TV+GyRJW0
   g8BVA1fc4BBccvj/tsvKUol72xqdpdYjJa6G6u7fvT9IpSwhdbaMqx856
   ADYQe7/JhRiUzc5q34UGH6Pqu2WQCayBEK2O/zBiIyDWfFuypzenAKsI9
   oOBy8gTXvXHcHKjBeuYBJsoixiqa5Aah4aKsynQcKPTOAflIm2Gj4o8Pw
   pLbOdcy/1EC8Gmqzgv3kkA0mtHHgad5sXjsK8uKezWTgLEtsgJDDaOohH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310804592"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="310804592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 12:20:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="693840010"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="693840010"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2023 12:20:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 0/3] Use idle_inject framework for intel_powerclamp
Date:   Fri, 27 Jan 2023 12:20:45 -0800
Message-Id: <20230127202048.992504-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropped the per core idle injection patch from this series. Hence the
subject of this series is changed. Now it is just for using
idle inject framework for intel_powerclamp.

The old cover letter:
This series introduces per CPU idle injection. In preparation for this
enhance the existing powercap/idle_inject and modify intel_powerclamp
to use this. Then add per core idle injection driver.

v4:
- Dropped the per core idle inject patch

v3
- Change callback from per CPU to per device and use in intel_powerclamp
- Remove unused var in per cpu idle injection module

v2
- Update based on feedback from Rafael on patch 2/4
- Kconfig dependency issue
Reported-by: kernel test robot <lkp@intel.com>


Srinivas Pandruvada (3):
  powercap: idle_inject: Export symbols
  powercap: idle_inject: Add update callback
  thermal/drivers/intel_powerclamp: Use powercap idle-inject framework

 drivers/powercap/idle_inject.c           |  57 +++-
 drivers/thermal/intel/Kconfig            |   2 +
 drivers/thermal/intel/intel_powerclamp.c | 374 ++++++++++-------------
 include/linux/idle_inject.h              |   3 +
 4 files changed, 209 insertions(+), 227 deletions(-)

-- 
2.37.2

