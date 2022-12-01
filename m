Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939BB63F55A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiLAQg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiLAQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:36:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29109ABA20;
        Thu,  1 Dec 2022 08:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA95C62075;
        Thu,  1 Dec 2022 16:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75632C433D6;
        Thu,  1 Dec 2022 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669912611;
        bh=teeOjCiHN0Fv9n+KoC6rqOlGObhK/vE2PhcSLZFcjpY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gTttZ1jERE9crYJe1Kw/glqQ02k9wSlJRYm0ISYhQw1V+ulysMPAfJ4LccCgxbtNv
         XCrBfhucsrlZ4dpPCaR+sQJX5x7sPKQP8AXsCQZpqRUNPJQGGRbnuQPCPf1lhSAwH2
         e8uXmdgGQyOvvW/52aBhZi1DUCihSWuxwgrRQj4s+CPPvop911k4zw+81GwZkCiaqA
         BeCmsYyJgNbvRoy13zVGCvYA86yngubBpG1lxINYGJbDhMQ0EIfW2TfbX0QB7ufaEo
         lK1FEDr85gyy6iTzI5zREoxckN9+ng/UcDxnPH+ZPyhxHN7rXJYGzpBIbbZhzWh7ey
         euHZfYclxrbcw==
Message-ID: <e037b3b5-3a5a-90c3-0d91-e4882700cbf5@kernel.org>
Date:   Thu, 1 Dec 2022 10:36:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] clk: socfpga: Fix memory leak in socfpga_gate_init()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221123031622.63171-1-xiujianfeng@huawei.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221123031622.63171-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/22 21:16, Xiu Jianfeng wrote:
> Free @socfpga_clk and @ops on the error path to avoid memory leak issue.
> 
> Fixes: a30a67be7b6e ("clk: socfpga: Don't have get_parent for single parent ops")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   drivers/clk/socfpga/clk-gate.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
> index 3e347b9e9eff..0c18c55edf8c 100644
> --- a/drivers/clk/socfpga/clk-gate.c
> +++ b/drivers/clk/socfpga/clk-gate.c
> @@ -133,8 +133,10 @@ void __init socfpga_gate_init(struct device_node *node)
>   		return;
>   
>   	ops = kmemdup(&gateclk_ops, sizeof(gateclk_ops), GFP_KERNEL);
> -	if (WARN_ON(!ops))
> +	if (WARN_ON(!ops)) {
> +		kfree(socfpga_clk);
>   		return;
> +	}
>   
>   	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
>   	if (rc)
> @@ -182,6 +184,7 @@ void __init socfpga_gate_init(struct device_node *node)
>   
>   	err = clk_hw_register(NULL, hw_clk);
>   	if (err) {
> +		kfree(ops);
>   		kfree(socfpga_clk);
>   		return;
>   	}

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
