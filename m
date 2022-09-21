Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C0D5BFCA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiIUK4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiIUK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:56:09 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD190C57
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:56:08 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:55:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663757767; x=1664016967;
        bh=ghRWy/e90VWRHHDbxBAs0t0Nb9qsu1i8ost31cToLGU=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=KqV05N021s1uRIPAZb0hxE5nLPPfhlVtsnoRQifU415XatpOHiU8V8Vwv4h8dRG8t
         ac9tWNmeMG6i1omV/8iBBIkGznTVT9mTEJbdyURMqM1kr+pRpOyNJqQleD8bVJ3aLn
         GfZlZtzAIs+lFwJWMbY+pf1sATzFrBGWLekv0EwUKpdTY3zSIWS1hYS4dXA0RWLVtD
         LVXPQ8KFrIVU8PPTvWhw1QeRdoGhH0UWBhaIsEPTv5lu8j7iDP/4j7gj/hBFI2kPs9
         +SfCLu2Z5TeTdNF+H2CBGlLzFhRgp3Od1ijdda5UeYaa5/R4vGa+h3jgXSPbmjBL4d
         bPLYmoKZSoAtA==
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Johnothan King <johnothanking@protonmail.com>
Subject: [PATCH v4] HID: nintendo: check analog user calibration for plausibility
Message-ID: <gvpL2G6VwXGJPvxX5KRiu9pVjvTivgayug_jdKDY6zfuAaAqncP9BkKLosjwUXNlgVVTMfJSKfwPF1K79cKAkwGComyC21vCV3q9B3EXNkE=@protonmail.com>
Feedback-ID: 1750573:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
Link: https://github.com/DanielOgorchock/linux/issues/36
Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
Signed-off-by: Johnothan King <johnothanking@protonmail.com>
---
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

Changes in v3:
 - Unbreak warning string to conform to coding style.
 - Change joycon_use_default_calibration() to accept a struct hid_device
   pointer instead of a struct joycon_ctlr pointer.

Changes in v4:
 - Reformat joycon_use_default_calibration() another time to move stick
   and ret onto the same line.
 - Revert =3D=3D to >=3D change to account for rollover.
 - Additional minor change to comment for value check.

 drivers/hid/hid-nintendo.c | 55 +++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 5cb5a1d53b71..71e2a9a0882a 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -760,12 +760,31 @@ static int joycon_read_stick_calibration(struct joyco=
n_ctlr *ctlr, u16 cal_addr,
 =09cal_y->max =3D cal_y->center + y_max_above;
 =09cal_y->min =3D cal_y->center - y_min_below;
=20
-=09return 0;
+=09/* check if calibration values are plausible */
+=09if (cal_x->min >=3D cal_x->center || cal_x->center >=3D cal_x->max ||
+=09    cal_y->min >=3D cal_y->center || cal_y->center >=3D cal_y->max)
+=09=09ret =3D -EINVAL;
+
+=09return ret;
 }
=20
 static const u16 DFLT_STICK_CAL_CEN =3D 2000;
 static const u16 DFLT_STICK_CAL_MAX =3D 3500;
 static const u16 DFLT_STICK_CAL_MIN =3D 500;
+static void joycon_use_default_calibration(struct hid_device *hdev,
+=09=09=09=09=09   struct joycon_stick_cal *cal_x,
+=09=09=09=09=09   struct joycon_stick_cal *cal_y,
+=09=09=09=09=09   const char *stick, int ret)
+{
+=09hid_warn(hdev,
+=09=09 "Failed to read %s stick cal, using defaults; e=3D%d\n",
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
@@ -793,38 +812,24 @@ static int joycon_request_calibration(struct joycon_c=
tlr *ctlr)
 =09=09=09=09=09    &ctlr->left_stick_cal_x,
 =09=09=09=09=09    &ctlr->left_stick_cal_y,
 =09=09=09=09=09    true);
-=09if (ret) {
-=09=09hid_warn(ctlr->hdev,
-=09=09=09 "Failed to read left stick cal, using dflts; e=3D%d\n",
-=09=09=09 ret);
-
-=09=09ctlr->left_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->left_stick_cal_x.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->left_stick_cal_x.min =3D DFLT_STICK_CAL_MIN;
=20
-=09=09ctlr->left_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
-=09=09ctlr->left_stick_cal_y.max =3D DFLT_STICK_CAL_MAX;
-=09=09ctlr->left_stick_cal_y.min =3D DFLT_STICK_CAL_MIN;
-=09}
+=09if (ret)
+=09=09joycon_use_default_calibration(ctlr->hdev,
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
+=09=09joycon_use_default_calibration(ctlr->hdev,
+=09=09=09=09=09       &ctlr->right_stick_cal_x,
+=09=09=09=09=09       &ctlr->right_stick_cal_y,
+=09=09=09=09=09       "right", ret);
=20
 =09hid_dbg(ctlr->hdev, "calibration:\n"
 =09=09=09    "l_x_c=3D%d l_x_max=3D%d l_x_min=3D%d\n"
--=20
2.37.3


