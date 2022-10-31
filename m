Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B59C613E74
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJaTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:40:58 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEF62E1;
        Mon, 31 Oct 2022 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667245255; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ev+MitsCvb12qgt/0r4BvM6yNG9k7Li3wHRVx265aw0=;
        b=hrfZgO2440u6WNNOd8DB0pQ/70uPdBsvk6fnaQaeMPBiWRo5HPWZ7bJb4WQAM1PepqQ0/D
        DcY9DaTMglBPI5KVPjwKdZEMm8zF6F69whlQ8hoGl63SBBQgsd7QWWGaGxlv9UUtkib0VN
        ktxAsvmugDhckF83ij6CGg3ZuumbQaI=
Date:   Mon, 31 Oct 2022 19:40:44 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: ingenic: Rework compatible
 strings and add #clock-cells
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net
Message-Id: <WNUMKR.BWKAZLU4SGE52@crapouillou.net>
In-Reply-To: <20221031192341.GA3270129-robh@kernel.org>
References: <20221028225519.89210-1-paul@crapouillou.net>
        <20221028225519.89210-2-paul@crapouillou.net>
        <20221031192341.GA3270129-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le lun. 31 oct. 2022 =E0 14:23:41 -0500, Rob Herring <robh@kernel.org> a=20
=E9crit :
> On Fri, Oct 28, 2022 at 11:55:16PM +0100, Paul Cercueil wrote:
>>  The RTC in the JZ4770 is compatible with the JZ4760, but has an=20
>> extra
>>  register that permits to configure the behaviour of the CLK32K pin.=20
>> The
>>  same goes for the RTC in the JZ4780.
>>=20
>>  Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do=20
>> not
>>  fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc=20
>> string
>>  now falls back to the ingenic,jz4770-rtc string.
>=20
> This is a compatibility mess. There is no driver support in v6.1-rc=20
> for
> ingenic,jz4770-rtc, so a new DT would not work with existing kernels.=20
> It
> sounds like you need 3 compatibles for 4780.

Do newer DTs need to work with older kernels? I always assumed the=20
compatibility was only enforced for the other way around.

If that's the case though, I guess I can enforce 3 compatibles for 4780=20
and 2 for 4770 like  you suggested.

Cheers,
-Paul

>>=20
>>  Additionally, since the RTCs in the JZ4770 and JZ4780 support=20
>> outputting
>>  the input oscillator's clock to the CLK32K pin, the RTC node is now=20
>> also
>>  a clock provider on these SoCs, so a #clock-cells property is added.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>=20
>>   v2: - add constraint on which SoCs can have the #clock-cells=20
>> property
>>       - add JZ4780 example which has a #clock-cells
>>=20
>>   .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 32=20
>> +++++++++++++++++--
>>   1 file changed, 30 insertions(+), 2 deletions(-)


