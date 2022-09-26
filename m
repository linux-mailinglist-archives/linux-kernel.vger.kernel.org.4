Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637ED5EB2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiIZUye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIZUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:54:31 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783EBADCE3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:54:29 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f26so4890020qto.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SYcT1rV/1jZbevK5XYC8lgj9qZdaL9Tq6lN4XyA7Y6g=;
        b=T3dcmYNaFNZK9eugDpgmC2YRaJW08em2U2+64ie4ZP7wkq6HRe3FiMUFjkQ8PbgLNH
         l0jM4v55TLGydlGsYAoKo37NQkSnlbs8S5HtmAcnSn7HYDvYGYvXWgRCBSgQCz4ZrQgV
         EQ5/sejVpkjrNayKBkNrEUyjX3HTUSbJO7hXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SYcT1rV/1jZbevK5XYC8lgj9qZdaL9Tq6lN4XyA7Y6g=;
        b=bZHzjw/bfWPse91xed0kGhXsRCquzAuP34hUtzerwSFFbf8Yg5dyr+DWYJaMstPp+u
         mvSN+9ZtUQtXImb5/P7naje4QaYRyssaaMWnJ8v2vuK0hpBwvo90h9D0FGr3mILlEgjo
         RAw7RVaxds2XUbL3CvRdBiNswp0Y+iO/cJ8GvChcd226NsEKisUHit9tP9Zzmc9SDmX/
         sniexMXUNPWm6bzn23kg/ndOaphK+tar/1502RbJZ7GzdcqrsgrpQzOh9UqMwj2T5W64
         fkygvR/eNUjssJYCfMjfMLA/lLNYMYzcC7OfYXqDQI11nOAJU7j/og/+1cAQcUTKrE4R
         Qodw==
X-Gm-Message-State: ACrzQf3tVof9lRrmthaJ/rJ1w/OZCs9ob8I4bHsmnCwt0k4CUYvEFxty
        bnjxMQ0iRAZ8UwvPpDoll7i3ZA==
X-Google-Smtp-Source: AMsMyM7G0pRcZPz+mZWQc8TJ4JVQ6CC0CMNgIcoLOwg5Pa52lPOoBS68DTYzk93SnWQbVB8RazmJDA==
X-Received: by 2002:ac8:5f0a:0:b0:35a:6fa8:23c4 with SMTP id x10-20020ac85f0a000000b0035a6fa823c4mr19644402qta.312.1664225668537;
        Mon, 26 Sep 2022 13:54:28 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id l27-20020a37f91b000000b006ce580c2663sm12229090qkj.35.2022.09.26.13.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:54:28 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:54:27 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzIRg2u2JYXN9bnK@google.com>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <YzH/646RHxhHBy6+@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzH/646RHxhHBy6+@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vlad,

On Mon, Sep 26, 2022 at 09:39:23PM +0200, Uladzislau Rezki wrote:
[...]
> > > On my KVM machine the boot time is affected:
> > > 
> > > <snip>
> > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > [  105.740109] random: crng init done
> > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > <snip>
> > > 
> > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > be waiting for "RCU" in a sync way.
> > 
> > I was wondering if you can compare boot logs and see which timestamp does the
> > slow down start from. That way, we can narrow down the callback. Also another
> > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > ftrace_dump_on_oops" to the boot params, and then manually call
> > "tracing_off(); panic();" from the code at the first printk that seems off in
> > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > output to see what were the last callbacks that was queued/invoked.

Would you be willing to try these steps? Meanwhile I will try on my side as
well with the .config you sent me in another email.

> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 08605ce7379d..40ae36904825 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> > > >  
> > > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > > >  
> > > > +#ifdef CONFIG_RCU_LAZY
> > > > +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > > > +#else
> > > > +static inline void call_rcu_flush(struct rcu_head *head,
> > > > +		rcu_callback_t func) {  call_rcu(head, func); }
> > > > +#endif
> > > > +
> > > >  /* Internal to kernel */
> > > >  void rcu_init(void);
> > > >  extern int rcu_scheduler_active;
> > > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > > index f53ad63b2bc6..edd632e68497 100644
> > > > --- a/kernel/rcu/Kconfig
> > > > +++ b/kernel/rcu/Kconfig
> > > > @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> > > >  	  Say N here if you hate read-side memory barriers.
> > > >  	  Take the default if you are unsure.
> > > >  
> > > > +config RCU_LAZY
> > > > +	bool "RCU callback lazy invocation functionality"
> > > > +	depends on RCU_NOCB_CPU
> > > > +	default n
> > > > +	help
> > > > +	  To save power, batch RCU callbacks and flush after delay, memory
> > > > +	  pressure or callback list growing too big.
> > > > +
> > > >
> > > Do you think you need this kernel option? Can we just consider and make
> > > it a run-time configurable? For example much more users will give it a try,
> > > so it will increase a coverage. By default it can be off.
> > > 
> > > Also you do not need to do:
> > > 
> > > #ifdef LAZY
> > 
> > How does the "LAZY" macro end up being runtime-configurable? That's static /
> > compile time. Did I miss something?
> > 
> I am talking about removing if:
> 
> config RCU_LAZY
> 
> we might run into issues related to run-time switching though.

When we started off, Paul said he wanted it kernel CONFIGurable. I will defer
to Paul on a decision for that. I prefer kernel CONFIG so people don't forget
to pass a boot param.

thanks,

 - Joel

