Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD4742972
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjF2PYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjF2PXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:23:41 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C743588;
        Thu, 29 Jun 2023 08:23:40 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7836272f36eso33544139f.1;
        Thu, 29 Jun 2023 08:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688052220; x=1690644220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIbzwk+16IGxV6FWzckLUrfZmaj1Jf5Ee41P3nY/4zc=;
        b=Ys/VRdMC92+BFY+CXthvb7nH7z+pnxbZRmSyYJrC6SVWyjWqyZpAdBACMc+6d5IA5z
         73oy1WaenNYgzLHLz7ZkHPfhiCBneXGm8IAFOEFWNiYXRU2dz885X1MkYog35KnE5yuA
         8IrkGEAyC2kh1PrOr1IU+2J0csl5oAmLk0ZpzG/TEaztle+0Yu2yg1IX2DeV0RzkUskY
         QlMBhEiZjmXtqXcO6XfohaeAJBotya4zr5h0Vb/5iPAvrwZxkwrBv/kr3YVEWe78fx9+
         /zeMgaWiN0PCwvLlWfbfU/mO9LLjC7PkNOXniW8ltm/x9TOr1W8eU2J1fNVwcf6pcNhh
         pmYw==
X-Gm-Message-State: AC+VfDxGcM+TRn/dX0prAUk1hzKW89Xuir39/1pCLpJy6aqWYj/ZO16C
        21nCFcysMaEXKtCFR2pCEw==
X-Google-Smtp-Source: ACHHUZ4BPmwhYeRuCB1b3WD8WeQpdEUY5Y/vga5MesEG9brj/gXSLEqJny1Nwo0NSJlCoeZIxy778g==
X-Received: by 2002:a5e:9508:0:b0:785:fbe8:1da0 with SMTP id r8-20020a5e9508000000b00785fbe81da0mr5086305ioj.15.1688052219729;
        Thu, 29 Jun 2023 08:23:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ei23-20020a05663829b700b0042ad757be01sm2260064jab.121.2023.06.29.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:23:38 -0700 (PDT)
Received: (nullmailer pid 3060526 invoked by uid 1000);
        Thu, 29 Jun 2023 15:23:35 -0000
Date:   Thu, 29 Jun 2023 09:23:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 08/11] dt-bindings: usb: ci-hdrc-usb2: Fix handling
 pinctrl properties
Message-ID: <20230629152335.GA3055525-robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-8-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-8-6b4b6cd081e5@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:24:24PM +0200, Konrad Dybcio wrote:
> Untangle the bit messy oneOf trees and add the missing pinctrl-2 mention
> to handle the different pinctrl combinations.
> 
> Fixes: 4c8375d35f72 ("dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      | 27 ++++++----------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> index 782402800d4a..24431a7adf3e 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> @@ -199,17 +199,6 @@ properties:
>        In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
>        In this case, the "idle" state needs to pull down the data and
>        strobe pin and the "active" state needs to pull up the strobe pin.
> -    oneOf:
> -      - items:
> -          - const: idle
> -          - const: active

These are no longer valid values? The description still mentions them.

> -      - items:
> -          - const: default
> -          - enum:
> -              - host
> -              - device
> -      - items:
> -          - const: default
>  
>    pinctrl-0:
>      maxItems: 1
> @@ -357,17 +346,15 @@ allOf:
>              - const: active
>      else:
>        properties:
> +        pinctrl-2:

This should be implicitly allowed. Is it not?

I'm reallly at a loss as to what problem this patch solves.

> +          maxItems: 1
> +
>          pinctrl-names:
>            minItems: 1
> -          maxItems: 2
> -          oneOf:
> -            - items:
> -                - const: default
> -                - enum:
> -                    - host
> -                    - device
> -            - items:
> -                - const: default
> +          items:
> +            - const: default
> +            - const: host
> +            - const: device
>    - if:
>        properties:
>          compatible:
> 
> -- 
> 2.41.0
> 
