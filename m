Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07169660551
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjAFRHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjAFRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:07:44 -0500
X-Greylist: delayed 1057 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 09:07:40 PST
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B5F8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:07:40 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.109.143.72])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id AF6232622D
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:49:58 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dkv5l (unknown [10.110.171.46])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id C0B041FF00;
        Fri,  6 Jan 2023 16:49:57 +0000 (UTC)
Received: from sk2.org ([37.59.142.107])
        by ghost-submission-6684bf9d7b-dkv5l with ESMTPSA
        id KI4TJzVRuGOnAQEAwhnnFg
        (envelope-from <steve@sk2.org>); Fri, 06 Jan 2023 16:49:57 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S0018fb2c2a3-f80b-4d71-80ed-2036c37f7c47,
                    9FE29456621203A27B372E1E0503D45BE0167874) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Stephen Kitt <steve@sk2.org>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Date:   Fri,  6 Jan 2023 17:48:52 +0100
Message-Id: <20230106164856.1453819-2-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5851864767681496795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 drivers/video/backlight/aat2870_bl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index a7af9adafad6..1cbb303e9c88 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -59,7 +59,7 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
 	struct aat2870_data *aat2870 =
 			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
-	int brightness = bd->props.brightness;
+	int brightness = backlight_get_brightness(bd);
 	int ret;
 
 	if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
@@ -70,11 +70,6 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
 		 bd->props.brightness, bd->props.power, bd->props.state);
 
-	if ((bd->props.power != FB_BLANK_UNBLANK) ||
-			(bd->props.state & BL_CORE_FBBLANK) ||
-			(bd->props.state & BL_CORE_SUSPENDED))
-		brightness = 0;
-
 	ret = aat2870->write(aat2870, AAT2870_BLM,
 			     (u8)aat2870_brightness(aat2870_bl, brightness));
 	if (ret < 0)
-- 
2.30.2

