Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265FA6FD909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjEJIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjEJIQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:16:00 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EB71BC0;
        Wed, 10 May 2023 01:15:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683706556; bh=VFBjS6KM+BKXoNWSG7Fj0R1+KXXRbEQwP2Vsz5SUkOI=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=SXOkXai4EA7lzjaH0yLiw23MJUm4m1M0YlmGT62tM3d7XgHBKPxp9ZWJdlLOKDAhe
         TXWqLOJzjrH7tmleBvVRXIEb4U221xOdX0NjfbPNF7B3Efvw2FC6F6OQ46opoKZ7NP
         2MTWp+p9wJlWMRgJsjKfH0hq0YDok5nPaBuNaki0=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
Date:   Wed, 10 May 2023 10:15:55 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <04BB0158-6C7B-400C-A87A-6E9B2835FDC7@cutebit.org>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10. 5. 2023, at 9:51, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/05/2023 18:38, Martin Povi=C5=A1er wrote:
>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
>> mono amplifier with digital input.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>=20
>=20
>> +  reg:
>> +    maxItems: 1
>> +
>> +  adi,ana-gain:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    description: |
>> +      The value to be set in the ANA_GAIN register field on the =
codec. This determines
>> +      the full voltage span of the codec's analog output.
>> +
>> +      To quote the datasheet on the available options:
>> +
>> +        00: 8.4 V Full-Scale Gain Mapping
>> +        01: 12.6 V Full-Scale Gain Mapping
>> +        10: 14 V Full-Scale Gain Mapping
>> +        11: 15 V Full-Scale Gain Mapping
>> +
>> +  '#sound-dai-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - adi,ana-gain
>> +
>> +additionalProperties: true
>=20
> uinevaluatedProperties: false instead, so users can have name-prefix.

I actually tweaked this to have the example passing, which has =
sound-name-prefix,
which I guess is what you have in mind. Not that I exactly understand =
what these
options do (both additionalProperties and unevaluatedProperties), the =
schema docs
didn=E2=80=99t enlighten me right away when I looked into it.

If 'unevaluatedProperties: false' is the way to go here, I will change =
it.

Kind regards,
Martin

> Best regards,
> Krzysztof

