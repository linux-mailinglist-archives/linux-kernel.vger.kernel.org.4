Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E478C5BFDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIUMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C792F2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663763533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DmmiulZMt100BXRKk69magtMbbZrqOsVx99Jfsr3JpY=;
        b=TkyilK0F8GsrZHKV42eQ+VjDeAYgyCMyZa2BOO9nClDvOKHC/dRdBH7GoH86J2zNL/YgwZ
        bBXWet78g+TPoMWMgTc891/xlQjLcx2Xxk8awRLdvOyCm9W5ehUOE9ej7Db/BCmygozXPD
        xZ1pWCfdz/e6WddDXfSUWQA3nCHXmtI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-2OsTSYGKMBWrp42zz-Yrjw-1; Wed, 21 Sep 2022 08:32:12 -0400
X-MC-Unique: 2OsTSYGKMBWrp42zz-Yrjw-1
Received: by mail-io1-f70.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so2982726ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DmmiulZMt100BXRKk69magtMbbZrqOsVx99Jfsr3JpY=;
        b=X3Zb7R3FgG8XgLBAIL0/GV6A5UtHbBb/NQdrxS4NauN5lEdCpQ9lK6PGcGmTkC851v
         CUMpDj7n6oB03oaqpiMdWbR09YkrZx2EkQT4v9Avh/MR/+Ga5hvZ30LciYcMY6zrmy7P
         Ys/McfAlvGB/2Dl5o1ndyMcCW1Sy46VAV7u0d/8wNd1LsLcrCfbYLRNf5scQXkmCCz9B
         eJxRiJhWrHtzmoY/+uGbISjcP9tc8n7sHeQT4vKgCuVXZGih09kSsenwCVJfonkTFpLV
         hgGiAMip2X+eq4UDg3xdrmx4uq6prYrYxY8/ko2u9OXmty5ewYf6eh2IPrzhiI2P0ID7
         E2ow==
X-Gm-Message-State: ACrzQf0Gcnhxtx+clWLuWmvAVVV87x32482arAzth5Pe4sYPw554PgdJ
        LEZaXBpyz0Ik0kdoOO96yuTfDhitZbkPn+kd/mWgQgBXMFu6Jkaj69egK6zVeIvtYwGeq7qCuxk
        2M+3kE0uggOkTrlzYBWGdS/SSM2PZtiQhRaGbgGrX
X-Received: by 2002:a05:6e02:1bc7:b0:2f2:406:3ede with SMTP id x7-20020a056e021bc700b002f204063edemr12019633ilv.240.1663763530678;
        Wed, 21 Sep 2022 05:32:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5gIXYTDEJ4X0JsF2+pTcRPoS+mmRke7eGpb75znwPwewB68fGejE6MyPAd3eBQj6Zhi4tIVxcImzFPBwr3SqE=
X-Received: by 2002:a05:6e02:1bc7:b0:2f2:406:3ede with SMTP id
 x7-20020a056e021bc700b002f204063edemr12019618ilv.240.1663763530356; Wed, 21
 Sep 2022 05:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <kn4CB9QoD1YwWTQC8wlBFUvXoEsYgDRtcx91dvd913pHTzuNw0ZnYoh8rWsN2WUSnghQm8nCz4xqwH4NbsK04MWihIvP3HWkV9kPi4KMK_I=@protonmail.com>
 <20220921083420.sm72vrsemaldjsz2@mail.corp.redhat.com> <sYmiVRgE2W0l3bBHFNqT-qFvK1mCRziesWwHDHPoYiefTpHS1T2hJkyDN23WfIWqbreMT3CGcTwgVQrcINwci0CsD19z1io-49Yv2G2cBi4=@protonmail.com>
In-Reply-To: <sYmiVRgE2W0l3bBHFNqT-qFvK1mCRziesWwHDHPoYiefTpHS1T2hJkyDN23WfIWqbreMT3CGcTwgVQrcINwci0CsD19z1io-49Yv2G2cBi4=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Sep 2022 14:31:59 +0200
Message-ID: <CAO-hwJLar_mQdUVAEjhoTqCzpwnFq66J3-K5MTYTgLLq5rUm6g@mail.gmail.com>
Subject: Re: [PATCH v3] HID: nintendo: check analog user calibration for plausibility
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 12:53 PM Johnothan King
<johnothanking@protonmail.com> wrote:
>
> For my v4 patch I'll just change the check back to using >=. The
> signedness of the min, max and center values will probably need some
> sort of fix, but that's out of the scope of this patch.

Yeah, no worries. The signedness issue was more a FYI, in case you
ever need signed integers from that function. I hope we won't have the
case here and that we are actually having unsigned integers in the
data.

Cheers,
Benjamin

>
> - Johnothan King
>
> ------- Original Message -------
> On Wednesday, September 21st, 2022 at 1:34 AM, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>
>
> > Hi Johnothan,
> >
> > On Sep 21 2022, Johnothan King wrote:
> >
> > > Arne Wendt writes:
> > > Cheap clone controllers may (falsely) report as having a user
> > > calibration for the analog sticks in place, but return
> > > wrong/impossible values for the actual calibration data.
> > > In the present case at mine, the controller reports having a
> > > user calibration in place and successfully executes the read
> > > commands. The reported user calibration however is
> > > min = center = max = 0.
> > >
> > > This pull request addresses problems of this kind by checking the
> > > provided user calibration-data for plausibility (min < center < max)
> > > and falling back to the default values if implausible.
> > >
> > > I'll note that I was experiencing a crash because of this bug when using
> > > the GuliKit KingKong 2 controller. The crash manifests as a divide by
> > > zero error in the kernel logs:
> > > kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI
> > >
> > > Changes in v2:
> > > - Move the plausibility check to joycon_read_stick_calibration() and
> > > have that function return -EINVAL if the check fails.
> > > - In the plausibility check, change >= to ==. hid_field_extract() never
> > > returns a negative value, so a scenario involving min > center or
> > > center > max is impossible.
> >
> >
> > I am not so sure this is a great idea. I agree this is correct, but it
> > definitely requires some processing from my brain and double
> > verifications in the code that this is correct.
> >
> > The problem is that all of the values are declared as s32.
> > hid_field_extract() returns a u32, yes, but I haven't checked the report
> > descriptor if that value can be a negative one. What needs to be done,
> > if the logical min value is negative is that we should call hid_snto32()
> > to convert into a proper s32 (I doubt you have to do it but I am putting
> > it here for completeness).
> >
> > So basically, you are blindly converting a u32 into a s32 and do not
> > take rollover into account.
> >
> > Given that this function is only called at probe time where timing is
> > not the biggest of our concerns, I would simply leave the more human
> > friendy with obvious failures cases with >= and <=.
> >
> >
> >
> > Second note: please move all "Changes in v*" below the first '---' and
> > before the file stats. This way they will be stripped out when applying
> > the patch. People who want to see the changes can always follow the lore
> > link that should be applied to the commit when this patch gets applied.
> >
> > > - To reduce code duplication, move the code for setting default
> > > calibration values into a single function called
> > > joycon_use_default_calibration().
> > >
> > > Changes in v3:
> > > - Unbreak warning string to conform to coding style.
> > > - Change joycon_use_default_calibration() to accept a struct hid_device
> > > pointer instead of a struct joycon_ctlr pointer.
> > >
> > > Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> > > Link: https://github.com/DanielOgorchock/linux/issues/36
> > > Co-authored-by: Arne Wendt arne.wendt@tuhh.de
> > > Signed-off-by: Johnothan King johnothanking@protonmail.com
> > > ---
> > > drivers/hid/hid-nintendo.c | 55 +++++++++++++++++++++-----------------
> > > 1 file changed, 30 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > > index 6028af3c3aae..f25b7b19e9a4 100644
> > > --- a/drivers/hid/hid-nintendo.c
> > > +++ b/drivers/hid/hid-nintendo.c
> > > @@ -760,12 +760,31 @@ static int joycon_read_stick_calibration(struct joycon_ctlr *ctlr, u16 cal_addr,
> > > cal_y->max = cal_y->center + y_max_above;
> > > cal_y->min = cal_y->center - y_min_below;
> > >
> > > - return 0;
> > > + /* check if values are plausible */
> > > + if (cal_x->min == cal_x->center || cal_x->center == cal_x->max ||
> > > + cal_y->min == cal_y->center || cal_y->center == cal_y->max)
> > > + ret = -EINVAL;
> > > +
> > > + return ret;
> > > }
> > >
> > > static const u16 DFLT_STICK_CAL_CEN = 2000;
> > > static const u16 DFLT_STICK_CAL_MAX = 3500;
> > > static const u16 DFLT_STICK_CAL_MIN = 500;
> > > +static void joycon_use_default_calibration(struct hid_device *hdev,
> > > + struct joycon_stick_cal *cal_x,
> > > + struct joycon_stick_cal *cal_y,
> > > + const char *stick, int ret)
> > > +{
> > > + hid_warn(hdev,
> > > + "Failed to read %s stick cal, using defaults; e=%d\n", stick,
> > > + ret);
> >
> >
> > nitpick: why not putting the format string on the line above and leave
> > "stick" and "ret in the second line? It should be OK for checkpatch and
> > will be less weird to have "ret" on its line all by itself.
> >
> > > +
> > > + cal_x->center = cal_y->center = DFLT_STICK_CAL_CEN;
> > > + cal_x->max = cal_y->max = DFLT_STICK_CAL_MAX;
> > > + cal_x->min = cal_y->min = DFLT_STICK_CAL_MIN;
> > > +}
> > > +
> > > static int joycon_request_calibration(struct joycon_ctlr *ctlr)
> > > {
> > > u16 left_stick_addr = JC_CAL_FCT_DATA_LEFT_ADDR;
> > > @@ -793,38 +812,24 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
> > > &ctlr->left_stick_cal_x,
> > > &ctlr->left_stick_cal_y,
> > > true);
> > > - if (ret) {
> > > - hid_warn(ctlr->hdev,
> > > - "Failed to read left stick cal, using dflts; e=%d\n",
> > > - ret);
> > > -
> > > - ctlr->left_stick_cal_x.center = DFLT_STICK_CAL_CEN;
> > > - ctlr->left_stick_cal_x.max = DFLT_STICK_CAL_MAX;
> > > - ctlr->left_stick_cal_x.min = DFLT_STICK_CAL_MIN;
> > >
> > > - ctlr->left_stick_cal_y.center = DFLT_STICK_CAL_CEN;
> > > - ctlr->left_stick_cal_y.max = DFLT_STICK_CAL_MAX;
> > > - ctlr->left_stick_cal_y.min = DFLT_STICK_CAL_MIN;
> > > - }
> > > + if (ret)
> > > + joycon_use_default_calibration(ctlr->hdev,
> > > + &ctlr->left_stick_cal_x,
> > > + &ctlr->left_stick_cal_y,
> > > + "left", ret);
> > >
> > > /* read the right stick calibration data */
> > > ret = joycon_read_stick_calibration(ctlr, right_stick_addr,
> > > &ctlr->right_stick_cal_x,
> > > &ctlr->right_stick_cal_y,
> > > false);
> > > - if (ret) {
> > > - hid_warn(ctlr->hdev,
> > > - "Failed to read right stick cal, using dflts; e=%d\n",
> > > - ret);
> > > -
> > > - ctlr->right_stick_cal_x.center = DFLT_STICK_CAL_CEN;
> > > - ctlr->right_stick_cal_x.max = DFLT_STICK_CAL_MAX;
> > > - ctlr->right_stick_cal_x.min = DFLT_STICK_CAL_MIN;
> > >
> > > - ctlr->right_stick_cal_y.center = DFLT_STICK_CAL_CEN;
> > > - ctlr->right_stick_cal_y.max = DFLT_STICK_CAL_MAX;
> > > - ctlr->right_stick_cal_y.min = DFLT_STICK_CAL_MIN;
> > > - }
> > > + if (ret)
> > > + joycon_use_default_calibration(ctlr->hdev,
> > > + &ctlr->right_stick_cal_x,
> > > + &ctlr->right_stick_cal_y,
> > > + "right", ret);
> > >
> > > hid_dbg(ctlr->hdev, "calibration:\n"
> > > "l_x_c=%d l_x_max=%d l_x_min=%d\n"
> > > --
> > > 2.37.3
> >
> >
> > Cheers,
> > Benjamin
>

