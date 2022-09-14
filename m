Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1305B8F50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiINTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiINTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:40:43 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 12:40:40 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B13422CC;
        Wed, 14 Sep 2022 12:40:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 53970157E;
        Wed, 14 Sep 2022 21:34:00 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:in-reply-to:references:from:from:subject:subject
        :date:date:received:received:received; s=dkim20160331; t=
        1663184039; x=1664998440; bh=QEPTuJ0CDzklXbRh4DD4or5E2pmxX6owZcy
        baaXghQU=; b=b+JaWMp/YUOwZehRVD9vbdqwn3/GHYsaY6zjt02zcqQSOM0UfaL
        vqXDh0WB5VitAV9QqtZRGvmi7ZehdrdgRKG3MoMKEZrw+k+TlgbAJYu8HAeAqbA9
        eNLqTtYTbnD3xM8krhbqHImkshL9l2quFuueMMNXkjFHbFTbDUbu3U8kythMmsqG
        hk78+iGetGDR8WT6vjWv5iqCLwLBFDpGFcnTGH3pnzH3OMbKdGtzRGd3ILZoj/FG
        ++pxXxaa2kZX6Ofg3UD8IYuTtcZVPA65oZ6wOz5XtFLKDvQQ0QBp4HEWAHmmHGE+
        KvEwVtGnLaBCBxMvJ9mCjF4RtwE7IQB2t2ZaR+XKmcTKl9WY2q19vwDzv+Vs2C7n
        i1W4i+EzI7EUIUHQoTjnaKY2Ag2egSb2EeJVTArBr/byHfNeBCkq6gQ2ZuYQrjwh
        KF/HL2N6TbEy43Az7OdN1jDO53KanSBEui9NRNgJZ7SGXTbABik7arbC5QBANSSg
        GZE5uBXO6RPesI62/07LXvIyC4jidwkAxNTNFUUoH204RPJMDdJYZRDv9YLHYTcN
        yg5UiQrzcNecR/oKYAnNIu4ULkEYObYbQcyR2siLbcs2UP/cMZRYZwXlch8ZMVPG
        rLHcXpPFKImgRO13FYb9FJaxnue2Gaw79O6DqJJi+ChuKA4w4pMC9To8=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kZJsm5l6656i; Wed, 14 Sep 2022 21:33:59 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id F3091147B;
        Wed, 14 Sep 2022 21:33:58 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 8992D2E98;
        Wed, 14 Sep 2022 21:33:58 +0200 (CEST)
Date:   Wed, 14 Sep 2022 21:33:56 +0200
To:     Johnothan King <johnothanking@protonmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: nintendo: check analog user calibration for
 plausibility
From:   "Silvan Jegen" <me@sillymon.ch>
References: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com>
In-Reply-To: <ByMO0BENaLBLEnGGrPwe37i3VDtN-VuRlSHqkdgk7Q1JHQ16bI_S1QuEtqtSdeV0XcwGMZwrAkFEGaEdXN_Z1qaN2r1cFeZnu5TyHMxszIU=@protonmail.com>
Message-Id: <3DQ9AO4TGVHWM.3BGLGQY972JSD@homearch.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Johnothan King <johnothanking@protonmail.com> wrote:
> Arne Wendt writes:
>   Cheap clone controllers may (falsely) report as having a user
>   calibration for the analog sticks in place, but return
>   wrong/impossible values for the actual calibration data.
>   In the present case at mine, the controller reports having a
>   user calibration in place and successfully executes the read
>   commands. The reported user calibration however is
>   min =3D center =3D max =3D 0.
>=20
>   This pull request addresses problems of this kind by checking the
>   provided user calibration-data for plausibility (min < center < max)
>   and falling back to the default values if implausible.
>=20
> I'll note that I was experiencing a crash because of this bug when using
> the GuliKit KingKong 2 controller. The crash manifests as a divide by
> zero error in the kernel logs:
> kernel: divide error: 0000 [#1] PREEMPT SMP NOPTI
>=20
> Link: https://github.com/nicman23/dkms-hid-nintendo/pull/25
> Link: https://github.com/DanielOgorchock/linux/issues/36
> Co-authored-by: Arne Wendt <arne.wendt@tuhh.de>
> Signed-off-by: Johnothan King <johnothanking@protonmail.com>
> ---
>  drivers/hid/hid-nintendo.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

I have actually hit this issue as well ...


Cheers,
Silvan

>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 6028af3c3aae..7f287f6a75f5 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -793,7 +793,17 @@ static int joycon_request_calibration(struct joycon_=
ctlr *ctlr)
>  					    &ctlr->left_stick_cal_x,
>  					    &ctlr->left_stick_cal_y,
>  					    true);
> -	if (ret) {
> +
> +	/*
> +	 * Check whether read succeeded and perform plausibility check
> +	 * for retrieved values.
> +	 */
> +	if (ret ||
> +		ctlr->left_stick_cal_x.min >=3D ctlr->left_stick_cal_x.center ||
> +		ctlr->left_stick_cal_x.center >=3D ctlr->left_stick_cal_x.max ||
> +		ctlr->left_stick_cal_y.min >=3D ctlr->left_stick_cal_y.center ||
> +		ctlr->left_stick_cal_y.center >=3D ctlr->left_stick_cal_y.max
> +	) {
>  		hid_warn(ctlr->hdev,
>  			 "Failed to read left stick cal, using dflts; e=3D%d\n",
>  			 ret);
> @@ -812,7 +822,17 @@ static int joycon_request_calibration(struct joycon_=
ctlr *ctlr)
>  					    &ctlr->right_stick_cal_x,
>  					    &ctlr->right_stick_cal_y,
>  					    false);
> -	if (ret) {
> +
> +	/*
> +	 * Check whether read succeeded and perform plausibility check
> +	 * for retrieved values.
> +	 */
> +	if (ret ||
> +		ctlr->right_stick_cal_x.min >=3D ctlr->right_stick_cal_x.center ||
> +		ctlr->right_stick_cal_x.center >=3D ctlr->right_stick_cal_x.max ||
> +		ctlr->right_stick_cal_y.min >=3D ctlr->right_stick_cal_y.center ||
> +		ctlr->right_stick_cal_y.center >=3D ctlr->right_stick_cal_y.max
> +	) {
>  		hid_warn(ctlr->hdev,
>  			 "Failed to read right stick cal, using dflts; e=3D%d\n",
>  			 ret);


