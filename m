Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AE5692A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjBJWsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjBJWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:48:15 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74E95;
        Fri, 10 Feb 2023 14:48:13 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CB13F100002;
        Fri, 10 Feb 2023 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676069292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=npErLWOcwsVPg4NweTtawM2+nIjlFe5D1TfEAySJ7lo=;
        b=dzUEiRSkO/CcvfCAmuhVbh5SeLOoWZbcb+rh2iIWvggPymxX1BxSPUbps7bC+t4zbWQH1i
        8dDVnbk/ouXAv/Nf6STeY2uLTwEeTOCzesB2TtaP/Z+avANWlSnaLrIAFygp6yHAZhGWJW
        AJns7vIZgBLfnaHaalQCrFJvGUvVWBWOkWJpTHijM4lGDkymjj3Bqpt/lcX8X5xgH9nG96
        aVVahL3VUDoL1UtbIabyTIcwait1+gbF8AXl21WPJAer5PjyRyj8jv1xX6+GSN1jMvt3Y6
        IVH+VGN5MqdoERN9G1cYI7nm5VnsyaogHa1JaY/s4B0Ag6lnogQIDyqsUZHG2Q==
Date:   Fri, 10 Feb 2023 23:48:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y+bJqIpgZ0fbzL2b@mail.local>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202155448.6715-17-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 16:54:42+0100, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which a
> driver can take into account.
> 
> Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> from the Unix epoch so that the RTC time can be updated on such
> platforms.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> index 21c8ea08ff0a..b95a69cc9ae0 100644
> --- a/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> @@ -40,6 +40,16 @@ properties:
>      description:
>        Indicates that the setting of RTC time is allowed by the host CPU.
>  
> +  nvmem-cells:
> +    items:
> +      - description:
> +          four-byte nvmem cell holding a little-endian offset from the Unix
> +          epoch representing the time when the RTC timer was last reset
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: offset
> +
>    wakeup-source: true

The patch doesn't apply because this part of the context is not
upstream. Can you rebase?

>  
>  required:
> @@ -69,6 +79,8 @@ examples:
>            compatible = "qcom,pm8921-rtc";
>            reg = <0x11d>;
>            interrupts = <0x27 0>;
> +          nvmem-cells = <&rtc_offset>;
> +          nvmem-cell-names = "offset";
>          };
>        };
>      };
> -- 
> 2.39.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
