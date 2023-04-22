Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D16EB6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 05:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDVDJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDVDJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 23:09:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B73F1FF7;
        Fri, 21 Apr 2023 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682132974; x=1713668974;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=6nXvMqoc0XfIWbY8flS/q6ajZvWZ0tjRB0xeWVdGp9E=;
  b=A41eXh+nu0aaXOCDSTXNqWn3f+pClXQDE2jVCJaD+ekOR+ynYFTtffwl
   fjYzncqu+zMd2u1P1lAD92JcnGCIv2CjDapZwcP5mR/uq+Lh8wJwdTcVM
   ouYu3092yUbhj3DtyKZu0xddyro/OFp5UhC6Z6G7OyMX2TO8z+vCN3sTr
   iZ3z4f8fyVFjlFLKhHg7fov59OvkK5QuZO3pIyEnSxhUFBJKVF4yJlSFO
   9CyiOmfDBodGZTV7L8cY0a0+q8jQTPLa5ZazT7SNC6ZpQxqZijyXzvDbC
   xxWqFdicCs302RQ0WATVeASUuThWoEVZilbZtsmd3V0twQMTiwJpkd/BX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343609052"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343609052"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="757092261"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="757092261"
Received: from jwostman-mobl2.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.111.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:09:33 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/4] cxl: Add a firmware update mechanism and cxl_test
 emulation
Date:   Fri, 21 Apr 2023 21:09:24 -0600
Message-Id: <20230421-vv-fw_update-v1-0-22468747d72f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORPQ2QC/x2N0QqDMAwAf0XyvEBbFdx+ZYyR2qgB6aTVThD/3
 eDjHRx3QOYknOFVHZC4SJZfVLCPCvqJ4sgoQRmccbVpnMVScPh/tyXQytg+uW4pmGBsB5p4yow
 +UewnjeI2zyqXxIPs9+P9Oc8LrX2tanMAAAA=
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Russ Weight <russell.h.weight@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=6nXvMqoc0XfIWbY8flS/q6ajZvWZ0tjRB0xeWVdGp9E=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCnO/m9n7z+9+YtB2ILMKsMS/8xp3jvmxZWtnORzgZW9b
 GuikLBbRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACaiKMzwP6haz1Xnwh/xc0sX
 XDFQCHQ/77/6mpX44fZ8lv/P3E5sbGVkOFT3Q9Tmx7mt8gW+Rz75m1jOXrcu9LD1gg1yX467JAa
 rMAAA
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
command, this series depends on the initial background command support
patches[1] from Davidlohr. These patches (patch 1 and 2) are included
in this series, unchanged, for reference.

Since the Transfer FW command can be a long-running background command,
it is desirable to retain kernel control over it, so that one command
doesn't monopolize the mailbox interface. The sysfs based firmware
loader mechanism that was developed for FPGAs is a suitable candidate to
help accomplish this. Patch 3 goes into more details on this.

The poll interval for the Transfer FW command is arbitrarily set at 1
second, and a poll count of 300, giving us a total wait time of five
minutes before which each slice of the transfer times out. This seems
like a good mix of responsiveness and a total wait - the spec doesn't
have any guidance on any upper or lower bounds for this. This likely
does not need to be user-configurable, so for now it is just hard-coded
in the driver.

Patch 4 implements the emulation of firmware update related commands in
the cxl_test environment to enable unit testing.

[1]: https://lore.kernel.org/linux-cxl/20230421092321.12741-1-dave@stgolabs.net

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Davidlohr Bueso (2):
      cxl/pci: Allocate irq vectors earlier in pci probe
      cxl/mbox: Add background cmd handling machinery

Vishal Verma (2):
      cxl: add a firmware update mechanism using the sysfs firmware loader
      tools/testing/cxl: add firmware update emulation to CXL memdevs

 drivers/cxl/cxl.h                       |   7 +
 drivers/cxl/cxlmem.h                    |  84 +++++++++
 drivers/cxl/core/mbox.c                 |   4 +-
 drivers/cxl/core/memdev.c               | 324 ++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c                       | 112 ++++++++++-
 tools/testing/cxl/test/mem.c            | 191 +++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-cxl |  11 ++
 drivers/cxl/Kconfig                     |   1 +
 8 files changed, 728 insertions(+), 6 deletions(-)
---
base-commit: 24b18197184ac39bb8566fb82c0bf788bcd0d45b
change-id: 20230421-vv-fw_update-59e35ad0d018

Best regards,
-- 
Vishal Verma <vishal.l.verma@intel.com>

