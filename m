Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9052E6F839D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjEENPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjEENPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:15:12 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78BD1E98B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683292508;
        bh=tOiJ6zUW61cuEA7/jkY0uY1HvKlP4bmAuj7fVSfP534=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WrQsH6Q499vLW0wlKpHbAzGhoazcem/MAdA7RBNlIdLiOv6xLsDAKGWoAZa9T+xnF
         UJheN7u77WC2iHEE4DCZCp9tKVYHPZafBV7hjIeL/TYmxYK+B+RmVAVfFLojORS8cD
         Xku5oKyDNRP2UzCgBf2KyGohIh+k2jbtiyo8h5lJma/ezZ8oXQ414SFLSK3DPHuibj
         MGKW1lYKZCo4V5IKFHO02rZjBgHBunthauuATYgspz13uP4qUEmLbNqluOefbMH6U6
         nKb/aPr+ANC5C4M4olIMJta7ElBGlbnnJEWxusa+91T1LU60SjCT6N/EkwHlQLN0de
         AiOj0k+1pT9SQ==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QCWPm31plz11HQ;
        Fri,  5 May 2023 09:15:08 -0400 (EDT)
Message-ID: <34b873b0-93e5-d492-9c30-9d6b5c022ace@efficios.com>
Date:   Fri, 5 May 2023 09:15:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH] rcu: rcupdate.h: Add missing parentheses around macro
 pointer dereference
Content-Language: en-US
To:     paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
References: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
 <20230503180640.630f3006@gandalf.local.home>
 <5b102a66-f88c-4a77-887e-1b41f8064454@paulmck-laptop>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <5b102a66-f88c-4a77-887e-1b41f8064454@paulmck-laptop>
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

On 2023-05-04 20:28, Paul E. McKenney wrote:
> On Wed, May 03, 2023 at 06:06:40PM -0400, Steven Rostedt wrote:
>> On Wed,  3 May 2023 16:32:36 -0400
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>> linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
>>>
>>>    typeof(*p)
>>>
>>> rather than
>>>
>>>    typeof(*(p))
>>>
>>> The following test-case shows how it can generate confusion due to C
>>> operator precedence being reversed compared to the expectations:
>>>
>>>      #define m(p) \
>>>      do { \
>>>              __typeof__(*p) v = 0; \
>>>      } while (0)
>>>
>>>      void fct(unsigned long long *p1)
>>>      {
>>>              m(p1 + 1);      /* works */
>>>              m(1 + p1);      /* broken */
>>>      }
>>>
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>>> Cc: Joel Fernandes <joel@joelfernandes.org>
>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>>> Cc: Zqiang <qiang1.zhang@intel.com>
>>> ---
>>>   include/linux/rcupdate.h | 18 +++++++++---------
>>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>> index dcd2cf1e8326..1565012fa47f 100644
>>> --- a/include/linux/rcupdate.h
>>> +++ b/include/linux/rcupdate.h
>>> @@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
>>>   
>>>   #ifdef __CHECKER__
>>>   #define rcu_check_sparse(p, space) \
>>> -	((void)(((typeof(*p) space *)p) == p))
>>> +	((void)(((typeof(*(p)) space *)p) == p))
>>
>> Hmm, should we have that be:
>> 	((void)(((typeof(*(p)) space *)(p)) == (p)))
>>
>> In case of the 1 + p1, which would end up as:
>>
>> 	((void)(((typeof(*(1 + p1)) __rcu *)1 + p1 == 1 + p1;
>>
>> I don't know how that __rcu get's passed around via the + statement there,
>> so it may be fine. May not even make sense to have that. But I like to
>> error on more parenthesis. ;-)
>>
>> The rest looks fine.
>>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Thank you all!  I applied Steve's suggested change with attribution
> as shown below.  Please let me know if I messed anything up.

Hi Paul,

I've done a new version of that patch which fixes other issues in 
rcupdate.h in the next round. Can you hold merging this until I remove 
the "RFC PATCH" tag please ? My goal is to gather feedback first to make 
sure everyone is OK with the overall changes across headers, so 
everything can become consistent.

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit d3d734216c88fb7c13205dc62178ff5011da415b
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed May 3 16:32:36 2023 -0400
> 
>      rcu: Add missing parentheses around rcu_dereference() "p" parameter
>      
>      linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
>      
>        typeof(*p)
>      
>      rather than
>      
>        typeof(*(p))
>      
>      The following test-case shows how it can generate confusion due to C
>      operator precedence being reversed compared to the expectations:
>      
>          #define m(p) \
>          do { \
>                  __typeof__(*p) v = 0; \
>          } while (0)
>      
>          void fct(unsigned long long *p1)
>          {
>                  m(p1 + 1);      /* works */
>                  m(1 + p1);      /* broken */
>          }
>      
>      [ paulmck: Apply Steve Rostedt additional () feedback. ]
>      
>      Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>      Cc: "Paul E. McKenney" <paulmck@kernel.org>
>      Cc: Joel Fernandes <joel@joelfernandes.org>
>      Cc: Josh Triplett <josh@joshtriplett.org>
>      Cc: Boqun Feng <boqun.feng@gmail.com>
>      Cc: Steven Rostedt <rostedt@goodmis.org>
>      Cc: Lai Jiangshan <jiangshanlai@gmail.com>
>      Cc: Zqiang <qiang1.zhang@intel.com>
>      Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>      Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>      Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index ddd42efc6224..cb938a89a923 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -405,16 +405,16 @@ static inline void rcu_preempt_sleep_check(void) { }
>   
>   #ifdef __CHECKER__
>   #define rcu_check_sparse(p, space) \
> -	((void)(((typeof(*p) space *)p) == p))
> +	((void)(((typeof(*(p)) space *)(p)) == (p)))
>   #else /* #ifdef __CHECKER__ */
>   #define rcu_check_sparse(p, space)
>   #endif /* #else #ifdef __CHECKER__ */
>   
>   #define __unrcu_pointer(p, local)					\
>   ({									\
> -	typeof(*p) *local = (typeof(*p) *__force)(p);			\
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)(p);		\
>   	rcu_check_sparse(p, __rcu);					\
> -	((typeof(*p) __force __kernel *)(local)); 			\
> +	((typeof(*(p)) __force __kernel *)(local));			\
>   })
>   /**
>    * unrcu_pointer - mark a pointer as not being RCU protected
> @@ -427,29 +427,29 @@ static inline void rcu_preempt_sleep_check(void) { }
>   
>   #define __rcu_access_pointer(p, local, space) \
>   ({ \
> -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
>   	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>   })
>   #define __rcu_dereference_check(p, local, c, space) \
>   ({ \
>   	/* Dependency order vs. p above. */ \
> -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
>   	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
>   	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>   })
>   #define __rcu_dereference_protected(p, local, c, space) \
>   ({ \
>   	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
>   	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(p)); \
> +	((typeof(*(p)) __force __kernel *)(p)); \
>   })
>   #define __rcu_dereference_raw(p, local) \
>   ({ \
>   	/* Dependency order vs. p above. */ \
>   	typeof(p) local = READ_ONCE(p); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>   })
>   #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

