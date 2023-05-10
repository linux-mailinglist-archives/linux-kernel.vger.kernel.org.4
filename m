Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8286F6FD840
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjEJHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbjEJHbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:31:39 -0400
X-Greylist: delayed 57364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 00:30:26 PDT
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3A7AA7;
        Wed, 10 May 2023 00:30:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1683703813; bh=GWMIsJ4hFWrB3lgN/az7Q/TXbt7UazwaDVD2LkZGOec=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=eMJd4yckLc7wVJTBr2QWpsT+shzcm9YEcAV1PXCmfkRLbWn6K1kra01SLWL4VhYux
         T3SWgqWGYdq6O/cJDhmPxZcZT11eZ8xdJdpPLd4cFZGeTIgDJ4rtlqlhkVJLXOP8oX
         QgxH34oxONrFgwsrABTqUvpocwgvFNViTRQSiVPY=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] ASoC: dt-bindings: Adjust #sound-dai-cells on TI's
 single-DAI codecs
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <baf338a7-1e63-4842-32a1-8f63f850bd2d@linaro.org>
Date:   Wed, 10 May 2023 09:30:12 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Shi Fu <shifu0704@thundersoft.com>,
        Shenghao Ding <shenghao-ding@ti.com>, kevin-lu@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8647EF5-566A-4B99-9020-772810CB2BF7@cutebit.org>
References: <20230509153412.62847-1-povik+lin@cutebit.org>
 <baf338a7-1e63-4842-32a1-8f63f850bd2d@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10. 5. 2023, at 9:17, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 09/05/2023 17:34, Martin Povi=C5=A1er wrote:
>> A bunch of TI's codecs have binding schemas which force =
#sound-dai-cells
>> to one despite those codecs only having a single DAI. Allow for =
bindings
>> with zero DAI cells and deprecate the former non-zero value.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> Documentation/devicetree/bindings/sound/tas2562.yaml | 6 ++++--
>> Documentation/devicetree/bindings/sound/tas2770.yaml | 6 ++++--
>> Documentation/devicetree/bindings/sound/tas27xx.yaml | 6 ++++--
>> 3 files changed, 12 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml =
b/Documentation/devicetree/bindings/sound/tas2562.yaml
>> index a5bb561bfcfb..31a3024ea789 100644
>> --- a/Documentation/devicetree/bindings/sound/tas2562.yaml
>> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
>> @@ -55,7 +55,9 @@ properties:
>>     description: TDM TX current sense time slot.
>>=20
>>   '#sound-dai-cells':
>> -    const: 1
>> +    # The codec has a single DAI, the #sound-dai-cells=3D<1>; case =
is left in for backward
>> +    # compatibility but is deprecated.
>> +    enum: [0, 1]
>=20
> Does it? I see playback and capture.

I think so. Playback and capture are not separate DAIs.

Martin

>=20
> Best regards,
> Krzysztof

