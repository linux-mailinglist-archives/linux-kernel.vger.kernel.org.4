Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACB64BF38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiLMWQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLMWQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:16:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55838193F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:16:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so7383125lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qwTfzPVAukeSo9de2K3wL2rXG0t+xWNA7VPZ779aEaM=;
        b=Q26p9NKClGPwIX+bpk9mYpBBk5EoqUgHHaFCELzFQyHIu0si/92T6tlDy8BtIbuKQg
         G8NA8TLQN5IB+QRFPm+G/RCDWIzO7QPCZ5VoY3Jh8gyyzimvzbq/9zrgLh1DjUE+53Qy
         GNOmw9c9t++B7anPUr8jCEqO10JnRvXcQX8r9rlstTxNio9dLboEd0i/LcmFZ7Xy96Kr
         zrzEY6TDuMnfh375G+6cB46dh074iRpfJ4kAe2UJ5iOI91oYTp59CgBw7i8gUhbXu3AG
         JHrP2oWZl003Bhz983ZevnJQVAufzDIJ8JmIa6EYh6j7Vc81UEA3KoPv4NNpPOLabPnl
         r+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwTfzPVAukeSo9de2K3wL2rXG0t+xWNA7VPZ779aEaM=;
        b=1U6M7s0vvrPgMFQtgsZBjEDYi1rDvEDu9P4bvkosPZ9TPc1s2FOzRxIojoJnsM9+G4
         UAI+p4aedjxlv8+rUCr4MXraviCW+Yzog62e6cAGOz/DrTrwDKIF+EKnvdJr+Z3Eaxhs
         Z5iUoLuPXhtpuXY+czhWaFGVfVMmXTQMiJa8pGhG+Bac9Klg5l41FuzLbZ6+Y3tQNuGJ
         PKvuaEla/xKEl4B37VHjfTRK0VGBi83bmv32V6op037er+N2i+PfMFVJDCKHEnTjc+ux
         m31yzbK/EOjpbTSoHfAj7ZWVc+cyWmdjjoOxqezQYr3l9JpcuPQMUlhBvzXPudopdBTW
         BM7Q==
X-Gm-Message-State: ANoB5pmsxLpNsUoq0kfgk1mEL5xa7C9A7MkT2lCkTzdWSf5hHiLW07MB
        RDbtQbjqJKH4RraUOgzaDNiV1zzSxvCGEbNgNfTVfQ==
X-Google-Smtp-Source: AA0mqf7ZFrQzu5I8zJUQI0vCSYilqn2GB6iXOQlE2rnMeIeDxt/SDrvtOZpcY9CcgELjDzgUaKaXcA==
X-Received: by 2002:ac2:54ad:0:b0:4b5:7bfe:4e44 with SMTP id w13-20020ac254ad000000b004b57bfe4e44mr5618365lfk.6.1670969794701;
        Tue, 13 Dec 2022 14:16:34 -0800 (PST)
Received: from ?IPv6:::1? (dzccz6yfpdgdc5vwjcs5y-3.rev.dnainternet.fi. [2001:14ba:a085:4d00:8c19:462c:c647:13f2])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b00498f77cfa63sm528948lfr.280.2022.12.13.14.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2022 14:16:34 -0800 (PST)
Date:   Wed, 14 Dec 2022 00:16:31 +0200
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Eric Chanudet <echanude@redhat.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pm8450a: add rtc node
User-Agent: K-9 Mail for Android
In-Reply-To: <20221213181855.ylkb3dglw3bkwor5@echanude>
References: <20221213005539.1133443-1-echanude@redhat.com> <219F5CF2-BA91-4749-A32C-84BCF541ECE0@linaro.org> <20221213181855.ylkb3dglw3bkwor5@echanude>
Message-ID: <6F3DC711-88FE-423E-A025-B6AF526B89F2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 December 2022 20:18:55 EET, Eric Chanudet <echanude@redhat=2Ecom> wr=
ote:
>On Tue, Dec 13, 2022 at 04:18:00AM +0300, Dmitry Baryshkov wrote:
>> >diff --git a/arch/arm64/boot/dts/qcom/pm8450a=2Edtsi b/arch/arm64/boot=
/dts/qcom/pm8450a=2Edtsi
>> >index 34fc72896761=2E=2Eaf761dbfbc66 100644
>> >--- a/arch/arm64/boot/dts/qcom/pm8450a=2Edtsi
>> >+++ b/arch/arm64/boot/dts/qcom/pm8450a=2Edtsi
>> >@@ -13,6 +13,14 @@ pm8450a: pmic@0 {
>> > 		#address-cells =3D <1>;
>> > 		#size-cells =3D <0>;
>> >=20
>> >+		rtc@6000 {
>> >+			compatible =3D "qcom,pm8941-rtc";
>> >+			reg =3D <0x6000>;
>> >+			reg-names =3D "rtc", "alarm";
>> >+			interrupts =3D <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>>=20
>>=20
>> 0x60?
>
>Checking downstream it uses 0x61 for the ppid=2E This is also the case
>for all other descriptions of that RTC I could find=2E On the other hand,
>that does not describe the "alarm" register bank at 0x6100=2E
>Should it be added, if anything to match reg-names?

Definitely yes=2E I think otherwise it breaks the idea of reg-names=2E

>
>I tried a quick test of the alarm on sa8540p-ride:
>$ echo $(date '+%s' -d '+ 10 seconds') > /sys/class/rtc/rtc0/wakealarm
>It logged the interrupt:
>172:          3          0          0          0          0          0   =
       0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
>

--=20
With best wishes
Dmitry
