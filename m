Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9746F0936
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjD0QJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243023AbjD0QJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:09:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925232709
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682611787; x=1714147787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ClPSbSMHZ6APwD7FTUJlRhQUb9hDopzA54r4WXXsdLo=;
  b=PAgV1rrSMCjykON0mG7TIQ8wVrPHah2uRCuxGZJZ6Uz252ZCjz39s/LN
   Nsz18TdC74EEv+vIwiBRwPvlzEFVOLs0TluKLXfbds7V4rR0HwCYcQXpS
   4EFjLwLCo6o+LMMcGGY0pGRzWalkotZL7Vm8EU4ho6JuxcASRctoKri/T
   2CckRC4MVvQBDpaWByHZIMcPsm7gw027iMtIzUM9CYMXtfHKALK2jhnxc
   7lzo3XcY3VmdGbwAV//7vANQl2txqapT/qya6ot9u51ceY3p07BxOxj5c
   4HpwZ0f+dscvmXuPdnj/P4nH/B9bvbGDpX27qW+ir6Y3bS1GSDHPVtaNH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="375470148"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="375470148"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="644759794"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="644759794"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2023 09:07:53 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/cache for 6.4
Date:   Thu, 27 Apr 2023 09:07:39 -0700
Message-Id: <20230427160739.1053203-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/cache changes for 6.4.  This contains a single commit
that reduces unnecessary hardware counter reads and also just plain makes
the code more readable.

--

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_6.4

for you to fetch changes up to 322b72e0fd10101f2da8985b31b4af70f184bf79:

  x86/resctrl: Avoid redundant counter read in __mon_event_count() (2023-03-15 15:44:15 -0700)

----------------------------------------------------------------
Reduce redundant counter reads with resctrl refactoring

----------------------------------------------------------------
Peter Newman (1):
      x86/resctrl: Avoid redundant counter read in __mon_event_count()

 arch/x86/kernel/cpu/resctrl/monitor.c | 43 ++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 24 deletions(-)
