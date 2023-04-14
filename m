Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059D6E1B00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDNEO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNEOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:14:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9CE210B;
        Thu, 13 Apr 2023 21:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681445660; x=1712981660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ilHX1TUJOSQR7mRe4+AEDRbkMzycBg1B0YKXxtFmyHw=;
  b=LchK71ymk2b8Tpsc5NIIb3YqngpYoKXaArF4MSbA/9ZciMU6OQ3wVexg
   0kJs2Cthj2lRUfgIY6en6oKlRH17WC7GdoIF2UfL6b7eCAMQGb7G7tA0T
   CxKeQoWOtyw9qotKYalk9Ylin0r4XPsF844z+z/ULu27l7W3do7jRakI1
   KaByojNSSZvR8/tNC89PjgPPxzX1mNIJk9qQ5b0k5sIWyR+r0XD19LEhg
   jfrQJN7Re1ST5UUsCS4H1yS3xCCEYZJOAaEwQQ/QNb8f1oUoRWW1GZVfU
   LkAkk66uGtiA63u1Y/FR2ga246fQvA07uDB9vX8SMdy8x6tuvZrYFXZPZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="343138350"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="343138350"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 21:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="683194742"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="683194742"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2023 21:14:18 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Yifan Li <yifan2.li@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v3 0/2] Fix test_resume failure by openning swap device non-exclusively
Date:   Fri, 14 Apr 2023 20:10:11 +0800
Message-Id: <cover.1681443714.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_resume does not work in current kernel when using swapfile for hibernation.
This is because the swap device should be openned non-exclusively in test_resume mode.

Patch 1 is a preparation to turn snapshot_test into a global variable.
Patch 2 is the fix to open swap device non-exclusively only for test_resume mode.

Change since v2:
Adjust the initialization of fmode and refine the commit message
per Rafael's suggestion.

Change since v1:
Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
nor load_image_and_restore().

Chen Yu (2):
  PM: hibernate: Turn snapshot_test into global variable
  PM: hibernate: Do not get block device exclusively in test_resume mode

 kernel/power/hibernate.c | 15 ++++++++++++---
 kernel/power/power.h     |  1 +
 kernel/power/swap.c      |  8 ++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.25.1

