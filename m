Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7565274F30A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGKPJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGKPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:08:44 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7DA100;
        Tue, 11 Jul 2023 08:08:42 -0700 (PDT)
Date:   Tue, 11 Jul 2023 15:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1689088119; x=1689347319;
        bh=VIjn5Sgr+XaI5m5nuTNBKwgTaDZhQimElHATfB00U6o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=hQD30D9TLLyDcO2bVl3okDKDs2kzhhC5933d/BlWVXxUwQTaMAx3k3rghCgId7t20
         k6HMSplZ3mlQOqHW09SZiGGpWfONV5kXZs53aG1Ih0OouFOKpT6AWs4loYxgwXJBdG
         yUJdaQEcExbliNS5agrIVUaRAlobvtUZR3TVaqds=
To:     Bjorn Andersson <andersson@kernel.org>,
        Gergo Koteles <soyer@irl.hu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     Jonathan Corbet <corbet@lwn.net>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Input: add ABS_SND_PROFILE
Message-ID: <65708872-3209-bd7b-d873-45e75a9e34bb@connolly.tech>
In-Reply-To: <20230407171103.5jf46g4hw3fed7dn@ripper>
References: <cover.1677022414.git.soyer@irl.hu> <1a4752739568afbdbaaff48436d2bb595d2bda0d.1677022414.git.soyer@irl.hu> <20230407171103.5jf46g4hw3fed7dn@ripper>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2023 18:11, Bjorn Andersson wrote:
> On Wed, Feb 22, 2023 at 01:10:33AM +0100, Gergo Koteles wrote:
>> ABS_SND_PROFILE used to describe the state of a multi-value sound profil=
e
>> switch. This will be used for the alert-slider on OnePlus phones or othe=
r
>> phones.
>>
>> Profile values added as SND_PROFLE_(SILENT|VIBRATE|RING) identifiers
>> to input-event-codes.h so they can be used from DTS.
>>
>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>> ---
>>  Documentation/input/event-codes.rst    | 6 ++++++
>>  drivers/hid/hid-debug.c                | 1 +
>>  include/uapi/linux/input-event-codes.h | 9 +++++++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/e=
vent-codes.rst
>> index b4557462edd7..d43336e64d6a 100644
>> --- a/Documentation/input/event-codes.rst
>> +++ b/Documentation/input/event-codes.rst
>> @@ -241,6 +241,12 @@ A few EV_ABS codes have special meanings:
>>      emitted only when the selected profile changes, indicating the newl=
y
>>      selected profile value.
>>
...
>>
>> +/*
>> + * ABS_SND_PROFILE values
>> + */
>> +
>> +#define SND_PROFILE_SILENT=090x00
>> +#define SND_PROFILE_VIBRATE=090x01
>> +#define SND_PROFILE_RING=090x02
>=20
> The patch looks good to me, bu I'd need these header file additions in
> order to merge the dts patch. Could I get an ack and take it through the
> Qualocmm tree, or could you pick it up for 6.4, and then I can merge the
> dts change after that?

Bump, I think this might have gotten lost.
>=20
> Regards,
> Bjorn
>=20
>> +
>>  #endif
>> --
>> 2.39.2
>>

--=20
Kind Regards,
Caleb

