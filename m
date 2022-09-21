Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3E5BF273
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIUAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIUAvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:51:55 -0400
X-Greylist: delayed 28678 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 17:51:53 PDT
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76EF79620
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:51:53 -0700 (PDT)
Date:   Wed, 21 Sep 2022 00:51:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663721511; x=1663980711;
        bh=n+ybg5BjOB6+nup0y9HKg9l5K+4YNo7fACmMKKW3RhQ=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=oWKto79PUCwIODCp6AlWfU4K/U4Iw6Yjdl/7A2PL9chdo7zBGDiv6hkb09PcH20B+
         22KmvEujIkz9pqtDzTAwpgZny1mxiVeSnyuVX3DociBtkzTppL0X+jbQDbFq0OmIjH
         g5PKkYAIfa0H0JIqg4QUrA2Wt9C82QHIg/532LCZyO2oGft80wQx/DszZUOHoffsUv
         xImUIFt7qDoj7rah/BHjxxuUFWYa5ULz1eQEzIpmhZ9UhGzFkZbZo5omTxqLIm0dRl
         y/ZpT7gcrJgPskSzu3T+VUbq77vElv28mmJhSAd1Ot72gPPHePg10zNGFWhADLFPv4
         f96lHCGdVB+Ig==
To:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Johnothan King <johnothanking@protonmail.com>
Subject: [PATCH v3] HID: nintendo: check analog user calibration for plausibility
Message-ID: <kn4CB9QoD1YwWTQC8wlBFUvXoEsYgDRtcx91dvd913pHTzuNw0ZnYoh8rWsN2WUSnghQm8nCz4xqwH4NbsK04MWihIvP3HWkV9kPi4KMK_I=@protonmail.com>
Feedback-ID: 1750573:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Changes in v3:
 - Unbreak warning string to conform to coding style.
 - Change joycon_use_default_calibration() to accept a struct hid_device
   pointer instead of a struct joycon_ctlr pointer.

Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
Link: https://github.com/DanielOgorchock/linux/issues/36
Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
Signed-off-by: Johnothan King <johnothanking@protonmail.com>
---
 drivers/hid/hid-nintendo.c | 55 +++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 6028af3c3aae..f25b7b19e9a4 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -760,12 +760,31 @@ static int joycon_read_stick_calibration(struct joyco=
n_ctlr *ctlr, u16 cal_addr,
 =09cal_y->max =3D cal_y->center + y_max_above;
 =09cal_y->min =3D cal_y->center - y_min_below;
=20
-=09return 0;
+=09/* check if values are plausible */
+=09if (cal_x->min =3D=3D cal_x->center || cal_x->center =3D=3D cal_x->max =
||
+=09    cal_y->min =3D=3D cal_y->center || cal_y->center =3D=3D cal_y->max)
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
+=09=09 "Failed to read %s stick cal, using defaults; e=3D%d\n", stick,
+=09=09 ret);
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


