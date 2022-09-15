Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B688A5B9C42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiIONqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIONpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:45:40 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE546E89F;
        Thu, 15 Sep 2022 06:45:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663249513; bh=l01iLyM36JedOYdbzAtHbSm+ZQiW2nZAjHAJLtQOIws=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=K5TAwaPZbHU8pEC1ODHmVk2rGZNxvX8lP1CrhlLin+uAdeE//NklaLbliGyuO37GS
         1aD+jCZlo1q28wPfikTP0ks7osCFIaqDUy2T2ilc+0qWxTJ4lONe3Njl7HZGlO/K08
         VKw4qsdaRXa7xW7ULNnDcMlFOQcCRig6u4y+RNNI=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2 04/11] ASoC: cs42l42: Split probe() and remove() into
 stages
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <2839a437-a57a-ffc4-da8e-dde9a9a9a5cc@opensource.cirrus.com>
Date:   Thu, 15 Sep 2022 15:45:10 +0200
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB6CBB73-5124-4C3B-9F03-DB4B5092767C@cutebit.org>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
 <20220915094444.11434-5-povik+lin@cutebit.org>
 <2839a437-a57a-ffc4-da8e-dde9a9a9a5cc@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 15. 9. 2022, at 14:20, Richard Fitzgerald =
<rf@opensource.cirrus.com> wrote:
>=20
> On 15/09/2022 10:44, Martin Povi=C5=A1er wrote:
>> From: Richard Fitzgerald <rf@opensource.cirrus.com>
>> To prepare for adding SoundWire the probe must be split into three
>> parts:
>> 1) The bus-specific probe
>> 2) Common bus-agnostic probe steps
>> 3) Initialization of the peripheral registers
>> Step (3) must be separate because on SoundWire devices the probe must
>> enable power supplies and release reset so that the peripheral can be
>> enumerated by the bus, but it isn't possible to access registers =
until
>> enumeration has completed.
>> The call to devm_snd_soc_register_component() must be done at stage =
(2)
>> so that it can EPROBE_DEFER if necessary. In SoundWire systems stage =
(3)
>> is not a probe event so a deferral at this stage would not result in
>> re-probing dependencies.
>> A new init_done flag indicates that the chip has been identified and
>> initialized. This is used to prevent cs42l42_remove(), =
cs42l42_suspend(),
>> cs42l42_restore() and cs42l42_irq_thread() from attempting register
>> accesses if the chip was not successfully initialized. Although this
>> cannot happen on I2C, because the entire probe would fail, it is
>> possible on SoundWire if probe succeeds but the cs42l42 is never
>> enumerated.
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> sound/soc/codecs/cs42l42.c | 127 =
+++++++++++++++++++++++++------------
>> sound/soc/codecs/cs42l42.h | 2 +
>> 2 files changed, 87 insertions(+), 42 deletions(-)
>> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
>> index 11cb659f03e0..427b29db2252 100644
>> --- a/sound/soc/codecs/cs42l42.c
>> +++ b/sound/soc/codecs/cs42l42.c
>> @@ -1627,7 +1627,7 @@ static irqreturn_t cs42l42_irq_thread(int irq, =
void *data)
>> 	int report =3D 0;
>> 	mutex_lock(&cs42l42->irq_lock);
>> -	if (cs42l42->suspended) {
>> +	if (cs42l42->suspended || !cs42l42->init_done) {
>> 		mutex_unlock(&cs42l42->irq_lock);
>> 		return IRQ_NONE;
>> 	}
>=20
> This doesn't apply to broonie/for-next. Needs rebasing onto commit:
> ea75deef1a73 ("ASoC: cs42l42: Only report button state if there was a
> button interrupt")

It did apply to broonie/for-6.1 roughly at the time of posting, but
since then the merge commit 12e51866c79f ("ASoC/qcom/arm64: Qualcomm
ADSP DTS and binding fixes=E2=80=9D) brought in changes into =
broonie/for-6.1
from elsewhere, I guess from broonie/for-next. (I am not sure this
was intentional.)

Since the series still applies in a 3-way automerge (git am -3) on
top of the new for-6.1 or for-next, I checked the automerge result
and also considering the other commit ea75deef1a73 touches an
unrelated part of cs42l42_irq_thread, I am not considering this an
issue, that is unless Mark says it is.

Martin

