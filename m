Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA38F5BFC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIUKxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIUKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:53:13 -0400
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C47CAA0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:53:12 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663757589; x=1664016789;
        bh=ap7mj8/mdNh1PBx7qgvwFOObSxfesy6GqXAIE71kjo4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=qeNCQon8/g6wmT455Pw90zt9ZiaMgYwtemgb2L6Z5ryCdXIyQszQIhzrfdPFJcT+W
         J0XwZvgj5rky25UbJbbmMvvLQJhLH9nKZ2oLH9eppVAElgCDSglMOqyQyWczLEUNmy
         Zxndxe5oXxBob4XnPOb013q6zqVk/xOFdrGkMSkySsNzcDkvH8yvXMhHBA2PswRjJU
         a1rdcsSwQpn2aw4LP0aRnZp228eyZn1KamlNYpCx2Wsz0ZaS5P9mIl1osHsgt+7lPi
         2RnmVpfW28NzgOYuGdrodbGowNJJQmVpmd//O9Oi93rHvRFo5Q/ZvUkjgCI0FO55Vd
         5WAfug4DRjgPg==
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] HID: nintendo: check analog user calibration for plausibility
Message-ID: <sYmiVRgE2W0l3bBHFNqT-qFvK1mCRziesWwHDHPoYiefTpHS1T2hJkyDN23WfIWqbreMT3CGcTwgVQrcINwci0CsD19z1io-49Yv2G2cBi4=@protonmail.com>
In-Reply-To: <20220921083420.sm72vrsemaldjsz2@mail.corp.redhat.com>
References: <kn4CB9QoD1YwWTQC8wlBFUvXoEsYgDRtcx91dvd913pHTzuNw0ZnYoh8rWsN2WUSnghQm8nCz4xqwH4NbsK04MWihIvP3HWkV9kPi4KMK_I=@protonmail.com> <20220921083420.sm72vrsemaldjsz2@mail.corp.redhat.com>
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

For my v4 patch I'll just change the check back to using >=3D. The
signedness of the min, max and center values will probably need some
sort of fix, but that's out of the scope of this patch.

- Johnothan King

------- Original Message -------
On Wednesday, September 21st, 2022 at 1:34 AM, Benjamin Tissoires <benjamin=
.tissoires@redhat.com> wrote:


> Hi Johnothan,
>=20
> On Sep 21 2022, Johnothan King wrote:
>=20
> > Arne Wendt writes:
> > Cheap clone controllers may (falsely) report as having a user
> > calibration for the analog sticks in place, but return
> > wrong/impossible values for the actual calibration data.
> > In the present case at mine, the controller reports having a
> > user calibration in place and successfully executes the read
> > commands. The reported user calibration however is
> > min =3D center =3D max =3D 0.
> >=20
> > This pull request addresses problems of this kind by checking the
> > provided user calibration-data for plausibility (min < center < max)
> > and falling back to the default values if implausible.
> >=20
> > I'll note that I was experiencing a crash because of this bug when usin=
g
> > the GuliKit KingKong 2 controller. The crash manifests as a divide by
> > zero error in the kernel logs:
> > kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI
> >=20
> > Changes in v2:
> > - Move the plausibility check to joycon_read_stick_calibration() and
> > have that function return -EINVAL if the check fails.
> > - In the plausibility check, change >=3D to =3D=3D. hid_field_extract()=
 never
> > returns a negative value, so a scenario involving min > center or
> > center > max is impossible.
>=20
>=20
> I am not so sure this is a great idea. I agree this is correct, but it
> definitely requires some processing from my brain and double
> verifications in the code that this is correct.
>=20
> The problem is that all of the values are declared as s32.
> hid_field_extract() returns a u32, yes, but I haven't checked the report
> descriptor if that value can be a negative one. What needs to be done,
> if the logical min value is negative is that we should call hid_snto32()
> to convert into a proper s32 (I doubt you have to do it but I am putting
> it here for completeness).
>=20
> So basically, you are blindly converting a u32 into a s32 and do not
> take rollover into account.
>=20
> Given that this function is only called at probe time where timing is
> not the biggest of our concerns, I would simply leave the more human
> friendy with obvious failures cases with >=3D and <=3D.
>=20
>=20
>=20
> Second note: please move all "Changes in v*" below the first '---' and
> before the file stats. This way they will be stripped out when applying
> the patch. People who want to see the changes can always follow the lore
> link that should be applied to the commit when this patch gets applied.
>=20
> > - To reduce code duplication, move the code for setting default
> > calibration values into a single function called
> > joycon_use_default_calibration().
> >=20
> > Changes in v3:
> > - Unbreak warning string to conform to coding style.
> > - Change joycon_use_default_calibration() to accept a struct hid_device
> > pointer instead of a struct joycon_ctlr pointer.
> >=20
> > Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> > Link: https://github.com/DanielOgorchock/linux/issues/36
> > Co-authored-by: Arne Wendt arne.wendt@tuhh.de
> > Signed-off-by: Johnothan King johnothanking@protonmail.com
> > ---
> > drivers/hid/hid-nintendo.c | 55 +++++++++++++++++++++-----------------
> > 1 file changed, 30 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > index 6028af3c3aae..f25b7b19e9a4 100644
> > --- a/drivers/hid/hid-nintendo.c
> > +++ b/drivers/hid/hid-nintendo.c
> > @@ -760,12 +760,31 @@ static int joycon_read_stick_calibration(struct j=
oycon_ctlr *ctlr, u16 cal_addr,
> > cal_y->max =3D cal_y->center + y_max_above;
> > cal_y->min =3D cal_y->center - y_min_below;
> >=20
> > - return 0;
> > + /* check if values are plausible */
> > + if (cal_x->min =3D=3D cal_x->center || cal_x->center =3D=3D cal_x->ma=
x ||
> > + cal_y->min =3D=3D cal_y->center || cal_y->center =3D=3D cal_y->max)
> > + ret =3D -EINVAL;
> > +
> > + return ret;
> > }
> >=20
> > static const u16 DFLT_STICK_CAL_CEN =3D 2000;
> > static const u16 DFLT_STICK_CAL_MAX =3D 3500;
> > static const u16 DFLT_STICK_CAL_MIN =3D 500;
> > +static void joycon_use_default_calibration(struct hid_device *hdev,
> > + struct joycon_stick_cal *cal_x,
> > + struct joycon_stick_cal *cal_y,
> > + const char *stick, int ret)
> > +{
> > + hid_warn(hdev,
> > + "Failed to read %s stick cal, using defaults; e=3D%d\n", stick,
> > + ret);
>=20
>=20
> nitpick: why not putting the format string on the line above and leave
> "stick" and "ret in the second line? It should be OK for checkpatch and
> will be less weird to have "ret" on its line all by itself.
>=20
> > +
> > + cal_x->center =3D cal_y->center =3D DFLT_STICK_CAL_CEN;
> > + cal_x->max =3D cal_y->max =3D DFLT_STICK_CAL_MAX;
> > + cal_x->min =3D cal_y->min =3D DFLT_STICK_CAL_MIN;
> > +}
> > +
> > static int joycon_request_calibration(struct joycon_ctlr *ctlr)
> > {
> > u16 left_stick_addr =3D JC_CAL_FCT_DATA_LEFT_ADDR;
> > @@ -793,38 +812,24 @@ static int joycon_request_calibration(struct joyc=
on_ctlr *ctlr)
> > &ctlr->left_stick_cal_x,
> > &ctlr->left_stick_cal_y,
> > true);
> > - if (ret) {
> > - hid_warn(ctlr->hdev,
> > - "Failed to read left stick cal, using dflts; e=3D%d\n",
> > - ret);
> > -
> > - ctlr->left_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
> > - ctlr->left_stick_cal_x.max =3D DFLT_STICK_CAL_MAX;
> > - ctlr->left_stick_cal_x.min =3D DFLT_STICK_CAL_MIN;
> >=20
> > - ctlr->left_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
> > - ctlr->left_stick_cal_y.max =3D DFLT_STICK_CAL_MAX;
> > - ctlr->left_stick_cal_y.min =3D DFLT_STICK_CAL_MIN;
> > - }
> > + if (ret)
> > + joycon_use_default_calibration(ctlr->hdev,
> > + &ctlr->left_stick_cal_x,
> > + &ctlr->left_stick_cal_y,
> > + "left", ret);
> >=20
> > /* read the right stick calibration data */
> > ret =3D joycon_read_stick_calibration(ctlr, right_stick_addr,
> > &ctlr->right_stick_cal_x,
> > &ctlr->right_stick_cal_y,
> > false);
> > - if (ret) {
> > - hid_warn(ctlr->hdev,
> > - "Failed to read right stick cal, using dflts; e=3D%d\n",
> > - ret);
> > -
> > - ctlr->right_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
> > - ctlr->right_stick_cal_x.max =3D DFLT_STICK_CAL_MAX;
> > - ctlr->right_stick_cal_x.min =3D DFLT_STICK_CAL_MIN;
> >=20
> > - ctlr->right_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
> > - ctlr->right_stick_cal_y.max =3D DFLT_STICK_CAL_MAX;
> > - ctlr->right_stick_cal_y.min =3D DFLT_STICK_CAL_MIN;
> > - }
> > + if (ret)
> > + joycon_use_default_calibration(ctlr->hdev,
> > + &ctlr->right_stick_cal_x,
> > + &ctlr->right_stick_cal_y,
> > + "right", ret);
> >=20
> > hid_dbg(ctlr->hdev, "calibration:\n"
> > "l_x_c=3D%d l_x_max=3D%d l_x_min=3D%d\n"
> > --
> > 2.37.3
>=20
>=20
> Cheers,
> Benjamin
