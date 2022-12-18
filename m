Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325956504AB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 21:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiLRU4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLRU4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 15:56:49 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B462D67;
        Sun, 18 Dec 2022 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671397005;
        bh=oWdW2jkZe4raUuGf80B4/zbCbKlnHF22B6LFBy+dTJE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ITBYIiCleOPPN21wQgH96+iJOOcMZNLIVYI5GqaqDe6yGsmjayX0KmiDBhfh32LLs
         MXOFE7GXWGLSrYCDIHYm6F3a07Mzoz/Q2tOSyu3ZUfzbOprYavX+GGJr6J9Ea89e/v
         voE1vOtDaQy1exPeDAyWmkvuMb0t9JH4Jp05BJq7QRrZUZVXlVp18KuHm/tFdTo5Qb
         35Q/B5tnD3pPsDdXKt6ZeVGkxYontSfSvV+JIHtcn50TgMqLqvKCVmmduVl3LaynJi
         Yr3thFZH4jH4LfBQAXKDdeG0ON0/a5/BJHZzq13zBDoOFMY2xCWXMIeXMgSB1t5RG9
         TJZGfcmckywBw==
Received: from [10.1.0.203] (192-222-188-69.qc.cable.ebox.net [192.222.188.69])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NZwB46JQMzbnX;
        Sun, 18 Dec 2022 15:56:44 -0500 (EST)
Message-ID: <589da7c9-5fb7-5f6f-db88-ca464987997e@efficios.com>
Date:   Sun, 18 Dec 2022 15:57:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20221218191310.130904-1-joel@joelfernandes.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221218191310.130904-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-18 14:13, Joel Fernandes (Google) wrote:
> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> can say to remove it, other than the possibility that it is unnecessary, is to
> not have extra code that does not help. However, since we are issuing a fully
> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
> 
> For this reason, please consider these patches as "informational", than a
> "please merge". :-) Though, feel free to consider merging if you agree!
> 
> All SRCU scenarios pass with these, with 6 hours of testing.

Hi Joel,

Please have a look at the comments in my side-rcu implementation [1, 2]. 
It is similar to what SRCU does (per-cpu counter based grace period 
tracking), but implemented for userspace. The comments explain why this 
works without the memory barrier you identify as useless in SRCU.

Following my implementation of side-rcu, I reviewed the SRCU comments 
and identified that the barrier "/* E */" appears to be useless. I even 
discussed this privately with Paul E. McKenney.

My implementation and comments go further though, and skip the period 
"flip" entirely if the first pass observes that all readers (in both 
periods) are quiescent.

The most relevant comment in side-rcu is:

  * The grace period completes when it observes that there are no active
  * readers within each of the periods.
  *
  * The active_readers state is initially true for each period, until the
  * grace period observes that no readers are present for each given
  * period, at which point the active_readers state becomes false.

So I agree with the clarifications you propose here, but I think we can 
improve the grace period implementation further by clarifying the SRCU 
grace period model.

Thanks,

Mathieu


[1] https://github.com/efficios/libside/blob/master/src/rcu.h
[2] https://github.com/efficios/libside/blob/master/src/rcu.c

> 
> thanks,
> 
>   - Joel
> 
> Joel Fernandes (Google) (2):
> srcu: Remove comment about prior read lock counts
> srcu: Remove memory barrier "E" as it is not required
> 
> kernel/rcu/srcutree.c | 10 ----------
> 1 file changed, 10 deletions(-)
> 
> --
> 2.39.0.314.g84b9a713c41-goog
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

