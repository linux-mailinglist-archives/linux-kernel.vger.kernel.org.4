Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01395B3C42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiIIPoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIIPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:44:20 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB52B729E;
        Fri,  9 Sep 2022 08:44:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662738255; bh=iQf3eHuSRWeGotbEYofBZciMp+NjvuT3Kv1h/4d/X3M=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=n2eWeH6ZvPApY9mJ0yKUXl1e12MAK+7kor4NjJZ6CufN8lt/yiaXpx8DrOKCJHWU+
         ruPpKHk10oPnza/ORTzLinO+9fJU1PvwkRit9928gEFuRIODfVqk4B/wWs5IzJ0HNz
         MzbcedJpnccEHAPsnk8WWsu3dbsSjobljAn8uTy8=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 07/10] ASoC: cs42l42: Split I2C identity into separate
 module
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <aabae52f-8230-f837-c17a-59d781b5af62@opensource.cirrus.com>
Date:   Fri, 9 Sep 2022 17:44:14 +0200
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
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
Message-Id: <5C349ED8-BD51-40BA-BD02-A44FBBEF9C52@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
 <20220909135334.98220-8-povik+lin@cutebit.org>
 <aabae52f-8230-f837-c17a-59d781b5af62@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 9. 9. 2022, at 17:40, Richard Fitzgerald <rf@opensource.cirrus.com> =
wrote:
>=20
> On 09/09/2022 14:53, Martin Povi=C5=A1er wrote:
>> +static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
>> +{
>> +	struct device *dev =3D &i2c_client->dev;
>> +	struct cs42l42_private *cs42l42;
>> +	struct regmap *regmap;
>> +	int ret;
>> +
>> +	cs42l42 =3D devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
>> +	if (!cs42l42)
>> +		return -ENOMEM;
>> +
>> +	regmap =3D devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
>> +	if (IS_ERR(regmap)) {
>> +		ret =3D PTR_ERR(regmap);
>> +		dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", =
ret);
>> +		return ret;
>> +	}
>> +
>> +	cs42l42->dev =3D dev;
>> +	cs42l42->regmap =3D regmap;
>> +	cs42l42->irq =3D i2c_client->irq;
>> +
>> +	ret =3D cs42l42_common_probe(cs42l42, &cs42l42_soc_component, =
&cs42l42_dai);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D cs42l42_init(cs42l42);
>> +	if (ret)
>> +		cs42l42_common_remove(cs42l42);
>=20
> This introduces a bug that regulator_bulk_disable() is called
> twice if there is an error.
>=20
> cs42l42_init() was supposed to clean up if it returns an error, which
> it nearly does, but my original patch is missing the call to =
free_irq()
> in the error paths of cs42l42_init().

Ah! I didn=E2=80=99t inspect it closely enough then, I only ran into the =
missing
free_irq.

Martin

