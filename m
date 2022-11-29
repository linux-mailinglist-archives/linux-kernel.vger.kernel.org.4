Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34BD63CA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbiK2V3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiK2V3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:29:48 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4B5655B;
        Tue, 29 Nov 2022 13:29:47 -0800 (PST)
Received: from g550jk.arnhem.chello.nl (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DA61BCAAFE;
        Tue, 29 Nov 2022 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1669757356; bh=cyHwj60MQxWv+m1wQhw3cegdMX2JlrYI3TaYhQorhOg=;
        h=From:To:Cc:Subject:Date;
        b=djwIltTvulexjuIPgOcxRiEWJlxKVrmB8/k6c7irIRfQyF/zcg+SokWaHQuhmsd2k
         wZAPEATvtEhvhEuLopoBthJ7I/LPvU9aSzf70GWep87HZNLKfpXK/Md2F4jl1O66Mu
         UVn8cCWeqLcgqA3+pvb7QdPzClbutk0WasVtEtPE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-leds@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] leds: is31fl319x: Fix setting current limit for is31fl319{0,1,3}
Date:   Tue, 29 Nov 2022 22:29:01 +0100
Message-Id: <20221129212901.1049085-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current setting lives in bits 4:2 (as also defined by the mask) but
the current limit defines in the driver use bits 2:0 which should be
shifted over so they don't get masked out completely (except for 17.5mA
which became 10mA).

Now checking /sys/kernel/debug/regmap/1-0068/registers shows that the
current limit is applied correctly and doesn't take the default b000 =
42mA.

Fixes: fa877cf1abb9 ("leds: is31fl319x: Add support for is31fl319{0,1,3} chips")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Cross-checked with SN3193 datasheet I found online and downstream
driver, but please double check also against any info you have.

The SN3193 is used on msm8974pro-oneplus-bacon and I will send a patch
in the future to add it to the dts.

 drivers/leds/leds-is31fl319x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319x.c
index 52b59b62f437..b2f4c4ec7c56 100644
--- a/drivers/leds/leds-is31fl319x.c
+++ b/drivers/leds/leds-is31fl319x.c
@@ -38,6 +38,7 @@
 #define IS31FL3190_CURRENT_uA_MIN	5000
 #define IS31FL3190_CURRENT_uA_DEFAULT	42000
 #define IS31FL3190_CURRENT_uA_MAX	42000
+#define IS31FL3190_CURRENT_SHIFT	2
 #define IS31FL3190_CURRENT_MASK		GENMASK(4, 2)
 #define IS31FL3190_CURRENT_5_mA		0x02
 #define IS31FL3190_CURRENT_10_mA	0x01
@@ -553,7 +554,7 @@ static int is31fl319x_probe(struct i2c_client *client)
 			     is31fl3196_db_to_gain(is31->audio_gain_db));
 	else
 		regmap_update_bits(is31->regmap, IS31FL3190_CURRENT, IS31FL3190_CURRENT_MASK,
-				   is31fl3190_microamp_to_cs(dev, aggregated_led_microamp));
+				   is31fl3190_microamp_to_cs(dev, aggregated_led_microamp) << IS31FL3190_CURRENT_SHIFT);
 
 	for (i = 0; i < is31->cdef->num_leds; i++) {
 		struct is31fl319x_led *led = &is31->leds[i];
-- 
2.38.1

