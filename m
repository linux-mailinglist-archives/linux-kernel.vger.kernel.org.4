Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3476C4DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCVOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCVOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B82E2A141
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495962; x=1711031962;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t2IaIeqBXPjnT1JLaI6jE8+v/kXPaxpXri3fvfvHkg4=;
  b=bfuQ7831e3LwUxZI4NNRrNgyC8Ck7k3YQjUd7pVRglUwcmdFaOEcujDS
   tMHKbS7YHj22KMMSbxiNwjD43Q//9aLeiBhDNRWzzhMAsnytA9OAS4Udq
   D2J+In/GuVa1YW5Oem3n9OZpNnsAbkK/fE54Z9zqUBV48Dc/hy/DBuQ6V
   ZQA0IPO+MSy08olrBRT5HghYfy17Jcc3XJOCNsd+aS8xmjPnBPQPK+fot
   PzHDfrh38l1seYcENNrmFNA6r9cRrjjW8qBpl6//y0qoHvEeHmgN6BuXi
   whmQw1LYxjdL0PFBDqNF394bjZqwgz8WXklxgPeA5HqvS4bIK1a3XiqaT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327609286"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="327609286"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792579424"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792579424"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 07:39:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93A561CC; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Date:   Wed, 22 Mar 2023 16:39:51 +0200
Message-Id: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few fixes to the documentation and some cleanups against extcon core
module.

Andy Shevchenko (14):
  extcon: Fix kernel doc of property fields to avoid warnings
  extcon: Fix kernel doc of property capability fields to avoid warnings
  extcon: Use DECLARE_BITMAP() to declare bit arrays
  extcon: use sysfs_emit() to instead of sprintf()
  extcon: Amend kernel documentation of struct extcon_dev
  extcon: Allow name to be assigned outside of the framework
  extcon: Use unique number for the extcon device ID
  extcon: Switch to use kasprintf_strarray()
  extcon: Use device_match_of_node() helper
  extcon: use dev_of_node(dev) instead of dev->of_node
  extcon: Remove dup device name in the message and unneeded error check
  extcon: Use sizeof(*pointer) instead of sizeof(type)
  extcon: Drop unneeded assignments
  extcon: Use positive conditional in ternary operator

 drivers/extcon/extcon.c | 126 +++++++++++++++++++++-------------------
 drivers/extcon/extcon.h |   9 ++-
 2 files changed, 71 insertions(+), 64 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

