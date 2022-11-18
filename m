Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B5462FC78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbiKRSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbiKRSVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:21:50 -0500
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FAB7DECB;
        Fri, 18 Nov 2022 10:21:49 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668795708; x=1669054908;
        bh=4aGhH9EhVaylkFLr9Cl301UNeKoyJLsI4X3gUZFSH9M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Z5HVHKGDen/kzJHlqMSklLwNX41bXVqxyGPXLYKWygFVqURHUnbdLDs1VBD+MX1/3
         nchNN+godIa5cgNoazTOpsyZGdiGyfhS5fzP5xj9pJFlkx89hiLyF2OtI7hFDrybeZ
         +fCNGDuCPhgbHxPpol81P8tcn+DYMSS/vai5TxpQhaD7AqwjyCDZbYT0FZE6Xa1jcP
         6BsZrLKqR06JkZ9lPYhB168Q5wWlT1kXIVHJTSmau7yUom7Uo+MywpGRLbQNgW8t4a
         tNYK9zIP/radRqL6skV4JFdi3Yy5PLcSq+H5LQf6j99cLs7LCy6DR4j2TX+/nqeJMy
         47FFiqmcI7czg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 2/3] input/touchscreen: imagis: Correct the maximum touch area value
Message-ID: <20221118182103.3405-3-linmengbo0689@protonmail.com>
In-Reply-To: <20221118182103.3405-1-linmengbo0689@protonmail.com>
References: <20221118182103.3405-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markuss Broks <markuss.broks@gmail.com>

As specified in downstream IST3038 driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Change from IST3038B to IST3038]
Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/input/touchscreen/imagis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen=
/imagis.c
index e2697e6c6d2a..b667914a44f1 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -210,7 +210,7 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
=20
 =09input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 =09input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-=09input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+=09input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
=20
 =09touchscreen_parse_properties(input_dev, true, &ts->prop);
 =09if (!ts->prop.max_x || !ts->prop.max_y) {
--=20
2.30.2


