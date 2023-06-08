Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732427289E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjFHVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjFHVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:04:08 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA82D4B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:04:06 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-77a13410773so90625839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686258246; x=1688850246;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vXxdCwOvLUUiF6F8HOMzi7EV2zdJ4C5gOBnag2vUVGI=;
        b=MmZXhNVStB0tURf0s1/F6llfQeeyVyu+HDHAVIPO797lBjbb+B/UVmzi2i0ziVPhU1
         /ijQja1MSl23HtvyT/P8E4s6oAUmIuNilwbp8wK5ZgWZMccRQitljdDyMvygmNj/wi7P
         3dhdkG+CFEVFeZauyXE07wGGBebSA2iZe6KBAnXmsexJFCvrHXPY1a65XJsZ140patU1
         RH/tmtgF6qsPBYi4ye3OKl2SCYrV7MrfRhH+vkHIltIMbaG+dr0k7BtM8sAbx7PQzml9
         yJjjcEnyAUbku52Wh1w4NItH4PL///JJQC20p0sLUVqDN4rwTcUWgAzR9Rq1R+MJszuG
         C90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686258246; x=1688850246;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vXxdCwOvLUUiF6F8HOMzi7EV2zdJ4C5gOBnag2vUVGI=;
        b=N2khGikcRfedy+aHPBiutIwUcprGrn4SC99Ugyr1cnlG1XkuN2HYtPF+TXLCjFZiAP
         IfRgZZ7PaPFldJNq4EY4k8ZvIJXg5s73d6ZhQqoNihmE4CSsUihCxNxpJo/4xF0m6FJt
         DhwUQGvVfeIqJjmeGGv8zf7eSQDRC8Pcu7lJ835QLEY8cztv5igzT4D+PcivVFkVtHuV
         U+L1TRnH5p7CnpcjA5+08AY7iufMMvsngFoHMca3meDmfziQaCmPgbtTN0UVe9FEunLv
         qJHilkY/MEffnwO5Z+Fy8whrUkEgyjSkhsOVy6QAX235xF2WN+G8pRfV4WBhlpoyfX71
         LAeg==
X-Gm-Message-State: AC+VfDzoEAvIJ0ZNDBqVG3uaKcMTU/E6WZCBeeGlA6OeTHwV2d3T6bZa
        Fg1evRY+j2wZuRd7W0Ajd3F8qUrkiFRxzbbUnbAg
X-Google-Smtp-Source: ACHHUZ4FIL05PKpg+uVO+IvNPjuz0Ztw5ysDj2LubSnmFKyFJOLkydcGFpSd1kjthVezhfOLSmaH+WgZR+/nw+bgAIfQ
X-Received: from horchata.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:5b3])
 (user=jefferymiller job=sendgmr) by 2002:a92:c00e:0:b0:335:908b:8f9 with SMTP
 id q14-20020a92c00e000000b00335908b08f9mr4461311ild.1.1686258246194; Thu, 08
 Jun 2023 14:04:06 -0700 (PDT)
Date:   Thu,  8 Jun 2023 21:04:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230608210404.722123-1-jefferymiller@google.com>
Subject: [PATCH v3] Input: synaptics-rmi4 - retry reading SMBus version on resume
From:   Jeffery Miller <jefferymiller@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Lyude Paul <lyude@redhat.com>, benjamin.tissoires@redhat.com,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        Andrew Duggan <aduggan@synaptics.com>,
        Jeffery Miller <jefferymiller@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" 
        <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On resume there can be a period of time after the
preceding serio_resume -> psmouse_deactivate call
where calls to rmi_smb_get_version fail with
-ENXIO.

The call path in rmi_smb_resume is rmi_smb_resume -> rmi_smb_reset ->
rmi_smb_enable_smbus_mode -> rmi_smb_get_version where
this failure would occur.

Add a 30ms delay and retry in the ENXIO case to ensure the following
rmi_driver_resume calls in rmi_smbus_resume can succeed.

This behavior was seen on a Lenovo T440p machine that required
a delay of approximately 7-12ms.

The 30ms delay was chosen based on the linux-input message:
Link: https://lore.kernel.org/all/BYAPR03MB47572F2C65E52ED673238D41B2439@BYAPR03MB4757.namprd03.prod.outlook.com/

With this patch the trimmed resume logs look similar to:
```
psmouse serio1: PM: calling serio_resume+0x0/0x8c @ 5399, parent: i8042
[5399] libps2:__ps2_command:316: psmouse serio1: f5 [] - 0/00000000 []
psmouse serio1: PM: serio_resume+0x0/0x8c returned 0 after 3259 usecs
...
rmi4_smbus 0-002c: PM: calling rmi_smb_resume ... @ 5454, parent: i2c-0
...
[5454] i2c_i801:i801_check_post:414: i801_smbus 0000:00:1f.3: No response
smbus_result: i2c-0 a=02c f=0000 c=fd BYTE_DATA rd res=-6
rmi4_smbus 0-002c: failed to get SMBus version number!
rmi4_smbus 0-002c: sleeping to retry getting the SMBus version number
...
rmi4_smbus 0-002c: PM: rmi_smb_resume ... returned 0 after 41351 usecs
```

Signed-off-by: Jeffery Miller <jefferymiller@google.com>
---

Early boot dmesg include:
```
rmi4_smbus 0-002c: registering SMbus-connected sensor
rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM2722-001, fw id: 0
```

The resume order looks correct. The `psmouse serio1` resume returns
before the rmi_smb_resume is called showing the patch from
https://lore.kernel.org/all/89456fcd-a113-4c82-4b10-a9bcaefac68f@google.com/
is applied and working for that ordering.

I attempted to try to rule out some interaction between the concurrent
input resume calls for other i8042 devices.
Adding a 7ms delay after psmouse_deactivate which is called in the
preceding psmouse serio1 serio_resume function also allows
this version call to succeed.

If the rmi_smb_probe device_disable_async_suspend patch is applied
it will also avoid this issue. However the time between
the psmouse_deactivate call for serio_resume and rmi_smb_resume
was over 60ms on my test machine. This would naturally be long
enough to avoid this particular delay.


Changes in v3:
- Tagged mail message Link to resolve checkpatch warning.

Changes in v2:
- Changed to a single retry of 30ms based on previous feedback.

 drivers/input/rmi4/rmi_smbus.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 4bf0e1df6a4a..b6d90c92e8a2 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -45,13 +45,25 @@ static int rmi_smb_get_version(struct rmi_smb_xport *rmi_smb)
 	int retval;
 
 	/* Check if for SMBus new version device by reading version byte. */
-	retval = i2c_smbus_read_byte_data(client, SMB_PROTOCOL_VERSION_ADDRESS);
-	if (retval < 0) {
+	for (int i = 0; i < 2; i++) {
+		if (i > 0) {
+			dev_warn(&client->dev, "sleeping to retry getting the SMBus version number\n");
+			fsleep(30000);
+		}
+		retval = i2c_smbus_read_byte_data(client,
+				SMB_PROTOCOL_VERSION_ADDRESS);
+		if (retval >= 0)
+			return retval + 1;
+
 		dev_err(&client->dev, "failed to get SMBus version number!\n");
-		return retval;
+		/* There can be a delay on resume where the read returns
+		 * -ENXIO. Retry to allow additional time for the read
+		 *  to become responsive.
+		 */
+		if (retval != -ENXIO)
+			break;
 	}
-
-	return retval + 1;
+	return retval;
 }
 
 /* SMB block write - wrapper over ic2_smb_write_block */
-- 
2.41.0.162.gfafddb0af9-goog

