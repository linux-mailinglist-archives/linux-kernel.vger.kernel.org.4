Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A616CBFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjC1Mt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjC1Mtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:49:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE034BB96;
        Tue, 28 Mar 2023 05:49:01 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y15so15663144lfa.7;
        Tue, 28 Mar 2023 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680007739;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sk/bTq47cK6nj+Ac1pI4bSPZHRqN64zVVHRtsT7Ah6M=;
        b=FI0LwPeqK21vwOjDUO4sDsypSJke+/48rFVykNUKJkXVxOkEguDkWqaPDMBScsv7NS
         X4ABIWvCXil2yh1bNBbFSQXtj4yjovDYpRxKCwOTwu42h9rRLJcXAAhA2bHKsw858rcC
         O5Umn40zpmwBKDDQB1fzz+6P2Ynuw8uCGuz2NzDuq1brtkMCzSSSIDbyZHKJUaLFdnEf
         45TAtvigDYmm0FqGZu+quqMBFRJYaekFRAnDKBvEOEfnoALqM9Y3QlQ3PR2wkNwlPUni
         9nDO5RH9wjNeidVdVd2lO9uwwryo0s3kBzGpQWPgUweBBlTLow4YO7JQqcVMVFxOlRdv
         DSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680007739;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sk/bTq47cK6nj+Ac1pI4bSPZHRqN64zVVHRtsT7Ah6M=;
        b=a7TYquqojxET5erNmzL2Z2+vFpaSYBXVi0oM0yO+UlwEesyqnI5kaBI5PKj/K0c3iF
         AVI1gQ1a5dRJeYggRRnnDcmnJkpWttRdE9D+Hz7pJdPeX2calANd6BxJ87UY1iNZjW9v
         V3g14J2wg7MprrKktpGGqBKkxugm/ywllSrZ1zfv/24u4RG81lKoJ89EQYIJJKU1ugIx
         o7R/C+TOk8cUYAGdi9nBmmno4QsTd2WJedFm//zIg0B158Zf5hoy3ZneXCGft1ynHJny
         XbBfFZzDpJe2EBVCXlh9vSyfeAR7pBuRom+OC+W7I/an+eUUPlJb/+ZVlUpb8R4Bepgh
         L4fw==
X-Gm-Message-State: AAQBX9cHKLJco/ruetOopgwlZPBC6aZnXcV0XQ6tTa2lCS6h2mJ7wFPY
        b5onOvNbB41rH8uC8lSqSU4=
X-Google-Smtp-Source: AKy350YiyU0VWTGcvZcBI5NZkpWc++4tFGbzwQme4GCi+Tuc9YOzJN0AKjzrEF7VXeXfU7vgSPjCkQ==
X-Received: by 2002:ac2:558f:0:b0:4e9:6e5c:bec0 with SMTP id v15-20020ac2558f000000b004e96e5cbec0mr4132316lfg.53.1680007739388;
        Tue, 28 Mar 2023 05:48:59 -0700 (PDT)
Received: from [127.0.0.1] ([91.204.85.69])
        by smtp.gmail.com with ESMTPSA id b26-20020a056512025a00b0048a9e899693sm5067768lfo.16.2023.03.28.05.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 05:48:59 -0700 (PDT)
Date:   Tue, 28 Mar 2023 15:48:58 +0300
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/5=5D_ARM=3A_tegra=3A_trans?= =?US-ASCII?Q?former=3A_use_labels_for_mmc_in_aliases?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZCLR2XYBrOVuJHL3@orome>
References: <20230304084319.18424-1-clamor95@gmail.com> <20230304084319.18424-4-clamor95@gmail.com> <ZCLR2XYBrOVuJHL3@orome>
Message-ID: <947201F1-1DB0-4F02-B638-A4CC84CAE3E1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



28 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 14:39:05 GMT+=
03:00, Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sat, Mar 04, 2023 at 10:43:17AM +0200, Svyatoslav Ryhel wrote:
>> Since mmc devices in common dtsi are labeled let's use labels
>> for simpler comprehension of tree=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/boot/dts/tegra30-asus-transformer-common=2Edtsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common=2Edtsi b=
/arch/arm/boot/dts/tegra30-asus-transformer-common=2Edtsi
>> index 08ea9cb32d0e=2E=2E70f7f279fd35 100644
>> --- a/arch/arm/boot/dts/tegra30-asus-transformer-common=2Edtsi
>> +++ b/arch/arm/boot/dts/tegra30-asus-transformer-common=2Edtsi
>> @@ -12,9 +12,9 @@ / {
>>  	chassis-type =3D "convertible";
>> =20
>>  	aliases {
>> -		mmc0 =3D "/mmc@78000600"; /* eMMC */
>> -		mmc1 =3D "/mmc@78000000"; /* uSD slot */
>> -		mmc2 =3D "/mmc@78000400"; /* WiFi */
>> +		mmc0 =3D &sdmmc4; /* eMMC */
>> +		mmc1 =3D &sdmmc1; /* uSD slot */
>> +		mmc2 =3D &sdmmc3; /* WiFi */
>
>I find it hard to see the improvement here=2E If you really need this,
>please merge this with the patch that adds the labels and add them on an
>as-needed basis=2E That is, if you want to replace the paths by phandle
>references here, then introduce the sdmmc{1,3,4} labels, but not the
>other ones which aren't used=2E
>

I see your point, I will reshape first 3 patches with labels=2E I may
amend this patchset entirely, though patches 4 (mount matrix) and
5 (peripheral opps) should be valid=2E

Best regards,
Svyatoslav R=2E

>Thierry
