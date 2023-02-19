Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82E669C13C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 16:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBSPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 10:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjBSPaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 10:30:10 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3279FF01;
        Sun, 19 Feb 2023 07:30:07 -0800 (PST)
Date:   Sun, 19 Feb 2023 15:30:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1676820605; x=1677079805;
        bh=ucl/nUvzkNkdPDWvkaASa6MWLaX46zxlHKTO/1V4RKU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=goDUvpW53D4mdq1g+VaJDFpGQeJybPvKJEcVXlBTW0uERq8xwOrrAToaoWbXx1swG
         OymG/2k/6PbS0AODQ1dt2FKsEu7k2qOGVOlmlVy9bP0NsztaRpHYJWeySPGycuBlyP
         lWbPJfTArnYbdY75Mkuli4p24Uwjyjms2HLxa+hE=
To:     Gergo Koteles <soyer@irl.hu>, Pavel Machek <pavel@ucw.cz>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add tri-state-key
Message-ID: <b2becbcf-fd9c-69b5-b208-17f4d0339684@connolly.tech>
In-Reply-To: <007239f0-1b13-77b9-0d9c-d68747e20331@irl.hu>
References: <20230209232556.91554-1-soyer@irl.hu> <Y+fE7gIMD4BDCffy@duo.ucw.cz> <d1959211-bf33-f4fd-01a8-91dcd247aa70@connolly.tech> <007239f0-1b13-77b9-0d9c-d68747e20331@irl.hu>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/02/2023 03:32, Gergo Koteles wrote:
> Hi,
>
>>
>>
>> On 11/02/2023 16:40, Pavel Machek wrote:
>>> Hi!
>>>
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>>>> @@ -52,6 +52,43 @@ key-vol-up {
>>>>   =09=09};
>>>>   =09};
>>>>
>>>> +=09tri-state-key {
>>>> +=09=09compatible =3D "gpio-keys";
>>>> +=09=09label =3D "Tri-state key";
>>>> +=09=09pinctrl-names =3D "default";
>>>> +=09=09pinctrl-0 =3D <&tri_state_key_default>;
>>>> +=09=09state-top {
>>>> +=09=09=09label =3D "Tri-state key top";
>>>
>>> "top/middle" is not too useful. Do we need the label at all? If so,
>>> should it say "loud/vibrations only/mute"?
>>
>> "mute", "vibrate" and "ring" sound good to me.
>>
>
> OnePlus uses the silent/vibrate/ring, iPhone the silent/ring names.
> Maybe silent/vibrate/ring are more familiar.
>
> Adding labels can document these modes here.
> Should we also document these in input-event-codes.h?

Maybe it would be best to define macros for these rather than leave them
as magic numbers
> #define ABS_SND_PROFILE=09=090x22 /* 0 =3D silent; 1 =3D vibrate; 2 =3D r=
ing */

#define ABS_SND_PROFILE_SILENT=090
#define ABS_SND_PROFILE_VIBRATE=091
#define ABS_SND_PROFILE_RING=092

>
>
> Thanks,
> Gergo
>
>> Although it would be nice if users can easily map the physical key
>> position to the action when viewing the input device or remapping the
>> key in userspace.
>>
>> Do you have any ideas or recommendations on how to do this?
>>>
>>> BR,
>>> =09=09=09=09=09=09=09=09Pavel
>>
>> --
>> Kind Regards,
>> Caleb
>>
>

--
Kind Regards,
Caleb

