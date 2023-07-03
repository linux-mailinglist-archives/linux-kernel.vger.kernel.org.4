Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546367462C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGCSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjGCSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B41E6B;
        Mon,  3 Jul 2023 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410347; x=1719946347;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=25ZLJW7OGmWWE2qbCthjIIhoB9XkL05rh/6oTpbhx6s=;
  b=BkLmlfC/Q0ssauCV4m26xLTNsJ7Jdij63hq19sPtFTnqu7JKC8f7gUno
   noozTR5LDCzNag7v57wnOgUxsnarRif4MNE6MbNP+ilUWSO21ay+GvqCe
   7MREKf5FJgL2JPSqvwp4hfku0050AgxlU5howDxdp5MEGBHf4OUHv+NmC
   VC0Fl0uOV9p4PZ4pRW7PLJd5P5X4HarqOHYopqxY94Mf1h4YSra83GfKo
   Pkp1w+moIpv/W+sy+Fsp6Z8dolj7W+JFXxs3j0uKufhqKMfn54bqUn4/g
   ZHRW/qv0iY1m7R8Gmdi3nqraSAEtvrWh2BiVCxkz2sj8EHJyFNCGs3zlg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347736197"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="347736197"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="842743322"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="842743322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 03 Jul 2023 11:52:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B021170; Mon,  3 Jul 2023 21:52:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Date:   Mon,  3 Jul 2023 21:52:10 +0300
Message-Id: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After I updated GPIO library for the case Benjamin has with CP2112,
I have a brief look into the CP2112 driver itself.

From GPIO perspective it has two main (maitenance) issues:
- usage of ->to_irq() with IRQ chip present;
- having IRQ chip not immutable.

Besides that there are plenty small cleanups here and there.
Hence this series.

Compile tested only.

Andy Shevchenko (12):
  lib/string_choices: Add str_write_read() helper
  HID: cp2112: Use str_write_read() and str_read_write()
  HID: cp2112: Make irq_chip immutable
  HID: cp2112: Switch to for_each_set_bit() to simplify the code
  HID: cp2112: Don't call ->to_irq() explicitly
  HID: cp2112: Remove dead code
  HID: cp2112: Define maximum GPIO constant and use it
  HID: cp2112: Define all GPIO mask and use it
  HID: cp2112: Use BIT() in GPIO setter and getter
  HID: cp2112: Use sysfs_emit() to instead of scnprintf()
  HID: cp2112: Convert to DEVICE_ATTR_RW()
  HID: cp2112: Use octal permissions

 drivers/hid/hid-cp2112.c       | 169 +++++++++++----------------------
 include/linux/string_choices.h |   1 +
 2 files changed, 58 insertions(+), 112 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

