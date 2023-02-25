Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF06B6A27D6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjBYIGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBYIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:05:53 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997011ACC8;
        Sat, 25 Feb 2023 00:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677312346; i=w_armin@gmx.de;
        bh=Kf5tr2Sg9Jqyp+j3xyIw9/QWCzBL3T6tk+vssRythnI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K99OKWKHOOzh05TDpZSxJE4GN6wiueUJLo6LO0haukLOys0FpZNus5BsgoIogxz/V
         k+NUWpPFENWVi5MNRNGIH0MqCmq++w9KTv1hPte4Tvnt6FfMfUXFsD0qXvUFxR+lAl
         VZlKp4Rq8plMnv4PyaSsvvv1Ct4ubVhBoenahAOfQyPrx3Cs0quL6TzRMBSRBcsLAW
         IkxCR9v6ubd6O1HtTzyk8zj4H8dmxIU+pozts1YYeWxLiJuMJEK0rYIcDeeFdy/I7B
         8mvytGFZnplh9I+p9DRRIRdr7blAXGdpRK18+if/PbRJ+E1JGRFZJvAP3/UcAs7/bP
         usEcy5zKn+nEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIMbU-1pJmsX44gO-00ENWP; Sat, 25 Feb 2023 09:05:46 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ACPI: SBS: Fix handling of Smart Battery Selectors
Date:   Sat, 25 Feb 2023 09:04:58 +0100
Message-Id: <20230225080458.1342359-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225080458.1342359-1-W_Armin@gmx.de>
References: <20230225080458.1342359-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Bj5TWsf+QBe1Q82Bfbxp7fvAaNYpdVIE+7sHR7gg5pI5R2KZ89
 GjKiyw3051qnnEkkMujFls+DULQzloyQ6TTSb5CiWZkMkJVZFTKw9pBo610rbhDv2TM4yGd
 ztSqxkFrnYOfcGZGR/wOMuT5WvHAFsH5Q9/4fqiKPgfdBUrWM0ndgshCxZo2gck3hNuu9KK
 tIRp+9XmMymNx1TEEZdBA==
UI-OutboundReport: notjunk:1;M01:P0:YkRaH1XJPhs=;4hmhe8YZBtQQPoxtSkBWjWo3gb+
 4kHbhaTEwcR4ZA8DeiCZnZb5nzpAM4uMPrrEN0+4kxKXzA4Z8K/AHKRmP406obwwew7GUPOsA
 WIifAuWREaZsEr4F0lWWMAtIm6D/Hxm0ta6wacRWeofnLfuOqPwtppyVMKAuhX82QyzY2q5cO
 uRWSAjJFFHiPJNCrE5oYjtPfZkm5ieKo0cNQrmwzRetT4V5i+cWMDgoI9697KGtmIGU/Mu+9h
 8wZsmz/e/uMmnxzaol18mynTh1XtV7gPaDxzK+KH4VNbrJUOF9K7GQFhq/qNVi4oBk4zqzTf8
 E79KPqizKKKb9dJNOaMA4gCErFgsSFKhbCzrwq+QDJi143i+jVdQycxVx45djmtB50Vo81sIU
 S+jPcfn6iViiyD2ZQ5iobu7J4JFzC3VeIj4fHr40NdmxmvlCl3AmTme2+1Q6APtOocenaK+gR
 9x8nTqpnd+E1eQNnaPIjtgEh8VYc0Ev4i2aKazy/PlRfUGYaiu8ci0LZfh9ghTPfqLnRh0cO0
 jQJ2oLXamKDRNdq+G2vPxAF9cLQM3UvCYVklac5l4ARYtSwL6NhIjv8mO3vGOTPlQnuW2voR/
 sEVewAOMqsRRPgp1m7R6cHv1AdCbGzPYOtVQemq8nkwlSiF37Qfq+H7U0e7GbnPTJ/1sTQn4Y
 zLIr5RLB0EXMP9qSmchtFqJOpdkkJ2HkhDm0VcNAbeeYcTeCaCum/P4nQyxHGNxIeLLLru/7G
 0DewxKlAjP9XscQ9ZftRa6dsc7kJeRW06dBCroH6Fb68BB0jjTcrRJfpXs+DapOU4iOoWPlCY
 JYQh4+t05CqH83CK2KIObGgXRON/ZqhdVPHwdJyukKcgiGXO5RJp4yzVd0dDxXVbc/lF3QcS4
 OaP+uQEegNhU46fEoU+nu8i4bDL7SRY1l8vRrTlIXgCoZJT9QTDuRDfbm3GFgAY6EgoNakzmL
 LcYgGNLeaHZA2Xj8FV5S6oFpwss=
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

