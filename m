Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326306FE47B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjEJT1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:27:35 -0400
Received: from mail-io1-xd4a.google.com (mail-io1-xd4a.google.com [IPv6:2607:f8b0:4864:20::d4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FA65A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:27:34 -0700 (PDT)
Received: by mail-io1-xd4a.google.com with SMTP id ca18e2360f4ac-760718e6878so1116933239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683746853; x=1686338853;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+inPJYpepp+ACSZW6BIAIkEOqyig746NS3gZIOmFwLQ=;
        b=zAfktYe/8hlDQRg91R5fUACj36UXWDHKU/UIuEYzUEIk9dDY8wfLWMXG5vSC6exkMH
         0+QVCoHESA6ZzzB+eh1uqdT6Xv9b4Gp5yrJVf7LB7ZcfMVLw0WDt3F5kPoIi7YKe6Uv/
         bo/qeYoqkBFePfOglnJ3I7Az3aq4uWI+H0rO9eKhwHJqAuWD4MlnqsCWgckrUktuYFyb
         0KftK9Qj5XguVZ5y2eWS9t2mJkTFIIWn9v2ZKRrcfwOye7NSIqemsoamkbBI2o6gCSqk
         ZWUMl8h18R+q53P56RwclMicEaDlYdEdxxtq0qDVedDGTMy9aFbGJ0OQf/A/ei+tsJ2d
         3nrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683746853; x=1686338853;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+inPJYpepp+ACSZW6BIAIkEOqyig746NS3gZIOmFwLQ=;
        b=If+aIcHQCkiltPc8ZFPi3wfe9Uj01JIw7UqbTs3dSvEp3vc9nXcCzD9sJcFtrlkXg6
         mPjnslq7RLryMs8rUkn72G0Jdm8Q+Hr9HN0CizUm+2af3qIcdqr0KCyz9l4JWwHQG8AU
         kOqUGB8PXScsZ05AZo6J0MPsvLIHb5G+J/CDe+4+WFKwtctFYAkB2D9YzxvVYZvtsDQy
         YK5Q3PApWLDrTPnMGPl99Y2/He7KxYDowqKKqnTO9E3WmE8ueuKGGZ4QxEoXu7kdCDIx
         RphpzshLRStKk/UwKrUnyk4m61ao5vcoYmc0GZIeRCZyLVCecp4L6PxCUVDqpXaedAnd
         AgVw==
X-Gm-Message-State: AC+VfDy1+J0/A5MijNn6F26sm2Um4WcTBjKl0O1KXCN8ZItebqgz5HRf
        YrughnPXG8X0HEYxraaQSlo4O4w87fk39ZpXTOIr
X-Google-Smtp-Source: ACHHUZ5fUmC0jL3VmaEhyRVfEVXyS7Zoj1O33yPSXCgoxzEUOxS+A7eDVyegeF8lL3pumdyUt/HOlmRpfNJJtuhYhwB/
X-Received: from horchata.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:5b3])
 (user=jefferymiller job=sendgmr) by 2002:a5e:dd05:0:b0:760:efd4:9582 with
 SMTP id t5-20020a5edd05000000b00760efd49582mr8964611iop.2.1683746853439; Wed,
 10 May 2023 12:27:33 -0700 (PDT)
Date:   Wed, 10 May 2023 19:27:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230510192731.300786-1-jefferymiller@google.com>
Subject: [PATCH] Input: synaptics-rmi4 - retry reading SMBus version on resume
From:   Jeffery Miller <jefferymiller@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrew Duggan <andrew@duggan.us>,
        Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Lyude Paul <lyude@redhat.com>, loic.poulain@linaro.org,
        benjamin.tissoires@redhat.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Jeffery Miller <jefferymiller@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
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

Adding a retry loop ensures that after rmi_smb_reset returns
the following rmi_driver_resume calls in rmi_smbus_resume can
succeed.

This behavior was seen on a Lenovo T440p machine that required
a delay of approximately 7-12ms.
The retry limit of 5 is chosen to be larger than
this observed delay.

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
rmi4_smbus 0-002c: PM: rmi_smb_resume ... returned 0 after 21351 usecs
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


 drivers/input/rmi4/rmi_smbus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 4bf0e1df6a4a..386e80ae141b 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -43,15 +43,26 @@ static int rmi_smb_get_version(struct rmi_smb_xport *rmi_smb)
 {
 	struct i2c_client *client = rmi_smb->client;
 	int retval;
+	int tries = 0;
 
 	/* Check if for SMBus new version device by reading version byte. */
-	retval = i2c_smbus_read_byte_data(client, SMB_PROTOCOL_VERSION_ADDRESS);
-	if (retval < 0) {
-		dev_err(&client->dev, "failed to get SMBus version number!\n");
-		return retval;
-	}
+	do {
+		if (tries > 0) {
+			dev_warn(&client->dev, "sleeping to retry getting the SMBus version number\n");
+			fsleep(5000);
+		}
+		retval = i2c_smbus_read_byte_data(client,
+				SMB_PROTOCOL_VERSION_ADDRESS);
+		if (retval >= 0)
+			return retval + 1;
 
-	return retval + 1;
+		dev_err(&client->dev, "failed to get SMBus version number!\n");
+		/* On resume the read of the version can
+		 * momentarily return -ENXIO.
+		 * Retry to allow additional time for it to succeed.
+		 */
+	} while (retval == -ENXIO && tries++ < 5);
+	return retval;
 }
 
 /* SMB block write - wrapper over ic2_smb_write_block */
-- 
2.40.1.606.ga4b1b128d6-goog

