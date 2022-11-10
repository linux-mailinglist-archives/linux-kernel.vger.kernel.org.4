Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B736247D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiKJRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiKJRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:00:51 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294F220D5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:00:49 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o13so2368189pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XC+lREAOJlgLAcs2t3gy8jxyqE4WrBSZDVI49YPP4fc=;
        b=S5R1Gt3RrGgwgt3s/LT2AXQscV4vOG8upTFNo8MgkAl6O7TApdBoYKAwbHsq7jss1p
         bG/1mPBWn+VPwUtsRejiM4X3U98qiWE5klSog/7MfLZuH/9HP+UwwS2hxJE7uDccNNdP
         FT65CeXjtLAn/QIN+HhC4VLynXa2rAlqaiYOh6IspOGP0tDKiJPlYaG5t1D0nhPqLL9o
         YH3Trd0yj2i18Gwqmq8cxj7gGJywTwaJz6SXuYMNE+M2W2FTGeAudnBgYZDVqwCoKbD2
         P4ciY9DDWaPFHRxiy2sSnrgNg4O1xXbxj9mBd4jxF5gMg7HmK8DdPpsp5Pt8KZ68P/vN
         RIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC+lREAOJlgLAcs2t3gy8jxyqE4WrBSZDVI49YPP4fc=;
        b=YiMcVg2T4kt7OnWEcehS8Y8M4li1QOfTdlUpCKPy8B9PGW2jjcd9fdjI4fDwwpATvN
         f/Fgcx3yOhwZSZYN/WOqXEC05k3mLZ9R0yY9ddD+kr0qegge3nPHEmx8IECQlVvj2n62
         bKhxyXS3b7O4G4+ScSMnpY8NRrTEzxgNztMpIrye3W4LOFZZhDimxJx6rwddIIfAnTo8
         6ZnDs7Goaj958FdfDKQa2rxRkHHUvXuXH+xhIincXNUmO2hm7H4x4lAfDDs+cLmBfgYo
         xU3dESrGWNfyzDESk7INS+hcqqSgWnfdv0nk59KpdYsLl9xUe0nzXteq30xqz03ZkOdG
         uLEw==
X-Gm-Message-State: ACrzQf0wZZJGHR1IhuyFawkrxoze6lQgKe8/OhTtLrN4mEVF4SMWLLYY
        bOYBG+vLTq03Hy/a4qKv0wy+YQ==
X-Google-Smtp-Source: AMsMyM40/tH7wKNr79mtqwVgiRRQXZbl5E1ywpoLKjNAapv719barK355ow9dO35ObkfeKmQbjVrnw==
X-Received: by 2002:a05:6a00:794:b0:56c:318a:f808 with SMTP id g20-20020a056a00079400b0056c318af808mr3005893pfu.11.1668099648683;
        Thu, 10 Nov 2022 09:00:48 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id u15-20020a170903124f00b0017e64da44c5sm11529104plh.203.2022.11.10.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 09:00:47 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     jerome Neanne <jneanne@baylibre.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Cc:     Lee Jones <lee@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, kristo@kernel.org,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, tony@atomide.com,
        vigneshr@ti.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
In-Reply-To: <1267bf43-618c-7347-be3a-2792c656d9b6@baylibre.com>
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com>
 <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
 <20221105000104.rtj3r6ufqwqmepon@keenly> <7heduewjp0.fsf@baylibre.com>
 <5418ac3b-04d7-5e77-7612-c8f168e24621@ti.com>
 <1267bf43-618c-7347-be3a-2792c656d9b6@baylibre.com>
Date:   Thu, 10 Nov 2022 09:00:47 -0800
Message-ID: <7hk042agn4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jerome Neanne <jneanne@baylibre.com> writes:

> On 09/11/2022 22:59, Andrew Davis wrote:
>> On 11/7/22 3:14 PM, Kevin Hilman wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> On 13:58-20221104, jerome Neanne wrote:
>>>>>
>>>> [...]
>>>>
>>>>>
>>>>>>
>>>>>> Can you try an compile with W=3D1 please.
>>>>> This raise one warning on mfd:
>>>>> drivers/mfd/tps65219.c:28:12: warning: =E2=80=98tps65219_soft_shutdow=
n=E2=80=99=20
>>>>> defined but
>>>>> not used [-Wunused-function]
>>>>> =C2=A0=C2=A0=C2=A0 28 | static int tps65219_soft_shutdown(struct tps6=
5219 *tps)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~
>>>>> soft_shutdown has been validated and is used in TI baseline even if n=
ot
>>>>> hooked in upstream version further to this review:
>>>>> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
>>>>>
>>>>> It was a TI requirement to implement it...
>>>>> Let me know if you want me to remove this function or if we can keep=
=20
>>>>> it like
>>>>> this.
>>>>
>>>> There are platforms without psci, correct? I think the comment was to
>>>> drop the force override with system-power-controller property,
>>>>
>>>> if (!pm_power_off) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0tps65219_i2c_client =3D client;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0pm_power_off =3D &tps65219_pm_power_off;
>>>> }
>>>>
>>>> Could still be valid for such platforms, no? I do see that the
>>>> capability that the PMIC has - which is software shutdown is a valid
>>>> feature that we support in many different PMIC drivers. Is'nt the job =
of
>>>> the driver to introduce the functionality in a manner that is
>>>> appropriate to the OS framework?
>>>
>>> Yeah, I think Nishanth is right here.
>>>
>>> We should probably keep the `if (!pm_power_off)` part so the PMIC will
>>> be used if PSCI is not, but it also allows an easy way to test/use the=
=20
>>> PMIC
>>> shutdown functionality downstream if needed.
>>>
>>=20
>> Then should be using the sys-off handler API[0] so it doesn't block PSCI
>> which is also switching over[1].
>>=20
>> Andrew
>>=20
>> [0] https://lwn.net/Articles/894511/
>> [1] https://www.spinics.net/lists/arm-kernel/msg1024127.html
> Can we go for upstream with v7 without tps65219_soft_shutdown. Then if=20
> everyone agrees with Andrew proposal, I'll submit a separate patch which=
=20
> adds implementation of tps65219_soft_shutdown support through sys-off=20
> handler.
>
> So that we are not blocking upstream in case further=20
> discussions/alignment are required.

Seems OK to me.  Nishanth?  Andrew?

But I think you'll need to at least submit a v8 without the unused
code/dead code that Lee pointed out.

Kevin
