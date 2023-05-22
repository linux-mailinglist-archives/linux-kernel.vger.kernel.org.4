Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5C70B9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjEVKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEVKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:12:28 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B16FC4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684750348; x=1716286348;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AowsIVjN01hSsP2hzA0Y+/oOa5/gKk8cHmqVtZrsmWs=;
  b=iSqj3mBDRpqe2L2xzWanJrkicr7mpt6hVqtkykTEZfqnwmjx6ALV3QNz
   jCo8QsuAPKu5f/mTed/rpL0uaU8eiTvCc2atidItkfhgRlCyMhZ9dlZsu
   wWKbb10+2T05PKvLA7ZKXmlxRRChXXoeZDG+DSzYRYz1YFR2iJ94XzLVG
   7J4asfBVFoLrvLQwyWS59zTZv48xTXWs/UIbfDycKJeKg9awdPBrbUoZK
   yqJWnGWAqtLi7kMmCMPYiwEEqHdIVC7c20XOUnJTCiTQ7lCHbGjfpm2m8
   XGE4Y4Z0ETzQ7m4b5rmWjhfNAeByB1VYnAA8svqbqedQ9piHauHVWeqbh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="333245339"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="333245339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 03:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="1033575412"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="1033575412"
Received: from twinkler-lnx.jer.intel.com ([10.12.230.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 03:12:26 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: bus: drop useless cldev null check
Date:   Mon, 22 May 2023 13:12:09 +0300
Message-Id: <20230522101210.2207395-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

cldev cannot be NULL when derived with to_mei_cl_device().
Drop useless NULL-checks.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 5d7a68674d9b20b32c415fe8..33ec6424dfee25aacd862fd0 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -1046,9 +1046,6 @@ static int mei_cl_device_match(struct device *dev, struct device_driver *drv)
 	const struct mei_cl_driver *cldrv = to_mei_cl_driver(drv);
 	const struct mei_cl_device_id *found_id;
 
-	if (!cldev)
-		return 0;
-
 	if (!cldev->do_match)
 		return 0;
 
@@ -1079,9 +1076,6 @@ static int mei_cl_device_probe(struct device *dev)
 	cldev = to_mei_cl_device(dev);
 	cldrv = to_mei_cl_driver(dev->driver);
 
-	if (!cldev)
-		return 0;
-
 	if (!cldrv || !cldrv->probe)
 		return -ENODEV;
 
@@ -1276,9 +1270,6 @@ static void mei_cl_bus_dev_release(struct device *dev)
 {
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 
-	if (!cldev)
-		return;
-
 	mei_cl_flush_queues(cldev->cl, NULL);
 	mei_me_cl_put(cldev->me_cl);
 	mei_dev_bus_put(cldev->bus);
-- 
2.40.1

