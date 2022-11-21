Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09328632B19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKURfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKURfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:35:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8CCDFC7;
        Mon, 21 Nov 2022 09:34:59 -0800 (PST)
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B36E74C;
        Mon, 21 Nov 2022 18:34:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669052097;
        bh=3wyOgjAlepB4I1xB99aLI2ewGundLQKtX3vaYZdcmJU=;
        h=From:To:Cc:Subject:Date:From;
        b=NpvoazUQE7AuSvxBN+HHs3jZop66wud55sBuIuEyc54SIYSlPJeM/nq01IWJpamw0
         q0wx4lViXiOdndaBE1BK/NRQxh/yOYxVPozZDQP7KZ38eesEbPYin/+ALLbDY1XUMS
         NR8/l3IOYxuGYciAHPu/Ri3gVKhBOeAvsAr5LCIM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jason Chen <jason.z.chen@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ajay Gupta <ajayg@nvidia.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Peter Rosin <peda@axentia.se>, Petr Machata <petrm@nvidia.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: i2c: ov08x40: Make remove callback return void
Date:   Mon, 21 Nov 2022 17:34:47 +0000
Message-Id: <20221121173447.387248-1-kieran.bingham+renesas@ideasonboard.com>
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

The OV08x40 was not able to be compile tested at the time due to a
KConfig issue, and was missed.

Now that the OV08x40 is able to be selected, update the driver
accordingly.

Fixes: ed5c2f5fd10d ("i2c: Make remove callback return void")
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
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

