Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00700720D21
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjFCCJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCCJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:09:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D16E4D;
        Fri,  2 Jun 2023 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685758168; x=1717294168;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=H0AeSXOoLm6d+sBF/QPZvpAaFBwHsrKQzLumiIp5WZ4=;
  b=nScQHy2GwrIYh2HSzMSpCqZfp+83VBGFmGGqbwlRj6Lix0vh7Riwlxz3
   NCrmpeWWhOdh+rvo1UfUFoQWXMFYVg3dH1XW52WlVsglr2NaQye28pMEZ
   ZESPt/tpUlfX7WZsIiQWNkuI/1RbhHqcC0Z2U9F6osB2Hh8jgK++wYeO7
   yevvWKxc1ED8LMGUamAghhezzL7/pDnrXLbUvbFDmvQzY8IHJUZN2wHtA
   B01zKd+36/KHYZsfr0hekK8+P4OlPPj+stKPaYi1UuqNhPoUizfpKifUc
   fjXc/Cm2lpcz1/QbqPgHRc4cp9cZyjEyOg3EKwwgX4PF9sJxZ1IcPn7j6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="340649428"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="340649428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852354408"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400"; 
   d="scan'208";a="852354408"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.97.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:09:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RFC 0/4] dax: Clean up dax_region references
Date:   Fri, 02 Jun 2023 19:09:20 -0700
Message-Id: <20230602-dax-region-put-v1-0-d8668f335d45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCgemQC/x2NQQqDQAxFryJZNzATodpuCz2A29JFZkx1Fp1KY
 osg3r2jy8f7j7+CiSYxuFYrqPySpU8u4E8VxJHzIJj6wkCOand2hD0vqDKUGU7fGRuK1F583cT
 goUSBTTAo5zju2ZttFt3FpPJKy/H0gO5+g+e2/QFT0YkefgAAAA==
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        Paul Cassella <cassella@hpe.com>, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685758165; l=1350;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=H0AeSXOoLm6d+sBF/QPZvpAaFBwHsrKQzLumiIp5WZ4=;
 b=PjRZrjIiB58OFu6WAQdcDL3Xejhg8ixrdE5f89yqGxPlQfRinmET22nVsPyNarG24GyR2xccf
 dB0c8u+VKbMANqBhmPQqFxwwEe0qVe05gadf2596QxTAPXXTClSoZD8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In[*] Yongqiang Liu presented a fix to the reference counting associated
with the dax_region in hmem.  At the time it was thought the patch was
unnecessary because dax_region_unregister() call would properly handle
reference counting.

Upon closer inspection Paul noted that this was not the case.  In fact
Yongqiang's patch was correct but there were other issues as well.

This series includes Yongqiang's patch and breaks up additional fixes
which can be backported if necessary followed by a final patch which
simplifies the reference counting.

[*] https://lore.kernel.org/all/20221203095858.612027-1-liuyongqiang13@huawei.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (3):
      dax/bus: Fix leaked reference in alloc_dax_region()
      dax/cxl: Fix refcount leak in cxl_dax_region_probe()
      dax/bus: Remove unnecessary reference in alloc_dax_region()

Yongqiang Liu (1):
      dax/hmem: Fix refcount leak in dax_hmem_probe()

 drivers/dax/bus.c       | 6 +++++-
 drivers/dax/cxl.c       | 7 +------
 drivers/dax/hmem/hmem.c | 7 +------
 drivers/dax/pmem.c      | 8 +-------
 4 files changed, 8 insertions(+), 20 deletions(-)
---
base-commit: 921bdc72a0d68977092d6a64855a1b8967acc1d9
change-id: 20230602-dax-region-put-72c289137cb1

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

