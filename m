Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F76A6745E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjASWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjASWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10799430A;
        Thu, 19 Jan 2023 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166064; x=1705702064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YiGwGYUEGq5e7hHdmSy+17dhbmnQ48wDY8W4pMp3mk=;
  b=VYjgfhE6i2IMDN9MN2PdaBv3qcPu5T03VmGEbJ5vpSAPOqPDZf/OD1gD
   k1P6LhPD76JYraebJ5bqt5niPVrnn0nFcYB86N5O7uCfueC2CI85sC15w
   WiBbRVlqInl/npsIYF+m1suxZPml/Xer919UQVOzjLRBw4SO6gEOEfiA3
   hKiBOzGKPnpx4C/jpLV8d3z+IgaGXdDYoQUbzIBS2tw1voA7kIQxZ3Jbn
   o36Trjb61TPjfVytOaxZIHsCNFiHlO7x/9QG+mA6lTaIkWuWIQhTQwhdg
   MvZ0oS1V6ggjWc8Q/mGOJOIQALBq3OBbUnBuU3HwxvY8/p2zPM5scoHga
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323130647"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323130647"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784226637"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="784226637"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 14:07:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3FA9836D; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/9] pktcdvd: use sysfs_emit() to instead of scnprintf()
Date:   Fri, 20 Jan 2023 00:08:03 +0200
Message-Id: <20230119220809.5518-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ad4336ae9927..98a5c388eabf 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -339,7 +339,7 @@ static ssize_t device_map_show(struct class *c, struct class_attribute *attr,
 		struct pktcdvd_device *pd = pkt_devs[idx];
 		if (!pd)
 			continue;
-		n += sprintf(data+n, "%s %u:%u %u:%u\n",
+		n += sysfs_emit_at(data, n, "%s %u:%u %u:%u\n",
 			pd->disk->disk_name,
 			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
 			MAJOR(pd->bdev->bd_dev),
-- 
2.39.0

