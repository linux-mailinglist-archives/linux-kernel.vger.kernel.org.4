Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2AA74EBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGKKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKKZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:25:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063C188
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:25:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so8891842e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689071114; x=1691663114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+Qilr7pP6gSy0LE7uHCYSIgV8Afel7/d4HNsbNnYA=;
        b=cyT5Q24B7H+TmYoe63NuWLwe9D8Jphm2YMzl7JBVssHGjd5OBuhpsFDV4P/x0RhbnZ
         LQKV6hr6BmO7AgYGVd57DoA78/w1Skx9mQy7+a7zJHWqOaf/XoZlfPEST/KONoOe9mvb
         bA9p6S4hf7t6g4iOFM54uiH67rhW9UURxQODfSrcNeg2vW7qsT1/bd1y3O4R6Zk9dz72
         enquOMRIwVgJqvReaf8myDsm0DGCh/48dQVLRBoXLjdDD5qsWTa3jptaY0pkt6rfNV5f
         IgCZ25TW9B8cgOxzAWeaDAFaDXM9h0ri1C0LaquBR7whsiXtlnvpKYuZ2hkXT6SYMncF
         lJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071114; x=1691663114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap+Qilr7pP6gSy0LE7uHCYSIgV8Afel7/d4HNsbNnYA=;
        b=EldFaR07C8bcC28SHbpChDpbdgcFB4og3cDVaYnYykOLtXzqHtlwH2Nqw1gIxsGQyj
         fqxnp8zdHWjJl4QQ2AUznp1UNpARGX/RaWqEv2bjkHV0kLHZOezSflv5ayRMPCr5DR5k
         q2k5TGXtUZ/6C860NzvRkKvRLv0UGxhcyMqRKMMpkL8/7MNT3OTihlTrmKqP7oQrIrk3
         7GbOQUe9EqTr4i3Qkw2wLgkFthMHXceAlDstPd5x4AZx9yWEBxqTYW7zMaDuYsre5rf2
         PVPReRfamgBcO8gWmCD9rJQA9Nh3OmZ3GvQckWgV+eMLsWOcf8rxwuwi/XIhfM5x6QCc
         12Qw==
X-Gm-Message-State: ABy/qLYv5MeDF9vIItJPwNqAKVhShuy3yfe2zGm0u8/o9VI21PqbZwsg
        lxtg1zZ3bx0/UKhyDPa0TjP+hGs/EkwbE/O3aOA=
X-Google-Smtp-Source: APBJJlEI1MBBNehgLKJV8ioSBy96KjyisYgRyyr0tV5x8hA/Ydijb7i3TewFQrl8uZrL2w9Z81nWdw==
X-Received: by 2002:a05:6512:5d7:b0:4f9:5a87:1028 with SMTP id o23-20020a05651205d700b004f95a871028mr11004577lfo.30.1689071113857;
        Tue, 11 Jul 2023 03:25:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm258645lfn.168.2023.07.11.03.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:25:13 -0700 (PDT)
Message-ID: <8433cbfa-52c5-90c5-1e4c-0b13236d2153@linaro.org>
Date:   Tue, 11 Jul 2023 13:25:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] clk: qcom: gcc-ipq9574: Mark nssnoc clocks as
 critical
Content-Language: en-GB
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        rafal@milecki.pl, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-3-quic_devipriy@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711093529.18355-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 12:35, Devi Priya wrote:
> Mark nssnoc clocks as critical as they are to be turned on to access
> nss port tx/rx clocks.

Can you please clarify, if these are turned off, one can not access 
nsscc clocks? Then the nsscc should be the consumer of these clocks 
(instead of declaring them as critical). May be using pm_clk for nsscc 
will work. If not, you'll have to do that manually from 
runtime_suspend/runtime_resume callbacks.

> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq9574.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 6914f962c893..b68addc6f687 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -2166,7 +2166,7 @@ static struct clk_branch gcc_nssnoc_nsscc_clk = {
>   				&pcnoc_bfdcd_clk_src.clkr.hw
>   			},
>   			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>   			.ops = &clk_branch2_ops,
>   		},
>   	},
> @@ -2565,7 +2565,7 @@ static struct clk_branch gcc_nssnoc_snoc_clk = {
>   				&system_noc_bfdcd_clk_src.clkr.hw
>   			},
>   			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>   			.ops = &clk_branch2_ops,
>   		},
>   	},
> @@ -2582,7 +2582,7 @@ static struct clk_branch gcc_nssnoc_snoc_1_clk = {
>   				&system_noc_bfdcd_clk_src.clkr.hw
>   			},
>   			.num_parents = 1,
> -			.flags = CLK_SET_RATE_PARENT,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>   			.ops = &clk_branch2_ops,
>   		},
>   	},

-- 
With best wishes
Dmitry

