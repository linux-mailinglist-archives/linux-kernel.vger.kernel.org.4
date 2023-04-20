Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F716E8CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjDTI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjDTI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:28:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F343AA4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:28:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b620188aeso986848b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681979301; x=1684571301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMHkc4ddxtiZDR/vOhmkpTYUjNc5FBHmkFEOL3O5eEI=;
        b=nY87j4ncBYV8Afs/V05HISSZlKNEMmYjThXCGm+F6KttBojRYQ5N5hQdAsjE1vBrc8
         TGCt2pgjC8AXgYN62q8Dl4spXMAvwsYeklhz6EIP3kLFlZSjWECd6LX8Z7aIv9Yc3Ah8
         ueiZwqaAFjLjT/Gk9a/0K0cItsTmGBsF768/AW7fPJsic0xufVWg5A7leHR7+QKdCTeL
         RzhWetGOAZK0qrq8qQD3SDqOYq+KBVqKtq6eYMSH8JNF/LKC9QjPB7lsSCE94hkLjNyI
         5tWfcUtlNbN0y+0HjFb6a9f+YE9SDAOJo+7RaFPBcj+FrsAawSqShedRhiEYQBPsg84b
         dpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681979301; x=1684571301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMHkc4ddxtiZDR/vOhmkpTYUjNc5FBHmkFEOL3O5eEI=;
        b=kAIwB76fMv3FZbAIFdX+U84BdqN2TNEZjbPj9YGIUFn4yuTP81uq0/bfflp8/kO2Jl
         LNx5vxDcd5lJmcs0QlmWzGfYk2YISspFfU/KlpuTj9jZQkU17M54gejjCUYI98igKiGL
         b+8T3LIhlJopDit5TkiKoABAlxeYd0Fh4KvvIspbbcro+5nryRcB9c2NByyz6sL+9M63
         y/Ri/U0suXZokuJyt/akVozfwmGxUvtxJdcZ06moZJQ9Yl8RfrFpIFrpPP+M+ljvSpWm
         w8mO09Dy1AKSJAUlzdiBEwQ+G7yRG8NUBNf2dp2y2PZyi3t4hUXXZE2rCLj0II1Q3jBp
         uNDA==
X-Gm-Message-State: AAQBX9c4R9EQ84EVG9X4Y6aDYNYmadOrJgUWTy4nGaeaeh7fwTf9mbGI
        8XC4b5tcfUFg+QAFrTPpF5cy
X-Google-Smtp-Source: AKy350YfTe+XSl06gctWCjJwT+JzE2EjX7cwndeGei8fwbiqk9lB3+gCjl3ILwy6bQ1KDlmAM2Lplw==
X-Received: by 2002:a05:6a20:734c:b0:ec:9d9c:4a05 with SMTP id v12-20020a056a20734c00b000ec9d9c4a05mr1371094pzc.13.1681979301536;
        Thu, 20 Apr 2023 01:28:21 -0700 (PDT)
Received: from thinkpad ([117.207.29.62])
        by smtp.gmail.com with ESMTPSA id m24-20020a62a218000000b0063d5fa9fb66sm712056pff.49.2023.04.20.01.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 01:28:21 -0700 (PDT)
Date:   Thu, 20 Apr 2023 13:58:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
Message-ID: <20230420082811.GA6308@thinkpad>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-1-ae80a325fe94@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

My 2 cents here...

First, this property doesn't belong in DT at all as it is OS specific handling.
This leaves us with the option of using a cmdline or module params for rmpcc.
But we already have one (clk_ignore_unused), so the platforms making use of old
DTB's should use that instead.

And that get's rid of the debate that when you start disabling rpmcc clocks, old
platforms will break. I don't see a valid point to keep the old platforms alive
since their DTB (firmware) is broken already. So either they have to fix the DTB
or use a cmdline option.

- Mani

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
> +    type: boolean
> +    description:
> +      Indicates whether unused RPM clocks can be shut down with the common
> +      unused clock cleanup. Requires a functional interconnect driver.
> +
>  required:
>    - compatible
>    - '#clock-cells'
> 
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
