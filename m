Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EF972B872
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjFLHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFLHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:11:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351A1996;
        Mon, 12 Jun 2023 00:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686553592; x=1718089592;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/buRSU7Qg/qz7BuEa/y0BICq087QvKa8t2CdljU2M5E=;
  b=VT6FiP9kSdvAxkoZQeBI4BRizlz1cE8vy1OMLTVtYgdv3CVRbot6tzah
   RBBHBILOSO+G9ztjBJ3FT4WBZJF+rO1vNyJs5sXvnEX6Rso5eibQPgrNH
   gzioLN/A39s+RSKuWm94gnFA4C15Ruj7onGNxHOdWbQBne/nte/M6zLUj
   BugDcTe+jfs0/DMBvil+9V5AKvxwaafQsPANnfY+AY8fs4+Nl2cIumaRE
   P2ll96VjR+DPdjihmAtaFtrQG8zR83ZyKrs0/ncf4gNzp8kUxDisXj+eu
   C+frJXw6Q+15D/JrFHmz+hJ0LKIOJTu2nxyJ+n/xb9JHpVGum4N9WtXC0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347613299"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347613299"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="835365312"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="835365312"
Received: from apeer-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.251.3.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:56:20 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Date:   Mon, 12 Jun 2023 00:55:55 -0600
Message-Id: <20230602-vv-fw_update-v3-0-869f82069c95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHvBhmQC/2WO3Q6CMAxGX8Xs2ukoA8Qr38MYM7YiS3SQDauG8
 O4OTPyJl1/7nZ4OLKC3GNh2MTCPZINtXQzpcsF0o9wJuTUxMxCQilwAJ+L17XjtjOqRY6LLXOV
 C55uCRaRSAXnlldPNBBGt391p3Xms7X227Q8xNzb0rX/Mckqm6csjIfn1UMIFB5BRIwtTQL2zr
 sfzSrcXNh0i+MB/TxJEGEvMtMmUqaT8hsdxfAIjP+pzBAEAAA==
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=3926;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=/buRSU7Qg/qz7BuEa/y0BICq087QvKa8t2CdljU2M5E=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCltByfULzjF0KghmWW2nbM3UeuVxVTjU7klTQtT/pQbO
 jK2cTt3lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCKnLjAy7NiizHhure1Ml4OL
 IuYezo5+o/346fTjh4R+iaVXRFQ9l2f4n8QaG/7Sz1ts3cc7f+q87Z9KCzzK593aYvlw5qfcqKY
 bzAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add firmware update capability to the CXL memdev driver, and emulation
in cxl_test. Since the 'Transfer FW' mailbox command is a background
command, this series depends on background command support [1].

Since Transfer FW can be a long-running background command, it is
desirable to retain kernel control over it, so that one command doesn't
monopolize the mailbox interface. The sysfs based firmware loader
mechanism that was developed for FPGAs is a suitable candidate to help
accomplish this. Patch 1 goes into more detail on this.

The poll interval for the Transfer FW command is arbitrarily set at 1
second, and a poll count of 30, giving us a total wait time of thirty
seconds before which each slice of the transfer times out. This seems
like a good mix of responsiveness and a total wait - the spec doesn't
have any guidance on any upper or lower bounds for this. This likely
does not need to be user-configurable, so for now it is just hard-coded
in the driver.

Patch 2 is a fix for the Poison commands effect population found while
developing these.

Patch 3 is a cleanup to give names to command effects.

Patch 4 implements the emulation of firmware update related commands in
the cxl_test environment to enable unit testing.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.5/cxl-background

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v3:
- Link to v2: https://lore.kernel.org/r/20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com
- Collect review tags (Alison, Jonathan)
- Remove unused leftover fw_name variable from the previous rev (Jonathan)
- Add a comment to clarify cur_size calculation and alignment (Jonathan)
- Clean up error return using dev_err_probe() (Jonathan)
- Remove unintended error handling change leftover from v1 (Jonathan)
- Refactor returning from the switch() in mock_activate_fw() (Jonathan)

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20230421-vv-fw_update-v1-0-22468747d72f@intel.com
- Make command field names more consistent with the spec (Jonathan)
- Remove pointers to info/activate/transfer from fw state (Jonathan)
- Use struct_size() insted of open coding it (Jonathan)
- Fix a memory leak with 'transfer' in cxl_fw_write() (Jonathan)
- Move fw setup/teardown into a devm action (Jonathan, Dan)
- Use decimals in command struct definitions to match the spec (Alison)
- Move fw loader registration up into cxl_pci_probe() (Dan)
- Remove the fw_name cargo cult (Dan)
- Change timeout for each transfer chunk to 30s (Dan)
- Add a timeout in cxl_fw_write() as well (not just in abort)
- Use IS_ALIGNED() instead of open coding it (Dan)
- Clean up cur_size calculation in ->write() (Dan)
- Remove the lock and 'clear_to_send (Dan)
- Use atomic bitops for the cancel flag (Dan)
- Gate fw loader setup on command availability (Dan)
- Clean up the effects list in cxl_test using defines (Jonathan)
- Use the sha256 routine in include/crypto/sha2.h (Jonathan)

---
Vishal Verma (4):
      cxl: add a firmware update mechanism using the sysfs firmware loader
      tools/testing/cxl: Fix command effects for inject/clear poison
      tools/testing/cxl: Use named effects for the Command Effect Log
      tools/testing/cxl: add firmware update emulation to CXL memdevs

 drivers/cxl/cxlmem.h                    |  82 +++++++++
 drivers/cxl/core/memdev.c               | 310 ++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            | 192 +++++++++++++++++++-
 Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
 drivers/cxl/Kconfig                     |   1 +
 6 files changed, 591 insertions(+), 9 deletions(-)
---
base-commit: ccadf1310fb0bc8d2cbcd14f94a6279c12ea9bee
change-id: 20230602-vv-fw_update-e1c96a60c687

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

