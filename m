Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD3697B80
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjBOMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBOMK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:10:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5463C2A987
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:10:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so1199960wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B88sRzH49NkKCIicSP4fo6lIj4LfSxlZhgeAIzbft1s=;
        b=T8ISws1Qojl5kqPrr/5KFCLc99U5ay4mkoqR09aGtORtKk3YrmPsFAv30dXkJnB4Px
         ya5aBKsXKP7u/qO2+RZT9jUc8CdLgpcvzBCh5E4ETP7g1wAEozqqncUK+1n+DMJtF7bZ
         ZJZ452ihxoNMgLH3Ob5/BaCGk+Po+dOCwgNets9cQjxTEn6zd+nvOb57sRBp/RDoybNI
         M0+1fZ/dwFIOBT4IMFcleDsVj9A1W0RQ/2IMxbY9XT2cD88HF5xgAABNWEaaAnAc1N4S
         mdWQGdZvc/p4Wdm/GV+24PM1D1JVbSZMAmYVeTvVl6QftWr+K1Twne6T1bMQB6czZ2ee
         ccLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B88sRzH49NkKCIicSP4fo6lIj4LfSxlZhgeAIzbft1s=;
        b=JrVUZonoMrN6U7WdaiAHYdX/iVAIxHbFtua6nOSgJ/Hb/RPf0sVQvjpV9YlsjfXmQ1
         33Hv2g4gpOmyxbmfkIU+WOKoEVXl7gxXvNR5CiBMpJThOBTCIwIU76xLc66edqZeySOG
         Pi+YSsrqtkPQ7h/yuFi0zu5M4OALh0duT3Rkkq3ck3IlMxEN1YmazF2NnIKJkw27ozgh
         lMHy55D/CVRu82gZMBh3tOE3yZr3EZ+wQn83tnMXNEcP7cWeqUdD3SQJ7jTFMBFp/tEy
         nL6moCtXZjAKvcSBCe5y5lRshEDJrvC+N2pCq/Ug9ezA+RqHmotgyqHcVTejtULxpE3E
         HTbw==
X-Gm-Message-State: AO0yUKWxTmLZOGE1/MgJAP9v+uJsjiNSoiK5ISaMzMozu/f8526wcAxp
        r9lDyEAQBq4Ap/qFkny9s9R8+A==
X-Google-Smtp-Source: AK7set99jj8objQ4uMIB7cUxdbUtE4aJnQuKjEF7GKvRvcGb2mUkzOk/bW78+lKB0A6h4fOPPoYfqQ==
X-Received: by 2002:a5d:518b:0:b0:2c5:5237:3b21 with SMTP id k11-20020a5d518b000000b002c552373b21mr1230962wrv.69.1676463022903;
        Wed, 15 Feb 2023 04:10:22 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w19-20020a05600c099300b003db03725e86sm1923947wmp.8.2023.02.15.04.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 04:10:22 -0800 (PST)
Date:   Wed, 15 Feb 2023 14:10:21 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: qcom,pdc: Add compatible for SM8550
Message-ID: <Y+zLrQYBC5HQ7lJD@linaro.org>
References: <20230127132558.1176730-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127132558.1176730-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-27 15:25:58, Abel Vesa wrote:
> Document the compatible for SM8550 PDC.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Rob, will you pick this up yourself?

Thanks.

> 
> The v1 is here:
> https://lore.kernel.org/all/20221116114210.2673902-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * rebased on next-20230125
>  * added Krzysztof's R-b tag
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> index 94791e261c42..5a733bd76b57 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
> @@ -37,6 +37,7 @@ properties:
>            - qcom,sm8250-pdc
>            - qcom,sm8350-pdc
>            - qcom,sm8450-pdc
> +          - qcom,sm8550-pdc
>        - const: qcom,pdc
>  
>    reg:
> -- 
> 2.34.1
> 
