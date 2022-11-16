Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81B562B366
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiKPGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233086AbiKPGga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:36:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B7413E1C;
        Tue, 15 Nov 2022 22:36:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48DF2CE19E5;
        Wed, 16 Nov 2022 06:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC374C433D6;
        Wed, 16 Nov 2022 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668580584;
        bh=evQXOWfzVqP+AWTRzWS1x5xxJxZ//Oz93Xhj355NnaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mEhPZu3huyY3vjMNH7uKCusmU6IkabZe1AJjFTEysaCHB4pGHpmnX/q9edoibF2jX
         zsdnqgu/5+ooYj9cqWWedEfFS8E6L+wtzsm1yWDfZJ2GIUiS7zzHa3M7vBKSp9+H4f
         b5Q1Qv+GFvVcAvcO1OoUVJOzWyqKatLhaXZStTJMkOAdQQkl34icyo8VZnbA14mqIr
         RFk115FB5N092rei/Ttv/7RCUFH9KHNxJXJK8JGn6ZBQ4B6zHv2Fr1wT8fyNlD9tUY
         IvUykAiZfKRp4RgpKqepLyKutZSYqdlO8sGCJShKxg54LMjdLVoLWPI1ycmHKGt9WW
         b83xZXytX0tKg==
Date:   Wed, 16 Nov 2022 15:36:20 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        rcu@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY kernels
Message-Id: <20221116153620.353819e9c6acb1bf39adeca2@kernel.org>
In-Reply-To: <20221115204847.593616-1-gpiccoli@igalia.com>
References: <20221115204847.593616-1-gpiccoli@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 15 Nov 2022 17:48:47 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> The function match_records() may take a while due to a large
> number of string comparisons, so when in PREEMPT_VOLUNTARY
> kernels we could face RCU stalls due to that.
> 
> Add a cond_resched() to prevent that.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org> # from RCU CPU stall warning perspective
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
> 
> Hi Steve / Paul, thanks for the discussions on the first thread [0],
> much appreciated! Here is the "official" version.
> 
> Steve: lemme know if it's good for you, and in case you prefer to
> send it yourself (since you proposed it on IRC), fine by me!
> 
> Paul: kept your ACK (thanks for that BTW) even though I changed the
> place of cond_resched() to align with Steve's preference. Lemme know
> in case you want to drop this ACK.
> 
> Cheers,
> 
> Guilherme
> 
> 
> [0] https://lore.kernel.org/lkml/1ef5fe19-a82f-835e-fda5-455e9c2b94b4@igalia.com/
> 
> 
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 7dc023641bf1..80639bdb85f6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4192,6 +4192,7 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
>  			}
>  			found = 1;
>  		}
> +		cond_resched();
>  	} while_for_each_ftrace_rec();
>   out_unlock:
>  	mutex_unlock(&ftrace_lock);
> -- 
> 2.38.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
