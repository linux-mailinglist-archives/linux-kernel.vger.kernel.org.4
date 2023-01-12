Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6725667785
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjALOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbjALOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:43:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80563394;
        Thu, 12 Jan 2023 06:32:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49431B81E73;
        Thu, 12 Jan 2023 14:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3A5C433EF;
        Thu, 12 Jan 2023 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673533959;
        bh=m9Ix+lLUkBPF9iqFxJS7VMgHIrgbScLcQu0xAEukD2E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l5VKHPZ/X/TaVa8tHeOb+/Qfm6x7qYKqMj8CXXGDtwzD1MJu9M0+6BWZM1fN1DDQi
         R9h7b73SQj8z8FczfVo9A18y4Cqkv8z5i9HxIOqq8K2ajT5MSMaWyuC0vG+S1LRHf7
         C6hmt719moqh8h3YgJQFSCG/0EGcLOpHSLrMP6nOhDwA6BVNbqoUGDxmCFJ2F8jP0O
         4CEaF31QBxaROftW+fAE5RLjxeBw3wAY3FBNPoXQI4IXqsVmN9nombJCY/67RpYjiH
         ZCPpXHq2iiusX3mxlaq0GO8thF+/Pf5k8/rEXhwXjmbqj0JGzIcNKJ0JBkDo6Rd1Sb
         lLUlFUIOxtasA==
Message-ID: <fefd9ded-b9d8-3b01-de39-7ff147206c84@kernel.org>
Date:   Thu, 12 Jan 2023 15:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2 v2] tools/tracing/rtla: osnoise_hist: use total
 duration for average calculation
To:     Andreas Ziegler <br015@umbiko.net>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
 <20230103103400.275566-2-br015@umbiko.net>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20230103103400.275566-2-br015@umbiko.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/23 11:33, Andreas Ziegler wrote:
> Sampled durations must be weighted by observed quantity, to arrive at a correct
> average duration value.
> 
> Perform calculation of total duration by summing (duration * count).
> 
> Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")
> Signed-off-by: Andreas Ziegler <br015@umbiko.net>

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
-- Daniel

> ---
> Changes v1 -> v2:
>  - add 'Fixes' line (Daniel)
> 
>  tools/tracing/rtla/src/osnoise_hist.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
> index 5d7ea479ac89..fe34452fc4ec 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -121,6 +121,7 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
>  {
>  	struct osnoise_hist_params *params = tool->params;
>  	struct osnoise_hist_data *data = tool->data;
> +	unsigned long long total_duration;
>  	int entries = data->entries;
>  	int bucket;
>  	int *hist;
> @@ -131,10 +132,12 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
>  	if (data->bucket_size)
>  		bucket = duration / data->bucket_size;
>  
> +	total_duration = duration * count;
> +
>  	hist = data->hist[cpu].samples;
>  	data->hist[cpu].count += count;
>  	update_min(&data->hist[cpu].min_sample, &duration);
> -	update_sum(&data->hist[cpu].sum_sample, &duration);
> +	update_sum(&data->hist[cpu].sum_sample, &total_duration);
>  	update_max(&data->hist[cpu].max_sample, &duration);
>  
>  	if (bucket < entries)

