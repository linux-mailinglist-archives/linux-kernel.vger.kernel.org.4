Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5181B69189C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjBJGlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjBJGlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:41:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9033976C;
        Thu,  9 Feb 2023 22:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676011310; x=1707547310;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=4xggN7P66K2tnaGFM2iCfVXbyCWBFwqN22XsUsnZ0Cw=;
  b=Qv9eg+t+1lCZFnskWPVMLP1rFPrDrEpI+51f7mnvPJ9aDNDVqS1ps+bw
   MFtsIdeyRJ8JpThT4rUK1Ox8R4Nyas9c1EREbePe/dixt4ITpZJGSh90w
   tU54EjZ+aP5j8bt5l2DiM4lANUwEeoEIL3CZoGwRPr/OBwjebPR5CjaVl
   qHJKSb9wuxi4fccbXPEP1XhlRe4pYIcED8Wc+aWDi/XHlLUZUa5GBA6+N
   4bLSIwD7xxhfw6kcr72CE9k8izULLBoTO4nxt9P2KGsTxuQn5JD6jBgYO
   o00hkMocgYCKZ83VD1DJc20ra60VZJDfknc8veMQutEW92IyxQzkO5YGd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="331654750"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="331654750"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:41:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="661300308"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="661300308"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.43.65])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 22:41:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2] cxl: Enhance trace point information
Date:   Thu, 09 Feb 2023 22:40:14 -0800
Message-Id: <20230208-cxl-event-names-v1-0-73f0ff3a3870@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7m5WMC/x2N0QrCMAwAf2Xk2UDNYFV/RXxIu8wVapRmjsHYv
 xt8vIPjdjBpRQxu3Q5N1mLlrQ7nUwd5Zn0KltEZKFAfKFwwbxVlFV1Q+SWG1z7SlCLxECJ4ldg
 EU2PNs3f6rdXlp8lUtv/m/jiOHzhnjyB2AAAA
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Jiang <dave.jiang@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676011309; l=730;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=4xggN7P66K2tnaGFM2iCfVXbyCWBFwqN22XsUsnZ0Cw=;
 b=ajZVbn66tUqNHmyl+tMCm7xIyyWgaBn0td3Ms+nodR01f0yski+eZgcSUmZNguMHih+sCjNtfug3
 ZvZZMn8hAaeRiY1ovJ4gMJz3OrT60A+hvhIcK4BijMz8SXgqqZc5
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace point definitions are reporting different linux devices for
the same CXL hardware device.  Clean this up and add parent device
information to all the trace points.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (2):
      cxl/trace: Standardize device information output
      cxl/trace: Add host output to trace points

 drivers/cxl/core/mbox.c  | 14 ++++----
 drivers/cxl/core/pci.c   |  8 ++---
 drivers/cxl/core/trace.h | 85 +++++++++++++++++++++++++++---------------------
 3 files changed, 57 insertions(+), 50 deletions(-)
---
base-commit: dbe9f7d1e155b97a42f7da81e22acc98fe0a9072
change-id: 20230208-cxl-event-names-9372fb72a607

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

