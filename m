Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99866A3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjAMUR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAMURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967A61EAF7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673641023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s9+h5CzjxOXFVyR2zY6Aj8bDP7ydcGeQkU1xxgKQ2VM=;
        b=XW5/bVFfZQMNl1D0i9/bTVe7ko1z1mnlzJTxKypSBl6dszrtGK3xqmAg9WdF6+i76F82hC
        u7j/RwBc0Q2VWu6c6qvUCNvA8URxk+STh8Q8wQ9fyl1uGlemRk4JlrIPS5mIllDi0Bn0vq
        XQmITN4oXGtZeApdxHWH18AUfqDYI/M=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-155-wE1TuX6lN5mxIM1fDjPliA-1; Fri, 13 Jan 2023 15:17:02 -0500
X-MC-Unique: wE1TuX6lN5mxIM1fDjPliA-1
Received: by mail-ot1-f69.google.com with SMTP id 46-20020a9d0331000000b00684ce0aa309so1868655otv.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 12:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9+h5CzjxOXFVyR2zY6Aj8bDP7ydcGeQkU1xxgKQ2VM=;
        b=K5Tz7wi2IGuakKOkfAYCHpb++JTLAXmoD08EsnkcPudVhf1wxcGOs/pvvcuXob+Vgc
         Zohlsesn/4KrZFgDPwb6aD9lHkrQFHNl0sxhizqf9pP6F1n07crp9fBckk4o/S6NoyEf
         d8g5/KBji1jf2ddJb2XoXzzyBzpvArm1nbm5uK8TzwywrEtggr/VxMoyw5Ev5Rgv7OLT
         ySnEJRXW45IPTZYWMt7pHuRqBalraAhdTUEzLr3/UkpnKnaBju74RFLlhWX1duz819Qv
         g0oIC1l1bpAAdlj+gchIx8JEy0hoO5kG/wLeEIYeH7fudqGayDY5r9EUYMWY6BlGvSnQ
         kRHw==
X-Gm-Message-State: AFqh2kqE2GE17ReYCDl5MdsUWv5jGfMVbmy1ZbVBC5jbz/eBCCEv3Dqw
        z6kR7T5NUX9hxHuW4GfsOjwt7ZhC2iSNnHSO6t4vqouU7VQSsHtelck0h1J0VDElNdgTs92eaPV
        VjqnTzv2iwPLF0/hsxXBgPNNB
X-Received: by 2002:a05:6830:30a8:b0:670:9e78:4b64 with SMTP id g40-20020a05683030a800b006709e784b64mr41163882ots.5.1673641021586;
        Fri, 13 Jan 2023 12:17:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvloTLpF1TOLJr2fph60aLc5QFnPfBrb1FmXTiTn+gCVkhVrHRjxfNA4WToTJ7FWhyAFlMNwA==
X-Received: by 2002:a05:6830:30a8:b0:670:9e78:4b64 with SMTP id g40-20020a05683030a800b006709e784b64mr41163867ots.5.1673641021391;
        Fri, 13 Jan 2023 12:17:01 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id b19-20020a9d6b93000000b0066ca61230casm11046830otq.8.2023.01.13.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:17:00 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:16:58 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Define CMA region for CRD
 and X13s
Message-ID: <20230113201658.lrue7e7tpuep537x@halaney-x13s>
References: <20230113041025.4188910-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041025.4188910-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:10:25PM -0800, Bjorn Andersson wrote:
> Booting the CRD needs roughly 64MB CMA, rather than relying on people
> adding boot parameters etc define a region for this, to remove the
> allocation errors from e.g. NVME.
> 
> While fixing the CRD define the same region for the X13s.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s

I'm not sure if I've seen this issue in the past, but booting with this
applied isn't showing any obvious problems like described in the commit.
It would be nice as Konrad said to be a little more explicit about what
you were seeing without this, but that's my personal opinion.

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                | 9 +++++++++
>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts      | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index b29c02307839..e30a37c73b90 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -128,6 +128,15 @@ vreg_wwan: regulator-wwan {
>  
>  		regulator-boot-on;
>  	};
> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 78e61a8184c5..5bfd1f0b2a24 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -153,6 +153,15 @@ vreg_wwan: regulator-wwan {
>  		regulator-boot-on;
>  	};
>  
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	thermal-zones {
>  		skin-temp-thermal {
>  			polling-delay-passive = <250>;
> -- 
> 2.37.3
> 

