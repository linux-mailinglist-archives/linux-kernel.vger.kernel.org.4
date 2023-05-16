Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445347046CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjEPHpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjEPHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:45:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43321BF0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:45:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53404873a19so1899787a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684223141; x=1686815141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMgxFstA4dU27VYUmC/EUyRT+aFdHF1+K5zpsmTBgHI=;
        b=eIHmYIJe70KWjBIIaFEi+nqfszwu0VfvZ1D0A/IWeIGuDFfDOnHkmv6fePL83K1RRd
         UK5QPAERzamapBRmO+mE18Ft/2kAyhGV1OgsNPhY74VKp+o+DdeO5pZ9w186RpBohOQl
         FvtOE3aVoG5QxrCOX3OALWID5aRckS6o8HCx3iJp8C7ZCE5699oR9Cw/FP934QyMLQKV
         KPCDtmLIGYIYX/smZngajVrKYNbOF4GTMgeKG3NSgFMxsWqffD3Q2lxX/ZryKw12Djn8
         ekw2cTR5px2SxGfhSnyDXIPE8W+K/rep/DU+Na7/mNXcVl9Y0jPLdDPBo0coBKlKQMeF
         rRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684223141; x=1686815141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zMgxFstA4dU27VYUmC/EUyRT+aFdHF1+K5zpsmTBgHI=;
        b=d9TN0bsHCc5wNJeClwtjM7WWWAZEQqUaJuBdpYIw46bvJcAFxg4QkL+Jui4mjr28wz
         1Sc7t4jydhh7Hr86EQbK1XmoLmOfk84c+xsNQndtiXFkFRvH9sUILspL1mcBqW3BwPNt
         fIRjB+AX13X07/4qn2GaF9dI/IUJTBLtLHi/4UFHyPFxaFPLDRg4R+PjkgP0z7zCxKjz
         vqndF7UtmY2IMTFhVhNcs46CQyyGN8seshS6gLbSnjU6WqJeo9kSetNyHshFpJGci3hn
         htMArrCGxB2Yhid949IVwTGds4iEYl2h4GF1ivgqWYbZXRBDIfnboMmY256K/ovdSoDm
         5tmw==
X-Gm-Message-State: AC+VfDwejCrJ/jtBTT5+R/wFkODewryicL8iGKzOKJet9BlQ7LhYOr8B
        SK+HBnsDqKCxtO5g9QlvzdAOvg==
X-Google-Smtp-Source: ACHHUZ4pnY+fFo/94XKa/+R1YA7DYAOpobLPzohvxH/9sqnqIAoxYntMvYCKwss0q8v4hkr6qUReGA==
X-Received: by 2002:a17:90b:4c8c:b0:252:8910:db42 with SMTP id my12-20020a17090b4c8c00b002528910db42mr18052102pjb.1.1684223140935;
        Tue, 16 May 2023 00:45:40 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb? ([2401:4900:1c60:6bed:62ca:2e52:e0c5:d0cb])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a2d8f00b0024df6bbf5d8sm973072pjd.30.2023.05.16.00.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:45:40 -0700 (PDT)
Message-ID: <4f68a71f-b9ea-7240-8d82-5578b9a94fbc@linaro.org>
Date:   Tue, 16 May 2023 13:15:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH V2 1/4] dt-bindings: clock: Add crypto clock and reset
 definitions
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_poovendh@quicinc.com
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
 <20230515150722.12196-2-quic_anusha@quicinc.com>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230515150722.12196-2-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/15/23 8:37 PM, Anusha Rao wrote:
> Add crypto clock and reset ID definitions for ipq9574.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   Changes in V2:
> 	- Separated out the clock/reset binding changes to a new patch.
> 
>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
>   include/dt-bindings/reset/qcom,ipq9574-gcc.h | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> index 5a2961bfe893..86790efa10f0 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -210,4 +210,8 @@
>   #define GCC_SNOC_PCIE1_1LANE_S_CLK			201
>   #define GCC_SNOC_PCIE2_2LANE_S_CLK			202
>   #define GCC_SNOC_PCIE3_2LANE_S_CLK			203
> +#define CRYPTO_CLK_SRC					204

For uniformity, please use GCC_ prefix int the above define as well.
Also make the similar changes at the places where this CLOCK_SRC macro 
is used.

Thanks,
Bhupesh

> +#define GCC_CRYPTO_CLK					205
> +#define GCC_CRYPTO_AXI_CLK				206
> +#define GCC_CRYPTO_AHB_CLK				207
>   #endif
> diff --git a/include/dt-bindings/reset/qcom,ipq9574-gcc.h b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> index d01dc6a24cf1..c709d103673d 100644
> --- a/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
> @@ -160,5 +160,6 @@
>   #define GCC_WCSS_Q6_BCR						151
>   #define GCC_WCSS_Q6_TBU_BCR					152
>   #define GCC_TCSR_BCR						153
> +#define GCC_CRYPTO_BCR						154
>   
>   #endif
