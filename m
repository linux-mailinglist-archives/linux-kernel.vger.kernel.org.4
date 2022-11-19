Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F063086E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKSBYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiKSBWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:52 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B427B0C;
        Fri, 18 Nov 2022 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817431; x=1700353431;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0bmYOnuCSTXVBe9yuKReGBo1+E+J2YeGU85B2raXA/E=;
  b=YQkwviDPDZ5AI9eL2xn8VlmbZrk0/loeQSusosx04UJuyHVtVp0rc3if
   5R6EhgVZKiaFrfo0BAL31coR/r81qfrBlnbcUtyu2Mot9DNLDyOtgZJDQ
   0QhmtJyDATafsFnggLvbnmp+hyazOGfMCf4PPQUHJIX0rdqbPSbKN/gqO
   llE71M8C8NY+dtuZm+vM6Hy0mD17UsneMNFV6hwSgegHUFxMUlLYnZyUZ
   SmnSi3UKTngrHW1J0vv31eaOQth6Zn3TbK1JTRCwIZWhe/6faxh7jXG8u
   jxF2GlHI8nDYHhGt8YWC1Zl6i2WAzAlniMn4DsRj79/d+nzXS9oJKwOgY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="292979931"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="292979931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="885495010"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="885495010"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2022 16:23:45 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id 50549580DDF;
        Fri, 18 Nov 2022 16:23:45 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/9] Extend Intel On Demand (SDSi) support
Date:   Fri, 18 Nov 2022 16:23:34 -0800
Message-Id: <20221119002343.1281885-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Defined Silicon (SDSi) is now known as Intel On Demand. The
following patches do the following:

1. Identify the driver/tools as Intel On Demand. Only text descriptions are
changed. Kconfig and filenames remain the same.
2. Perform some attribute cleanup by preventing the showing of files when
features are not supported.
3. Adds support for a new GUID. GUIDs are used to identify the layout of
the On Demand registers in sysfs. Layouts are described in the
documentation on github [1].
4. Add support for reading On Demand meter certificates in sysfs.
5. The rest of the patches modify the existing tool to support discovery
and reading of On Demand registers and the meter certificate.

Link: https://github.com/intel/intel-sdsi/blob/master/os-interface.rst [1]

David E. Box (9):
  platform/x86/intel/sdsi: Add Intel On Demand text
  platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
  platform/x86/intel/sdsi: Support different GUIDs
  platform/x86/intel/sdsi: Add meter certificate support
  tools/arch/x86: intel_sdsi: Add support for reading state certificates
  tools/arch/x86: intel_sdsi: Add Intel On Demand text
  tools/arch/x86: intel_sdsi: Read more On Demand registers
  tools/arch/x86: intel_sdsi: Add support for new GUID
  tools/arch/x86: intel_sdsi: Add support for reading meter certificates

 .../ABI/testing/sysfs-driver-intel_sdsi       |  47 +-
 drivers/platform/x86/intel/Kconfig            |   8 +-
 drivers/platform/x86/intel/sdsi.c             | 136 +++++-
 tools/arch/x86/intel_sdsi/intel_sdsi.c        | 462 ++++++++++++++----
 4 files changed, 516 insertions(+), 137 deletions(-)


base-commit: 260ad3de718301ed8c22e28558e3a31c99f54cf6
-- 
2.34.1

