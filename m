Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9517A62E51F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbiKQTPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbiKQTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:15:37 -0500
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2128A145;
        Thu, 17 Nov 2022 11:15:29 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668712527; x=1668971727;
        bh=T794GTPNQYc9tJalhy0LCsNElYleSnXWekOIp9tkVi0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IxQ1YJ5wAd8KJ78vIc00OjS2Xh+FtGl1k4Q9GwmnOJxz0WfgISGUPwUWAdSGyzGnt
         NUcrvqSyd35VvL+y4Wnz7ayE5k4QlG/3e+76AqoxGn0B0Y5PbqzMGX2gXewS5JYgfj
         0aa8aQxxt5Uppe55fGBCCbtu0u3BcfKFgNujnFt6RiGycUC8mQrsEeRZmzEzj9K4+Z
         GcRNl2mN1x42ANtAW3+ELkT07Q2EVv3GsSdUfZKoaNwiAwxbnJRhqPiYb/DvdktISe
         kIE6FZUyxf2ted3bcb9NKNF+aZhyGbZOCHzT79kulsoc0emFvNa8uaXIWruwK+9HY9
         XGVg0+NRV+UFA==
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
Subject: [RESNED PATCH 2/3] input/touchscreen: imagis: Correct the maximum touch area value
Message-ID: <20221117191436.87938-3-linmengbo0689@protonmail.com>
In-Reply-To: <20221117191436.87938-1-linmengbo0689@protonmail.com>
References: <20221117191436.87938-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markuss Broks <markuss.broks@gmail.com>

As specified in downstream IST3038/IST30XXB driver and proved by testing,
the correct maximum reported value of touch area is 16.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
[Change from IST3038B to IST3038 and IST30XXB]
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


