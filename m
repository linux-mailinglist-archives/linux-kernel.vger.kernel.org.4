Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0676D788C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbjDEJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbjDEJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:38:59 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAF41BCD;
        Wed,  5 Apr 2023 02:38:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id AADA2EBD85;
        Wed,  5 Apr 2023 02:29:52 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gzx8Ou6BRyKA; Wed,  5 Apr 2023 02:29:52 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1680686991; bh=lBhbPCF1Y4hppeWsEQDV7v/uKE47NGMFGiQeVEMoCLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ+XhHgSha6aNpNiRwh5xIElof1z2G6wmwGi51ucJh2CJ9qjHisHZPxsLE4jkBEfw
         SfUEPsUgz5dOm2W2GGcbO+Es8ZMt1IVVpfppavp/RU7Hv+kWU1Af8pfBGfVmuqGPDz
         AYaWpxRxeEhJoHPBn7ZBxTBCXCye5EVupEkR+1BxzMa8XVwQvX2f1wUa5ZS/Kglz4u
         boIAamlgQA4Ignb3b+ZD9FUtHmMTh2sHOGGL/Ritg/b8uBgSU4YRUPw1ZAMXTAPG9i
         4vehL5AdeDjPhgyi93ZmgGkHgsoF4scrXwhpY6GM4dxXycNQDI0hJLD+llVTZaSAcV
         hb1U/XgGYEx6Q==
To:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com
Cc:     kernel@puri.sm, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/2] media: hi846: preserve the streaming state during system suspend
Date:   Wed,  5 Apr 2023 11:29:04 +0200
Message-Id: <20230405092904.1129395-3-martin.kepplinger@puri.sm>
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

The hi846 driver changed the "streaming" state inside of "start/stop_streaming".
The problem is that inside of the (system) suspend callback, it calls
"stop_streaming" unconditionally. So streaming would always be stopped
when suspending.

That makes sense with runtime pm for example, after s_stream(..., 0) but
does not preserve the "streaming" state during system suspend when
currently streaming.

Fix this by simply setting the streaming state outside of "start/stop_streaming"
which is s_stream().

While at it, improve things a bit by not assigning "1", but the "enable"
value we later compare against, and fix one error handling path in resume().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/media/i2c/hi846.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 0b0eda2e223cd..1ca6e9407d618 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1780,8 +1780,6 @@ static int hi846_start_streaming(struct hi846 *hi846)
 		return ret;
 	}
 
-	hi846->streaming = 1;
-
 	dev_dbg(&client->dev, "%s: started streaming successfully\n", __func__);
 
 	return ret;
@@ -1793,8 +1791,6 @@ static void hi846_stop_streaming(struct hi846 *hi846)
 
 	if (hi846_write_reg(hi846, HI846_REG_MODE_SELECT, HI846_MODE_STANDBY))
 		dev_err(&client->dev, "failed to stop stream");
-
-	hi846->streaming = 0;
 }
 
 static int hi846_set_stream(struct v4l2_subdev *sd, int enable)
@@ -1816,10 +1812,12 @@ static int hi846_set_stream(struct v4l2_subdev *sd, int enable)
 		}
 
 		ret = hi846_start_streaming(hi846);
+		hi846->streaming = enable;
 	}
 
 	if (!enable || ret) {
 		hi846_stop_streaming(hi846);
+		hi846->streaming = 0;
 		pm_runtime_put(&client->dev);
 	}
 
@@ -1898,6 +1896,8 @@ static int __maybe_unused hi846_resume(struct device *dev)
 		if (ret) {
 			dev_err(dev, "%s: start streaming failed: %d\n",
 				__func__, ret);
+			hi846_stop_streaming(hi846);
+			hi846->streaming = 0;
 			goto error;
 		}
 	}
-- 
2.30.2

