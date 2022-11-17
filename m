Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7758B62E218
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbiKQQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiKQQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:36:13 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF8B73426
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:35:20 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:35:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668702916; x=1668962116;
        bh=T794GTPNQYc9tJalhy0LCsNElYleSnXWekOIp9tkVi0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gwkXwMZwxr4Avx4oXTOoKywGukieqd7ts3LOAGkWKLd6fsJJzdyBPn099Y4jm/2KU
         v5hbnHhlv5LIumBS7L5F9JGJzfsvGI6iCTGRnv2Wzlsn4U2jySV6RYjCtuSGfkTgvi
         o0KxlyrxWicBL50lDvJQdOLK2uvq8magN75kPT0BXvR7N/7vfxnAydfpYgJGfQyowh
         Fb9GMxLZx7kBSOZCSzY0jsGiBSDm9WnuUVh6pTaG4pi7iYHzVXgNUVHwi+DxDptDHm
         /ZYwSNDKRcBFlCPIKKC82cK5QR1tH+AcZExLRGdWXhMJz5Xax+3gvUDfVpaVfUwd+9
         TllrvZV4mDkoA==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>
Subject: [PATCH 2/3] input/touchscreen: imagis: Correct the maximum touch area value
Message-ID: <20221117163440.23394-3-linmengbo0689@protonmail.com>
In-Reply-To: <20221117163440.23394-1-linmengbo0689@protonmail.com>
References: <20221117163440.23394-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
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


