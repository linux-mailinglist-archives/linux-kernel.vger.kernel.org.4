Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C236571FF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbjFBKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjFBKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:35:08 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B3198E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:34:05 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="98600091"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="98600091"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:09 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0A2E1CA1E8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 36982D616D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DB03E4AAF;
        Fri,  2 Jun 2023 19:27:04 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v3 1/3] nvdimm: set force_raw=1 in kdump kernel
Date:   Fri,  2 Jun 2023 18:26:50 +0800
Message-Id: <20230602102656.131654-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10-0.974000-10.000000
X-TMASE-MatchedRID: t1Iw0ML99//7w6uw5pqYnoOlbll4OMtk9LMB0hXFSeg6Zx3YUNQTG+Wh
        NKYuM7eN4QRvjxz49tHS7j6TEIEt1D3TQfUpAv1sPkILbTHNp5vYUDvAr2Y/17fYIuZsOQ0sOXB
        2cqV0mCIre4xpX839SFAz81vtOOYiZ4F2TwmYmEDum6Nvy6t3NlK6+0HOVoSoWAuSz3ewb22AI+
        pLfk3sByL637QCIVpi8vc3EUpCmrV9Y/vlKk76U9splnBzc8xMTFQnI+epPIaRo95rkBSGU6PFj
        JEFr+olwXCBO/GKkVqOhzOa6g8KrW2CLRXivi3wNhkKY/nNBRst5qYpMkBetMsgyaJj+IZ28rnl
        FWxtjwA8cpbtw5mTmssX0GOwKpO0i+7bNO++4Qw50ytg9FCbQRXBt/mUREyAj/ZFF9Wfm7hNy7p
        pG0IjcFQqk0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtually mapped memory map allows storing struct page objects for
persistent memory devices in pre-allocated storage on those devices.
These 'struct page objects' on devices are also known as metadata.

During libnvdimm/nd_pmem are loading, the previous metadata will
be re-constructed to fit the current running kernel. For kdump purpose,
these metadata should not be touched until the dumping is done so that
the metadata is identical.

To achieve this, we have some options
1. Don't provide libnvdimm driver in kdump kernel rootfs/initramfs
2. Disable libnvdimm driver by specific comline parameters (
   initcall_blacklist=libnvdimm_init libnvdimm.blacklist=1 rd.driver.blacklist=libnvdimm)
3. Enforce force_raw=1 for nvdimm namespace, because when force_raw=1,
   metadata will not be re-constructed again. This may also result in
   the pmem doesn't work before a few extra configurations.

Here we choose the 3rd one because the kdump application in this RFC relies
on some /sys interfaces exported by libnvdimm and nd_pmem etc.

CC: Dan Williams <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: nvdimm@lists.linux.dev
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: new patch
---
 drivers/nvdimm/namespace_devs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index c60ec0b373c5..2e59be8b9c78 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/nd.h>
+#include <linux/crash_dump.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
@@ -1504,6 +1505,8 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 			return ERR_PTR(-ENODEV);
 	}
 
+	if (is_kdump_kernel())
+		ndns->force_raw = true;
 	return ndns;
 }
 EXPORT_SYMBOL(nvdimm_namespace_common_probe);
-- 
2.29.2

