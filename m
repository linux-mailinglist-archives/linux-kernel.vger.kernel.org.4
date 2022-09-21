Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15A35BF26A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiIUAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiIUAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:46:31 -0400
X-Greylist: delayed 28300 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 17:46:30 PDT
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827B796A5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:46:30 -0700 (PDT)
Date:   Wed, 21 Sep 2022 00:46:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663721188; x=1663980388;
        bh=vsY6bpnDXXQyofo2pcWGC3Wr4RLYUZCP3JxTNYrryxs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=QMBU3DJ1SOrkU6IcvK/HOVXq2wtl3VnQXVUorDWf8Bf1Kk1JXJ1NaQ1FZOhl3gYNh
         ia32TI9UAeNw+lNcXcTrdmb3oz/XodtNNA4aom17pVjDy8QD9x+MIPDRKsOfK5Wnsw
         MfO/E2Vndm6/aUlI4MsNkyh8z54lk0HwLe+eNaA5ozkyNBCBMKP6SK0cn3akyBZtdz
         hLF5G3IehFlrbfiUA3Y6L6MpieIU515+D39yqoU39GiAVO73hBvqZOYDjaqPgtwUA/
         UKBlZz/W6CVDQzKnuwPSLhU4bpYmA4shxcijRhfl1jNHRi/pxQR6Un90kSTTgpwrzi
         FTnYUfnG9DnuQ==
To:     Daniel Ogorchock <djogorchock@gmail.com>
From:   Johnothan King <johnothanking@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: nintendo: check analog user calibration for plausibility
Message-ID: <f468kPVeU3xgbeIr3VAo9yn79tU-Wk94UJlr9uMsGP-XxyE1MbYejfHRmGsyhoujW5vwobD6wwfRhSjAtZdtlfm-ccqNxkCvSuHMnurhlbc=@protonmail.com>
In-Reply-To: <CAEVj2t=F-zF9jTmfJuqx=DRFopygKDXVv0wX91nRLqP1QZqS_w@mail.gmail.com>
References: <RINjeKS0brZzIa6F-fgBKuiHrrcZB8zfTg_chbQIT3BRLqx-l9SmsxvV3LXx7upuctFCki33uAIhXNsM92YWTub8vbzSQHcJibhPkN5ijB8=@protonmail.com> <CAEVj2tn8byGn2RHmvYc77rv2BZkApW3yQ5qSDDzNGxhbygO2Ag@mail.gmail.com> <CAEVj2t=F-zF9jTmfJuqx=DRFopygKDXVv0wX91nRLqP1QZqS_w@mail.gmail.com>
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

I'll submit a third version that fixes the warning string. I've also
made another minor tweak to joycon_use_default_calibration() for
the v3 patch.

- Johnothan King

------- Original Message -------
On Tuesday, September 20th, 2022 at 3:06 PM, Daniel Ogorchock <djogorchock@=
gmail.com> wrote:


> > static const u16 DFLT_STICK_CAL_CEN =3D 2000;
> > static const u16 DFLT_STICK_CAL_MAX =3D 3500;
> > static const u16 DFLT_STICK_CAL_MIN =3D 500;
> > +static void joycon_use_default_calibration(struct joycon_ctlr *ctlr,
> > + struct joycon_stick_cal *cal_x,
> > + struct joycon_stick_cal *cal_y,
> > + const char *stick, int ret)
> > +{
> > + hid_warn(ctlr->hdev,
> > + "Failed to read %s stick cal, "
> > + "using defaults; e=3D%d\n",
> > + stick, ret);
> > +
>=20
>=20
> Sorry, missed this on my first readthrough. I think the coding style
> mentions not to break up the logged string into multiple lines, since
> it'll harm greppability.
>=20
> -Daniel
