Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E74A6F8465
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjEEN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEEN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:56:39 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ACA173A;
        Fri,  5 May 2023 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683294997;
        bh=5M9k0bwdHPjNHyq3O6a+ixC/79M0N+oL/NNP1rCMNhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QzML2CJCDJtpNDL7aCQiroYEnfxHuhTq1zlGVsB0pQqYSnrAKaux0BkX6/PgieYge
         0IasiXzaSXA3201HxcQenQY9HO5niHFnV2hmqa2YNQ3uZVReUo2J+eoTGPpqnT9MJz
         q9v0alUkhHxLf6xpKJ/ss3RxXGQ2iHmf+fdvj/6aWvGqgOaE45j+Xz/vPT83Agypy8
         FmoSSpwmpl9XCol4/o/wg5ZXexLmWIbGFjdk+0qe6uSy984U4LsVHn8yKtcmbns6rH
         TONatvpYJnP9gVfG4NjLBIrZMtMIWCrJmYPlJhC0sR7UIrIH2ZiZ+pbIRMkjsEhdD2
         yfVoLK3C9yJFw==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QCXKd4f08z120s;
        Fri,  5 May 2023 09:56:37 -0400 (EDT)
Message-ID: <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
Date:   Fri, 5 May 2023 09:56:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 16:05, Mathieu Desnoyers wrote:
> Fix the following macro parameter usage patterns in blk-mq.h for
> consistency, ensuring that operator precedence is respected:
> 
> Added parentheses:
[...]
> - "x = y" is changed for "x = (y)", because "y" can be an expression
>    containing a comma if it is the result of the expansion of a macro such
>    as #define eval(...) __VA_ARGS__, which would cause unexpected operator
>    precedence. This use-case is far-fetched, but we have to choose one
>    way or the other (with or without parentheses) for consistency.

[...]

>   include/linux/blk-mq.h | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 06caacd77ed6..4de6ad92530c 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -223,13 +223,13 @@ static inline unsigned short req_get_ioprio(struct request *req)
>   
>   #define rq_list_add(listptr, rq)	do {		\
>   	(rq)->rq_next = *(listptr);			\
> -	*(listptr) = rq;				\
> +	*(listptr) = (rq);				\
>   } while (0)
> 

Linus,

Which way do we want to go with respect to the rvalue of the assignment 
operator "=" in a macro ? (with or without parentheses)

In short:

#define m(x) do { z = (x); } while (0)

or

#define m(x) do { z = x; } while (0)

?

Given that "=" has the lowest operator precedence just above comma, and 
its associativity is right-to-left, I suspect the only use that would 
break it without the extra parentheses around "x" is:

#define eval(...) __VA_ARGS__
#define m(x) do { z = x; } while (0)

m(eval(1, abc))

Which generates the following C code after preprocessing:

do { z = 1, abc; } while (0)

which ends up expanding the comma within the rvalue. But this use-case 
is a bit far-fetched, so I don't know if we want to require the 
parentheses or not.

And if we decide that we do want to require the parentheses around the 
"x" parameter in the "=" rvalue, then this means we have to consider 
whether we want to require parentheses around the macro arguments used 
as function/macro arguments, e.g.:

#define eval(...) __VA_ARGS__
#define m(x)    f(x)

m(eval(1, abc));

Which generates the following C code after preprocessing:

f(1, abc);

If we want to be consistent, I suspect we want to require the same for 
both use-cases ("=" rvalue and function/macro parameters).

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

