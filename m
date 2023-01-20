Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9E674A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjATEaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjATEaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4BB2E53;
        Thu, 19 Jan 2023 20:29:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1584B8233A;
        Fri, 20 Jan 2023 04:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15DEC433D2;
        Fri, 20 Jan 2023 04:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674188947;
        bh=yAmXPbBSRLpimCnR9Yp98v03bNqg5mhYa1PIGrqybE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1oD0dWc221H9Cyh/yAl36/+UwLkYWa3tnWGrZJFYeV5x3tMGa3a4ishT3dAK1Yn8
         WIDVlbRvVDqMQtI8TVqackFlQEo+LmvveiMiwU6qDBsNtd3YraLyLz4BhtZsZqdX6T
         tAp71V5qU9ieW4VXoWff8ul+RCunsSVOQG93eBd8nExyuMQQz2dc9ZYDSZ7iRk5hII
         XqEYlJCZNzujkgD3nrCesSyJf7raO7ZOpmy+KfpAGQT+r3xiIZwDQcLjsCLthRIxvU
         p37L5813Qs81P6HUXDy9GUGo1H8jgcnVyopbJQdfqeFymadKRl5R3xTOLQ/YLXGneE
         WFpOMYJJPhoQA==
Date:   Thu, 19 Jan 2023 22:29:05 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: Restrict 'mpp'
 child node name pattern
Message-ID: <20230120042905.d2pdrzyv3e3airdj@builder.lan>
References: <20230120020600.3232001-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120020600.3232001-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 08:06:00PM -0600, Rob Herring wrote:
> Just 'mpp' is a bit ambiguous for a pattern. It allows any prefix or
> suffix. I couldn't find any actual users, so update the pattern to match
> the example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> index 72cce38bc1ce..891a7385d7cb 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> @@ -74,7 +74,7 @@ patternProperties:
>      oneOf:
>        - $ref: "#/$defs/qcom-pmic-mpp-state"
>        - patternProperties:
> -          "mpp":
> +          "-mpp$":

How about aligning it with the other Qualcomm pinctrl bindings and make
it "-pins$" instead?

If my grep is correct we have one "mpp5" and two "-pins$" currently in
the sources, so this should be beneficial as well.

Regards,
Bjorn

>              $ref: "#/$defs/qcom-pmic-mpp-state"
>          additionalProperties: false
>  
> -- 
> 2.39.0
> 
