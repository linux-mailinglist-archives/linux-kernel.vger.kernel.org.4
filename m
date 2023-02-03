Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C1688B9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBCAP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBCAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:15:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA2073058
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675383312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZii04idi4snEs1Pp8F67oc8bCMrsdYL6FcEHVrhkW0=;
        b=CDHfLDHUOLRs2Mr0nNgoM7pkTQbu667vAoOf2iaG8/tTDyfGkfoxvamzD1pP/jY63bPRHL
        EJHchhXot0QTV/2PQ/k2d7BQQuMCz/3ko+kb7zCliYRW5iG99EkAjFwfVwHpTb4Ll6iMdD
        RfMuSg3L6C8DHOPpXJnvi2nikUR9XFI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-zVPQPBbaOyKO6jmmHRy-vg-1; Thu, 02 Feb 2023 19:15:11 -0500
X-MC-Unique: zVPQPBbaOyKO6jmmHRy-vg-1
Received: by mail-il1-f198.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so2318672ilu.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZii04idi4snEs1Pp8F67oc8bCMrsdYL6FcEHVrhkW0=;
        b=nqcFNCMMw1GgWdC/n+EMK9F1/yM1T1FR31o9+DTteoUYXg0al5MT9SlVkXNk/CT0xY
         6RvuLZzIdDWYKffis9iY+kOqo7MVj3VMI0YaEBngcr6FgpRgRgBvD2ygpQq8Y/FPvfP2
         pFymGHguHktVeedshXH5BQZ9eL86ivV+QcbSJlUINn7Kr0n/nFHp4HD1Z1WKE4RHXNHF
         7IHk2TXKWDS2y+svqktJhTEJaXGOvSlEUFbKkeBVlFTDhxzm9HdrjVlXBBvkf5F5HcLG
         wHgU9jNtG76oy5TF2+9/JmiVKWtoij6bm4rsgBE9WyNNYzN0Te1CSPhsYPKX9ST8doPU
         H6EQ==
X-Gm-Message-State: AO0yUKVS/hus11ZU12KmQN3X39VU9vNDFZ6K4pbNW7pOezjU0HXMQcF4
        08H8MwlG9/4X7dpcI8Ee2olw+TNoi+9VYl46LndxQwTbbiiRxd1gCU/a6lcV3HchJIpdrR+V/Oj
        kMEXdEq6x/ycxyhi0GDE9umjG
X-Received: by 2002:a05:6e02:1a46:b0:311:20f:bc77 with SMTP id u6-20020a056e021a4600b00311020fbc77mr6285773ilv.6.1675383309924;
        Thu, 02 Feb 2023 16:15:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+lbPEIbkCglkbHrVZ7yC7ELtrZRYRaCyZ0+Iv+658LyqnW2+LBjhq8imActoVACDnw9RK2Jg==
X-Received: by 2002:a05:6e02:1a46:b0:311:20f:bc77 with SMTP id u6-20020a056e021a4600b00311020fbc77mr6285749ilv.6.1675383309714;
        Thu, 02 Feb 2023 16:15:09 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id w193-20020a022aca000000b003a5de29178esm371182jaw.104.2023.02.02.16.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:15:08 -0800 (PST)
Date:   Thu, 2 Feb 2023 19:15:07 -0500
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
Message-ID: <Y9xSCwgUxHDeppz7@x1>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
 <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
 <Y9xAEoc0QXe222D0@x1>
 <25f5a750-b51c-7d7b-0d50-5b2f78de8512@linaro.org>
 <Y9xOeZjAQmQqLOa1@x1>
 <1319a973-26ae-8c11-d967-8720aaf894df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1319a973-26ae-8c11-d967-8720aaf894df@linaro.org>
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

On Fri, Feb 03, 2023 at 01:05:35AM +0100, Konrad Dybcio wrote:
> On 3.02.2023 00:59, Brian Masney wrote:
> > For others quick reference, Konrad is talking about this line from
> > sa8540p-ride.dts:
> > 
> > 	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> > 
> > I noticed that earlier but assumed this was one based. However, looking
> > at pinctrl-sc8280xp.c I see gpio0..gpio227 defined.
>
> + gpio229 is the reset pin for the UFS card slot

We don't have the UFS card slot on the sa8540p exposed. However, it is
available on the sa8295p.

The original DTS in upstream listed 230 pins, however pinctrl-sc8280xp.c
lists 233 pins and the two UFS pins match what we have in DTS.

static const struct pinctrl_pin_desc sc8280xp_pins[] = {
        PINCTRL_PIN(0, "GPIO_0"),
	...
	PINCTRL_PIN(227, "GPIO_227"),
	PINCTRL_PIN(228, "UFS_RESET"),
	PINCTRL_PIN(229, "UFS1_RESET"),
	PINCTRL_PIN(230, "SDC2_CLK"),
	PINCTRL_PIN(231, "SDC2_CMD"),
	PINCTRL_PIN(232, "SDC2_DATA"),

Rescind-Reviewed-by: Brian Masney <bmasney@redhat.com>

