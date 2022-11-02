Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A228616F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiKBVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKBVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:23:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5B3B3;
        Wed,  2 Nov 2022 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667424221; bh=563YttvuumXCAkFcYzDRK3i2GybkAFkEzHBYksZEWqI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=anaXfdO/64IuThV7el5fQKM6XEYNbXrxkvTzU9lCSvuCyyHwnyKd9o0MYshpj8JP2
         +XeGoWCsNbne5eCdIcjJDTQXNtnvRAgXdwordeZ8hjl3xHy4ukpx31VC/qKmbV4W0g
         w2rYh+p3jT7M5voi9LJvsCpeRSO6QiAHy0lFH7/2aH2R+KN5FnyRk36rXO3fq04Qn6
         OTLaWIFMuUy+TUXZYtKN87R0wwFELtyDYMndzOCfJgU7uYTzwF2Fytkrwjkq/PW2U5
         1YY1hmpSM4LyWoBfYrWHLGX0y7HLkXY32A6egrTahuYkKE8+lh8CQ5Z0b3vYA8ieZ5
         PcC5jWZ6f4ZQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MrhUK-1pM77w3KIW-00niY3; Wed, 02 Nov 2022 22:23:40 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-ddv: Warn if ePPID has a suspicious length
Date:   Wed,  2 Nov 2022 22:23:36 +0100
Message-Id: <20221102212336.380257-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102212336.380257-1-W_Armin@gmx.de>
References: <20221102212336.380257-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bPHFCUaFM4G5bc43gyqGc0rmvo24NZRgRlCSd6py95bDNiEWccD
 opHe4nHaVq/OJ2fpBiIfvfpI1/ldnvgOn0bQFIN10f/dX3bLkueAmGKjaWomXeoEpid/QBM
 mHHBvur28rmqRrzEDAKuw4tB6O849oEIiUuYQmz635ivFYzkMNNTIIZukSmPev7F+UD2kub
 bgbYHLjBFU0e1xefThLMQ==
UI-OutboundReport: notjunk:1;M01:P0:PoCCcPMRsyQ=;IHRoRgARaxt+hB6bwzo1YPqX1B/
 EKiXMZBDgCXEDhwNIzxYlrcCdpHu/PmqYY43U4i1+d2HhCsZMBBoZp5ft+e9SmcIDRZXa8txR
 3KQrBCJHYf1ekuxFmtJ6w2XneOlBXxANwYsePGWoKRt0pBXATFnxtnrRkEPlwnGBBqT1BW4OD
 YYwj1oALeMoFmeD+S+Tggd0JVWRLT6xPZwbUG4ruRpkZeSIU+OYnxaq/QjUMQ4kKEBqqK27yH
 Te5Y4cCzsBYjG1wAj2keHaC4Y47gXoDdFMC98ztVz0gbUGp/DcqVpsl3GNkpwbgsdI5blVxhQ
 oNkMBH5FXyiPbow4hYGuifyGFud+0LpmYTtqY9rpafLuqSc2lneK4BzRV08H8gxEn82pTpU/C
 H3DM22Mx5URnuUjjfyu+VLgO6utZ8g/jIU6WSkP73AL1VdgW0ASYzW9b08wMs6q8CNaN/hZaj
 g5eEcQMSgaRkIR1JQaHX5OKJaxYb9yTX9UIb43DLKQQ0LteeSSNsTGY490JWRik5OTdL5vfyQ
 4cj+u0RHtdcvuwnF5TrbKGYlRjacSyIc8nK0Gdae2I3/s61aDxO5pgnciYADGAaPsqSKltWYS
 F/7coQK5rtOdpU6PbY2hwzOq5cNjw7HNEqNPF36XXomAbqbQ7shgc2/R2wQayHjje7M9MeA5t
 /6nygh0Hd4MyvwU95hftxpw2IaZHYYCJfqMbMLLfCUdq1zYtWLoUyXRszftyTL/UcAUgeA85c
 v7Jmn39qLmMX9282IX/eYXm1BoKlVjdEYI3vDti95Rv6mJD6yM8M/9umuBctepxlDopxsysh+
 +f8MUHmGhfTQkhna6gQ5/nY98h3DlE5mChSzWPn+GhUh8YxGkc5zeb/Kt18StJoey0RNir/zR
 chSjOLeejtNbpgn4jY9MmalFF8j9B66LOw+LJFOYHYyo10RCmuagHXqyVU6p0Hi8cPMcgAMiR
 F3x0ulRF2V0cQJbB7vCIvUFKIF4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems (like the Dell Inspiron 3505), the acpi operation
region holding the ePPID string is two bytes too short, causing
acpi functions like ToString() to omit the last two bytes.
This does not happen on Windows, supposedly due to their implementation
of ToString() ignoring buffer boundaries.
Inform users if the ePPID length differs from the Dell specification
so they can complain to Dell to fix their BIOS.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 1a001296e8c6..2bb449845d14 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -10,12 +10,14 @@
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/limits.h>
 #include <linux/power_supply.h>
+#include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/wmi.h>
@@ -27,6 +29,9 @@
 #define DELL_DDV_SUPPORTED_INTERFACE 2
 #define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"

+#define DELL_EPPID_LENGTH	20
+#define DELL_EPPID_EXT_LENGTH	23
+
 enum dell_ddv_method {
 	DELL_DDV_BATTERY_DESIGN_CAPACITY	=3D 0x01,
 	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	=3D 0x02,
@@ -196,6 +201,10 @@ static ssize_t eppid_show(struct device *dev, struct =
device_attribute *attr, cha
 	if (ret < 0)
 		return ret;

+	if (obj->string.length !=3D DELL_EPPID_LENGTH && obj->string.length !=3D=
 DELL_EPPID_EXT_LENGTH)
+		dev_info_once(&data->wdev->dev, FW_INFO "Suspicious ePPID length (%d)\n=
",
+			      obj->string.length);
+
 	ret =3D sysfs_emit(buf, "%s\n", obj->string.pointer);

 	kfree(obj);
=2D-
2.30.2

