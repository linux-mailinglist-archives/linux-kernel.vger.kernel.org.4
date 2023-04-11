Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3196DD0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDKEW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKEWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:22:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D111BF0;
        Mon, 10 Apr 2023 21:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681186973; x=1712722973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hmE/4fx0REVbtNDLwDAGT/41Nij4JlBZargTHRs5SMU=;
  b=NNLM5lqExyNQdiOXoAQ44/Ux3z5JrwmUaEtRZcW+gUWM/mzPJwjhADmC
   RmL6k3WHGvcxIOLuIn1L6yoqQ9sJ86dTRMMfDO7iToU4UxKC4GYpDCbqJ
   yTEHOQYtUEyi50xFQJTf/cH6e4phY/1KQNWfIHTpjBhizap40gNFKSKUM
   9AzXNITkTo4l7PD4ya3I/lRBK8Nd6oJsudrr0dGVmhRx8anOjLEil6Mzn
   D8kfV7T4ia7kw0m//rlqtmcnBxH63qGiyMQb9TFXxBA9zbI1EPW8VOMTw
   3SzjoW34pZw2j4LFJ9OgZzGdthWIeusYvDOrJhbW/id8Oc43KopA9qeaq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341010163"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="341010163"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 21:22:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="721045362"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="721045362"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga001.jf.intel.com with ESMTP; 10 Apr 2023 21:22:50 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>
Cc:     Ye Bin <yebin10@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v2 0/2] Fix test_resume failure by openning swap device non-exclusively
Date:   Tue, 11 Apr 2023 20:18:43 +0800
Message-Id: <cover.1681186310.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_resume does not work in current kernel when using swapfile for hibernation.
This is because the swap device should be openned non-exclusively in test_resume mode.

Patch 1 is a preparation for patch 2 and it turns snapshot_test into a global variable.
Patch 2 opens swap device non-exclusively for test_resume mode, and exclusively for manual
hibernation resume.

Change since v1:
Turn snapshot_test into global variable and do not introduce parameters for swsusp_check()
nor load_image_and_restore().


Chen Yu (2):
  PM: hibernate: Turn snapshot_test into global variable
  PM: hibernate: Do not get block device exclusively in test_resume mode

 kernel/power/hibernate.c | 12 +++++++++---
 kernel/power/power.h     |  1 +
 kernel/power/swap.c      |  5 +++--
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.25.1

