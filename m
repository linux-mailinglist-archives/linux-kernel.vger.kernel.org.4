Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6825BEB64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiITQx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiITQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:53:58 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC767C9A;
        Tue, 20 Sep 2022 09:53:56 -0700 (PDT)
Date:   Tue, 20 Sep 2022 16:53:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663692832; x=1663952032;
        bh=QjwZpG0S4LvvZwbetfklzra7gZLZ6HwurOPADiwMJxI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=KZfqCwXgKaiM6Pt9GI7JHIM3g/ZRZMvQ3zeXiXLephSZ1frJOzhwC98yvMqjlq/2B
         6xuUvZRJaMxfcZHDF+/frOU0uId5Bv7TMX4Oos7k3Mqh4W5zDYjvy7JLAk/Ft6Ewg+
         MPVRtdhxdYwYas4HvfXG2EO3YMjOrA+oHBj8NkMLsSuUQttuX0r/VXR5+MBvgrnVoK
         3lDGn8Mi5lYMgkVpAgc6GI61D++V185dWi7VuJEU9AnboBeH4Ue3H0finieqZ+7b7m
         wrc9Ijay4HYjlH2onBXqk1408lesRj247KLqNCaD19XsL7p4427s+xTQLCJfeRDOzm
         6zqXISTfUUfWw==
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: nintendo: check analog user calibration for plausibility
Message-ID: <UlQ1j3XGMvGs8eZn-2GlSLo-cGjC9OCaN8W2oUOXavBPKTnx22y_lBR6YVreyKosiV6IQkYZFAiBkyxoNpFcLgei5p9nfYqUEG2Av8qrOmI=@protonmail.com>
In-Reply-To: <CAO-hwJLxTQ6Sq=yHksE1f9sDveAsX88ozhu5Pw4+N+kwHdi8hg@mail.gmail.com>
References: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com> <CAO-hwJLxTQ6Sq=yHksE1f9sDveAsX88ozhu5Pw4+N+kwHdi8hg@mail.gmail.com>
Feedback-ID: 1750573:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it make sense to have a function that takes a single struct
> joycon_stick_cal pointer and does the check?

I acknowledge the current code can be simplified further. I will submit a s=
econd version of this patch that moves the plausibility check to joycon_rea=
d_stick_calibration() and adds a joycon_use_default_calibration() function.=
 This will avoid the code duplication present in the current patch.

In the v2 patch the check will still use both the cal_x and cal_y pointers.=
 However, since the check will be reduced to just one if statement, that sh=
ould be enough to simplify the code. The new function in the v2 patch (joyc=
on_use_default_calibration()) was implemented so that I could simplify the =
existing default stick calibration code for reuse with both the left and ri=
ght sticks. The new function in effect reduces four lines of code to one:
    -ctlr->left_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
    -ctlr->left_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
    -ctlr->right_stick_cal_x.center =3D DFLT_STICK_CAL_CEN;
    -ctlr->right_stick_cal_y.center =3D DFLT_STICK_CAL_CEN;
    +cal_x->center =3D cal_y->center =3D DFLT_STICK_CAL_CEN;

- Johnothan King

------- Original Message -------
On Tuesday, September 20th, 2022 at 3:21 AM, Benjamin Tissoires <benjamin.t=
issoires@redhat.com> wrote:


> On Wed, Sep 14, 2022 at 9:51 AM Johnothan King
> johnothanking@protonmail.com wrote:
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
> > Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> > Link: https://github.com/DanielOgorchock/linux/issues/36
> > Co-authored-by: Arne Wendt arne.wendt@tuhh.de
> > Signed-off-by: Johnothan King johnothanking@protonmail.com
> > ---
> > drivers/hid/hid-nintendo.c | 24 ++++++++++++++++++++++--
> > 1 file changed, 22 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > index 6028af3c3aae..7f287f6a75f5 100644
> > --- a/drivers/hid/hid-nintendo.c
> > +++ b/drivers/hid/hid-nintendo.c
> > @@ -793,7 +793,17 @@ static int joycon_request_calibration(struct joyco=
n_ctlr ctlr)
> > &ctlr->left_stick_cal_x,
> > &ctlr->left_stick_cal_y,
> > true);
> > - if (ret) {
> > +
> > + /
> > + * Check whether read succeeded and perform plausibility check
> > + * for retrieved values.
> > + */
> > + if (ret ||
> > + ctlr->left_stick_cal_x.min >=3D ctlr->left_stick_cal_x.center ||
> > + ctlr->left_stick_cal_x.center >=3D ctlr->left_stick_cal_x.max ||
> > + ctlr->left_stick_cal_y.min >=3D ctlr->left_stick_cal_y.center ||
> > + ctlr->left_stick_cal_y.center >=3D ctlr->left_stick_cal_y.max
> > + ) {
> > hid_warn(ctlr->hdev,
> > "Failed to read left stick cal, using dflts; e=3D%d\n",
> > ret);
> > @@ -812,7 +822,17 @@ static int joycon_request_calibration(struct joyco=
n_ctlr ctlr)
> > &ctlr->right_stick_cal_x,
> > &ctlr->right_stick_cal_y,
> > false);
> > - if (ret) {
> > +
> > + /
> > + * Check whether read succeeded and perform plausibility check
> > + * for retrieved values.
> > + */
> > + if (ret ||
> > + ctlr->right_stick_cal_x.min >=3D ctlr->right_stick_cal_x.center ||
> > + ctlr->right_stick_cal_x.center >=3D ctlr->right_stick_cal_x.max ||
> > + ctlr->right_stick_cal_y.min >=3D ctlr->right_stick_cal_y.center ||
> > + ctlr->right_stick_cal_y.center >=3D ctlr->right_stick_cal_y.max
>=20
>=20
> Wouldn't it make sense to have a function that takes a single struct
> joycon_stick_cal pointer and does the check?
> This would make things more readable IMO.
>=20
> Cheers,
> Benjamin
>=20
> > + ) {
> > hid_warn(ctlr->hdev,
> > "Failed to read right stick cal, using dflts; e=3D%d\n",
> > ret);
> > --
> > 2.37.3
