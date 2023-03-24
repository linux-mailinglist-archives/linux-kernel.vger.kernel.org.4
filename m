Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B066C86D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjCXU0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjCXU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:26:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4F1CAF7;
        Fri, 24 Mar 2023 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679689594; i=w_armin@gmx.de;
        bh=Kf5tr2Sg9Jqyp+j3xyIw9/QWCzBL3T6tk+vssRythnI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jz7UK7X44cZiLlMnPjfqrmg9DTnMY1c4CjqpJ16w6yZIHp3H+D8oGuduCYwJYXzkd
         BkktoJKPNcaGIemCrhYZqBqpX1YGNlC9d+butJu9yVmQWmdvI7IMZ0hoIrCNCETGqC
         iZWmUe/6RnKrg/BdQbqOa2gDHV7tVb9Nw0s3mpyIqzCgeiUNlDYfy6CFKs+ey51QFA
         bqdnT4yeOAgKpW3sErgKrF0VFJaQWBVkgr5sx28WnPiozwZjrbzi6Vwt8UaJSXOtDN
         /WhiATvc0FG8MnpC31nPZB32eldaDGb4sMjTlQfK/pj1F8hAuqgNq1tX02DCJf2tav
         EobTL6A7TwIKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M5QJD-1peyVz0Wxx-001V9f; Fri, 24 Mar 2023 21:26:34 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ACPI: SBS: Fix handling of Smart Battery Selectors
Date:   Fri, 24 Mar 2023 21:26:28 +0100
Message-Id: <20230324202628.76966-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230324202628.76966-1-W_Armin@gmx.de>
References: <20230324202628.76966-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6kCTV4lmq1MUZg5UgLFBxpfVLzcFsskWeHIn+zzN7i5VpibZyna
 iFFCDhPiMsHdnksiw4Lhi3wy7j6sJxeBtonoQOj5LjtGZ/jyeLZviH6nq9U3lIds6b5ulin
 5rqOUfNx/pZvx1sHu4AFKpFtnoFyoWv3oId5GQwlevdMfWhAk0pLKd4fgppjsISe82ApVzd
 OLWM0E6MVsDIJ0N6SRPvg==
UI-OutboundReport: notjunk:1;M01:P0:KKOaR6Ombfk=;oog638bcX83iT+9+zEnhIL7S1I6
 dpcRL/Rb8GgrtwD7OZe5jsFs5Q07FyhWoCDkCvsuV5/8oKy6DLxNf7OMAqzYpSY03tVvdcaUt
 rlhC0ONyFg1b9sOGP5YyNbrlekj14bLdy0weIpxZNKRs6Lyi7Z3WSo/zDJ0O/Pc5s64gJWbD7
 4tR/KAskbeWUnHHhn0cCyFgRttkrIdspSzq9tRMDAf3ZHwN2pXQeS8CIYFTyQPEpQM+wjfY/m
 T5qvr4/L4dlBBXoejTl3AqFZEHK5NDwrMyshslj2YY3SwTuMhI3RkODbpBeijBglDYJsWSKEt
 BAvoA0IOW3o0py/aiL5Ah1305jd4fkhGOM1Lnr28Kv4E6MQAQPPUoK247lJHoYBMJNTJbRadf
 4MMveFi37hK/Ac4nYqo5HTmaxNmZCKCqSIRBUvIiMGOXdG2RARhWKHlV68bGRIt6pUv4RbpRw
 Ydb8Xg1jEaeD/GtV/2BJMP1kWXOKTo62uu5Mjjt+rOdUdOybWv+KOHSyboPrpSXpGTw1F/SPx
 dVhaVnUgC8zU/Pr7VZ+RNv8A/6rIP8XhsLMoQB9HzGaGqm9OXMrmzMn9z0QYeBWcmanZdZth6
 N84ej2UUdHF7uAAQAyDNVWcxa2t07pxSKIsM3i3Pq19FmUNUQv/qsxpL77qySuaQS8ilJJF0V
 bNFhSk8jteU5i2MmIe+mvQsKgOJ+Eqgc1BLEOIH5UBbpPb6Cz8yL8OPgeCPdQc9ayMMl+rvbW
 osNMqiuspx29K0wxIl2pK0K9LmrRxVeQ/DZckdZ85l8Pw6UzALcx7TsDMKrLkfvlZOGpZ88S2
 qYIiqCE9BL+PntGpQs8p6lVJ296Xfc7d1MBAdgsoJ6nxFpn36Sb89bCP1LKr/tY5rxJefjCS4
 d/eC1dBdVRbp3qQ02eBIk4Vbx+K2weBsEfk67PoB4kDcoK5MzSy+GMrj73HQGQSzxlrbemwut
 MgPSth72gZePeUxC1Tu9+dAhX4A=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

