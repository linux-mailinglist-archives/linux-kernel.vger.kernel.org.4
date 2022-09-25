Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B315E91B9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 10:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIYI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIYI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 04:57:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6F27159;
        Sun, 25 Sep 2022 01:57:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a41so5349160edf.4;
        Sun, 25 Sep 2022 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=jv1R7uybFiFnN62T7LeT8cPnORSx0H4iaSe0cVM3ZAc=;
        b=IoHiRSEI45ReK4Rc1Gp5BhLE9lC7AAdkThWNuB+KTHyY4Ao1xIoZ3Dm7trmnHBDK+f
         XOtjJDHGekOJgev+g5CR5mRc0WPjD78ipcL6/GVyX3dHrMLo+NkDe9p5+ShWXtC7JlUv
         d1+8iUh35Jt2d2IOU+qEtHkXvEJxRt3vQDM6spFjx43dUyolii29wtDP7pr280e15V3N
         T44w0r1lXVZTWIN519AIO31pPHEF6SKx2GesW+DRwVuQ7rPpVpW+Mz0gcvBenAROE5GR
         vx7ckQPlwu/Jb8pDDaSWPmD28KauI9rnkhUHFmhgA5rrzmQCYq0/J4GXjUvc2/MvJDRl
         ocAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jv1R7uybFiFnN62T7LeT8cPnORSx0H4iaSe0cVM3ZAc=;
        b=3NMeTcwHmxvEAOC6YAs+YrOZrBnlyz06YD/eqzWRLP+CZK0TWOkwB5dTCxeETeVbjK
         PhjUJ0ccQVj2lDZQOi2/mrHyPOpb060+dLysMBKhlxOXHlXGM9LqNuYGY+6W5S9k+Eyt
         N9T/Mmgcs8lxWb6bXB965LE3VH6j9jZtLy5tn9mQTTytoSsYXV5L0WZiATJX6i1TWGK/
         mf+mIldh1zoQoonxoxslCPYSiaV4wSj+OfTIaDpLHxo32gQW9zHU8AcmNu5ICL/ICkHh
         BiENILFnh2DbFZOnBW9OqQPYnEMJ9qK4ATFayLmI06cKufgRiRSoRdVKldyAWrKWg6a2
         1lvg==
X-Gm-Message-State: ACrzQf0CtV4gk5g3Ljlmu/si/QfSyP0RpfvpgYqWOAePz6N6kHpogjER
        DpgP8YAOEpaE6rimHFjgzFVOShfqihKkDg==
X-Google-Smtp-Source: AMsMyM4gzw+hC15lHyjSL1+1L1SU81RfqzHecb657gJouuBR3aC92MVix4qStEknLCVcsofj41Gmvw==
X-Received: by 2002:aa7:d293:0:b0:457:65d:c0cb with SMTP id w19-20020aa7d293000000b00457065dc0cbmr5384303edq.25.1664096232886;
        Sun, 25 Sep 2022 01:57:12 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b00457171d1fffsm1802052edu.44.2022.09.25.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 01:57:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 25 Sep 2022 10:57:10 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzAX5kOwjrZzoed6@pc636>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922220104.2446868-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Implement timer-based RCU lazy callback batching. The batch is flushed
> whenever a certain amount of time has passed, or the batch on a
> particular CPU grows too big. Also memory pressure will flush it in a
> future patch.
> 
> To handle several corner cases automagically (such as rcu_barrier() and
> hotplug), we re-use bypass lists to handle lazy CBs. The bypass list
> length has the lazy CB length included in it. A separate lazy CB length
> counter is also introduced to keep track of the number of lazy CBs.
> 
> v5->v6:
> 
> [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
>   deferral levels wake much earlier so for those it is not needed. ]
> 
> [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
> 
> [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
> 
> [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
> 
> [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
> 
> [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
> 
I think it make sense to add some data to the commit message
illustrating what this patch does.

From my side i gave a try of this patch on my setup. Some data:

<snip>
root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_v6.script | sort -nk 6 | grep rcu
name:                       rcuop/23 pid:        184 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/26 pid:        206 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/29 pid:        227 woken-up     1     interval: min     0     max     0       avg     0
name:                        rcuop/2 pid:         35 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/34 pid:        263 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/35 pid:        270 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/36 pid:        277 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/37 pid:        284 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/38 pid:        291 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/49 pid:        370 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/59 pid:        441 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/63 pid:        469 woken-up     1     interval: min     0     max     0       avg     0
name:                        rcuog/0 pid:         16 woken-up     2     interval: min  8034     max  8034       avg  4017
name:                       rcuog/24 pid:        191 woken-up     2     interval: min  7941     max  7941       avg  3970
name:                       rcuog/32 pid:        248 woken-up     2     interval: min  7542     max  7542       avg  3771
name:                       rcuog/48 pid:        362 woken-up     2     interval: min  8065     max  8065       avg  4032
name:                       rcuog/56 pid:        419 woken-up     2     interval: min  8076     max  8076       avg  4038
name:                       rcuop/21 pid:        170 woken-up     2     interval: min 13311438  max 13311438    avg 6655719
name:                       rcuog/16 pid:        134 woken-up     4     interval: min  8029     max 13303387    avg 3329863
name:                        rcuop/9 pid:         85 woken-up     4     interval: min 10007570  max 10007586    avg 7505684
name:                        rcuog/8 pid:         77 woken-up     8     interval: min  6240     max 10001242    avg 3753622
name:                    rcu_preempt pid:         15 woken-up    18     interval: min  6058     max 9999713     avg 2140788
name:                     test_rcu/0 pid:       1411 woken-up 10003     interval: min   165     max 19072       avg  4275
root@pc638:/home/urezki/rcu_v6#

root@pc638:/home/urezki/rcu_v6# ./perf_script_parser ./perf_default.script | sort -nk 6 | grep rcu
name:                       rcuop/33 pid:        256 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuop/51 pid:        384 woken-up     1     interval: min     0     max     0       avg     0
name:                       rcuog/32 pid:        248 woken-up     2     interval: min 11927     max 11927       avg  5963
name:                       rcuop/63 pid:        469 woken-up     2     interval: min 23963     max 23963       avg 11981
name:                       rcuog/56 pid:        419 woken-up     3     interval: min 11132     max 23967       avg 11699
name:                       rcuop/50 pid:        377 woken-up     3     interval: min  8057     max 4944344     avg 1650800
name:                       rcuog/48 pid:        362 woken-up     8     interval: min  2712     max 37430015    avg 5298801
name:                       rcuop/16 pid:        135 woken-up  4790     interval: min  7340     max 16649       avg  8843
name:                       rcuog/16 pid:        134 woken-up  4792     interval: min  7368     max 16644       avg  8844
name:                    rcu_preempt pid:         15 woken-up  5302     interval: min    26     max 12179       avg  7994
name:                     test_rcu/0 pid:       1353 woken-up 10003     interval: min   169     max 18508       avg  4236
root@pc638:/home/urezki/rcu_v6#
<snip>

so it is obvious that the patch does the job.

On my KVM machine the boot time is affected:

<snip>
[    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
[   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
[   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
[  104.115418] process '/usr/bin/fstype' started with executable stack
[  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
[  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[  104.340193] systemd[1]: Detected virtualization kvm.
[  104.340196] systemd[1]: Detected architecture x86-64.
[  104.359032] systemd[1]: Set hostname to <pc638>.
[  105.740109] random: crng init done
[  105.741267] systemd[1]: Reached target Remote File Systems.
<snip>

2 - 11 and second delay is between 32 - 104. So there are still users which must
be waiting for "RCU" in a sync way.

> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..40ae36904825 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
>  
>  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
>  
> +#ifdef CONFIG_RCU_LAZY
> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> +#else
> +static inline void call_rcu_flush(struct rcu_head *head,
> +		rcu_callback_t func) {  call_rcu(head, func); }
> +#endif
> +
>  /* Internal to kernel */
>  void rcu_init(void);
>  extern int rcu_scheduler_active;
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f53ad63b2bc6..edd632e68497 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
>  	  Say N here if you hate read-side memory barriers.
>  	  Take the default if you are unsure.
>  
> +config RCU_LAZY
> +	bool "RCU callback lazy invocation functionality"
> +	depends on RCU_NOCB_CPU
> +	default n
> +	help
> +	  To save power, batch RCU callbacks and flush after delay, memory
> +	  pressure or callback list growing too big.
> +
>
Do you think you need this kernel option? Can we just consider and make
it a run-time configurable? For example much more users will give it a try,
so it will increase a coverage. By default it can be off.

Also you do not need to do:

#ifdef LAZY
...
#else
...
#endif

>  
> +/*
> + * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
> + * can elapse before lazy callbacks are flushed. Lazy callbacks
> + * could be flushed much earlier for a number of other reasons
> + * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
> + * left unsubmitted to RCU after those many jiffies.
> + */
> +#define LAZY_FLUSH_JIFFIES (10 * HZ)
> +static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
Make it configurable? I do not think you actually need 10 seconds here.
Reducing it will reduce a possibility to hit a low memory condition. 1
second would be far enough i think.

--
Uladzislau Rezki
