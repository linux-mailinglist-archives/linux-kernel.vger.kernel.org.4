Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06E8688B43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjBCAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjBCAAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401380FB9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675382398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bDcZC2KZtREVXqfHnuGHgZ7VwNY0S0IOfvv3rQbeW4=;
        b=hcW6cvTsDY22iVdMpTIRDS1wFxbI6F2uOps9slXo7bmcsC/vM7YW1vkybeEFquJmdikMtw
        P1pPWhYHUehr+0clr2DUwpcApatEWt7Ni4hqd6NlUdsVBzCGWwNwKanqS3WcMm4oa6qayC
        DXV1JyawxcgamYorpIvWSpPOcKRMpYA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-O_s0LLGhN8ebYNNhmZpVug-1; Thu, 02 Feb 2023 18:59:56 -0500
X-MC-Unique: O_s0LLGhN8ebYNNhmZpVug-1
Received: by mail-io1-f70.google.com with SMTP id d22-20020a5d9656000000b00704d3bd8c07so2071593ios.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bDcZC2KZtREVXqfHnuGHgZ7VwNY0S0IOfvv3rQbeW4=;
        b=P1m1K9nlATL6cynZ19/vEL1n4kjVq83IcFiDhUTn1450Jbo+70eTgVX1uZhtR7+C5I
         IRPQNZX2QMsirg8O2ZoACxOYDiRVguSrqAgcsAFmAflCKKav2HTGK3+CqPLZQN3e8S2j
         O0VXOZmL1Gc1YvS9Djn1bee31CE2faVdjIX0jpisqug9NiBn/WefWzxwz3JEN/Ym5kcm
         PlM8kFO0aOtwVYy8/SIX+1V0vMnJpLhcfvUAb6zo7sezByyV/2ofN7VOd1zn0tlTFfzb
         ILNmLfI/E4d2dPtndYrx4NvycrVu/o0qYJKTZOmX3jpkDdzv3tgyIv3+tUhTS+t0OQxj
         rMog==
X-Gm-Message-State: AO0yUKVUmCO0lY1FCSUvUenJVraZzL711Da5KNrbK7bOK+nxRC6iRYQc
        2nIwNyX9XBhvAxdZOVokOywH4I0eGatqf5D6m4K/L/WlH35yrvDTrSqxDNWES8mzDhdhrOeiR6a
        7b1jg67WYedAhZRFxsdxnWm70
X-Received: by 2002:a05:6e02:152b:b0:310:a3c6:f429 with SMTP id i11-20020a056e02152b00b00310a3c6f429mr6682819ilu.9.1675382396276;
        Thu, 02 Feb 2023 15:59:56 -0800 (PST)
X-Google-Smtp-Source: AK7set9LNYh3Kf6+b+khtb8IBGRI1RmsErXJsQlmhJodF/olSjKeN7OHNcYXyG1spqpuD7v4/aGIRg==
X-Received: by 2002:a05:6e02:152b:b0:310:a3c6:f429 with SMTP id i11-20020a056e02152b00b00310a3c6f429mr6682805ilu.9.1675382396059;
        Thu, 02 Feb 2023 15:59:56 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e021c0300b0031109a23893sm307816ilh.23.2023.02.02.15.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:59:55 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:59:53 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 05/14] arm64: dts: qcom: sc8280xp: correct TLMM
 gpio-ranges
Message-ID: <Y9xOeZjAQmQqLOa1@x1>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
 <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
 <Y9xAEoc0QXe222D0@x1>
 <25f5a750-b51c-7d7b-0d50-5b2f78de8512@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f5a750-b51c-7d7b-0d50-5b2f78de8512@linaro.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:45:49AM +0100, Konrad Dybcio wrote:
> On 2.02.2023 23:58, Brian Masney wrote:
> > On Wed, Feb 01, 2023 at 04:50:56PM +0100, Krzysztof Kozlowski wrote:
> >> Correct the number of GPIOs in TLMM pin controller.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> index fa2d0d7d1367..17e8c26a9ae6 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> >> @@ -3533,7 +3533,7 @@ tlmm: pinctrl@f100000 {
> >>  			#gpio-cells = <2>;
> >>  			interrupt-controller;
> >>  			#interrupt-cells = <2>;
> >> -			gpio-ranges = <&tlmm 0 0 230>;
> >> +			gpio-ranges = <&tlmm 0 0 228>;
> Won't that kill the UFS pins?

For others quick reference, Konrad is talking about this line from
sa8540p-ride.dts:

	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;

I noticed that earlier but assumed this was one based. However, looking
at pinctrl-sc8280xp.c I see gpio0..gpio227 defined.

Brian

