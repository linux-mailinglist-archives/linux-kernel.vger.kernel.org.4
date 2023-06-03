Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FA720CFA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbjFCBXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjFCBXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:23:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367561AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:23:40 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6259c242c96so24106126d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685755419; x=1688347419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1BLmFCKytW9ZYVm+ndzJiXX+MhplDDGBVFny/CzIpE=;
        b=JV3AUE7PyR3YjCdaAxSZDCOjQYUynkpk49ctuBKzEdwUn1nj0WgVLEwevCaL86pe1d
         2u+Amlra+y+EJ0XNvJbHGPXZukJH7aDS4eApEwEh5or0W+nZmZJKb2agXsI8RP3wRiCT
         gtuIfd4hlpASfCKlg6gEaEjVdofApXe3cLG2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755419; x=1688347419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1BLmFCKytW9ZYVm+ndzJiXX+MhplDDGBVFny/CzIpE=;
        b=jNOSbJjgUObW+OZdbbR0FV3m1mhtEG00DEXl0InsLHRerJUzjXmOedbwmwN9j8QOYh
         OCIqYZzfdU+8WO0W4lyjFXnljQoqFDKNoibK3DDYM8nENYiD5TpsFCY+3+taWJG0J4hU
         HtbwuCPVYtyvB9D1JcIx3JV+gGaqCCXJiyVfhBZg0BRBG8w8+4fmVDIEcpx/cHMO4Jqg
         HDo5/2NhStQeAxh0hWcv5TSt0aCKnJMQU+rg1x5ykEIayjMW8UDqbC7+lB50wLqk65hn
         RgutRmX9R503gS7TIGAhzOB+YabEu9bfVd+1nWY0d5xfSQghhur3R5COGfP0/XOq6QBD
         kIyA==
X-Gm-Message-State: AC+VfDweGuIQGT84qZwVpRY5DhAKGNJvMlguY9sI+ItMNXue51v476Wl
        5C8HggAPtS9uQdD/92IbWX2XDA==
X-Google-Smtp-Source: ACHHUZ6UnhYU5u1nrUcucEeqhz6VZj3zOUwepg05ZdXmSS8lXFTQ5rbCB8l6SQKzaSNo+JgB64fBAw==
X-Received: by 2002:a05:6214:124b:b0:628:49c5:d755 with SMTP id r11-20020a056214124b00b0062849c5d755mr198419qvv.50.1685755419286;
        Fri, 02 Jun 2023 18:23:39 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id he31-20020a05622a601f00b003e394714c07sm1487081qtb.10.2023.06.02.18.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:23:38 -0700 (PDT)
Date:   Sat, 3 Jun 2023 01:23:38 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: Re: [PATCH 4/9] rcu: Introduce lazy queue's own qhimark
Message-ID: <20230603012338.GA2795276@google.com>
References: <20230531101736.12981-1-frederic@kernel.org>
 <20230531101736.12981-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101736.12981-5-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:17:31PM +0200, Frederic Weisbecker wrote:
> The lazy and the regular bypass queues share the same thresholds in
> terms of number of callbacks after which a flush to the main list is
> performed: 10 000 callbacks.
> 
> However lazy and regular bypass don't have the same purposes and neither
> should their respective thresholds:
> 
> * The bypass queue stands for relieving the main queue in case of a
>   callback storm. It makes sense to allow a high number of callbacks to
>   pile up before flushing to the main queue, especially as the life
>   cycle for this queue is very short (1 jiffy).

Sure.

> 
> * The lazy queue aims to spare wake ups and reduce the number of grace
>   periods. There it doesn't make sense to allow a huge number of
>   callbacks before flushing so as not to introduce memory pressure,
>   especially as the life cycle for this queue is very long (10
>   seconds).

It does make sense as we have a shrinker, and it is better to avoid RCU
disturbing the system unwantedly when there's lots of memory lying around.

> 
> For those reasons, set the default threshold for the lazy queue to
> 100.

I am OK with splitting the qhimark, but this lazy default is too low. In
typical workloads on ChromeOS, we see 1000s of callback even when CPU
utilization is low. So considering that, we would be flushing all the time.

Eventually I want the mm subsystem to tell us when flushing is needed so we
could flush sooner at that time if really needed, but for now we have a
shrinker so it should be OK. Is there a reason the shrinker does not work for
you?

thanks,

 - Joel


> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c      | 2 ++
>  kernel/rcu/tree_nocb.h | 9 ++++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bc4e7c9b51cb..9b98d87fa22e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -379,6 +379,8 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  static long blimit = DEFAULT_RCU_BLIMIT;
>  #define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
>  static long qhimark = DEFAULT_RCU_QHIMARK;
> +#define DEFAULT_RCU_QHIMARK_LAZY 100 // If this many pending, flush.
> +static long qhimark_lazy = DEFAULT_RCU_QHIMARK_LAZY;
>  #define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
>  static long qlowmark = DEFAULT_RCU_QLOMARK;
>  #define DEFAULT_RCU_QOVLD_MULT 2
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 8320eb77b58b..c08447db5a2e 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -480,10 +480,9 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  
>  	// If ->nocb_bypass has been used too long or is too full,
>  	// flush ->nocb_bypass to ->cblist.
> -	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
> -	    (ncbs &&  bypass_is_lazy &&
> -	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush))) ||
> -	    ncbs >= qhimark) {
> +	if (ncbs &&
> +	    ((!bypass_is_lazy && ((j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark)) ||
> +	     (bypass_is_lazy && (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) || ncbs >= qhimark_lazy)))) {
>  		rcu_nocb_lock(rdp);
>  		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
>  
> @@ -724,7 +723,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  
>  		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) ||
> -		     bypass_ncbs > 2 * qhimark)) {
> +		     bypass_ncbs > 2 * qhimark_lazy)) {
>  			flush_bypass = true;
>  		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> -- 
> 2.40.1
> 
