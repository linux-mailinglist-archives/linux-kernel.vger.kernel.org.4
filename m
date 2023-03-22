Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742856C40E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCVDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCVDTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:19:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE54A1D5;
        Tue, 21 Mar 2023 20:19:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5689B61F2A;
        Wed, 22 Mar 2023 03:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D079AC433D2;
        Wed, 22 Mar 2023 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455189;
        bh=Ll4mdzz4ZdDA497jhdQvJ5RZFR2hipZ/r4YfSaeeXsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBKnxxoqNQJDCu2RDkv3SLcGtXxuun0U2yEbvI2ts3QrsqE5DeLK5pmQOqIgsZlGv
         /0Il16S4ft3Sjy2fcmZDKjwbFCz+5D0U1ytzUH0MUTQUarNscxBWai4Mlj8MBjJF+b
         ybJAVqj5K4friyXgB8rR9E7ivGJEzy8rDOYnUPWAbQ/F+bVsLVieEI+DOqMbhWBozG
         o1Smt9Q5mO86twMIg7wOc9EYMX6sI9naRP/u4UYGECFAMIrkB5UhHwVShSxWYIzTqv
         5aFnmTDxPIHjO3BRcLfcpM1LEjeUmjhyyVpSstkxB+JD6ZrGGJEWrZmj2YxzdOUJuE
         +sx2qEAHsBzNw==
Date:   Tue, 21 Mar 2023 20:23:02 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFT v2 01/14] dt-bindings: clock: qcom,rpmcc: Add a way
 to enable unused clock cleanup
Message-ID: <20230322032302.objqdzryhq2mbljf@ripper>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:35:17PM +0100, Konrad Dybcio wrote:
> Disabling RPMCC clocks can be a bit touchy. If we can't guarantee all
> (or at least most) of the oneline peripherals ask the interconnect
> framework to keep their buses online and guarantee enough bandwidth,
> we're relying on bootloader defaults to keep the said buses alive through
> RPM requests and rate setting on RPM clocks.
> 
> Without that in place, the RPM clocks are never enabled in the CCF, which
> qualifies them to be cleaned up, since - as far as Linux is concerned -
> nobody's using them and they're just wasting power. Doing so will end
> tragically, as within miliseconds we'll get *some* access attempt on an
> unlocked bus which will cause a platform crash.
> 
> On the other hand, if we want to save power and put well-supported
> platforms to sleep, we should be shutting off at least some of these
> clocks (this time with a clear distinction of which ones are *actually*
> not in use, coming from the interconnect driver).
> 
> To differentiate between these two cases while not breaking older DTs,
> introduce an opt-in property to correctly mark RPM clocks as enabled
> after handoff (the initial max freq vote) and hence qualify them for the
> common unused clock cleanup.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> index 2a95bf8664f9..386153f61971 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
> @@ -58,6 +58,12 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  qcom,clk-disable-unused:

This is a Linux implementation detail, not a description of the
hardware. So it unfortunately doesn't belong here.

> +    type: boolean
> +    description:
> +      Indicates whether unused RPM clocks can be shut down with the common
> +      unused clock cleanup. Requires a functional interconnect driver.

This is an interesting aspect though, there's a lot of things that will
break if any one of these building blocks are missing, for any reason.

Regards,
Bjorn

> +
>  required:
>    - compatible
>    - '#clock-cells'
> 
> -- 
> 2.39.2
> 
