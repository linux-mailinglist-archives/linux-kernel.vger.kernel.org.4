Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34963E26B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiK3VC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK3VCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:02:25 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC5E837ED;
        Wed, 30 Nov 2022 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1669842142; bh=gVzGEYVjD0h5I9/deBEqHQ2NmlqOqDxgiAHZGpIxWVs=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=es000FQP0pFBzLOxjLEKQGFCpMCpBPeA1m8bPE18E83gRC2rDVCcsTRpkNX/xykqy
         u0R9Vc2d/fURgLSQ0jHuSA1ipydXQ0/ncba3Q/ujjaE77zXYQPOtwst4p9e5FPsK1c
         C8p3kqoYxW+pOAxHsvr2W9YMRnYlNwofscc6Z9eQ=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Wed, 30 Nov 2022 22:02:22 +0100 (CET)
X-EA-Auth: npvI2yDxuBEDTjMfik9gmG6DPGyCOW1KAjRF/d2wxd+dCF6U1o7QEM8BkGz24Rpc5tGn+OzxDalVUMg9V87xLqHwwKFl14OZrfqD0Fr253Y=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org
Subject: [PATCH RESEND] Input: msg2638 - only read linux,keycodes array if necessary
Date:   Wed, 30 Nov 2022 22:01:59 +0100
Message-Id: <20221130210202.2069213-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux,keycodes property is optional.
Fix the driver not probing when it's not specified.

Fixes: c18ef50346f2 ("Input: msg2638 - add support for msg2138 key events")
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
Resending because of mailing issue,
ie. not appearing on mailing lists.
---
 drivers/input/touchscreen/msg2638.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/msg2638.c b/drivers/input/touchscreen/msg2638.c
index 51b1c0e8a761..4c0816b09d33 100644
--- a/drivers/input/touchscreen/msg2638.c
+++ b/drivers/input/touchscreen/msg2638.c
@@ -412,13 +412,15 @@ static int msg2638_ts_probe(struct i2c_client *client)
 		msg2638->num_keycodes = ARRAY_SIZE(msg2638->keycodes);
 	}
 
-	error = device_property_read_u32_array(dev, "linux,keycodes",
-					       msg2638->keycodes,
-					       msg2638->num_keycodes);
-	if (error) {
-		dev_err(dev, "Unable to read linux,keycodes values: %d\n",
-			error);
-		return error;
+	if (msg2638->num_keycodes > 0) {
+		error = device_property_read_u32_array(dev, "linux,keycodes",
+						       msg2638->keycodes,
+						       msg2638->num_keycodes);
+		if (error) {
+			dev_err(dev, "Unable to read linux,keycodes values: %d\n",
+				error);
+			return error;
+		}
 	}
 
 	error = devm_request_threaded_irq(dev, client->irq,
-- 
2.38.1



