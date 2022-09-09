Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE45B3B81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIIPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIIPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:10:53 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A9915F9;
        Fri,  9 Sep 2022 08:10:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662736247; bh=4NS9jOc+DKYjPlXdslwxuf9QrepRBJxIl1RQFwG0wLc=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=LJ4wFHF5Ch89nRfLgiUdEOVGOXI0VmjoH78a0fFKjH3755SQJKgdpZx2R9Wm+7h3g
         xzMl3lYqxW3Hplz2UlV735ZTboKP6xQiA0IQBoQMOrUmJMxaVFmlmpOI2XZ52xGDFI
         2kUJ2+JtivHhevG9Tt6VpzCZ0r3Oq2YcBy9Gfyyk=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 09/10] ASoC: cs42l83: Extend CS42L42 support to new part
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <541b11a1-6b5a-cae0-73d9-f1fe8c961a15@linaro.org>
Date:   Fri, 9 Sep 2022 17:10:45 +0200
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <822926B0-CF33-4FF0-B234-8EF644DCED21@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-10-povik+lin@cutebit.org>
 <541b11a1-6b5a-cae0-73d9-f1fe8c961a15@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 9. 9. 2022, at 16:47, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/09/2022 15:53, Martin Povi=C5=A1er wrote:
>> The CS42L83 part is a headphone jack codec found in recent Apple
>> machines. It is a publicly undocumented part but as far as can be =
told
>> it is identical to CS42L42 except for two points:
>>=20

(...)

>> +static const struct dev_pm_ops cs42l83_i2c_pm_ops =3D {
>> +	SET_SYSTEM_SLEEP_PM_OPS(cs42l42_suspend, cs42l83_i2c_resume)
>> +};
>> +
>> +static const struct of_device_id __maybe_unused cs42l83_of_match[] =3D=
 {
>> +	{ .compatible =3D "cirrus,cs42l83", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, cs42l83_of_match);
>> +
>> +static struct i2c_driver cs42l83_i2c_driver =3D {
>> +	.driver =3D {
>> +		.name =3D "cs42l83",
>> +		.pm =3D &cs42l83_i2c_pm_ops,
>> +		.of_match_table =3D of_match_ptr(cs42l83_of_match),
>=20
> This should complain with compile testing. Usually it comes with
> __maybe_unused/

Which symbol? cs42l83_of_match has maybe_unused.

Best, Martin

>=20
>=20
> Best regards,
> Krzysztof

