Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4059A61D9E6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKEMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKEMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 08:38:14 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70615726
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667651877; bh=GtMx5VstEy61vrzIUASE+KC+AT3zTaHsHrHD2w3tP/k=;
        h=X-EA-Auth:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=HucCY67VaIu0on7RDF1CjxBYyZ5K4fOsh1jre9HaWPUEGCFupceKfrvOaTKUnvi9v
         VfhwgyUFrP2mruGMF6aFK2TvlJgMm5RmhG88WnWKrMNaqpnJh2bc19cLChHFSWxS9W
         WlnsAxtVEV6/CsCWlwQevZ/Ycj/r0vfSQkARp26M=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sat,  5 Nov 2022 13:37:57 +0100 (CET)
X-EA-Auth: UMfo2Qe/JnqzwN5ERAoWxYpcmCoJbQswsmnrVgTU93l0comRXwpP3OSZeJ6Ema/mzBFBynJuA581D2XsSp12iwPkcKsCi/xeqW5+fQUaf6A=
Message-ID: <5f1a31ba4a53f8461bad7747ae09e73fcfe0af1c.camel@mailoo.org>
Subject: Re: [PATCH v1 1/1] leds: is31fl319x: Wrap mutex_destroy() for
 devm_add_action_or_rest()
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Date:   Sat, 05 Nov 2022 13:37:55 +0100
In-Reply-To: <20221104235940.74044-1-andriy.shevchenko@linux.intel.com>
References: <20221104235940.74044-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 05 novembre 2022 =C3=A0 01:59 +0200, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> Clang complains that devm_add_action() takes a parameter with a wrong typ=
e:
>=20
> warning: cast from 'void (*)(struct mutex *)' to 'void (*)(void *)' conve=
rts to incompatible function type [-Wcast-
> function-type-strict]
> =C2=A0=C2=A0=C2=A0 err =3D devm_add_action(dev, (void (*)(void *))mutex_d=
estroy, &is31->lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =C2=A0=C2=A0=C2=A0 1 warning generated.
>=20
> It appears that the commit e1af5c815586 ("leds: is31fl319x: Fix devm vs.
> non-devm ordering") missed two things:
> - while mention devm_add_action_or_reset() the actual change got
> =C2=A0 devm_add_action() call by unknown reason
> - strictly speaking the parameter is not compatible by type
>=20
> Fix both issues by switching to devm_add_action_or_reset() and adding a
> wrapper for mutex_destroy() call.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: e1af5c815586 ("leds: is31fl319x: Fix devm vs. non-devm ordering")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/leds/leds-is31fl319x.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl319=
x.c
> index 52b59b62f437..6f94ad83e066 100644
> --- a/drivers/leds/leds-is31fl319x.c
> +++ b/drivers/leds/leds-is31fl319x.c
> @@ -494,6 +494,11 @@ static inline int is31fl3196_db_to_gain(u32 dezibel)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return dezibel / IS31FL31=
96_AUDIO_GAIN_DB_STEP;
> =C2=A0}
> =C2=A0
> +static void is31f1319x_mutex_destroy(void *lock)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_destroy(lock);
> +}
> +
> =C2=A0static int is31fl319x_probe(struct i2c_client *client)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct is31fl319x_chip *i=
s31;
> @@ -510,7 +515,7 @@ static int is31fl319x_probe(struct i2c_client *client=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_init(&is31->lock);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D devm_add_action(dev, (=
void (*)(void *))mutex_destroy, &is31->lock);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D devm_add_action_or_res=
et(dev, is31f1319x_mutex_destroy, &is31->lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return err;
> =C2=A0

LED still works fine after applying this patch,
also after rmmod'ing and modprobe'ing again.
Please let me know if something else should be tested.
Thank you !

Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>


