Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414E723118
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjFEUVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjFEUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C738122;
        Mon,  5 Jun 2023 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685996451; x=1717532451;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Ym+yuWgcnHLtxi0UIQsl39e5g5TvnqkH8IdmhkQ2xE8=;
  b=b1UWSv2ioBx+tzANi5DhJnXV07jRwW/03PBAqMI0VNkj75up2SzCZpKX
   0kkVnopP1Oh4R23DeKaWBv7VrmH5M3fvuRBwnC7kuiJlHV3vrwfQ9M1tk
   1TpeLSxAc2/dXx+OmMVlgycfk+PoNd7xtW4vDzfuy3nDH1CYdxXHewS+d
   tI7nvIu/2qbvxyUdg+f3Rh8+UTfpNLZ6kGzznEO4FfReXqgST/aPVvA7c
   64s3MOou+lT0qR0s7HejsdBg080EcwTKz9+0rRH/3VBRzbR1VEs6ODjV2
   xbcHCPNtd6Pp4lr4WLiodKNWb/EtV4E/S9i6C6rG4ZBHTztDF3ZBdXOeb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336093119"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="336093119"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="832934185"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="832934185"
Received: from kmsalzbe-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.52.9])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 13:20:50 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Date:   Mon, 05 Jun 2023 14:20:21 -0600
Message-Id: <20230602-vv-fw_update-v2-0-e9e5cd5adb44@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVDfmQC/1WN3wqCMBSHX0V23antJLO86j1CYs5jDmrKZqdCf
 PemQdDl9/vDN4lIwVEUZTaJQOyi630C3GTCdsZfCVyTWKDEvdQSgRna5+UxNGYkIGWP2mhp9aE
 Q6VKbSFAH4223nJh3v+1SD4Fa91pt5ypx5+LYh/cqZ7WkX0+O6t/DCiQg5kmTF02B7cn5kW5b2
 99FNc/zB5oHSrvHAAAA
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Ym+yuWgcnHLtxi0UIQsl39e5g5TvnqkH8IdmhkQ2xE8=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCl1znM1O+/H3JsgXCmt9F5UiY89QltdsMz0opnakVij1
 fV6q6M6SlkYxLgYZMUUWf7u+ch4TG57Pk9ggiPMHFYmkCEMXJwCMBG7SEaGOS022+4yZho3WFQ+
 S599du0bh+3dnJItz2rDl258eMywn5Hh072Pz2NC+voPnVobyPazvO2qhOhVJ8svE1dU6Lw42fa
 MFwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

 drivers/cxl/cxlmem.h                    |  85 +++++++++
 drivers/cxl/core/memdev.c               | 309 +++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c                       |   4 +
 tools/testing/cxl/test/mem.c            | 194 +++++++++++++++++++-
 Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
 drivers/cxl/Kconfig                     |   1 +
 6 files changed, 594 insertions(+), 10 deletions(-)
---
base-commit: ccadf1310fb0bc8d2cbcd14f94a6279c12ea9bee
change-id: 20230602-vv-fw_update-e1c96a60c687

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

