Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7803D6A2968
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBYLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBYLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:52:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96419F31;
        Sat, 25 Feb 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677325914; i=w_armin@gmx.de;
        bh=Kf5tr2Sg9Jqyp+j3xyIw9/QWCzBL3T6tk+vssRythnI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c0xUIIR4n8Ta7Pq7e9hvf2X5cHaEbZm+PoZFbaPg7b6b2EFiv+u1G33ibkY4OZrql
         6boChBK+jv1p4hPBagpvxw/b2Luc7pu2DKvhhz4Au2CpIRA9WfUO93GfRpE5QdCXkQ
         8qztMahw+2Ti0FIwILlblrTUIFQDpHNGU57Lfq44Ofzxiw7Ri7coBD/9Bt2uY3NFYq
         UpvtfMIyVSE/VV9wtjfaFv+byC6cnd3ru8KNSVeIxOBdN4i6VyohLUrZMb15Gy+Phf
         E6Lmz4KgbZx1kWiMSSHhUdjEkzgrmJguL7UYxizCZTz0gsJiqFAllmphnSrCCziM0K
         SkrRXClOn0Omg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MoO24-1oh6wL3TUO-00oncz; Sat, 25 Feb 2023 12:51:53 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ACPI: SBS: Fix handling of Smart Battery Selectors
Date:   Sat, 25 Feb 2023 12:51:44 +0100
Message-Id: <20230225115144.31212-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225115144.31212-1-W_Armin@gmx.de>
References: <20230225115144.31212-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kj0EMGZQOKo1DIaNjvZpdw3cvFja6SPU6xwfeorMcBeWFCVw6om
 FI+9RGDNPJYSLetid2vlfeRQ8ezH1yS1/XRSl+IzjZ2pwwqynn4BWZE3n5ojhbQ+uYVU/VU
 jMzfJo1uWW89NvOij2tvDDT3I1tKFhg5a/9fAMTyrEd6VoqeI7uOr3I8rHe8ofm+Dp2urY2
 4j+iEnIFP5bNho5eWkcTw==
UI-OutboundReport: notjunk:1;M01:P0:snJFoJxO8+A=;9EANH49BVgQJ+cJ9Rrl5EWnzryP
 AG3yl9+7tQjbsZJvilgZzt90Lc9RIjMtdUhVcY9xZPm9mgkRZPac55jy6gaP/9hsL40NbEfxR
 VoHYMJSQkuXbbz0lZerepE++ZRoqSA/dleeizyygNsMBoLWlFI3nQ71ME6aZxaSQPD7XfBwnP
 4e+DbzGmdu5xaenKPkpjr+RFHCVZPmqaxrKbcniCBahpItLzPr7hneZmcd2vXiHrMnEKuBnr7
 ZGserGNwEwW+w5jAbjvXpp4ZxzS1PjyCcK/aV70KB1vC6rghuf5Ra6wdSsYelH3snGQrLJiZb
 Oi9poOAPNF7JuSzs9Bs2g5nlZsmIwG/JT9t5P4ZGRdIVa3spxPWZ8fo2BMWYCGAcdp0H8Mbom
 1sWpS6V0Ki0NLbo7gQz96w24+sAwQQMfnG14C7xvI1IUQ3A8eXTPcR+pRpq+MQrQgdKVBcfbB
 YgVFC1y+D17aHLTyOGisLeDkdcfz+XUFCZVcz4Bd07cs4eZ2wBnTk0ORbEdZIHDHdG6e28hP6
 j5e5Rb3RnBlecMEJqzQ+yiro8ewhD1yuOlcw07/i09K+l2m1IiD71SKT7P2wZcbtqL4KEFowM
 4HNL6BC3VLx10awDe83BPpTBuWWtg9/z5qAmuFzeJZF/shlhggW247d83lDKnxzHtmjx/LvZ6
 fDSyW8Zlk4Ht9tZQ5MgIr93w9y44AcZmrOCZOq3BbfDiZkXy0UDjmEVtHFxjdAB/v4fchnTt6
 7VdnZuVPxH4XVnYkAEHWvECVlLqLweVg2PFYVgHOswJTcvmKxTggNGUc9QmtxxJCBjxVNTp9z
 bsOfRMWHbUb5xB2Xo8muPkrUT5OldYPhbyibr/S6DMqnsjrFjaWsh2wdSAcEQBrCelsEHzViD
 4roC4p8QYUijIyhcZvBflYhVO0A56iQAXBryWDZtRbuKV+NBRGLpI11WisE8bi+JY650rthPM
 pPHD92ESyUDgjLMtRkL1zb0Q4ZA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Smart Battery Selector" standard says that when writing
SelectorState (0x1), the nibbles which should not be modified
need to be masked with 0xff. This is necessary since in contrast
to a "Smart Battery Manager", the last three nibbles are writable.

Failing to do so might trigger the following cycle:
1. Host accidentally changes power source of the system (3rd nibble)
   when selecting a battery.
2. Power source is invalid, Selector changes to another power source.
3. Selector notifies host that it changed the power source.
4. Host re-reads some batteries.
5. goto 1 for each re-read battery.

This loop might also be entered when a battery which is not present
is selected for SMBus access. In the end some workqueues fill up,
which causes the system to lockup upon suspend/shutdown.

Fix this by correctly masking the value to be written, and avoid
selecting batteries which are absent.

Tested on a Acer Travelmate 4002WLMi.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/sbs.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index e90752d4f488..94e3c000df2e 100644
=2D-- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -473,23 +473,32 @@ static const struct device_attribute alarm_attr =3D =
{
    ----------------------------------------------------------------------=
---- */
 static int acpi_battery_read(struct acpi_battery *battery)
 {
-	int result =3D 0, saved_present =3D battery->present;
+	int result, saved_present =3D battery->present;
 	u16 state;

 	if (battery->sbs->manager_present) {
 		result =3D acpi_smbus_read(battery->sbs->hc, SMBUS_READ_WORD,
 				ACPI_SBS_MANAGER, 0x01, (u8 *)&state);
-		if (!result)
-			battery->present =3D state & (1 << battery->id);
-		state &=3D 0x0fff;
+		if (result)
+			return result;
+
+		battery->present =3D state & (1 << battery->id);
+		if (!battery->present)
+			return 0;
+
+		/* Masking necessary for Smart Battery Selectors */
+		state =3D 0x0fff;
 		state |=3D 1 << (battery->id + 12);
 		acpi_smbus_write(battery->sbs->hc, SMBUS_WRITE_WORD,
 				  ACPI_SBS_MANAGER, 0x01, (u8 *)&state, 2);
-	} else if (battery->id =3D=3D 0)
-		battery->present =3D 1;
-
-	if (result || !battery->present)
-		return result;
+	} else {
+		if (battery->id =3D=3D 0) {
+			battery->present =3D 1;
+		} else {
+			if (!battery->present)
+				return 0;
+		}
+	}

 	if (saved_present !=3D battery->present) {
 		battery->update_time =3D 0;
=2D-
2.30.2

