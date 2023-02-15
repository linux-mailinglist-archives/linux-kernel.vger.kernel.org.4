Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756A69751B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBOENL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBOEND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:13:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD991024E;
        Tue, 14 Feb 2023 20:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676434380; x=1707970380;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=lwM/sZ7BpE64mBqdLy0BdpvSDtzZ+4+SR/Stq9iDTgM=;
  b=UDB94g8PL9Is9O9ZjLuKICnMtMRw09yobcZOsj0wRkUnRTdB9+1g9gHm
   ApQoRp/bKjoJal47AWpimpqVTLJHpZk5b4wdJJjX9tBhWo63Y2edSf2c/
   w5ajfUxtbQJ4PXonPSfK6XSF4MaVE9aGEKJQtTJjpuYwYjxKo9aGlOkfB
   Npiv77brTauTRnJPnIMM2Rm/K5zDgTgb5fUJIlsOm0SPn++di40iTRiyH
   TuscL/+6dY27lU+ViPaoiyPByzq6tik990VOe8kTVvMdg9C2L3SSbXRZg
   wV4EBdfasqt1h0C7+W0d+MhHEz9cGCbZ6RH806aOPjsWJbmp1mmKLI4Qz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="311706798"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="311706798"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:12:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647016992"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="647016992"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.74.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 20:12:58 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/3] cxl: Enhance trace point information
Date:   Tue, 14 Feb 2023 20:12:42 -0800
Message-Id: <20230208-cxl-event-names-v2-0-fca130c2c68b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpb7GMC/3WNQQrCMBAAvyJ7dmWbgKme/If0kMaNXUhTSWqol
 P7d2LvHGRhmhcxJOMP1sELiIlmmWEEdD+AGG5+M8qgMipQmRS26JSAXjjNGO3LGizbK90bZMxm
 oVW8zY59sdEPt4juEKl+JvSz75t5VHiTPU/rs19L87P9BaZDQaE/ea6tbQzeJM4eTm0botm37A
 iXaIDfDAAAA
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676434378; l=1046;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=lwM/sZ7BpE64mBqdLy0BdpvSDtzZ+4+SR/Stq9iDTgM=;
 b=gQ0Znntz78ZrMJrxh8rpdDHAAwMPOnZgjxLIlqppt4jv83lN1iHS9/fd6D5OHvfFF3f1l6HKV8Zh
 wQ59h+Z+BWEcaw7B9snL3ukvIcgOccYlca7ZRfJbzQZecu8Q2bBl
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace point definitions are reporting different linux devices for the
same CXL hardware device.  Clean this up.  Add additional parent device
and serial number to all the trace points for easier user space
identification.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- Dan: Add patch for serial number
- Fix macro parameter isolation
- Minor formatting change
- Link to v1: https://lore.kernel.org/r/20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com

---
Ira Weiny (3):
      cxl/trace: Standardize device information output
      cxl/trace: Add host output to trace points
      cxl/trace: Add serial number to trace points

 drivers/cxl/core/mbox.c  | 14 +++----
 drivers/cxl/core/pci.c   |  8 +---
 drivers/cxl/core/trace.h | 95 +++++++++++++++++++++++++++++-------------------
 3 files changed, 66 insertions(+), 51 deletions(-)
---
base-commit: b8b9ffced017528bcdd262730ab10bc5084c3bb4
change-id: 20230208-cxl-event-names-9372fb72a607

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

