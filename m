Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B6D5E9508
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIYRrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiIYRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:46:56 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CC23BDD
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:46:55 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g12so2951267qts.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8jE96hogZR+NquxzuPoUFyq87wtmzQSELzXQTPSQhSs=;
        b=epLVXpG2/zy7Qon/++OSH0d1HDaGjKoWhpyLmAKTQQ/Fk1pd5tw6wNb1s2/Gmdl6rw
         Dz0fslVf2SO/vVP+GsqszF4a4FRv9pn70FC4yjd0BhYSZr7xwYr6PGkG3VtmdFj0HCxB
         Edwysi4GYOugxwljAWRwWT3NzSv7tvL4ofUGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8jE96hogZR+NquxzuPoUFyq87wtmzQSELzXQTPSQhSs=;
        b=m5aMFjbbLVg1kqMZz0CneCvZWffwelBnmCjw16nHi3MXm7EZNV1fsbzQO0pszJPlW8
         k25PqLu9sFBbRBecJib4nKP32KXWf29BiVz5VBsG8hrtpSH1J8ahL4rm94y22+rDWWCI
         WpXFRjdklMxxWvK4kdmLp2bjDZn2WIczrFtW/ktVwHlwbikH6spkAYGUBdYM7XSpVwqL
         wOmP8HQsoMsIh2dcDzvQ0mQZiCyw5hClQzwMviu380Rnfx0T4t2qBc5sq+1pXnMyMQSS
         pJw7JNYo5k8W2j70Y6YJqzkk9qggkPrgdLAXHl+NQgptjIKvkaXrAqeUEMtS97hIl//5
         WjTQ==
X-Gm-Message-State: ACrzQf15FCd+c28wyvLWe3AJSDOdcdmUNuBoiR4WxK44Eti16YN02YpT
        p4us3KEHsal96/V/mtWenjXN6g==
X-Google-Smtp-Source: AMsMyM48SFlUti6V6oANMuQ2XTQDcP59hkQJw62s0fw6lIIkGZVsbHvXEfQ6mrCMwisO1ctjs+9z9A==
X-Received: by 2002:a05:622a:491:b0:35d:acd:d855 with SMTP id p17-20020a05622a049100b0035d0acdd855mr15118353qtx.143.1664128014323;
        Sun, 25 Sep 2022 10:46:54 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006cede93c765sm10443329qkn.28.2022.09.25.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:46:53 -0700 (PDT)
Date:   Sun, 25 Sep 2022 17:46:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzCUDXn3htWbqM4f@google.com>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzAX5kOwjrZzoed6@pc636>
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

On Sun, Sep 25, 2022 at 10:57:10AM +0200, Uladzislau Rezki wrote:
> > Implement timer-based RCU lazy callback batching. The batch is flushed
> > whenever a certain amount of time has passed, or the batch on a
> > particular CPU grows too big. Also memory pressure will flush it in a
> > future patch.
> > 
> > To handle several corner cases automagically (such as rcu_barrier() and
> > hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> > length has the lazy CB length included in it. A separate lazy CB length
> > counter is also introduced to keep track of the number of lazy CBs.
> > 
> > v5->v6:
> > 
> > [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
> >   deferral levels wake much earlier so for those it is not needed. ]
> > 
> > [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> > 
> > [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> > 
> > [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> > 
> > [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> > 
> > [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> > 
> I think it make sense to add some data to the commit message
> illustrating what this patch does.

Sure, will do!

> From my side i gave a try of this patch on my setup. Some data:
> 
> <snip>
> root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_v6.script | sort -nk 6 | grep rcu
> name:                       rcuop/23 pid:        184 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/26 pid:        206 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/29 pid:        227 woken-up     1     interval: min     0     max     0       avg     0
> name:                        rcuop/2 pid:         35 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/34 pid:        263 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/35 pid:        270 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/36 pid:        277 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/37 pid:        284 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/38 pid:        291 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/49 pid:        370 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/59 pid:        441 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/63 pid:        469 woken-up     1     interval: min     0     max     0       avg     0
> name:                        rcuog/0 pid:         16 woken-up     2     interval: min  8034     max  8034       avg  4017
> name:                       rcuog/24 pid:        191 woken-up     2     interval: min  7941     max  7941       avg  3970
> name:                       rcuog/32 pid:        248 woken-up     2     interval: min  7542     max  7542       avg  3771
> name:                       rcuog/48 pid:        362 woken-up     2     interval: min  8065     max  8065       avg  4032
> name:                       rcuog/56 pid:        419 woken-up     2     interval: min  8076     max  8076       avg  4038
> name:                       rcuop/21 pid:        170 woken-up     2     interval: min 13311438  max 13311438    avg 6655719
> name:                       rcuog/16 pid:        134 woken-up     4     interval: min  8029     max 13303387    avg 3329863
> name:                        rcuop/9 pid:         85 woken-up     4     interval: min 10007570  max 10007586    avg 7505684
> name:                        rcuog/8 pid:         77 woken-up     8     interval: min  6240     max 10001242    avg 3753622
> name:                    rcu_preempt pid:         15 woken-up    18     interval: min  6058     max 9999713     avg 2140788
> name:                     test_rcu/0 pid:       1411 woken-up 10003     interval: min   165     max 19072       avg  4275
> root@pc638:/home/urezki/rcu_v6#
> 
> root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_default.script | sort -nk 6 | grep rcu
> name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuop/51 pid:        384 woken-up     1     interval: min     0     max     0       avg     0
> name:                       rcuog/32 pid:        248 woken-up     2     interval: min 11927     max 11927       avg  5963
> name:                       rcuop/63 pid:        469 woken-up     2     interval: min 23963     max 23963       avg 11981
> name:                       rcuog/56 pid:        419 woken-up     3     interval: min 11132     max 23967       avg 11699
> name:                       rcuop/50 pid:        377 woken-up     3     interval: min  8057     max 4944344     avg 1650800
> name:                       rcuog/48 pid:        362 woken-up     8     interval: min  2712     max 37430015    avg 5298801
> name:                       rcuop/16 pid:        135 woken-up  4790     interval: min  7340     max 16649       avg  8843
> name:                       rcuog/16 pid:        134 woken-up  4792     interval: min  7368     max 16644       avg  8844
> name:                    rcu_preempt pid:         15 woken-up  5302     interval: min    26     max 12179       avg  7994
> name:                     test_rcu/0 pid:       1353 woken-up 10003     interval: min   169     max 18508       avg  4236
> root@pc638:/home/urezki/rcu_v6#
> <snip>
> 
> so it is obvious that the patch does the job.

Thanks a lot for testing!

> On my KVM machine the boot time is affected:
> 
> <snip>
> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [  104.115418] process '/usr/bin/fstype' started with executable stack
> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> [  104.340193] systemd[1]: Detected virtualization kvm.
> [  104.340196] systemd[1]: Detected architecture x86-64.
> [  104.359032] systemd[1]: Set hostname to <pc638>.
> [  105.740109] random: crng init done
> [  105.741267] systemd[1]: Reached target Remote File Systems.
> <snip>
> 
> 2 - 11 and second delay is between 32 - 104. So there are still users which must
> be waiting for "RCU" in a sync way.

I was wondering if you can compare boot logs and see which timestamp does the
slow down start from. That way, we can narrow down the callback. Also another
idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
ftrace_dump_on_oops" to the boot params, and then manually call
"tracing_off(); panic();" from the code at the first printk that seems off in
your comparison of good vs bad. For example, if "crng init done" timestamp is
off, put the "tracing_off(); panic();" there. Then grab the serial console
output to see what were the last callbacks that was queued/invoked.

> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 08605ce7379d..40ae36904825 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> >  
> >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> >  
> > +#ifdef CONFIG_RCU_LAZY
> > +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> > +#else
> > +static inline void call_rcu_flush(struct rcu_head *head,
> > +		rcu_callback_t func) {  call_rcu(head, func); }
> > +#endif
> > +
> >  /* Internal to kernel */
> >  void rcu_init(void);
> >  extern int rcu_scheduler_active;
> > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > index f53ad63b2bc6..edd632e68497 100644
> > --- a/kernel/rcu/Kconfig
> > +++ b/kernel/rcu/Kconfig
> > @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> >  	  Say N here if you hate read-side memory barriers.
> >  	  Take the default if you are unsure.
> >  
> > +config RCU_LAZY
> > +	bool "RCU callback lazy invocation functionality"
> > +	depends on RCU_NOCB_CPU
> > +	default n
> > +	help
> > +	  To save power, batch RCU callbacks and flush after delay, memory
> > +	  pressure or callback list growing too big.
> > +
> >
> Do you think you need this kernel option? Can we just consider and make
> it a run-time configurable? For example much more users will give it a try,
> so it will increase a coverage. By default it can be off.
> 
> Also you do not need to do:
> 
> #ifdef LAZY

How does the "LAZY" macro end up being runtime-configurable? That's static /
compile time. Did I miss something?

> ...
> #else
> ...
> #endif
> 
> >  
> > +/*
> > + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> > + * can elapse before lazy callbacks are flushed. Lazy callbacks
> > + * could be flushed much earlier for a number of other reasons
> > + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> > + * left unsubmitted to RCU after those many jiffies.
> > + */
> > +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> > +static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
> Make it configurable? I do not think you actually need 10 seconds here.
> Reducing it will reduce a possibility to hit a low memory condition. 1
> second would be far enough i think.

Hmm, I can make the delay configurable but for now I'll keep this as default
as all of our power testing has been done with that and I don't want risk
losing the optimization.

Honestly, I am not worried too about memory pressure as we have a shrinker
which triggers flushes on the slightest hint of memory pressure. If it is not
handling it properly, then we need to fix the shrinker.

thanks,

 - Joel

