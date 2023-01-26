Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000D467D8E4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjAZWzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAZWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE962FCFF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674773691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p5Ykxjtl3TsXTsPdCfEmgAHl6ut65lEBsB3rbec3S1g=;
        b=MhHy83KJPpOKvy3NzHd343lYTg1a6SZmWm3DdZdg2bXPF7JYf/qkwR6h4Z6BT3J5em+Pss
        T/YcT7Seb/W1V8QB/JEbTaiKHj78oZnnaIOLcM1ef7ZPNXKcch/RHfhKv+OyJ9SJrZ6ZtV
        fzFcxgSCfuZ+IXZzw0vPOxbDDIVc1XQ=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-300-NjawdILsNqG3MvmydQFCEw-1; Thu, 26 Jan 2023 17:54:50 -0500
X-MC-Unique: NjawdILsNqG3MvmydQFCEw-1
Received: by mail-oi1-f198.google.com with SMTP id ex11-20020a056808298b00b003612dac2af8so1265429oib.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5Ykxjtl3TsXTsPdCfEmgAHl6ut65lEBsB3rbec3S1g=;
        b=Ny9UFdYAuSJuOXGx+5Ucges8Lr/T3gYMY6TxM5ZdfLr+ZyPdtAMsCKIhwiCm9FtqyE
         +E0Zxjmx7vgWt3BzvqYjQsH/2WaVJSuuWUe68P6mzpjkzzbDHqXT4LI/eySjPFnkZLOE
         WTZKpmNeQlmELGERHCXqFKmfi4Bhgr4fs5C9EvQYKjF4NMehgIJ/5GC5Ea5gnLmduqOD
         N7c/NtvsX3mLW1fNY7/r11bgLQSLVroxCFBMhwOI8MlySMYgTkhEtus710YoDxbblykX
         0A84r0Y4uNETp9FVpNJiV0Ql9onKu3Z5jzcY7BIhogNt5++AdysjsXx6VDJyzfqRRtiO
         5PKw==
X-Gm-Message-State: AFqh2kpTWbkBhYw6J6lWBSaB/2uQeE2iQv6iQcFslGsU6VABrBp5fy2D
        XcPzzoIQ2qWsCtBeRHk7JxBZWukqTfF8GPzR1nNPety4thuBqDKgRJXL3S9ZpWiNZREWkSvTxpa
        n6HWGKMkRBT7rtM42+ZzR2K8C
X-Received: by 2002:a05:6870:1609:b0:15e:ce8d:f65c with SMTP id b9-20020a056870160900b0015ece8df65cmr23449622oae.23.1674773689409;
        Thu, 26 Jan 2023 14:54:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsdeliN+wRD0ouJycj0uRxI8ORwWz77jZBv4UziUIwkNFHcqUC+w2hRdyGCIUFpexruansoig==
X-Received: by 2002:a05:6870:1609:b0:15e:ce8d:f65c with SMTP id b9-20020a056870160900b0015ece8df65cmr23449601oae.23.1674773689119;
        Thu, 26 Jan 2023 14:54:49 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id u2-20020a056870304200b0015b64f8ff2bsm1043015oau.52.2023.01.26.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:54:48 -0800 (PST)
Date:   Thu, 26 Jan 2023 16:54:46 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on
 i2c12
Message-ID: <20230126225446.rjckq5p35zeozphq@halaney-x13s>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
 <20230124184440.1421074-4-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124184440.1421074-4-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:44:40AM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - i2c node had changed name
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

I realized today this has to do with the comment over at:

    https://lore.kernel.org/all/30166208-ba9d-e6e6-1cd2-807a80536052@quicinc.com/

and I just didn't realize that the schematic I've started looking at
black boxes the SOM/SIP which holds this... darn I thought I could see
more than I could :(

I took a similiar patch for a spin on sa8540p-ride (which I'll later
submit), and things worked fine (I'm not really consuming the output of
the regulator mind you).

Downstream devicetree indicates all of this looks ok except for possibly
the below comment:

> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index bb4270e8f551..642000d95812 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -266,6 +266,27 @@ &dispcc1 {
>  	status = "okay";
>  };
>  
> +&i2c12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c12_state>;
> +
> +	status = "okay";
> +
> +	vdd_gfx: regulator@39 {
> +		compatible = "maxim,max20411";
> +		reg = <0x39>;
> +
> +		regulator-name = "vdd_gfx";
> +		regulator-min-microvolt = <800000>;

Is there a reason you chose this instead of the 500000 I see downstream?

> +		regulator-max-microvolt = <968750>;

Likewise, I see in this brief description of the regulator
that the upper bound is higher than this (1.275 V). I am not sure if
the values in the devicetree are supposed to describe the
min/max of the regulator itself, or of what your board can really
handle/needs (the latter I guess makes more sense since you wouldn't want to
accidentally request a current draw that could melt something.. that can
be fun). I do see you've got that min/max in the driver itself (now that
I peaked at that patch).

https://www.analog.com/en/products/MAX20411.html#product-overview

For what it is worth, I also see a SIP document that states vdd_gfx min/max
is 0.56/1.03 V, which is ultimately what you'd feed this into. The
downstream devicetree uses the max value you provide though.

No idea how much faith I should put into the SIP document's bounds, or
downstream, but I thought I should at least highlight them.

Thanks,
Andrew

