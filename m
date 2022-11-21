Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3F5632B37
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKURkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKURkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:40:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F9CFEB4;
        Mon, 21 Nov 2022 09:39:59 -0800 (PST)
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1987674C;
        Mon, 21 Nov 2022 18:39:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669052397;
        bh=sExCtvh75xW72P8PYcJyOGr18zPBiZkEL2+R3XyI2kM=;
        h=From:To:Cc:Subject:Date:From;
        b=OcRBh240mIiGwQkSAyZwomaKrA4BJK19ATennWVFe9mAh+bLH+PjMry/5D8H9qolZ
         PLar/qVT8XQYfMOl2GrEOttkKnYo8NV6+hZ4hzYkGT5iTfw35YEbYG+/WDPBz/+8Qm
         bts+DXn2J4AnOQrJd1ZNARNeEkgUacsOU0hYH0wg=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        kernel test robot <lkp@intel.com>,
        Jason Chen <jason.z.chen@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] media: i2c: ov08x40: Make remove callback return void
Date:   Mon, 21 Nov 2022 17:39:50 +0000
Message-Id: <20221121173950.390230-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit ed5c2f5fd10d ("i2c: Make remove callback return void") drivers
were updated to remove the return value of the remove callback, and
return void.

The OV08x40 was added after this commit but was not compile tested at
the time due to a KConfig issue, and this warning was missed.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 38fc5136ac16 ("media: i2c: Add ov08x40 image sensor driver")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---

How come it's always after sending that it is easier to notice the
small mistakes like ordering of the commits to blame.

v2:
 - Fix wording of commit message to show that the driver patch came
   after the change in remove call back API.

 drivers/media/i2c/ov08x40.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index b4ade17a83f5..72ae7fba94eb 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -3281,7 +3281,7 @@ static int ov08x40_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int ov08x40_remove(struct i2c_client *client)
+static void ov08x40_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *sd = i2c_get_clientdata(client);
 	struct ov08x40 *ov08x = to_ov08x40(sd);
@@ -3292,8 +3292,6 @@ static int ov08x40_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops ov08x40_pm_ops = {
-- 
2.34.1

