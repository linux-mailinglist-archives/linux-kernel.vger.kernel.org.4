Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372C36CD0C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC2Dly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjC2Dlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:41:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE3272A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:41:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k2so13672612pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680061309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWa7wOxAFG7tdLlil0NzPbk6K8fs9R4JDMItxPB89Zk=;
        b=FLF2hx/aelGWFy3MQVxuI78e6bOjKUK0lDvmENJJpmng1+jiJwkepTsA6xcZ7bgyJL
         DmUnAcpXeCosXu57J8rd/T5bW2vQu2R18QhdAcLfCAYqBZYTe7ZOpng9pfU6q3pZLZWy
         bZ0xYsmqIJh9d+pDd+SvQtG1AcdGk5PjZL7mr06iuDiGUN2YyXXOWbosx+9jl89gm15+
         tAhoQzr7B/nPPEHzzERhQigxMSOza9THTNsE4XgiryPRfsIjMZtlHOGDNlCN8/gDXP2k
         tUVI0zXENIL+47cZxozxrhKUktrd2ctQyctmqqGPMag5wvF1b81ZzC62uflLkKA237Jl
         jhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWa7wOxAFG7tdLlil0NzPbk6K8fs9R4JDMItxPB89Zk=;
        b=AZ4d57s6WUCfeDAtdZeHgUUP2ll131j1Ises8xXK1VKeU98W4+7cYeyIhXw3sQT9Y1
         s32nfDa2+24JGMIvv3ojLTswfyZlWkqUvqhRmtuVA9j95hyNPi2w7oc4lmG9V4mD8ips
         ArJYSIklPuFyEV6/QfiqpW1Ko2eK2snpSGodLuLlK0U82QSPRv5S7RhU/GYwG+2bqObf
         NPzJzszwYIAy+aBSjzGWUhvsBYrKfgzphbzPNR2OfvLUd79ZMYsk8FZQTXVb1WQ2wAI0
         zRUXRcff6LgPI15S/Mi/BR8nBM1E3yIcQwzfWB1TOTReWVVAJXN+1roUfrlehu2HY9Pe
         +8FQ==
X-Gm-Message-State: AAQBX9fpGQcX5yIV7KeKLEGKhef+bKhIcaX/ZE2FCnqPY20EEI7agCEF
        iUeh/SPV6L34COv98jNPK3g06g==
X-Google-Smtp-Source: AKy350Z9qGLrPtkmUBr4ckTpyxUSYvNDmeQ5iMJn6z0y5G7PURan5PkPuuuHsPMHlcFFJYajoaXeSw==
X-Received: by 2002:a17:90b:4c0c:b0:233:d12f:f43a with SMTP id na12-20020a17090b4c0c00b00233d12ff43amr17346852pjb.1.1680061309170;
        Tue, 28 Mar 2023 20:41:49 -0700 (PDT)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id fh5-20020a17090b034500b0023b5566f744sm311482pjb.39.2023.03.28.20.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 20:41:48 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:41:41 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: mpm: Allow
 passing reg through phandle
Message-ID: <20230329034141.GB3554086@dragon>
References: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
 <20230328-topic-msgram_mpm-v1-1-1b788a5f5a33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328-topic-msgram_mpm-v1-1-1b788a5f5a33@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:02:52PM +0200, Konrad Dybcio wrote:
> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
> use 'reg' to point to the MPM's slice of Message RAM without cutting into
> an already-defined RPM MSG RAM node used for GLINK and SMEM.
> 
> Document passing the register space as a slice of SRAM through the
> qcom,rpm-msg-ram property. This also makes 'reg' no longer required.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> index 509d20c091af..77fe5e0b378f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
> @@ -30,6 +30,11 @@ properties:
>      description:
>        Specifies the base address and size of vMPM registers in RPM MSG RAM.
>  
> +  qcom,rpm-msg-ram:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the APSS MPM slice of the RPM Message RAM
> +
>    interrupts:
>      maxItems: 1
>      description:
> @@ -64,7 +69,6 @@ properties:
>  
>  required:
>    - compatible
> -  - reg

It's not my call, but I wonder if we need to maintain the 'reg' ABI
at all, as there is no DTS landed so far.  In either case, I suggest
we update the example to adopt the new way.

Shawn

>    - interrupts
>    - mboxes
>    - interrupt-controller
> 
> -- 
> 2.40.0
> 
