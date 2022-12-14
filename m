Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C4E64CD78
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiLNP4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbiLNPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:55:48 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4549D28E22
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gtawquJbr4j4KL/a0E8zt+JLEwoREh5/6YFc6c6V6no=; b=qmbneJv+DvannkGKQqEoytBscM
        t3jplbl9lpSl9+7He82fxjiS1cfW7eTLshIhlQXJ5rg3DxCObB1Mp6XEnv5HL7YYXRSBOgnt7ZSdp
        +3vMLhMSgpvRL2Un1blxBcT3AGZdp1HjCtae3+LQjtw0yzDduFStYvarKnjymwm/CxVb6YIfspH8N
        Dmzwfa/oYaSPKKMoaQkm9Bj0u9MaCp6SgbhouFzwKHRLfLLWmQXvrr5QuO2QflpsmnBW0YnNPMJ/D
        9xgEsrnuuCb5Zx5FI6Njp9KIypiPyCMVoKs4JXk0cqCfGcmKKRryQLg2xDUXGMIyxquCjYgSLPeeh
        OT04mcrw==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1p5U4F-003IrC-56; Wed, 14 Dec 2022 16:53:11 +0100
Message-ID: <b95f7a3d-429a-3564-fc9e-fa05d1d551df@igalia.com>
Date:   Wed, 14 Dec 2022 12:53:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [for-next][PATCH 6/8] ftrace: Prevent RCU stall on
 PREEMPT_VOLUNTARY kernels
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221214140133.608431204@goodmis.org>
 <20221214140209.346584113@goodmis.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221214140209.346584113@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 11:01, Steven Rostedt wrote:
> From: "gpiccoli@igalia.com" <gpiccoli@igalia.com>

Hi Steve, would be possible to use my full name here, like: Guilherme G.
Piccoli <gpiccoli@igalia.com> ?

Thanks,


Guilherme

> 
> The function match_records() may take a while due to a large
> number of string comparisons, so when in PREEMPT_VOLUNTARY
> kernels we could face RCU stalls due to that.
> 
> Add a cond_resched() to prevent that.
> 
> Link: https://lkml.kernel.org/r/20221115204847.593616-1-gpiccoli@igalia.com
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index d04552c0c275..b8e374a372e5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4204,6 +4204,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
>  			}
>  			found = 1;
>  		}
> +		cond_resched();
>  	} while_for_each_ftrace_rec();
>   out_unlock:
>  	mutex_unlock(&ftrace_lock);
