Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEBA648F62
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiLJPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLJPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:04:23 -0500
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9A1A068
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:04:22 -0800 (PST)
DKIM-Signature: a=rsa-sha256; b=AIqE8nIidxFj9sQ70ILk6zwpDv+YydLmRhIrPXjz8t2I1d/UCkaeX77dbcMp7WnbgUf7fGNqAGXoNWbkt0TJTOr0mURi3y89+zIpphzAnaNoR8ECJn4Lp8oF8NwL+V6ElVRDKeH+QHMGkqMRxZ7OSDaXVWHb//4onJUfD7Lw7WaYXr5Hj524kj4JtzcFWaGtw0NCMJ0SBN1YVa7r4zkec8W8jt/VAriLr0zW+bcB6sArxM3feSKMbWOoW9cRN9e045P70bPQtKJQBqQ8vFWGxtbakxMv6iSooRNS4LpB8xYSUFmCEkce5MIjLEBiQI5zrFO/6BYbf71/YGoOzUli3A==; s=purelymail3; d=iskren.info; v=1; bh=cQLGZDbFHIKXmQ8daeDFExWP2epemSRMiQcQS0P5txE=; h=Received:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=3/WzdjgYAY/a2KOBdmeo6wWo9iW6qFGNblwHur235QqdpCYz4nqAT0rIiELo/fl8LVzNNp9HJE/EvKgNAa6yhz4XtNzz4J6qRGqJeWvnBznupFm48x/R039b9VGArqNcSJqZIHBxVU6Vhub/D6TsY9vRAa04UNgmQAXfhjnBwMBd/8cFgFjVFKOmwJ20q9tq0LlzSUokidDOp31PuAmaC3znd7ObLLhUKEKuDTRhWis4KIA0wFAk1gy1wlAWwzD4qwKENbNjeFz8TilOmFxySB2kgsnWWGSYm8ZGFChOlGtZ6QDeTqmB+V82Y0eTvTEX4UlMd2T0SAL3JZdZTAAhrQ==; s=purelymail3; d=purelymail.com; v=1; bh=cQLGZDbFHIKXmQ8daeDFExWP2epemSRMiQcQS0P5txE=; h=Feedback-ID:Received:Subject:To:From;
Feedback-ID: 10275:2339:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1405222646;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 10 Dec 2022 15:03:51 +0000 (UTC)
Message-ID: <fbb5fadd-c2b4-b689-1285-45440b55fe31@iskren.info>
Date:   Sat, 10 Dec 2022 17:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] clk: qcom: gcc-sm6115: Use floor_ops for SDCC1/2 core clk
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209123910.178609-1-konrad.dybcio@linaro.org>
From:   Iskren Chernev <me@iskren.info>
In-Reply-To: <20221209123910.178609-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/22 14:39, Konrad Dybcio wrote:
> Just like in case of other SoCs change SDCC1/SDCC2 ops
> to floor to avoid overclocking the controller.
> 
> Fixes: cbe63bfdc54f ("clk: qcom: Add Global Clock controller (GCC) driver for SM6115")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Iskren Chernev <me@iskren.info>

> ---
>  drivers/clk/qcom/gcc-sm6115.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
> index 565f9912039f..5b8222fea2f7 100644
> --- a/drivers/clk/qcom/gcc-sm6115.c
> +++ b/drivers/clk/qcom/gcc-sm6115.c
> @@ -1258,7 +1258,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
>  		.name = "gcc_sdcc1_apps_clk_src",
>  		.parent_data = gcc_parents_1,
>  		.num_parents = ARRAY_SIZE(gcc_parents_1),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  	},
>  };
>  
> @@ -1305,7 +1305,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>  		.name = "gcc_sdcc2_apps_clk_src",
>  		.parent_data = gcc_parents_11,
>  		.num_parents = ARRAY_SIZE(gcc_parents_11),
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_rcg2_floor_ops,
>  		.flags = CLK_OPS_PARENT_ENABLE,
>  	},
>  };
