Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12B7135DF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 19:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjE0RWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjE0RWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 13:22:02 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DEBD;
        Sat, 27 May 2023 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685208118;
        bh=5XMvPQIAG4VKqcOFjJ+4yenaaFoxa0cRI511fqDm5UY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AFELtOBKHt01Mq28TK/qi4+iHw8bdHZ8Lnu57iQc47QxW9+CaiAlURKJYPHwQ3pfR
         vGh3Brz91qjpMjxHPt6olHY0AM986BYtLbGm8gRs+CxxZNlwzHLZJFxE5h1NfTZaDD
         vIxUeK/0OJ2v+jz2fP9t8g1ixoiVywQ3f3F2haB2gsnhUIiFmOqBEksKZVCbZzjEmi
         y/q+/6+O3YAiOumms1C4YLPQAMqnlaLLEUlJfAzdZEg196N8qLpMQFwQMWXhemeJLT
         57De5rbEvIDF9AWj0wah2KEuOoXYNmcJlbuOzvJ6a2K97uL6F4jTI5lPdnR/XbzsIL
         B7wD3P7NbihxA==
Received: from [192.168.18.28] (unknown [198.16.212.139])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QT7rP6XnYz162G;
        Sat, 27 May 2023 13:21:57 -0400 (EDT)
Message-ID: <8b08772b-a69c-1f00-a43f-afcc5861ab4e@efficios.com>
Date:   Sat, 27 May 2023 13:21:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
References: <20230526205204.861311518@infradead.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230526205204.861311518@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 16:52, Peter Zijlstra wrote:
> By popular demand, a new and improved version :-)
> 
> New since -v1 ( https://lkml.kernel.org/r/20230526150549.250372621@infradead.org )
> 
>   - much improved interface for lock guards: guard() and scoped () { }
>     as suggested by Linus.

<name bikeshedding>

I know I'm the one who hinted at C++ "std::scoped_lock" as a similar 
preexisting API, but I find that "scoped()" is weird in the newly 
proposed form. "scoped_lock" is fine considering that "scoped" is an 
adjective applying to "lock", but in the case of e.g. scoped(rcu) { }, 
then we are really declaring a "scope" of type "rcu". I suspect that in 
this case:

scope(rcu) { }

would be less unexpected than the adjective form:

scoped(rcu) { }

Especially if we go for the name "guard()", rather than the adjective 
guarded(), for its counterpart.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

