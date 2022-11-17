Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6913B62DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbiKQO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbiKQO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:28:44 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293951261B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:28:42 -0800 (PST)
Date:   Thu, 17 Nov 2022 14:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668695315; x=1668954515;
        bh=h8QUQMuBeId16fwT8sIh6ZqutzDewiMZtFIp21P7mOY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=cLYLHTMvI4pQQtyVvzPKzaE42SZoN0qoVPQeQLANiJ77ipklFCAlKAu9C2fUV9eQn
         B+dBlatkXMTkQhcJxLeUiX5os+iXkuE6Dny9XEf+idfQzdHupDpmBG/f6/MHmuA7Lr
         XEd9hN5wfk4hjQEfPv1xyMlEAh3lnNglucGJ2Xdk43Vwhsz2JpZFKojtMoU4tDd1lf
         YP3z2yogAUeXhmE3lTxsdYliSWbIy5uNXp1g7nrsotbj8VmDvtOGHEq5ekFX3m6LdO
         i1eJuzY10Jz64eFubqo79KYtQfTU/717jpWZI7ABXH9twBqmoSps8Uow3PsOpbOHes
         aCVnYVrwm/oQw==
To:     linux-input@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Corey Minyard <cminyard@mvista.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] Input: stmfts - retry commands after timeout
Message-ID: <20221117142753.2477-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #define STMFTS_RETRY_COUNT 3 to retry stmfts_command() 3 times.
Without it, STMFTS_SYSTEM_RESET or STMFTS_SLEEP_OUT may return -110 to
failed attempt due to no event received for completion.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/input/touchscreen/stmfts.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen=
/stmfts.c
index d5bd170808fb..22de34966373 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -68,6 +68,7 @@
 #define STMFTS_DATA_MAX_SIZE=09(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
 #define STMFTS_MAX_FINGERS=0910
 #define STMFTS_DEV_NAME=09=09"stmfts"
+#define STMFTS_RETRY_COUNT=093
=20
 enum stmfts_regulators {
 =09STMFTS_REGULATOR_VDD,
@@ -317,19 +318,20 @@ static irqreturn_t stmfts_irq_handler(int irq, void *=
dev)
=20
 static int stmfts_command(struct stmfts_data *sdata, const u8 cmd)
 {
-=09int err;
+=09int err, retry;
=20
 =09reinit_completion(&sdata->cmd_done);
=20
-=09err =3D i2c_smbus_write_byte(sdata->client, cmd);
-=09if (err)
-=09=09return err;
-
-=09if (!wait_for_completion_timeout(&sdata->cmd_done,
-=09=09=09=09=09 msecs_to_jiffies(1000)))
-=09=09return -ETIMEDOUT;
+=09for (retry =3D 0; retry < STMFTS_RETRY_COUNT; retry++) {
+=09=09err =3D i2c_smbus_write_byte(sdata->client, cmd);
+=09=09if (err)
+=09=09=09return err;
=20
-=09return 0;
+=09=09if (wait_for_completion_timeout(&sdata->cmd_done,
+=09=09=09=09=09=09msecs_to_jiffies(1000)))
+=09=09=09return 0;
+=09}
+=09return -ETIMEDOUT;
 }
=20
 static int stmfts_input_open(struct input_dev *dev)
--=20
2.30.2


