Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299B369B9E4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBRLx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBRLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:53:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D924F18158;
        Sat, 18 Feb 2023 03:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676721207; i=w_armin@gmx.de;
        bh=QPjZNlJU4QJ41mwOkCGDhNx04tR/f7ULkAR65bMgRBE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nKjGxFVawnebHNAYS2FFFcwbyNCrcCeqKOgaSTS7E1jsD4tSgossVDuwOB8eOEF0o
         UybTERZcm5gAvVXSanYE2Jhvn4A1tCnFsWInmRSXnio9+bt8H4YAKdbPhe9aUSYhSG
         eflUpGZkj22FsQgeuZ6Z9TcZ5MMzYXlB8gfWbbKS54gDgzvjVE206H0tUdneNv91Fz
         yJWMlDEJGm2EmIeMJWK5MI3XjjN3W6HHfSTHQjepqvZOY7PLpK/RZUxwUzB93fDiq3
         tk/l6tX3HcvhY8ActknHRb1K5nxRIVJbrLCiN2wDCCTbyjCxM/8L1pw7p1YC38XfiR
         z7ItDAfoMsh3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O6Y-1pXBnd2nQE-003yMD; Sat, 18 Feb 2023 12:53:27 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: dell-ddv: Fix temperature scaling
Date:   Sat, 18 Feb 2023 12:53:18 +0100
Message-Id: <20230218115318.20662-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230218115318.20662-1-W_Armin@gmx.de>
References: <20230218115318.20662-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gbh4wqiM8biRiU8epJdlXhRMVTnObRg6WJp80kZzdY00wrcko8S
 9Gdz0+GGC7t3nN1lu3DHOaJ1ezIsY7QGdva0Llw+oFFUNnINEogt4utp8RslV9tWg/KwVUm
 sAnDnfkjX47VjUc2crcBtec3myUtKGkwax60+GmAnWKKqs0tn620rEndVwHrVBNMefBQhqc
 9PTwcpUCs14ucRyre+42w==
UI-OutboundReport: notjunk:1;M01:P0:fRhWJvkkKy4=;y//mm4Qs0ynnCNKzNgCXWQXQ4Eq
 UoVtF5fB277FilJ4P22Ys91fyrt8h3MpLhwrjqivt2yHqZ1TCyYdhq9TRFabadZgesQO8vYnp
 QlUe+6VwYCoXOEWzsB4Mdgc9ut2yPLx/rItdfSDL6dNhe9zlIfmtdRnRQIuZjDOLSfkEGFTRm
 oGm3vSv/7AWkQNsNMSPUCvnWHw9eJQz48PJUTRTsd7zzMD7s4577IBycFIBbb/is/JGhTveC2
 bW1pOVcX4nmzvClQ2fMzq+QBVa55heVEXteZmnZQ3fkshRRRSUZYh9BI41BcF8kqsbHIc69ns
 p1XtMP/J+xYSi+H3FIGJA8+ZVXNZsrlsk0sgh1z78Efssxp88AOIgwsUtKqM1c2Er/EpeiTMZ
 voezy1XYD+lhDOG+1ZUK4r4u94lXaLdky6bIBiWC6m8Myw2tukHnzqak1OUyN1yLG5rxTLTUl
 W34Acg8oTQq4QByWAuJ28W1G+4MFhwQ2L4aDlYenq1zDj7l9IRSj1VPbCQwrN7uM86a3ZFx5T
 YwzacgoLUB4i7jJiOezgsbFXkyQRfcztGgS15F/PXbUOQ/yCgrFG2O1x/IFSXRbLXMfcQPYEf
 pAEGjS504TSVuHl5MXCGbetpDx8h0UMh3Di/kt9rQGHSa/M5QakV0prt+gnq5f/qjxZS+HDT8
 YLRHjKRGn7l2RRRYnoRxcQoMoVdf3WWNa47Yh7Qgd2wcXvHSEkXL4ur6BMSiP+Nvbm1l4Vvmx
 C8hqRoL1czmkcDBtlaPmUgMyMDVasmKEukG+zSeipLEvCOu5cU+LMZuiILbk3mcQUJPbxRmix
 NLs6TrcFL7pN4z0fqa55Bwui6ZhJhxIYPxby0VQJD67Fg4p/UwETIKxksLwmGyjcmrPIh8Tke
 asux1LqZBd36RLspqpkTZa9yoCbxXnQ1g3vtOQHifKwkbBuApNlpBQHvtlMXAACaGAG8dbojF
 JN+PLJTLi7vvjZL36elEu984UrE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After using the built-in UEFI hardware diagnostics to compare
the measured battery temperature, i noticed that the temperature
is actually expressed in tenth degree kelvin, similar to the
SBS-Data standard. For example, a value of 2992 is displayed as
26 degrees celsius.
Fix the scaling so that the correct values are being displayed.

Tested on a Dell Inspiron 3505.

Fixes: a77272c16041 ("platform/x86: dell: Add new dell-wmi-ddv driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- Avoid unnecessary rounding
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index eff4e9649faf..2750dee99c3e 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/hwmon.h>
 #include <linux/kstrtox.h>
-#include <linux/math.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -665,7 +664,8 @@ static ssize_t temp_show(struct device *dev, struct de=
vice_attribute *attr, char
 	if (ret < 0)
 		return ret;

-	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value, 10));
+	/* Use 2731 instead of 2731.5 to avoid unnecessary rounding */
+	return sysfs_emit(buf, "%d\n", value - 2731);
 }

 static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
=2D-
2.30.2

