Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE466ADED5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCGMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCGMgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:36:13 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB44A1D6;
        Tue,  7 Mar 2023 04:36:11 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B1CFD1C0DE7; Tue,  7 Mar 2023 13:36:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1678192568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=1PlvY26tIHyNiqhAYJQIp+i1zuL+i9oLYMD+0Zno304=;
        b=ZdR2Q3VmAJbqIfmzQBuo80BePszCATog/JJr5+3pFSbAMZNNSxBs7oym0QL+HViHRo5h6B
        PYL3JAeEErPbwg/Wskp6+LcC+1vQxKIhkPWh8P1vtIY4vpfcbz0Tny+UxFtuZlkyCh9H4o
        4dWOfIeGVD2Ar7HNt4W/L/jrIz+qUl8=
Date:   Tue, 7 Mar 2023 13:36:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: Motorola Droid 4 -- Stopping charger when battery is full
Message-ID: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7xbXmd+4l/jRSr+Y"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7xbXmd+4l/jRSr+Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I complained that "battery life is very poor" with leste. It seems to
be combination of several factors.

1) I was using very old battery

2) My charger is detected as "USB", not as "AC"

3) Charger was cycling on/off, which was annoying and I often ending
up dissconnecting the charger

4) It probably has a bit higher power consuption than original android

5) Android is more aggressive, charges to 4.35V, and allows deeper
discharge

According to my measurements "CPCAP_REG_CRM_FET_OVRD |
CPCAP_REG_CRM_FET_CTRL" results in battery discharding and 0A drawn
frmo the USB.  "CPCAP_REG_CRM_FET_OVRD" is phone powered from USB,
with battery more or less disconnected (<12mA), which is what we want
in battery full situation.

Second problem was that phone never really stayed in "battery full",
immediately exiting it.

This should solve both issues (plus it enables a lot of
debugging).

Best regards,
								Pavel

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cp=
cap-charger.c
index 8bd1abe246cc..af268fc87fbf 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -10,6 +10,7 @@
  * Copyright (C) 2009-2010 Motorola, Inc.
  */
=20
+#define DEBUG
 #include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -410,8 +411,7 @@ static int cpcap_charger_disable(struct cpcap_charger_d=
data *ddata)
 	int error;
=20
 	error =3D regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
-				   CPCAP_REG_CRM_FET_OVRD |
-				   CPCAP_REG_CRM_FET_CTRL);
+				   CPCAP_REG_CRM_FET_OVRD);
 	if (error)
 		dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
=20
@@ -686,8 +686,11 @@ static void cpcap_usb_detect(struct work_struct *work)
 	if (error)
 		return;
=20
+	dev_dbg(ddata->dev, "%d %d %d %d\n", s.chrg_det, s.chrgcurr1, s.chrgcurr2=
, s.vbusvld);
+
 	/* Just init the state if a charger is connected with no chrg_det set */
 	if (!s.chrg_det && s.chrgcurr1 && s.vbusvld) {
+	  printk("Just init -- not chrg_det\n");
 		cpcap_charger_update_state(ddata,
 					   POWER_SUPPLY_STATUS_NOT_CHARGING);
=20
@@ -699,6 +702,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 	 * charged to 4.35V by Android. Try again in 10 minutes.
 	 */
 	if (cpcap_charger_get_charge_voltage(ddata) > ddata->voltage) {
+	  printk("Battery overcharged, wait\n");
 		cpcap_charger_disconnect(ddata,
 					 POWER_SUPPLY_STATUS_NOT_CHARGING,
 					 HZ * 60 * 10);
@@ -713,14 +717,24 @@ static void cpcap_usb_detect(struct work_struct *work)
 			break;
 		new_state =3D POWER_SUPPLY_STATUS_FULL;
=20
+		printk("No current -> we are done\n");
+
 		if (s.chrgcurr1 && s.vbusvld) {
 			cpcap_charger_disconnect(ddata, new_state, HZ * 5);
 			return;
 		}
 		break;
 	case POWER_SUPPLY_STATUS_FULL:
+		if (s.vbusvld) {
+			printk("Full, stay full\n");
+			schedule_delayed_work(&ddata->detect_work, HZ * 10);
+			return;
+		}
 		if (!s.chrgcurr2)
 			break;
+
+		printk("Full but we need to do something\n");
+
 		if (s.vbusvld)
 			new_state =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
@@ -762,6 +776,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 		if (!delayed_work_pending(&ddata->ramp_work))
 			schedule_delayed_work(&ddata->ramp_work, HZ/20);
 	} else {
+	  printk("No feeding bus, disabling\n");
 		ddata->set_current =3D 0;
 		error =3D cpcap_charger_disable(ddata);
 		if (error)

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--7xbXmd+4l/jRSr+Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZAcvuAAKCRAw5/Bqldv6
8sS2AJ0c/lCr9NYEJajukVCVSMDNpN4GqwCdHZ/pDLpGHZKrHJxNE8IBo6IXG3A=
=zONU
-----END PGP SIGNATURE-----

--7xbXmd+4l/jRSr+Y--
