Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5F6602C3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAFPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjAFPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:07:52 -0500
X-Greylist: delayed 2230 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 07:07:36 PST
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C0777D9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:07:36 -0800 (PST)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.146.76])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 272CA25ACD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 14:30:25 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rqjmb (unknown [10.111.172.194])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 700B11FF2C;
        Fri,  6 Jan 2023 14:30:24 +0000 (UTC)
Received: from sk2.org ([37.59.142.97])
        by ghost-submission-6684bf9d7b-rqjmb with ESMTPSA
        id lBj7FYAwuGPZygAAJ5VTDA
        (envelope-from <steve@sk2.org>); Fri, 06 Jan 2023 14:30:24 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-97G0024d129192-3f53-40a5-8aba-33e6275bc708,
                    9FE29456621203A27B372E1E0503D45BE0167874) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Stephen Kitt <steve@sk2.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
Date:   Fri,  6 Jan 2023 15:30:01 +0100
Message-Id: <20230106143002.1434266-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3495074787925264091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight_properties.fb_blank is deprecated. The states it represents
are handled by other properties; but instead of accessing those
properties directly, drivers should use the helpers provided by
backlight.h.

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

This means that BL_CORE_SUSPENDED is now taken into account, as it
should be.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---

Notes:
    Changes since v1: mention BL_CORE_SUSPENDED.

 drivers/auxdisplay/ht16k33.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index 02425991c159..15ab118c80f5 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -314,14 +314,9 @@ static int ht16k33_initialize(struct ht16k33_priv *priv)
 
 static int ht16k33_bl_update_status(struct backlight_device *bl)
 {
-	int brightness = bl->props.brightness;
+	int brightness = backlight_get_brightness(bl);
 	struct ht16k33_priv *priv = bl_get_data(bl);
 
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & BL_CORE_FBBLANK)
-		brightness = 0;
-
 	return ht16k33_brightness_set(priv, brightness);
 }
 
-- 
2.30.2

