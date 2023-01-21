Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A50676784
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjAUQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUQyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:54:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313A120067;
        Sat, 21 Jan 2023 08:54:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7067B80816;
        Sat, 21 Jan 2023 16:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6615EC433EF;
        Sat, 21 Jan 2023 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674320082;
        bh=6ozn67CKzOc1y3DxxRz93tgT2WqnbMotA91WAsPajuY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYbFzMT9ytogqyj1iWCKlG/uRMZpyaqTwCvSLm43T7YBALV16GjveBWqWWwpeCzF8
         KQIevFEvqzC2YPgSrAVE4RCd6GR5gtZ1kf9NvlW1qr9izDv5UOQ4F5PmXmaeZ6W7xl
         eQkMtJz3zdv7dDFTZPlQDUtfrGwjchnf/BU0L3rv6wNU+RjP8QcUBDAhv8aryeZ/qc
         lIduCFwc3UDCPVDVvvztTSuhMJTL10Niq4+jhOanvCfiChT2QV2wyllZ9yIcC+Neep
         urFE6wCVIOLngB5wvNhqhxkZAV8Yp+tW9r++SMnWOVcgd8n/4K48XuvGPAerIfA4MP
         +q6mCiSikLvhg==
Date:   Sat, 21 Jan 2023 17:08:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Require generic adc-chan
 name for channel nodes
Message-ID: <20230121170825.0d284151@jic23-huawei>
In-Reply-To: <20230119212632.185881-2-marijn.suijten@somainline.org>
References: <20230119212632.185881-1-marijn.suijten@somainline.org>
        <20230119212632.185881-2-marijn.suijten@somainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 22:26:31 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> As discussed in [1] it is more convenient to use a generic adc-chan node
> name for ADC channels while storing a friendly - board-specific instead
> of PMIC-specific - name in the label, if/when desired to overwrite the
> channel description already contained (but previously unused) in the
> driver [2].
> 
> Replace the .* name pattern with the adc-chan literal, but leave the
> label property optional for bindings to choose to fall back a channel
> label hardcoded in the driver [2] instead.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Other than the use in the tm5 thermal example that Rob's bot found, this looks
good to me.  I think ideal would be to fix that in a precursor patch then
do this one.

Note that the existing two patches should be in the other order
1. Update the dtsi
2. Tighten the bounds to check they are right.

Doesn't matter much though as the two patches will probably go through
different trees.

Thanks,

Jonathan

> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml         | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index bd6e0d6f6e0c..9b1a60fe7599 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -54,7 +54,7 @@ required:
>    - '#io-channel-cells'
>  
>  patternProperties:
> -  "^.*@[0-9a-f]+$":
> +  "^adc-chan@[0-9a-f]+$":
>      type: object
>      additionalProperties: false
>      description: |
> @@ -148,7 +148,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^adc-chan@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 512, 1024, 2048, 4096 ]
> @@ -171,7 +171,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^adc-chan@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 256, 512, 1024 ]
> @@ -194,7 +194,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^adc-chan@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 250, 420, 840 ]
> @@ -217,7 +217,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^adc-chan@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 85, 340, 1360 ]
> @@ -292,16 +292,18 @@ examples:
>              #io-channel-cells = <1>;
>  
>              /* Other properties are omitted */
> -            xo-therm@44 {
> +            adc-chan@44 {
>                  reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
> +                label = "xo_therm";
>              };
>  
> -            conn-therm@47 {
> +            adc-chan@47 {
>                  reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
> +                label = "conn_therm";
>              };
>          };
>      };

