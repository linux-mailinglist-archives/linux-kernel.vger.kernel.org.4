Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0288667D581
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjAZTkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjAZTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:40:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B982D51;
        Thu, 26 Jan 2023 11:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762030; bh=2TL7aTm8N/AzcTDSZC7SmNVqKjGX/jFf0Ms82bCmlQ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=sUV2O9sisppQ5XXA8g+mZZ+Cx2PgWPgOWrxSu2SQI4nWrDhc0ydAmK76YZWWKYRXb
         RDS5bvpH+5QIT6/KNzsqFUyYvlNNLufUbRI9rJoOORmrDHZW1fe7Kg8agFe878wEs8
         m7ERRrPSYYzysTJlG4Zy2G9TOZyE6LtLWD5rqUVSzArbkJGf7aK/QvWfji+VY3OfEw
         ZKEY9GXTlVWEWieVpPNxB8Bs2+4ux/MjyEhbuwurEZfRwtJeQKSFrcsbpXA/oRt7o1
         Q1bckiTyEXAjyDDzCaDscKwkUkT2vMZXGXf5qK63bJzrtaJFHK2pNFuwnbhZdYV2rP
         HeCp51hkYs8DQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M42nY-1pL86o0Wpc-0001Gb; Thu, 26 Jan 2023 20:40:30 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: dell-ddv: Add support for interface version 3
Date:   Thu, 26 Jan 2023 20:40:17 +0100
Message-Id: <20230126194021.381092-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126194021.381092-1-W_Armin@gmx.de>
References: <20230126194021.381092-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cv+dN4fSwbR9l2vEKOEDAENRLMdwkFzHQ4eIoeDdE5p0oZttKYX
 zjHWDE/v7mxpFRiDAyZjH4Hu3vOAx1z7As5mwDb28OPwcDJPsAjFN8bT8CM8dSQstoOMoBK
 1EOLXaeSJ+QugAdSaEG7D6OONTe37PQWMMBGyLc3um26bmKtTlY0CsMir7oNJyA8ngOAeUk
 H1uoRiDzJj+M3xIyWq7LQ==
UI-OutboundReport: notjunk:1;M01:P0:ib7GGmWQ2PA=;Y+R1eYyO3J9NR2Pv0sNfv78K44V
 1o0JfBV03CeIIJYNO7AVjqEe1YMrjDRrz7M4VI8EUw0MKqiXFcM5rdcY7UeNlHkwb5ErTQMkI
 JVHfbzsrKe0XGrf2+GnfgBBkk15MqoYS/K460lQVj6Oj9G8UnHNE6Qe2Hx6WqFC2QtrPs5wgS
 mDdAyM2XkDgARmh4yV4tS2pkpYyMGeSE2dNKazK8xWVhku1ABFzALb1I7BRgVhBQKcRQW6AHr
 O0Ccgh5L7cLGacO1eYSdr6HOmOtqZZf3dldrmrbKI9w7u+JgCAjTuj+q4DBgCu2fI70/CR60q
 FBByw8mhC6ObSTu8KYlhouWJ5+XD4w87aUtgGM7EJpP+W0iuqnncZwa448j6BIcwkD+C74WwP
 XEteXx7S/7PQQWTUgBL6JmjQc1f8LXJ0csFBaT5qW/jOyM3H2ZUJZ64fKEU9cXnpeI5bu7+Wp
 4E2o95KasC26kChfVTQljYZEIrcjHxoakESDH9LIE5Ap7Zxg6LIK2ckoIvCUhTWY0NuBuyFTj
 i+soZXSrJn6H7FiYfZJooYCLmdEIBe+oDqF/DhIL0CCRNDwzWy0fvjsmUb6srN1B7gQ8JCekG
 cFD0XjEL1IP3ExEzVQIE0R5/uCdoCLpVeU530xc+a/9EqHiDKFxWiSsLbyn8ok53uLf2wPhsv
 7XTMTIl71Mmf6paL9pbV80s/Kuo+epijeIk3U64UWuQ7SI4fa8ZcNadNKHRwENj3lr07oK70C
 UOmKkRVBmw/x2KSrphv3I+cfr52I1n7mQ/q8ZzRMOpnTjklnY9gdw3l3vVsUT+HquTByA//rE
 oSMXnNd8nLrp3wIC42RXw74nZSvyAY2Jip4WPkkfgHjCFRRLXCjcf2f6wGq5RG25JYctznq0b
 eNVYv73KPCoaX9lVbhds3jQzkiekoetviqWOMasHLgjmarCXxSVMxPCM8QtTtSFujBcmi/7nt
 ZHwmOKT4dF4Cs8gWE5Va1DrjosA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to solve a bugreport on bugzilla, i learned that
some devices (for example the Dell XPS 17 9710) provide a more
recent DDV WMI interface (version 3).
Since the new interface version just adds an additional method,
no code changes are necessary apart from whitelisting the version.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 2bb449845d14..9cb6ae42dbdc 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -26,7 +26,8 @@

 #define DRIVER_NAME	"dell-wmi-ddv"

-#define DELL_DDV_SUPPORTED_INTERFACE 2
+#define DELL_DDV_SUPPORTED_VERSION_MIN	2
+#define DELL_DDV_SUPPORTED_VERSION_MAX	3
 #define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"

 #define DELL_EPPID_LENGTH	20
@@ -49,6 +50,7 @@ enum dell_ddv_method {
 	DELL_DDV_BATTERY_RAW_ANALYTICS_START	=3D 0x0E,
 	DELL_DDV_BATTERY_RAW_ANALYTICS		=3D 0x0F,
 	DELL_DDV_BATTERY_DESIGN_VOLTAGE		=3D 0x10,
+	DELL_DDV_BATTERY_RAW_ANALYTICS_A_BLOCK	=3D 0x11, /* version 3 */

 	DELL_DDV_INTERFACE_VERSION		=3D 0x12,

@@ -340,7 +342,7 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev,=
 const void *context)
 		return ret;

 	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
-	if (version !=3D DELL_DDV_SUPPORTED_INTERFACE)
+	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPO=
RTED_VERSION_MAX)
 		return -ENODEV;

 	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
=2D-
2.30.2

