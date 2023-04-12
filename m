Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9A6DFFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLU2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDLU2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7822519C;
        Wed, 12 Apr 2023 13:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12FAF632FC;
        Wed, 12 Apr 2023 20:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F14EC433EF;
        Wed, 12 Apr 2023 20:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331281;
        bh=ucKZLhKe62bbnw/EWcaA1+2XQ2/JIMvvlSKG2xSH+ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lrpqBXvCwU/OabaOUt6fMCCWbpzjDQYvVaQeCrK39Ebp5PjvTpblM9DelhSmAEnaM
         5n+0VGxGiUkVjeuWZ/z3G9SvwoJ2OQBOT2ZeRcdoPkWIkXZrt7LLS5auoZPqTZpJf0
         CTV91dhwqvx6VNlyZCYmsLC4+CxWyIHrNyYhcp8AhjIsU/3urb9fZfWwJdnAwnLC/V
         N8tVQmmRA3Xm3gT9rCSnzoclUa3RpT4Jen+FY+lKXNbq9FzaB1yR+C4tRlT60mh+Tc
         uYl80GznIkiSnFEOo/ySjeis2YIf8G/HRVxGupJPx/2RmkeZN4mNxlSDjCR4uJSerH
         3pRRWhqti3N7w==
Date:   Wed, 12 Apr 2023 21:27:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 5/5] dt-bindings: iio: adc: Require generic `channel`
 name for channel nodes
Message-ID: <20230412212756.0b4b69f3@jic23-huawei>
In-Reply-To: <20230410202917.247666-6-marijn.suijten@somainline.org>
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
        <20230410202917.247666-6-marijn.suijten@somainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 10 Apr 2023 22:29:17 +0200
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> As discussed in [1] it is more convenient to use a generic `channel`
> node name for ADC channels while storing a friendly - board-specific
> instead of PMIC-specific - name in the label, if/when desired to
> overwrite the channel description already contained (but previously
> unused) in the driver [2].
> 
> The same `channel` node name pattern has also been set in
> iio/adc/adc.yaml, but this generic binding is not inherited as base for
> qcom,spmi-vadc bindings due to not having any other generic elements in
> common, besides the node name rule and reg property.
> 
> Replace the .* name pattern with the `channel` literal, but leave the
> label property optional for bindings to choose to fall back a channel
> label hardcoded in the driver [2] instead.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
> [2]: https://lore.kernel.org/linux-arm-msm/20230116220909.196926-4-marijn.suijten@somainline.org/
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

There are various ways we could pick up this patch set...
a) Binding changes via individual subsystem trees,
b) All in on go.

I think it's late to guarantee to land the changes from (a) in the coming merge window
so if someone else is willing to do (b) then

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Otherwise we can do (a) early in next cycle.  Feel free to poke me if we are doing (b)
and I seem to have forgotten to pick up this patch!

Jonathan

> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index bd6e0d6f6e0c..f30114424b92 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -54,7 +54,7 @@ required:
>    - '#io-channel-cells'
>  
>  patternProperties:
> -  "^.*@[0-9a-f]+$":
> +  "^channel@[0-9a-f]+$":
>      type: object
>      additionalProperties: false
>      description: |
> @@ -148,7 +148,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^channel@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 512, 1024, 2048, 4096 ]
> @@ -171,7 +171,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^channel@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 256, 512, 1024 ]
> @@ -194,7 +194,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^channel@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 250, 420, 840 ]
> @@ -217,7 +217,7 @@ allOf:
>  
>      then:
>        patternProperties:
> -        "^.*@[0-9a-f]+$":
> +        "^channel@[0-9a-f]+$":
>            properties:
>              qcom,decimation:
>                enum: [ 85, 340, 1360 ]
> @@ -249,7 +249,7 @@ examples:
>              #io-channel-cells = <1>;
>  
>              /* Channel node */
> -            adc-chan@39 {
> +            channel@39 {
>                  reg = <0x39>;
>                  qcom,decimation = <512>;
>                  qcom,ratiometric;
> @@ -258,19 +258,19 @@ examples:
>                  qcom,pre-scaling = <1 3>;
>              };
>  
> -            adc-chan@9 {
> +            channel@9 {
>                  reg = <0x9>;
>              };
>  
> -            adc-chan@a {
> +            channel@a {
>                  reg = <0xa>;
>              };
>  
> -            adc-chan@e {
> +            channel@e {
>                  reg = <0xe>;
>              };
>  
> -            adc-chan@f {
> +            channel@f {
>                  reg = <0xf>;
>              };
>          };
> @@ -292,16 +292,18 @@ examples:
>              #io-channel-cells = <1>;
>  
>              /* Other properties are omitted */
> -            xo-therm@44 {
> +            channel@44 {
>                  reg = <PMK8350_ADC7_AMUX_THM1_100K_PU>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
> +                label = "xo_therm";
>              };
>  
> -            conn-therm@47 {
> +            channel@47 {
>                  reg = <PM8350_ADC7_AMUX_THM4_100K_PU(1)>;
>                  qcom,ratiometric;
>                  qcom,hw-settle-time = <200>;
> +                label = "conn_therm";
>              };
>          };
>      };

