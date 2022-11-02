Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD33616F9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKBVXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBVXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:23:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B1386;
        Wed,  2 Nov 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667424219; bh=aampEa/W6j9d6+DzK+wvXKve8YoufcAeq3lEwB+0Uao=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kZtXtH+N4DsT7bPMIy0s4JioiFGeG85GG3Nx5zRynB6hk+UFkXbXhCZElOHkeOtF4
         1IxbPeI/LPAHQF6T6RAEi14uZbTSZYoMibmp4mTwCITfJxvb/QuktN1JtRQhZ9ss9G
         a8r7gYz/nYNYusTYwwqY211t2zNAEnIm8RbAQnPrGXhg0p9vynPvIQemYI3Om6Jwoc
         xw1jExnitpzbd+Jdzv0fJz2ETY7Eh0vK9aDMUXQCbDTJcVC0szDHAOO9RbRlBX8kOJ
         +yhE9pE5LrhhYH6zfr7k2zEKGxHZkJRwyYDdipo/B8Zh6OoVa1yGBZpO4TDTIImjg/
         f12+yxCMOAqUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGN2-1oZDUy4C50-00JIEH; Wed, 02 Nov 2022 22:23:39 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: dell-ddv: Improve buffer handling
Date:   Wed,  2 Nov 2022 22:23:35 +0100
Message-Id: <20221102212336.380257-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nr9KeNWdY7WLGxN05P9csXuYDmA/r2Qe4xbNDZlNmjJ+fC8e95q
 XBS9UT7JG1cpeC8H68zLCPZ9wI2GNEvWLyB6PruNFrJpXdw4/Ft6WCiMhDRBkm7fudmWMX3
 rylZJdtavVPnrY62EumARp+M2vEpJgVpaDHxZDrq60qKLsN3zlsEkIFJcOHG5C4Z2m23tLS
 L1XolCjM5XFcxElNIxqRQ==
UI-OutboundReport: notjunk:1;M01:P0:9uLHvllaT/A=;ZithkZVRqNPOK2V8hjiT5neSuNo
 cz4HCWUs6YlIDEIj1q11gYFMa7sdja+NrDRs+i/vkbsfLJ0pp4IIZ/E6L+6U9d45BB7kGiDgC
 3XvzC7BuChN0vI8VoHLkvocrYEA6J5MhbBPgkT9pqPAhGq5Y5O3IKW1cDWCz4ZXXxiV7wDZTt
 jTA0EiQDG2pv2JbZnfFnfb+TA/ugtZCmVanHbnBH6PDG8bzsVUmyiX3sucwv5/Ey6SSRdWUCI
 xw9dra48IzB+2v/MehxSJCGBammZLWdlhKTpIH8EhYydgkJ5ZftnOr0eVxNHZ2GDY1ohLhglA
 YjnV3OxwK3nS5muK5uIBFghJ5/jFniqoGTLWhB1LmzdZRS+hzCJ13oUPZ1Pyfy1VQOo1/K/BD
 /ZWezwPJvFktb9tA54fi/3TtWg3AFRxu3N6DMg+cK1DMWcK9cRKRIRj+sP/9eeT1g29afiEPR
 HGC2ctpcH87MKB4SpSATgxw5wVc396SZsJKq2hKkMg270z4kG3Qxdib0ZJXhBlfbFXLpYYaAL
 CG+otK9MUabBNxDtwXdEvLUx1DqHOwlVj/CJuCD1expdXQYy+UuiU2+S7gKXHsdhg+HcGbvNS
 fWMPVv9y/wHiHAYg5knK+uvvDmkaoVDxr/b34iCP5szRRB2B5rU6yrKKp7EjIgEyle6zbQu/+
 FuCktFX1OTiJEQKGM9FuWfv0wFrSCzwEO13eA/ShcTYNPQ2B2nNsJ/Fci0FFTn/hrxU5aaqKf
 Cdx2rfdnjzlvoJOvbajoSvQw+/aPQCTc83Ay74OjohPd2LtiswDNGkvgxQZwnz1DKqyCZm3Rh
 U0YiMlz8BV8cWIkHskJZ9ACoGcbR4L7TyPY8pg1Wst+327R9GE1tfs0OEN69jTbMVsd15qnO/
 KGdNfwXTIyWkxYj5e+o+UddEIMn5sUPGl6voWkS/ylTuS+K+Ph1pMKKmaHhdYV7eHF/s/29sN
 pCvruSvEtcHZB0IPLNYmd+USnxA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the DDV interface returns a buffer, it actually
returns a acpi buffer containing an integer (buffer size)
and another acpi buffer (buffer content).
The size of the buffer may be smaller than the size of
the buffer content, which is perfectly valid and should not
be treated as an error.
Also use the buffer size instead of the buffer content size
when accessing the buffer to prevent accessing bogus data.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 699feae3c435..1a001296e8c6 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -129,9 +129,9 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device=
 *wdev, enum dell_ddv_meth
 	if (obj->package.elements[1].type !=3D ACPI_TYPE_BUFFER)
 		goto err_free;

-	if (buffer_size !=3D obj->package.elements[1].buffer.length) {
+	if (buffer_size > obj->package.elements[1].buffer.length) {
 		dev_warn(&wdev->dev,
-			 FW_WARN "ACPI buffer size (%llu) does not match WMI buffer size (%d)\=
n",
+			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer size (%d)\n",
 			 buffer_size, obj->package.elements[1].buffer.length);

 		goto err_free;
@@ -271,15 +271,17 @@ static int dell_wmi_ddv_buffer_read(struct seq_file =
*seq, enum dell_ddv_method m
 	struct device *dev =3D seq->private;
 	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
 	union acpi_object *obj;
-	union acpi_object buf;
+	u64 size;
+	u8 *buf;
 	int ret;

 	ret =3D dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
 	if (ret < 0)
 		return ret;

-	buf =3D obj->package.elements[1];
-	ret =3D seq_write(seq, buf.buffer.pointer, buf.buffer.length);
+	size =3D obj->package.elements[0].integer.value;
+	buf =3D obj->package.elements[1].buffer.pointer;
+	ret =3D seq_write(seq, buf, size);
 	kfree(obj);

 	return ret;
=2D-
2.30.2

