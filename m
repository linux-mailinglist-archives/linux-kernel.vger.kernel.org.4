Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34524660527
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjAFQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjAFQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:57:16 -0500
X-Greylist: delayed 7777 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 08:57:14 PST
Received: from 7.mo575.mail-out.ovh.net (7.mo575.mail-out.ovh.net [46.105.63.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E510B7A38F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:57:14 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.20.16])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id D0A07259FB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:50:00 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-dkv5l (unknown [10.110.171.46])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 130501FEBF;
        Fri,  6 Jan 2023 16:50:00 +0000 (UTC)
Received: from sk2.org ([37.59.142.107])
        by ghost-submission-6684bf9d7b-dkv5l with ESMTPSA
        id 6P5cAjhRuGOnAQEAwhnnFg
        (envelope-from <steve@sk2.org>); Fri, 06 Jan 2023 16:50:00 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-107S0011a1aef4d-84f6-4e9b-be06-f9755663a738,
                    9FE29456621203A27B372E1E0503D45BE0167874) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Stephen Kitt <steve@sk2.org>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/4] backlight: ipaq_micro: Use backlight helper
Date:   Fri,  6 Jan 2023 17:48:54 +0100
Message-Id: <20230106164856.1453819-4-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5852427716709222107
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdelhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/video/backlight/ipaq_micro_bl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/backlight/ipaq_micro_bl.c b/drivers/video/backlight/ipaq_micro_bl.c
index 85b16cc82878..f595b8c8cbb2 100644
--- a/drivers/video/backlight/ipaq_micro_bl.c
+++ b/drivers/video/backlight/ipaq_micro_bl.c
@@ -16,17 +16,12 @@
 static int micro_bl_update_status(struct backlight_device *bd)
 {
 	struct ipaq_micro *micro = dev_get_drvdata(&bd->dev);
-	int intensity = bd->props.brightness;
+	int intensity = backlight_get_brightness(bd);
 	struct ipaq_micro_msg msg = {
 		.id = MSG_BACKLIGHT,
 		.tx_len = 3,
 	};
 
-	if (bd->props.power != FB_BLANK_UNBLANK)
-		intensity = 0;
-	if (bd->props.state & (BL_CORE_FBBLANK | BL_CORE_SUSPENDED))
-		intensity = 0;
-
 	/*
 	 * Message format:
 	 * Byte 0: backlight instance (usually 1)
-- 
2.30.2

