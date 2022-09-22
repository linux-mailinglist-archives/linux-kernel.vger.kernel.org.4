Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF9D5E62D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiIVMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiIVMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:52:49 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 05:52:46 PDT
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E51E7C03
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:52:46 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYFLs2jySzMqJ30;
        Thu, 22 Sep 2022 14:43:17 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYFLs0bwZzx4;
        Thu, 22 Sep 2022 14:43:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1663850597;
        bh=+OIz10N0TA8uuQex2ybW9n6SGAbwcDokvY4GhIEiPro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=av5JMroOBKiey1Rx1ox6FjGZK+pgv1N0kM2fJGIJQoRKGafLPwBJVCoDSFa6SUGqI
         g8ADwi3jh/0D6nX3yIlEH1zclnikto68pCqs73JC6BBfYefSo8s2zfn9iOqaowkshn
         S/dK2UHJ0GuyVRFlJjqXjav6u9iF4sZRgbKJVCPo=
From:   Philippe Schenker <dev@pschenker.ch>
To:     dri-devel@lists.freedesktop.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 3/4] drm/bridge: lt8912b: fix corrupted image output
Date:   Thu, 22 Sep 2022 14:43:05 +0200
Message-Id: <20220922124306.34729-4-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922124306.34729-1-dev@pschenker.ch>
References: <20220922124306.34729-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Correct I2C address for the register list in lt8912_write_lvds_config(),
these registers are on the first I2C address (0x48), the current
function is just writing garbage to the wrong registers and this creates
multiple issues (artifacts and output completely corrupted) on some HDMI
displays.

Correct I2C address comes from Lontium documentation and it is the one
used on other out-of-tree LT8912B drivers [1].

[1] https://github.com/boundarydevices/linux/blob/boundary-imx_5.10.x_2.0.0/drivers/video/lt8912.c#L296

Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 6a4bb7422176..5968f4af190b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -188,7 +188,7 @@ static int lt8912_write_lvds_config(struct lt8912 *lt)
 		{0x03, 0xff},
 	};
 
-	return regmap_multi_reg_write(lt->regmap[I2C_CEC_DSI], seq, ARRAY_SIZE(seq));
+	return regmap_multi_reg_write(lt->regmap[I2C_MAIN], seq, ARRAY_SIZE(seq));
 };
 
 static inline struct lt8912 *bridge_to_lt8912(struct drm_bridge *b)
-- 
2.37.3

