Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDB694F29
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBMSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjBMSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:23:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4013E5596;
        Mon, 13 Feb 2023 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676312549; bh=k12c6zpHprezemc3Q5ubUFsaXlGc2har9SHXA5+paEI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JcUyi3VKtz/3ypoVSInsLrLw4V2oyxcWBNyuVdbr5JX49Dmkk3lC8jgADvlLzgh7k
         pidNUdTcrpjU07JAN0s0dCZP3rtniIAeYrBP8AAp9O5NuFhjiA8uoDpPmquwg5AwS7
         p5rgTvCA07GqU+cC9f266jNSyvgc5IcmD1OvZirv40fQHZn38wISrokM4/kYkuB8vN
         5CwhOW/WbStPKVQMramegVAhyyPkf9HwNj+234k3R/Lz2UbHlY9xVi5lmL4HKa5cNu
         A02Eox6RR5bb9pJGM1o+cxE7SCSScQcloepr6Wpu+Z+JVFvFLQBty3YMxFYidqJVWJ
         KVYVWVVQcnZfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M3DJl-1pQnSS0Pdt-003bcv; Mon, 13 Feb 2023 19:22:29 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: dell-ddv: Fix cache invalidation on resume
Date:   Mon, 13 Feb 2023 19:22:14 +0100
Message-Id: <20230213182215.53703-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vvmoBXbeMMdQXvxmbFvA+IKtYLvXu8GmIvKNzcZTX2BmVRXgpWV
 XZRCQoZr7zdQDqh+2ogr+ggJxaqROGv9LyB4npHtP74HBvkf37XUnugGjnpaqFN8FY8PvQC
 yApJ7PZRjcjzEhljWzWzaD5Fa9mthH7wfD933rQlkPKBhmu5+jy1XITKqQmgukrHGqItPzh
 n2PCgMSBC2AgHyyIqOq9w==
UI-OutboundReport: notjunk:1;M01:P0:QvA1UfwFAJ0=;lVXkmxUufO/mmZwys7/Monjmitq
 556Pu+QDay0fKVvqauJHpGRJM1YHN9lekqiMlukE4thBjg1xSi0pcIsrSI5MbH331Gk0tWItT
 g2rwrq+PMo2rlT/9ebvRt+YTC6AG+HKZC0pRTpc2QkXlZainpqNg/2qZmw9uMJ3JLmIiOkUZ5
 60GlgjDhl7t36rcGObC1SwOuAI2zqqB6L4GN+0OJEqxKFl9An1PO2Z5y+s68q2t63tS28wuaG
 Akp1TedQQISeZtaf2z/SsygVjkamZQFcQs2iTnypSAobL/ZMnJYitzpWUAloqAh6cMhUEuWr+
 XVJvffpbq/td9pwT4y56PgxuubvpEDd7Rrkl9z4gKkz7Xu3KY9i5QCKggqk4rwRDSC+iycUBK
 IItyLjCbporVcrDtNqdiF0/5Gy3vTc6Yg56EIV9VOKCvnYlRouxENDxcG1taPN/F8R9PlKF3H
 rerxpA2uKuO9KH2xx8VpyF9i1oKlv7sLaQTcucaFZ/Kdt2IISSlqXucfxYSJjjlFz++FxN9hd
 7wgHXiquL7ECSez7G9pSoa65cVqJ2+xLN1zvHLKquLCAu/e1MM7LuaFqKORiIB9ulGJ5kCL3f
 LB6AiMMJBJl2Pulz2ekKK/MrvaeQcMcaatOmuqHtSuaPqnjbf1Fe8rQXlmDTSvOqo1BHYE+ty
 o1fx+va80uNQeNLjS7M3DmYXBQZsMt8UIGRcw95+DzhktCui5gCqYckQFP+rwivvZ+emdYxxK
 7+nt1j7g4Mm3QRv9n/+XFEmNZj0WBugFalyTtMgPHB4108JbuFlCkB4bQ8SKkCm/SnG3OpKRD
 1QwT2Q1051SE3FaB5n4LYl4te3YJe8sT665nLmbKMtBZbuFcLu72No8lb/mHPr9d3t2zXDV0F
 VtM08jNV2nl7O5mhxLImPjpbCnQM8aHr8lwA/5qrGkXF1Mg++A5WjOsbPczXMkaIzE0h0YMGJ
 4Hzf6CQq4TJpeOeUIRnkHkNUIrs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one or both sensor buffers could not be initialized, either
due to missing hardware support or due to some error during probing,
the resume handler will encounter undefined behaviour when
attempting to lock buffers then protected by an uninitialized or
destroyed mutex.
Fix this by introducing a "active" flag which is set during probe,
and only invalidate buffers which where flaged as "active".

Tested on a Dell Inspiron 3505.

Fixes: 3b7eeff93d29 ("platform/x86: dell-ddv: Add hwmon support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index d547c9d09725..58f996b3b374 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -96,6 +96,7 @@ struct combined_chip_info {
 };

 struct dell_wmi_ddv_sensors {
+	bool active;
 	struct mutex lock;	/* protect caching */
 	unsigned long timestamp;
 	union acpi_object *obj;
@@ -530,6 +531,7 @@ static void dell_wmi_ddv_hwmon_cache_destroy(void *dat=
a)
 {
 	struct dell_wmi_ddv_sensors *sensors =3D data;

+	sensors->active =3D false;
 	mutex_destroy(&sensors->lock);
 	kfree(sensors->obj);
 }
@@ -549,6 +551,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel=
_init(struct wmi_device *w
 		return ERR_PTR(ret);

 	mutex_init(&sensors->lock);
+	sensors->active =3D true;

 	ret =3D devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_de=
stroy, sensors);
 	if (ret < 0)
@@ -852,9 +855,12 @@ static int dell_wmi_ddv_resume(struct device *dev)
 {
 	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);

-	/* Force re-reading of all sensors */
-	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
-	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
+	/* Force re-reading of all active sensors */
+	if (data->fans.active)
+		dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
+
+	if (data->temps.active)
+		dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);

 	return 0;
 }
=2D-
2.30.2

