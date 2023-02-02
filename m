Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209B688A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 23:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjBBW7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 17:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 17:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200077C703
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 14:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675378711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lEHSVIVicg+eRhy1uVj7EmYyc3zjgu6fM5PclI9TmE8=;
        b=BFUdLU2MOhaax2keJcfRCvlFI41twSwR3JZCo5b4+rQBOUmdXuVD0y/Dd2Q/VKhrCUQi0p
        uHWrzpES9hhyQZiq0jMN7DRSPQbbJOGI740O6NxnZKE9+73pQ1JU7ywNkCN8xgAKi0FiVf
        t3fNQgSZXD8iO6RbB2A0zcyKUczNeBc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-iu0miMBKMxqSlnMgB5cBQg-1; Thu, 02 Feb 2023 17:58:30 -0500
X-MC-Unique: iu0miMBKMxqSlnMgB5cBQg-1
Received: by mail-il1-f199.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso2195475ilq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 14:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEHSVIVicg+eRhy1uVj7EmYyc3zjgu6fM5PclI9TmE8=;
        b=mERYh523OS1GDI8GSeGvPWog0VD0SVkUj8NIWF+5StfMp0PKIX+92VyBzT7YaD3LrX
         DsDy3MCc1I0RaldrOGdY6FUZ8oqEQA61RanFRhMVENUN976/GxavAbcW8BEKaR7gmF1E
         TphDa7V2q7ny2geioNzEMe5asTwkqSjfhYRr43np24TZ85K8heVoP+Zt18lCtDUzfkFq
         4fQBdHEtf2OwsZNEnneyVcSg59hCiJF7QCOh0s0BYCPsCpzBCdVt7tNVJFeNKasxkg0h
         hSR/0ASobrPgrGLNHkty1m2IVqALwO0B9ejJUTVJjj+MFcavIGCLDy5KHz73I5C9F3dm
         jtoA==
X-Gm-Message-State: AO0yUKVd+pJd2rLEyHS1BmoQl1vvw34ht5gr2X713yqoPx5tu4syRiaX
        20Z6c0hHhRE5PGUeQ4nRxRxByGXhFhDWOvuBpiFQ69ZGn9GnMbaw4hTSW5pya30vzX6AAu1TqC7
        jtkZhX3dCC5fyT7es8O2cXgGE
X-Received: by 2002:a5d:8456:0:b0:71c:1516:1b09 with SMTP id w22-20020a5d8456000000b0071c15161b09mr4724953ior.0.1675378709567;
        Thu, 02 Feb 2023 14:58:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9sgMoyXqOZL07OUt40qn/JePX4OLj4TW1cUpkZcRm14UaauZJKfKVhAH9sT0rma+zI8iaoYQ==
X-Received: by 2002:a5d:8456:0:b0:71c:1516:1b09 with SMTP id w22-20020a5d8456000000b0071c15161b09mr4724941ior.0.1675378709288;
        Thu, 02 Feb 2023 14:58:29 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id z12-20020a02938c000000b0039ea34dffcdsm305250jah.129.2023.02.02.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 14:58:28 -0800 (PST)
Date:   Thu, 2 Feb 2023 17:58:26 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 05/14] arm64: dts: qcom: sc8280xp: correct TLMM
 gpio-ranges
Message-ID: <Y9xAEoc0QXe222D0@x1>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
 <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in TLMM pin controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index fa2d0d7d1367..17e8c26a9ae6 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3533,7 +3533,7 @@ tlmm: pinctrl@f100000 {
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> -			gpio-ranges = <&tlmm 0 0 230>;
> +			gpio-ranges = <&tlmm 0 0 228>;
>  		};

I verified that this count matches what's in downstream.

Reviewed-by: Brian Masney <bmasney@redhat.com>


However, I noticed in upstream that we're using this reg property:

   reg = <0 0x0f100000 0 0x300000>;

Downstream has a different base address and a wider size. Note: I added
spaces for easy comparison.

   reg = <  0x0F000000   0x1000000>;

I don't have access to the appropriate documents to see which is
correct. I assume the base address in upstream is at least correct since
pinctrl is working on this platform.

Brian

