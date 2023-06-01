Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFF71926C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjFAFkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjFAFjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:39:42 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1E31732
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 22:38:45 -0700 (PDT)
Message-ID: <5bc1ac0d-cea8-19e5-785a-cd72140d8cdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685597879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8KKClr4mwxkP83/QvliDYMt02i03s7p/NNDdJNcids=;
        b=fH3TdsVq8CEbPsRnt5077VpAg6MQuK/X+xLlj3QRaXIQmwgx1k9xXsw7S0z3/lDuo8eJXV
        qu+8Mf1VW6lISAHxq1ruB7QBTi3ywmuixstKQ9twPtpS+JwXvZ0z3bHYPVbbe3qqIP8jR/
        m6OLSlJDITn/dx3ZdC6dtrQWoZFOrRQ=
Date:   Wed, 31 May 2023 22:37:52 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: getsockopt hook to get optval without
 checking kernel retval
Content-Language: en-US
To:     Feng zhou <zhoufeng.zf@bytedance.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230601024900.22902-1-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 7:49 PM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> Remove the judgment on retval and pass bpf ctx by default. The
> advantage of this is that it is more flexible. Bpf getsockopt can
> support the new optname without using the module to call the
> nf_register_sockopt to register.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   kernel/bpf/cgroup.c | 35 +++++++++++++----------------------
>   1 file changed, 13 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..ebad5442d8bb 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1896,30 +1896,21 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>   	if (max_optlen < 0)
>   		return max_optlen;
>   
> -	if (!retval) {
> -		/* If kernel getsockopt finished successfully,
> -		 * copy whatever was returned to the user back
> -		 * into our temporary buffer. Set optlen to the
> -		 * one that kernel returned as well to let
> -		 * BPF programs inspect the value.
> -		 */
> -
> -		if (get_user(ctx.optlen, optlen)) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +	if (get_user(ctx.optlen, optlen)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
>   
> -		if (ctx.optlen < 0) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> -		orig_optlen = ctx.optlen;
> +	if (ctx.optlen < 0) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +	orig_optlen = ctx.optlen;
>   
> -		if (copy_from_user(ctx.optval, optval,
> -				   min(ctx.optlen, max_optlen)) != 0) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +	if (copy_from_user(ctx.optval, optval,
> +				min(ctx.optlen, max_optlen)) != 0) {
What is in optval that is useful to copy from if the kernel didn't handle the 
optname?

and there is no selftest also.

> +		ret = -EFAULT;
> +		goto out;
>   	}
>   
>   	lock_sock(sk);

