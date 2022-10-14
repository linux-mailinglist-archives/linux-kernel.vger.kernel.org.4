Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEE85FF66E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJNWpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJNWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:45:11 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83584303E2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:45:06 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a24so4593640qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wTTtDn8bMgOHPumRgeVGmfS8E9BMHk34r0/6EY7HK8=;
        b=fn+Sp8nK+zHTUKEu0/UOyIV8lH0ubMxMGI8FTL8t5mvCB+3CKr1NLT6vcv/DeD3m4i
         OLauho6n3mQht+QrGQYmub8EAOQ9IaNXNv9qRXNIyZbKaGkLg7xmxDR3qEywUr3puL3x
         g2MNZOtpJz0kIpWQup/tJynHBWGi/gjSQAWU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wTTtDn8bMgOHPumRgeVGmfS8E9BMHk34r0/6EY7HK8=;
        b=Dp0LLXa7FR8WHGUgiIfYphVPsWzt472OvzjDLGtniCB/W5eqvbS3JnSg0eeWiw85P1
         UBGAZhUY2+fg+g+6dLi9crGe921qVo8skRWkY0zSmCmQS+sryuUQnTHuWEc+D1IAI223
         siThNjYnXhG1UGLul8kif0pWPU72ZzZpTNf1E9qYb/3hClkFuX/UK+vLPx8Y7Tkn+wkL
         ic2zFti87uNwRjNK5rLNseBaMooCfmGKZQWCWOR27PDp1bYo9gpKexE3P52gFekQIYHc
         YEi1s62ZUHFKe8bzFp2lIylUIUoPFJXmcuQf6C+WAHDdQ2xhZGlqxKBxTUVYptM3dwdi
         xlUg==
X-Gm-Message-State: ACrzQf141gcPFsihoF5IfhhELRSQi6/BkoYyXGwnv66L8Z7fF/l4s3SR
        o2f7SqmcoYzgssr95HpV44kKVyDCphKqvA==
X-Google-Smtp-Source: AMsMyM7v6wQZQjuv6d1fxvAxCjL/mv6dq9FXoigfgcYIsjgQwKkCjnv8TIlfaW5n7AjTBf7wXbWWmQ==
X-Received: by 2002:ac8:59c1:0:b0:39c:d5c3:6859 with SMTP id f1-20020ac859c1000000b0039cd5c36859mr61103qtf.230.1665787505654;
        Fri, 14 Oct 2022 15:45:05 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bc10-20020a05622a1cca00b0039ccd7a0e10sm2856195qtb.62.2022.10.14.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 15:45:05 -0700 (PDT)
Date:   Fri, 14 Oct 2022 22:45:04 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, quic_neeraju@quicinc.com,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/3] srcu: Warn when NMI-unsafe API is used in NMI
Message-ID: <Y0nmcH0SktDdonyW@google.com>
References: <20221013172244.1099010-1-frederic@kernel.org>
 <20221013172244.1099010-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013172244.1099010-2-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 07:22:42PM +0200, Frederic Weisbecker wrote:
> Using the NMI-unsafe reader API from within NMIs is very likely to be
> buggy for three reasons:
> 
> 1) NMIs aren't strictly re-entrant (a pending nested NMI will execute
>    at the end of the current one) so it should be fine to use a
>    non-atomic increment here. However breakpoints can still interrupt
>    NMIs and if a breakpoint callback has a reader on that same ssp, a
>    racy increment can happen.
> 
> 2) If the only reader site for a given ssp is in an NMI, RCU is definetly
								  definitely
>    a better choice over SRCU.

Just checking - because NMI are by definition not-preemptibe, so SRCU over
RCU doesn't make much sense right?

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> 3) Because of the previous reason (2), an ssp having an SRCU read side
>    critical section in an NMI is likely to have another one from a task
>    context.
> 
> For all these reasons, warn if an nmi unsafe reader API is used from an
> NMI.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/srcutree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c54142374793..8b7ef1031d89 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -642,6 +642,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
>  
>  	if (!IS_ENABLED(CONFIG_PROVE_RCU))
>  		return;
> +	/* NMI-unsafe use in NMI is a bad sign */
> +	WARN_ON_ONCE(!nmi_safe && in_nmi());
>  	sdp = raw_cpu_ptr(ssp->sda);
>  	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
>  	if (!old_nmi_safe_mask) {
> -- 
> 2.25.1
> 
