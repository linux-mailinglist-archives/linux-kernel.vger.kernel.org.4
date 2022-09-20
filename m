Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607FD5BEB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiITQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiITQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:55:06 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759EE29C81
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 09:54:52 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663692888; x=1663952088;
        bh=b6ndjbcZhGSJGsthJvwVEPx5dH9yn8An6taijSqj7Go=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=ow6j0wF5pGYOm+Gw463dsuCkcLJvXC8Czc3BMRj3RYX3BhJU4IP7fXy5In8SOhfIf
         M7QwGTOoAan0c8P8PeonOAwRpFtCt2GYpxQNOsy4xSSYXjrWYWZ5cVYIGJGZhUzuk3
         6Cyvasg/xHsbCy8OTu/CRoPG9rtVDzGjDitprIR7sEwj4Ys9/GHyptQMM+FSs5P72v
         /QNO5miBdY5mNNPR6wL96kdqhZeB5pdI3FGo8HfhKk9Ya0o+eJZwp1zyUuVktsz6ld
         GlxNlom+xcT/OR4A28lCOjZv8UhC9QWhTZ78V6nYmFIcsAihVfZ2QymBnVAiTSpOQr
         Lov7O+BksP3Gg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>
From:   Johnothan King <johnothanking@protonmail.com>
Subject: [PATCH v2] HID: nintendo: check analog user calibration for plausibility
Message-ID: <RINjeKS0brZzIa6F-fgBKuiHrrcZB8zfTg_chbQIT3BRLqx-l9SmsxvV3LXx7upuctFCki33uAIhXNsM92YWTub8vbzSQHcJibhPkN5ijB8=@protonmail.com>
Feedback-ID: 1750573:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Wendt writes:
  Cheap clone controllers may (falsely) report as having a user
  calibration for the analog sticks in place, but return
  wrong/impossible values for the actual calibration data.
  In the present case at mine, the controller reports having a
  user calibration in place and successfully executes the read
  commands. The reported user calibration however is
  min =3D center =3D max =3D 0.

  This pull request addresses problems of this kind by checking the
  provided user calibration-data for plausibility (min < center < max)
  and falling back to the default values if implausible.

I'll note that I was experiencing a crash because of this bug when using
the GuliKit KingKong 2 controller. The crash manifests as a divide by
zero error in the kernel logs:
kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI

Changes in v2:
 - Move the plausibility check to joycon_read_stick_calibration() and
   have that function return -EINVAL if the check fails.
 - In the plausibility check, change >=3D to =3D=3D. hid_field_extract() ne=
ver
   returns a negative value, so a scenario involving min > center or
   center > max is impossible.
 - To reduce code duplication, move the code for setting default
   calibration values into a single function called
   joycon_use_default_calibration().

Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
Link: https://github.com/DanielOgorchock/linux/issues/36
Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
Signed-off-by: Johnothan King <johnothanking@protonmail.com>
---
 drivers/hid/hid-nintendo.c | 58 ++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 6028af3c3aae..ca58f5440159 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -760,12 +760,34 @@ static int joycon_read_stick_calibration(struct joyco=
n_ctlr *ctlr, u16 cal_addr,
 =09cal_y->max =3D cal_y->center + y_max_above;
 =09cal_y->min =3D cal_y->center - y_min_below;
=20
-=09return 0;
+=09/* check if values are plausible */
+=09if (cal_x->min =3D=3D cal_x->center ||
+=09    cal_x->center =3D=3D cal_x->max ||
+=09    cal_y->min =3D=3D cal_y->center ||
+=09    cal_y->center =3D=3D cal_y->max)
+=09=09ret =3D -EINVAL;
+
+=09return ret;
 }
=20
 static const u16 DFLT_STICK_CAL_CEN =3D 2000;
 static const u16 DFLT_STICK_CAL_MAX =3D 3500;
 static const u16 DFLT_STICK_CAL_MIN =3D 500;
+static void joycon_use_default_calibration(struct joycon_ctlr *ctlr,
+=09=09=09=09=09   struct joycon_stick_cal *cal_x,
+=09=09=09=09=09   struct joycon_stick_cal *cal_y,
+=09=09=09=09=09   const char *stick, int ret)
+{
+=09hid_warn(ctlr->hdev,
+=09=09 "Failed to read %s stick cal, "
+=09=09 "using defaults; e=3D%d\n",
+=09=09 stick, ret);
+
+=09cal_x->center =3D cal_y->center =3D DFLT_STICK_CAL_CEN;
+=09cal_x->max =3D cal_y->max =3D DFLT_STICK_CAL_MAX;
+=09cal_x->min =3D cal_y->min =3D DFLT_STICK_CAL_MIN;
+}
+
 static int joycon_request_calibration(struct joycon_ctlr *ctlr)
 {
 =09u16 left_stick_addr =3D JC_CAL_FCT_DATA_LEFT_ADDR;
@@ -793,38 +815,24 @@ static int joycon_request_calibration(struct joycon_c=
tlr *ctlr)
 =09=09=09=09=09    &ctlr->left_stick_cal_x,
 =09=09=09=09=09    &ctlr->left_stick_cal_y,
 =09=09=09=09=09    true);
-=09if (ret) {
-=09=09hid_warn(ctlr->hdev,
-=09=09=09 "Failed to read left stick cal, using dflts; e=3D%d\n",
-=09=09=09 ret);
=20
-=09=09ctlr->left_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->left_stick_cal_x.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->left_stick_cal_x.min =3D DFLT_STICK_CAL_MIN;
-
-=09=09ctlr->left_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->left_stick_cal_y.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->left_stick_cal_y.min =3D DFLT_STICK_CAL_MIN;
-=09}
+=09if (ret)
+=09=09joycon_use_default_calibration(ctlr,
+=09=09=09=09=09       &ctlr->left_stick_cal_x,
+=09=09=09=09=09       &ctlr->left_stick_cal_y,
+=09=09=09=09=09       "left", ret);
=20
 =09/* read the right stick calibration data */
 =09ret =3D joycon_read_stick_calibration(ctlr, right_stick_addr,
 =09=09=09=09=09    &ctlr->right_stick_cal_x,
 =09=09=09=09=09    &ctlr->right_stick_cal_y,
 =09=09=09=09=09    false);
-=09if (ret) {
-=09=09hid_warn(ctlr->hdev,
-=09=09=09 "Failed to read right stick cal, using dflts; e=3D%d\n",
-=09=09=09 ret);
-
-=09=09ctlr->right_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->right_stick_cal_x.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->right_stick_cal_x.min =3D DFLT_STICK_CAL_MIN;
=20
-=09=09ctlr->right_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->right_stick_cal_y.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->right_stick_cal_y.min =3D DFLT_STICK_CAL_MIN;
-=09}
+=09if (ret)
+=09=09joycon_use_default_calibration(ctlr,
+=09=09=09=09=09       &ctlr->right_stick_cal_x,
+=09=09=09=09=09       &ctlr->right_stick_cal_y,
+=09=09=09=09=09       "right", ret);
=20
 =09hid_dbg(ctlr->hdev, "calibration:\n"
 =09=09=09    "l_x_c=3D%d l_x_max=3D%d l_x_min=3D%d\n"
--=20
2.37.3


