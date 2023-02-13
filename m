Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E4694F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBMSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBMSXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:23:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E16E98;
        Mon, 13 Feb 2023 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676312551; bh=b5QUutaHQdMw1ITCujaZf3S17KDnmXPSw2Vah3oOv2Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eqd1JaUlXdhpcrMgA0EBygDe1Z7+E1JkSHunCS3BwiT24eQN41iHYfK+TzPI7jgqq
         zG+keZQtX0R0fWNEiXc6sWQG95GkAII7KY5dbBiPQbsEp7ufuonUGNyH7rM/M70JBi
         2TsBzIQHYNvcABCfvUaWN7Uwj3n2/QB0qkfq49bXJK2ML79913wwrsL3m9mXxpDk0D
         1NXHCcf8zihNr6WMUcHdtiz9ZueIsPauuNRorJO+3kL7JbVu01VbpZN7h1bXM9eFy6
         hoCUbwU4s4N0M3jB4cYn9cWX8eDin1/Qp79Qy3WJA8eZq6DBYc9SuGdw+wEt9URNnI
         xmdHVfs9eacQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mj8mb-1oyKKg1XPB-00f8UO; Mon, 13 Feb 2023 19:22:31 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-ddv: Fix temperature scaling
Date:   Mon, 13 Feb 2023 19:22:15 +0100
Message-Id: <20230213182215.53703-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230213182215.53703-1-W_Armin@gmx.de>
References: <20230213182215.53703-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NhzqSUt+bn0H9DxRSOha9IUwskz3t/Fblmav0R/35xynQgpPNKK
 YZ5CguPVi+PLB+IJrzQPX6TLgWgpFDUZOlbVx32PPg/asUYHnTznl2YJhUINUHlqa2178V2
 OeCgOinPTstJEn369Xn+3c8Uny8lvWAsOqJ7YDEZcfDvhfsaWKTSQDvtQHXCkr+gmQi4XD5
 ABz/1xcB6/TlR003lWKuw==
UI-OutboundReport: notjunk:1;M01:P0:6Dm/wEaONZc=;ehZ0GEK4zSNC5ztgt6p1jhQut2k
 jDWPk1cy7Mcx8DbabPCcBURrMO4NpdCCWyDo189m0RRydqn12O+eVe+eGnpVp7ekSkxHWShwZ
 fph3W+9Aujmzy6Awf6YtvNkN6QePenF0hDyO9Wg33EhL6jMZgKc2+ke+gf0duz3WjTw4TiMIy
 T/N1t0zVDJPDFo9+2nO6bQIpDRQH7c6nTpygzHVKX7L1oNLyM/sezD/KnB14wvH/5USnPLLrF
 FuRwdGhdySGrGVuPYLwkVOso9ant04SCmeQTyvN02jbbhlm4eowzLnWvleVMH705V0ZgjFE0l
 utDWh2MZRlS372lSeYHvxpbpVyMoqEtHNyxsTZai0+mVt27RtziKk9CF/rZPTzyxmWGZs+O2F
 5QyXJvYRlL2ecDJhI3k+Tj7nqfHCHBsnkl0zF9yn4UDUz350zwilyoMsgnXUM3vrBl20uV5Qw
 e+opENAc7P7ZNoca5wUIjTAcUL3UvEhci9YpuleguhaAeP+Q+lpeLjb/kkbJwb8TA9XOlTShO
 3E7mK4hzIXgpjKR8907e6jevq6KdFD1laOZtHu1CpOQAxYj5/TEvwfnXfD03FYqts+m/sfjm0
 tD1e+Um1M5E1JMx61kf2Lphto38pxxgnsDucWZF9GMQI5QXJADLw6G+pnxJlbKj088rg0Zrky
 eEQ6wvWRY3gGNLns5at6cyNrYTcss3HMiX/aLJ7rZAg29I5hJSjFOVaVv3PhT4K/vTmTjcZEX
 JqG195VG3zAornT0Fl+Wwl4hKzeBzY+WlwhLplXzmwCwpuuAJ5UzS4mgk4zzw3Bhqjup063KM
 Kw4wY+DnvlxJtpV10H37HxP9nHmx0eLQ/nIhZj7WDVVzD1s3FiQHaJbuuBStQcNkyg2XEDDw9
 V69QKTwUsVuIzgFau8rOBd5HnI4O+PYTMNDUcKNs8NELwnKpY3LNSL0myExn9naZ17WKJnoPe
 lWHUw/RMm/0CKO3Hxa1cbpfRssE=
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
 drivers/platform/x86/dell/dell-wmi-ddv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 58f996b3b374..efa860dbff6c 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -662,7 +662,7 @@ static ssize_t temp_show(struct device *dev, struct de=
vice_attribute *attr, char
 	if (ret < 0)
 		return ret;

-	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value, 10));
+	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value * 10 - 27315, 10)=
);
 }

 static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
=2D-
2.30.2

