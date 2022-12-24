Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82065585D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 05:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiLXETe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 23:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLXETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:19:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF941CB14;
        Fri, 23 Dec 2022 20:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671855540; bh=5PoiGuKTjTB2f9D4z+MnZKdOvcx2VJpMI8xwt9UGaxg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WnFVltG1bY+7NVl6gfuDWom0b0Dx0Mgy2UI4yUSie5PlVXvx+jB0G3pNanK3QlyTs
         DOYrBpfsM4b13rWxYC4mCQcp2LzxA7Lbxh90GGVIUj5MOtuQuVzON7evI7lA7izLbM
         eV6wOr+kOglPbgIJz2M2fTUNYJZw4KGeTqPCIaDJpUOX2He9oBaU2vzaFXOPLxW0+L
         SBcJAENjN6uNEnWvZSMaBtFHGPfL0vV0132jCZZ5SKePeaRLsZf0hmGRPYosJN8+Ou
         KX69b+CeOGgH4qq+2ggfccxhmKV1CnohV0xk58LJ6viuve3XSeBWWNs9H9f3J6NTHU
         QGOJCGQjEJdfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MirjS-1od9Tk2KYO-00euL0; Sat, 24 Dec 2022 05:19:00 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (ftsteutates) Fix scaling of measurements
Date:   Sat, 24 Dec 2022 05:18:53 +0100
Message-Id: <20221224041855.83981-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221224041855.83981-1-W_Armin@gmx.de>
References: <20221224041855.83981-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zwsmSLNj/mM9MGI2msAmznXpdXUl/1DAJ8f8clp9J97TVKEyIhw
 AoGW6GY3BGa5Wll0tpAH7rabhsDh4rDa/JHVkU/DCYoGmo72w9JLjiVMFkV7H7XKhl/QH/g
 ju45yhE8jQw5dlCefEvkMpOrR8PSpwuRgBrmvLEyh4C62QnlmZkutxT9VCNN9qQHpCMkT/Z
 bTHizQjYALjtuZgpdCqaQ==
UI-OutboundReport: notjunk:1;M01:P0:AOpju1sjKI8=;5PPtJWo1UXanX9WNFPqb27wSHH0
 pUDlqwuEnp9RuN9cudXP5f8l+ybmehDFT/1wG1soDFFQHwHNStqH57zCPTHlY8YI8v0la347F
 0by9KCCfAco79UG4A9oSh81pINHeFZJZ2sPPo42Z0SsBvgrGc/XOp0HKnMhVSmfxXouZmH/f5
 sFPXQS6BrrBj61necy2ERgAvO0FlC3cTHqCmFyPKGnD9N0ghzOh7IfEDT3yO6I2aPW/Tgq+EW
 tLwtX+VQjuoFFM3ZT1dVEo3Xcx6fl01sK1OdTxLGPRk58FBLmHzTH6rqUPD3jaQra2UPB74TB
 hhg8bU1hX6VjlAi15ZvYHhfySoVniLTlyZ8rmPvIawu6UmAX0vbnCSHunbb5x/QWuwFWwOI3r
 T1rR2NcMcCAG1Ez/wDqU7/Mj5pABBTXLnVZZegVopHB8g9kWod3axREl/BRejDhrnYilId+Bi
 47AOgvVMPaLHQmww+mlzPf67uw6QnF3Xy3v7Qb2FkIH5f8bbq3OvaVnKbKGZ1OuQmLNL/3BUJ
 sHiND6AxZwc2Lkehg2uR2ZPQVD6E1eKww//lLccn1fg3Zx3vzJl2zSWUQCzIonBF+OKMHxu5L
 oOBbmMylbtTpOefigQ1PebBmgeP6mGRHQ2L4tTruL4JfEvBtVuF4sawnDxtmCystHOIKFZEoH
 5d0UeK5ZUGWFB9w9aZ7xfuu5vU5GVytaTkYAMx0CVYUqUVd3l+6JNF0ciydjtrSnwY7jZL72t
 n/eZuk925vseTbXqDuYn78ENAi5EYHgZDZf8Xj2N8E19He00q0Nn+OzJM5zBSej4wyv6UtjhT
 BLqADd2ah17GZw1l/T7NLmmLA1FU7S3KjMCypKh3yBymJm6pG+qhptv4iX+42pLQdgUkSWeSg
 EQ3AVbQkU7/rF9f7GE8TRUcWiy38Ek2iKD8oEugXMrcVm7OGij/vu7aKslPOgswO1QZrtHTUr
 1qjjlcnpXeeOAUIRH9yulzUQAN8=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user complained that the ftsteutates driver was displaying
bogus values since its introduction. This happens because the
sensor measurements need to be scaled in order to produce
meaningful results:
- the fan speed needs to be multiplied by 60 since its in RPS
- the temperature is in degrees celsius and needs an offset of 64
- the voltage is in 1/256 of 3.3V

The offical datasheet says the voltage needs to be divided by 256,
but this is likely an off-by-one-error, since even the BIOS
devides by 255 (otherwise 3.3V could not be measured).

The voltage channels additionally need a board-specific multiplier,
however this can be done by the driver since its board-specific.

The reason the missing scaling of measurements is the way Fujitsu
used this driver when it was still out-of-tree. Back then, all
scaling was done in userspace by libsensors, even the generic one.

Tested on a Fujitsu DS3401-B1.

Fixes: 08426eda58e0 ("hwmon: Add driver for FTS BMC chip "Teutates"")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/ftsteutates.rst |  4 ++++
 drivers/hwmon/ftsteutates.c         | 19 +++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/fts=
teutates.rst
index 58a2483d8d0d..198fa8e2819d 100644
=2D-- a/Documentation/hwmon/ftsteutates.rst
+++ b/Documentation/hwmon/ftsteutates.rst
@@ -22,6 +22,10 @@ enhancements. It can monitor up to 4 voltages, 16 tempe=
ratures and
 8 fans. It also contains an integrated watchdog which is currently
 implemented in this driver.

+The 4 voltages require a board-specific multiplier, since the BMC can
+only measure voltages up to 3.3V and thus relies on voltage dividers.
+Consult your motherboard manual for details.
+
 To clear a temperature or fan alarm, execute the following command with t=
he
 correct path to the alarm file::

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index f5b8e724a8ca..ffa0bb364877 100644
=2D-- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -12,6 +12,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -347,13 +348,15 @@ static ssize_t in_value_show(struct device *dev,
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
 	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+	int value, err;

 	err =3D fts_update_device(data);
 	if (err < 0)
 		return err;

-	return sprintf(buf, "%u\n", data->volt[index]);
+	value =3D DIV_ROUND_CLOSEST(data->volt[index] * 3300, 255);
+
+	return sprintf(buf, "%d\n", value);
 }

 static ssize_t temp_value_show(struct device *dev,
@@ -361,13 +364,15 @@ static ssize_t temp_value_show(struct device *dev,
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
 	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+	int value, err;

 	err =3D fts_update_device(data);
 	if (err < 0)
 		return err;

-	return sprintf(buf, "%u\n", data->temp_input[index]);
+	value =3D (data->temp_input[index] - 64) * 1000;
+
+	return sprintf(buf, "%d\n", value);
 }

 static ssize_t temp_fault_show(struct device *dev,
@@ -436,13 +441,15 @@ static ssize_t fan_value_show(struct device *dev,
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
 	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+	int value, err;

 	err =3D fts_update_device(data);
 	if (err < 0)
 		return err;

-	return sprintf(buf, "%u\n", data->fan_input[index]);
+	value =3D data->fan_input[index] * 60;
+
+	return sprintf(buf, "%d\n", value);
 }

 static ssize_t fan_source_show(struct device *dev,
=2D-
2.30.2

