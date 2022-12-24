Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C266765585F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 05:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiLXETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 23:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiLXETX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:19:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A71CB2E;
        Fri, 23 Dec 2022 20:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671855545; bh=C3o0ZLdtTlEJI2pYfk3GoSAVs6STbyj1X4ArX6hGlPs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cHzsmviExQDJFCME5rIWjUizcfRy/tU2AJDHU1k+bc2F9fa67IXMOUuMgqRpUHyLI
         fGOZoW1O89+eFS6AoC0K6FfwfaUo4YCSY0duNO8Cb9NpMotioNsfwxvKfp1h5JHQF8
         sqclrRZlr4fM/OfnFt7p/MklUdvTUfGLGP8Dtaq65Z4i7jCjimrXuycqJXbGXriqm5
         myV8Km1dPW23+sag1G0hIMNV+s+pMVC/sEf8HQYrwvRxRJeEwYQgGAX+ehYaefzrD7
         GqfKZ8bv1cCfW6GXlWwevDhT0NW0HBYaqSgl5hf6lXnFSAEXU1EyafiZgiVznUNhL+
         T0vh536NeqVZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M59C2-1p7pXR2j5g-001BZi; Sat, 24 Dec 2022 05:19:05 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (ftsteutates) Use devm_watchdog_register_device()
Date:   Sat, 24 Dec 2022 05:18:55 +0100
Message-Id: <20221224041855.83981-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221224041855.83981-1-W_Armin@gmx.de>
References: <20221224041855.83981-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7nl4MURSq3AU+KB+lIzKjozqIBMe8kzrct014sU7H0mlIb1sBgW
 jVkbMR3KWEy400YVlz538qrJrp01ieThQsskQ/yjYOBSK/v+cZNbe/OKHDJlNMVaXpzFIh9
 ZCkNq1C22MuCLgJbTTjA0VPPRG5MKrBlhUENVofGuTndydiqsmwms0SNgPnphk/gtEy1iB9
 WAIsoqtgFwenY5y7G3pDQ==
UI-OutboundReport: notjunk:1;M01:P0:S6UXNNAY8rY=;S+0q/L4KlVSl1hCKyPxForzHkCd
 WzJTR/JjArww35upLCENkuqFOtlQWG3gfAKULKfRKqZsKoxMFGOMesDFcjIlNzhoKNEQa5FxX
 pUoqiKVtB2mIxgC4EAk12EkT6D/vs2LZ6L7Ydawq4PXNh5HoBLtNJZ7w/YNVzHPw0VNQw0ddE
 d9Z+r+dCM7YeVuSYg6Yw2RhxXtBzv2WcW5Oe0PCko6Y4WtUxsqLKvsgnGVCBBwb5L4W4F5NwH
 8kvQk6vBuJ2b23TKSpx6WsFSg1nVeNQUDS8BdRHDltux0zdVcAJbPMhmQ9gSwhrG5ZijT2yxq
 LFJ7H0yZLx7A2Oim1gVFRMUzE58IpanVGBLm3nmvtWDxZBRBdbWvf8PMmCsmUCBEqEZe0q2Ya
 CXKZ4wNA6W8fi+G/hzXF9dxr2dZABGbE5tHeqIo+8/BN5i7+Qzvqsqq0zDsG6o0zJay45cK+a
 g0neAgjzGYf/KfUCFiAflAts6C+Z/KXCpWVvOvfegJQi7yCqbcDTOMQdG2PBom8pdgu4nmrBN
 AzITE+MDnn6tUqhXRAX31z6zz3vwhl/geyp23v/NF4jdpfJsq1ZszSP9c1SrOAS7t6OR65155
 ReDn6kYydAuYJ1UWMBdVzKAfLu7OMAqfNpYQMZ2rpw27StZdj8DM4ZgNAeK3O/wl8cDnIOXCb
 Cv3MAQywmsuA4TAAzIxNpkZGzuGYAqVC4wf0VozsUqkf/XUCoBZIcCL7DT/9TGx6rXzjgHTW4
 buBzZjLSIIX7NyFFdhW4qsAeCvtszXA4FohYSTC7HRRm3f6jnfJgVHshvnpAPwdxSX3ZuEKyS
 kRz9F42EnVRQ6VW9dOqRSrrlE34JnZBpLMdkdgL8OhQD6pD/urLJPfFtNnQ9t5YofMGRE0LeL
 s0VfVif1w1WAitExu5z5/BAsLV2u9qB6p1wG6RdLyME6P+FHIifbtcGcCgDoo96A+zvXpXb+A
 WmD67kryh0UM6q9saar/QmSIl48=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_watchdog_register_device() to let devres take care
of unregistering the watchdog at device removal. Remove the
now pointless fts_remove() function.

Tested on a Fujitsu DS3401-B1.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/ftsteutates.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index 66ff8d69a0de..d8878b8d16bc 100644
=2D-- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -333,7 +333,7 @@ static int fts_watchdog_init(struct fts_data *data)
 	/* max timeout 255 minutes. */
 	data->wdd.max_hw_heartbeat_ms =3D 0xFF * 60 * MSEC_PER_SEC;

-	return watchdog_register_device(&data->wdd);
+	return devm_watchdog_register_device(&data->client->dev, &data->wdd);
 }

 static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_type=
s type, u32 attr,
@@ -611,13 +611,6 @@ static int fts_detect(struct i2c_client *client,
 	return 0;
 }

-static void fts_remove(struct i2c_client *client)
-{
-	struct fts_data *data =3D dev_get_drvdata(&client->dev);
-
-	watchdog_unregister_device(&data->wdd);
-}
-
 static int fts_probe(struct i2c_client *client)
 {
 	u8 revision;
@@ -684,7 +677,6 @@ static struct i2c_driver fts_driver =3D {
 	},
 	.id_table =3D fts_id,
 	.probe_new =3D fts_probe,
-	.remove =3D fts_remove,
 	.detect =3D fts_detect,
 	.address_list =3D normal_i2c,
 };
=2D-
2.30.2

