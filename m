Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0783A7305DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbjFNRSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbjFNRSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:18:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1DA2702;
        Wed, 14 Jun 2023 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686763089; x=1718299089;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HmK7bDebbhr7b7K3cyVs1HeSpf1Lpx36fQVnTVM7V+s=;
  b=FEca6OXJUQEI1iB7Uhr2qyUddYcsFqA6Q2dPtZOKeD68QOkrBt1iZ2hR
   KSl6r6RqxC7s4QJyYrnRW2gSFAoJV7jiorgeTmAeUHH52Q15GexIG1nFD
   GkAhagi9CJlQnVs1zDn/JnCpQt2TwCh9KioSOUrrSMtlBoiPllN8Bb3LC
   7+MDuuzjdOc2Tfm2cW1/Ufp3sxKiXN5yVMFUwwjUxjikill3HtBiFGRUj
   CMq7gcphTtJS7YWg/8/OvCFUR1E0TwLQd24aOrIgXdNgYSUo7NV362vNP
   02qWCe7S/EDEnnaQmE+1TDrMSvvMViFtAXQLoknqKFPxONtnrltLrBVC/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362054355"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="362054355"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662470727"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="662470727"
Received: from mahbubu1-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.44.245])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 10:18:07 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Date:   Wed, 14 Jun 2023 11:17:39 -0600
Message-Id: <20230602-vv-fw_update-v4-0-c6265bd7343b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADP2iWQC/32Oy47CMAxFfwVlTSB107RhNf8xQihNXBoJWpR0P
 CDUfycFiafE8tr3+PjMIgaPka1mZxaQfPR9l4Kcz5htTbdF7l3KDATkQgngRLz53/wdnBmQY2a
 1MkpYVZUsIbWJyOtgOttOENHy3p3Wh4CNP15tv+uUWx+HPpyucsqm6c0jIXv1UMYFB5BJI0tXQ
 vPjuwF3C9vv2XSI4AF/PEmQYNRYWFcYV0v5Duff4DzBldJNBUJpq4tneBzHCxQjqVxBAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4148;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=HmK7bDebbhr7b7K3cyVs1HeSpf1Lpx36fQVnTVM7V+s=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCmd3xy7U0qSzjO+W9p7e+PaCPW5kruk1649Lt8Xdrdi4
 wu16uObO0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjARxyiG/1Gys5xO+D754xwc
 liC/JChq3hF+x5WCu43fxl/emPtE0Z6R4Yraka9vWE0WxqYrLWAL3CvOqBDXt4N1793wGZZvLFQ
 rmQE=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Changes in v4:
- Link to v3: https://lore.kernel.org/r/20230602-vv-fw_update-v3-0-869f82069c95@intel.com
- Collect review tags (Dave, Jonathan)
- Remove a double free (Jonathan)
- Remove stray whitespace (Jonathan)

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
 drivers/cxl/core/memdev.c               | 308 ++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            | 192 +++++++++++++++++++-
 Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
 drivers/cxl/Kconfig                     |   1 +
 6 files changed, 589 insertions(+), 9 deletions(-)
---
base-commit: ccadf1310fb0bc8d2cbcd14f94a6279c12ea9bee
change-id: 20230602-vv-fw_update-e1c96a60c687

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

