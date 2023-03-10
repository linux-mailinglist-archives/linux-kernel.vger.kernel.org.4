Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52C6B3A52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCJJ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCJJ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:26:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839B115B7F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:22:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso5504198wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=amCH/lHrcklR0+d3J23eI66asqVQGuti8CuzmNbDPmk=;
        b=ThxaH5SSXDsoF2E2AzIv1S3MPDfjDXhsNqShvzOTdQnFd3ZTKCFoAM4K0TExIj2riO
         nlEgvOozWdCG6mypfMNNO0rRodtQ83M7M7Ac93zxCkxWVgfe2MittrNQrQ6UFMA8bWOg
         PcMe1pEGLj4R4HhGlWEN5A9PW4zeQbGlo9jkL7pd8nxuGYMqGFMPWGmsz1tRHVCZ3sQ7
         Od/qITZkxKbS2B2N3f3gseXVZPo+zY/M47Yy4/APcH1OOYquZbjTTm4wfPoz2eOjwrIN
         VwKTeBx2qapwU+k1zSKv8lTjXqoWXP9elQ0bLF+o/z2haqpCzmu5VoA4beaNhYDhETl3
         j3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amCH/lHrcklR0+d3J23eI66asqVQGuti8CuzmNbDPmk=;
        b=hl9/NNehwH3NixAfr3zm146LB5SXfk5o1dqQ5OkfUhNpDiXnaA1jOb2jqKVaC25Lv5
         djxEWoWNSQmNJGk+u/jabiZkChwpEDqVNsKnuxLVO5qVy9lg8p8DPrMi0RcSYiX+2Nm9
         kKjZxL+Du4q5DveaLLnWVOKGk/OX8x3GiSktpKjfZC3q7AitU7Z329aAw/3V/fyUMwYE
         nx+UiL9A7/pczK6rZ2xZqAr7nqcbBLvDezgg6JCYisjJ6nv29ve0XhgZDRe5LdQ4bgBt
         4igYezermlUqoykmlmhfgWwhUxivIG+DXGAZmhEWBxd2+bLu7arCFmy6R2rmF27Y1MLs
         MLYg==
X-Gm-Message-State: AO0yUKXyWF69dZpl6RQ9YSrjr3ojYB/efUO2CySzAX3pBzIW6uvY8J4H
        Gd9CEyE6/qLAHIH9wdbBT4180w==
X-Google-Smtp-Source: AK7set/AuOAaLcDFhYJbfB/xH8AqlAbVyJzxll6C9HqAYzvdeVBYRroShbnYkCmFaoJlaUJm9gf+MQ==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr2095410wmq.0.1678440098175;
        Fri, 10 Mar 2023 01:21:38 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e23-20020a05600c219700b003dd1bd0b915sm2322266wme.22.2023.03.10.01.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:21:35 -0800 (PST)
Date:   Fri, 10 Mar 2023 11:21:34 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto
 Engine nodes
Message-ID: <ZAr2nlFSKkBBQgcY@linaro.org>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
 <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-10 09:13:29, Krzysztof Kozlowski wrote:
> On 09/03/2023 19:31, Eric Biggers wrote:
> > On Thu, Mar 09, 2023 at 11:31:46AM +0100, Krzysztof Kozlowski wrote:
> >> On 08/03/2023 16:58, Abel Vesa wrote:
> >>> Drop all properties related to ICE from every UFS and SDCC node,
> >>> for all platforms, and add dedicated ICE nodes for each platform.
> >>> On most platforms, there is only one ICE instance, used by either
> >>> UFS or SDCC, but there are some platforms that have two separate
> >>> instances and, therefore, two separate nodes are added.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>>
> >>> Changes since v1:
> >>>  * Made changes for all platforms that use ICE, as a single patch since
> >>>    most changes look really similar.
> >>>
> >>>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 18 +++++++++-----
> >>>  arch/arm64/boot/dts/qcom/sdm670.dtsi | 15 +++++++----
> >>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 21 +++++++++-------
> >>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 37 +++++++++++++++++-----------
> >>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 31 ++++++++++++++---------
> >>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 21 +++++++++-------
> >>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++-------
> >>>  7 files changed, 102 insertions(+), 63 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>> index 5827cda270a0..2aed49104d9d 100644
> >>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> >>> @@ -1330,9 +1330,8 @@ opp-200000000 {
> >>>  		sdhc_1: mmc@c0c4000 {
> >>>  			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
> >>>  			reg = <0x0c0c4000 0x1000>,
> >>> -			      <0x0c0c5000 0x1000>,
> >>> -			      <0x0c0c8000 0x8000>;
> >>> -			reg-names = "hc", "cqhci", "ice";
> >>> +			      <0x0c0c5000 0x1000>;
> >>> +			reg-names = "hc", "cqhci";
> >>
> >> I believe this will break the ICE on these platforms without valid
> >> reason. The commit msg does not explain why you do it or why this is
> >> necessary.
> >>
> >> We already we received comment that we keep breaking Qualcomm platforms
> >> all the time and need to keep them in some shape.
> >>
> >> Also, patchset is non-applicable in current set (breaks users) and
> >> neither commit nor cover letter mentions it.
> >>
> > 
> > FWIW, I tested this patchset on SDA845, and ICE continues to work fine.
> 
> Really? I clearly see of_find_device_by_node -> "return NULL" and all
> old code gone, so ABI is broken. Are you sure you applied patch 1-6 and
> ICE was working?

of_qcom_ice_get will return the ICE instance if the consumer node has a
qcom,ice property with a phandle for the ICE devicetree node. It will
return NULL otherwise. SDA845 has such ICE node added by this patch,
therefore, it will work. All platforms that have such node will work
functionally like before. But I'll take care of the legacy approach as
well in v3 (see below).

> 
> > 
> > (Though if I understand the patchset correctly, the ICE clock is no longer
> > turned off when the UFS host controller is suspended.  That isn't ideal as it
> > wastes power.  I would like that to be fixed.)
> > 
> > Anyway, when you say "break the ICE", do you really mean "make an incompatible
> > change to the device-tree bindings"?
> 
> It breaks existing users of DTS and kernel.

I assume you mean it breaks if someone is using old approach DTS with a
kernel that would have ICE driver merged. Yes, that it does. And for
that, in the v3, I'll make of_qcom_ice_get check if there is a reg entry
with name "ice" and create an ICE instance but for the same dev as the
consumer driver. OTOH, if there is no reg entry called "ice", it will
look up a device based on phande of qcom,ice property. This will allow
legacy style DTS to work fine, while using the unified driver as a
library, in that case. For newer platforms, the recommended approach
will be to add a new ICE node and use qcom,ice property.

> 
> > 
> > I'd think there would be no problem with that as long as everything is updated
> > at once, which this patchset does.
> 
> Which is obviously not possible. DTS always goes separate branch,
> always. It cannot be combined with code into the same branch! So how do
> you even imagine this?
> 
> > 
> > I've heard before that some people consider the device-tree bindings to be a
> > stable UAPI.  That doesn't make sense to me. 
> 
> It is stable ABI. Bindings and DTS are used by other firmwares,
> bootloaders and systems. The kernel *must* work with old and out of tree
> DTS.
> 
> Even if this does not make sense to you, these are the realities,
> practice and current rules.
> 
> 
> > Actually, my original ICE patches
> > ran into this issue too, and the resolution was simply that the Qualcomm
> > platforms maintainer (Bjorn) decided to take the patches anyway.  I never heard
> > any complaints afterwards.  Maybe the same is fine here too?
> 
> 
> No, it is not fine. The patchset breaks ABI, breaks existing kernel with
> old DTS and breaks other projects using DTS and bindings.
> 
> Best regards,
> Krzysztof
> 
