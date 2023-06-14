Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2973074A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjFNSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFNSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:19:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C941FF5;
        Wed, 14 Jun 2023 11:18:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9V51-0002TJ-Ri; Wed, 14 Jun 2023 20:18:51 +0200
Message-ID: <358c69ad-fa8a-7386-fe75-92369883ee48@leemhuis.info>
Date:   Wed, 14 Jun 2023 20:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Move LVS regulator nodes
 up
Content-Language: en-US, de-DE
To:     Amit Pundir <amit.pundir@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     regressions <regressions@lists.linux.dev>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230602161246.1855448-1-amit.pundir@linaro.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230602161246.1855448-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686766734;563ab592;
X-HE-SMSGID: 1q9V51-0002TJ-Ri
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 18:12, Amit Pundir wrote:
> Move lvs1 and lvs2 regulator nodes up in the rpmh-regulators
> list to workaround a boot regression uncovered by the upstream
> commit ad44ac082fdf ("regulator: qcom-rpmh: Revert "regulator:
> qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"").
> 
> Without this fix DB845c fail to boot at times because one of the
> lvs1 or lvs2 regulators fail to turn ON in time.

/me waves friendly

FWIW, as it's not obvious: this...

> Link: https://lore.kernel.org/all/CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com/

...is a report about a regression. One that we could still solve before
6.4 is out. One I'll likely will point Linus to, unless a fix comes into
sight.

When I noticed the reluctant replies to this patch I earlier today asked
in the thread with the report what the plan forward was:
https://lore.kernel.org/all/CAD%3DFV%3DV-h4EUKHCM9UivsFHRsJPY5sAiwXV3a1hUX9DUMkkxdg@mail.gmail.com/

Dough there replied:

```
Of the two proposals made (the revert vs. the reordering of the dts),
the reordering of the dts seems better. It only affects the one buggy
board (rather than preventing us to move to async probe for everyone)
and it also has a chance of actually fixing something (changing the
order that regulators probe in rpmh-regulator might legitimately work
around the problem). That being said, just like the revert the dts
reordering is still just papering over the problem and is fragile /
not guaranteed to work forever.
```

Papering over obviously is not good, but has anyone a better idea to fix
this? Or is "not fixing" for some reason an viable option here?

Ciao, Thorsten

> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 24 +++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> index e14fe9bbb386..df2fde9063dc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
> @@ -301,6 +301,18 @@ regulators-0 {
>  		vdd-l26-supply = <&vreg_s3a_1p35>;
>  		vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
>  
> +		vreg_lvs1a_1p8: lvs1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		vreg_lvs2a_1p8: lvs2 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
>  		vreg_s3a_1p35: smps3 {
>  			regulator-min-microvolt = <1352000>;
>  			regulator-max-microvolt = <1352000>;
> @@ -381,18 +393,6 @@ vreg_l26a_1p2: ldo26 {
>  			regulator-max-microvolt = <1200000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
> -
> -		vreg_lvs1a_1p8: lvs1 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-always-on;
> -		};
> -
> -		vreg_lvs2a_1p8: lvs2 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-always-on;
> -		};
>  	};
>  
>  	regulators-1 {
