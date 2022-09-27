Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8DD5ECA98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiI0RQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiI0RQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:16:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA31CD114;
        Tue, 27 Sep 2022 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664298997; x=1695834997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odCSUQaD20kY0LLbPFVfME7ijRKqAtXNIipf6xkiSaA=;
  b=FdVwUFMhf0x37q8TS52zvksXx6H4mctLkp3GVF9kzTv2nUoogZ9BCtID
   xphCgpRD5oFWErYVE5i/IGPzgtqwNDRFP4KtZ81mpIZnclrfAFAn7zOu+
   iUMH+kaCa8vV9rIaQJQ0mTvv1cYiG8c3nbylF4Qoug166OD7EyUKoBu5i
   3POtV4lMGgh73XyXGneW++UQ7cwnrFbue+DeyKKm6jv0CROylWpoSPXzR
   4SLFHNyJ46NNLHcDzcfJE9h6vK5LJZjT+8P231G+/hPux/cqJHc2AUdKb
   YCe/MlrKy2XlNJbQm8wujb+E3hUugbdn2OwmZCh9QYkN+da1qqb2OZG+4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301354133"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="301354133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:16:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="866645707"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="866645707"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 27 Sep 2022 10:16:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2BC457C; Tue, 27 Sep 2022 20:16:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] media: subdev: Replace custom implementation of device_match_fwnode()
Date:   Tue, 27 Sep 2022 20:16:18 +0300
Message-Id: <20220927171618.51971-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom implementation of the device_match_fwnode().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 5c27bac772ea..c483dd5575dd 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -845,7 +845,7 @@ int v4l2_subdev_get_fwnode_pad_1_to_1(struct media_entity *entity,
 	fwnode = fwnode_graph_get_port_parent(endpoint->local_fwnode);
 	fwnode_handle_put(fwnode);
 
-	if (dev_fwnode(sd->dev) == fwnode)
+	if (device_match_fwnode(sd->dev, fwnode))
 		return endpoint->port;
 
 	return -ENXIO;
-- 
2.35.1

