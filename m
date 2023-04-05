Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726FB6D7890
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbjDEJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjDEJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:39:17 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A6E45;
        Wed,  5 Apr 2023 02:39:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 92502EBEA7;
        Wed,  5 Apr 2023 02:29:50 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XkIvBR3ZAw1f; Wed,  5 Apr 2023 02:29:49 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1680686989; bh=J+SamVitwrn6CSgDX3gHlDODJDXG4R3njYfPnja5Jks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDNMOi4apUwBdA6TXv0o8U8+by8UsFv1XJ5M6skx4DGbgp2CDK461L5iRaVc4ww0J
         M+/zQYDA6IR4BhqXlxvu+oFW3V5stI27gUa3cPeJFr5bY/P2xL8BAa+g6t32wQXjWT
         kNjdPdJ0R0ALVZoUk35Fben1X5i3tBTAXGp9XkwXIf4nczOxVqnE6UuoCGxTya1pKx
         g2erFkmlWiboKNeSe/lc/ZX9SIKPJp/V1Fs9Q6kz0OJObYtWT377N/tffdac+tpVYb
         Ya1tiupdpMorc3npNqmBwARch79BffWirqR/H248dZnDumjArgkS2qmzqGruX+ZJRj
         fJ+TU8dZw/kmg==
To:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 1/2] media: hi846: fix usage of pm_runtime_get_if_in_use()
Date:   Wed,  5 Apr 2023 11:29:03 +0200
Message-Id: <20230405092904.1129395-2-martin.kepplinger@puri.sm>
In-Reply-To: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
References: <20230405092904.1129395-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_if_in_use() does not only return nonzero values when
the device is in use, it can return a negative errno too.

And especially during resuming from system suspend, when runtime pm
is not yet up again, this can very well happen. And in such a case
the subsequent pm_runtime_put() call would result in a refcount underflow!

Fix it by correctly using pm_runtime_get_if_in_use().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/media/i2c/hi846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 5b5ea5425e984..0b0eda2e223cd 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1544,7 +1544,7 @@ static int hi846_set_ctrl(struct v4l2_ctrl *ctrl)
 					 exposure_max);
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	if (pm_runtime_get_if_in_use(&client->dev) <= 0)
 		return 0;
 
 	switch (ctrl->id) {
-- 
2.30.2

