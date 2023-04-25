Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D636EDFB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjDYJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjDYJtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:49:16 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E737AA6;
        Tue, 25 Apr 2023 02:48:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E0A7DE218A;
        Tue, 25 Apr 2023 02:48:17 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vushg0EI5uh4; Tue, 25 Apr 2023 02:48:16 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1682416096; bh=htkeGWGZq0gFSHJqOcTrHfNQ30U5mGxJy6/7r//b6Ww=;
        h=From:To:Cc:Subject:Date:From;
        b=bgWqPBESIU25QMG7/GCBD90eLfRQVAlgRZK2DC+dUy1NoUeOZgI6WLOAto+XafvtU
         14BqHGq/4Icn9TyHsY28eQnSMfZtuTWW+RTsrqiJ6bRzylat9aFmBrml/GNfTyxndl
         JYSuPzdCRvbQLiim5+6diwKW4pi/iXKH1VrzyL5KlLPS2X+1J31WjzjtEX8FNraASC
         808vxtj88AgMR13q34oFsQDOXrwGYn48DdizcVAJYRl+Cqn28RNbR9RRXGMMfMEZBQ
         R98n5bgCBYTlQ3GhoE+a7msL+8OK1CHBJqxLdTxuntYGVzK4vby/34mV+zCr/3VDnT
         IEYw7qmDnp4Rg==
To:     laurent.pinchart@ideasonboard.com
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, martin.kepplinger@puri.sm,
        mchehab@kernel.org, sakari.ailus@iki.fi
Subject: [PATCH v2] media: hi846: fix usage of pm_runtime_get_if_in_use()
Date:   Tue, 25 Apr 2023 11:47:47 +0200
Message-Id: <20230425094747.2769693-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_if_in_use() does not only return nonzero values when
the device is in use, it can return a negative errno too.

And especially during resuming from system suspend, when runtime pm
is not yet up again, -EAGAIN is being returned, so the subsequent
pm_runtime_put() call results in a refcount underflow.

Fix system-resume by handling -EAGAIN of pm_runtime_get_if_in_use().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

revision history
----------------
v2 (thank you Sakari and Laurent):
* drop the other patch (the streaming-state in suspend/resume needs to
  be solved differently).
* Sakari pointed out that many drivers are affected by this and that
  runtime-pm might need changes instead. I think this patch doesn't hurt
  and could serve as a reminder to do so.

v1: initial submission:
https://lore.kernel.org/linux-media/20230405092904.1129395-1-martin.kepplinger@puri.sm/

 drivers/media/i2c/hi846.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 306dc35e925f..f8709cdf28b3 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1353,7 +1353,8 @@ static int hi846_set_ctrl(struct v4l2_ctrl *ctrl)
 					 exposure_max);
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	ret = pm_runtime_get_if_in_use(&client->dev);
+	if (!ret || ret == -EAGAIN)
 		return 0;
 
 	switch (ctrl->id) {
-- 
2.30.2

