Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9D6151FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKATLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKATKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17B1C416;
        Tue,  1 Nov 2022 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329855; x=1698865855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v4mMdfUTF9VOG7V/dYK2oO5lGRluqJF2HADth9xZz0c=;
  b=ZLUZImlZ304pzICwiSnj6DMOXXN3HwwB5M62FU4ZjQZvrFG9YOP0BZOR
   QEsWO5ILQrfaOjyVwz/08fc3g5AGM6xHZR6eHiGVTIG4P6Tl9WkZ/uQfd
   YFrfgLQ3exnVp8pZvO19lDw6q+aoT4PDE3+7w60jc47LPuw1s9hL9aHJR
   MqlVmzji6vEXexdrJoPeGdGgTW5+8Q17xXFx6hJdOiaVPe3Q7dJeKiY7L
   nO6v7YGrezfDdJRRUFp1B63Mqtrrh0840pSJBIeGyLjmgA5W31Zyl3SL5
   wU/IVhQh+0d4gZmmjj/8iwxykvGAS3l5vdmfDFoTT17c5/vS90KBvNKAG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310320616"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310320616"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="809004561"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="809004561"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 01 Nov 2022 12:10:26 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id D80F7580AA7;
        Tue,  1 Nov 2022 12:10:25 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Extend Intel On Demand (SDSi) support
Date:   Tue,  1 Nov 2022 12:10:14 -0700
Message-Id: <20221101191023.4150315-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst

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
 drivers/platform/x86/intel/sdsi.c             | 134 ++++-
 tools/arch/x86/intel_sdsi/intel_sdsi.c        | 458 ++++++++++++++----
 4 files changed, 513 insertions(+), 134 deletions(-)


base-commit: 225469d4acbcb873358d7618bad6e0203b67b964
-- 
2.25.1

