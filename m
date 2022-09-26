Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1F5EB608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIZX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIZX55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076BD80BD5;
        Mon, 26 Sep 2022 16:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 958FB6149E;
        Mon, 26 Sep 2022 23:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F6C433D6;
        Mon, 26 Sep 2022 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664236676;
        bh=ruhtHy1jX7W4cTqbjAtE4WdcljIrqUW0GHQx14am/Aw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ggJd2u66Y4NLmBs4IDbeXqlRRQLWwFEPD680zYBv5yCWB1x0RUABtmK7Y1QDjoIE2
         V2nWdfJfmfRq34CB9F8annRiyTKsIgFAl2L4TMF9pL/lMp17XaAP5NrsFtGjgB92u7
         zhpJZ/n2+RSMCN8AWpn3ALvc5fpjVacFTDbPJIeW2xd0Gz2DqBf/uc22Nn8PhrzKK6
         R4vjdioSyuUDKl0miFN74Yht62X7M0ZsbMoSoPXtGaP3H+Al/6ziqtQFOP6M2NnWAE
         y8uzC47q6ZopA/f/MC3ihKQOUw9wsoW51anJR2t0tSxt5hbYzFGGi2a+aZ69sdlJLK
         kYSHVL9K9zG5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9CE2F5C0BE3; Mon, 26 Sep 2022 16:57:55 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:57:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <20220926235755.GD4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926223534.GY4196@paulmck-ThinkPad-P17-Gen-1>
 <BE2B629D-B5D2-4ED0-944E-2F13E846047E@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BE2B629D-B5D2-4ED0-944E-2F13E846047E@joelfernandes.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 07:44:19PM -0400, Joel Fernandes wrote:
> 
> 
> > On Sep 26, 2022, at 6:35 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Sep 26, 2022 at 08:54:27PM +0000, Joel Fernandes wrote:
> >> Hi Vlad,
> >> 
> >> On Mon, Sep 26, 2022 at 09:39:23PM +0200, Uladzislau Rezki wrote:
> >> [...]
> >>>>> On my KVM machine the boot time is affected:
> >>>>> 
> >>>>> <snip>
> >>>>> [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> >>>>> [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> >>>>> [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> >>>>> [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> >>>>> [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> >>>>> [  104.115418] process '/usr/bin/fstype' started with executable stack
> >>>>> [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> >>>>> [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> >>>>> [  104.340193] systemd[1]: Detected virtualization kvm.
> >>>>> [  104.340196] systemd[1]: Detected architecture x86-64.
> >>>>> [  104.359032] systemd[1]: Set hostname to <pc638>.
> >>>>> [  105.740109] random: crng init done
> >>>>> [  105.741267] systemd[1]: Reached target Remote File Systems.
> >>>>> <snip>
> >>>>> 
> >>>>> 2 - 11 and second delay is between 32 - 104. So there are still users which must
> >>>>> be waiting for "RCU" in a sync way.
> >>>> 
> >>>> I was wondering if you can compare boot logs and see which timestamp does the
> >>>> slow down start from. That way, we can narrow down the callback. Also another
> >>>> idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> >>>> ftrace_dump_on_oops" to the boot params, and then manually call
> >>>> "tracing_off(); panic();" from the code at the first printk that seems off in
> >>>> your comparison of good vs bad. For example, if "crng init done" timestamp is
> >>>> off, put the "tracing_off(); panic();" there. Then grab the serial console
> >>>> output to see what were the last callbacks that was queued/invoked.
> >> 
> >> Would you be willing to try these steps? Meanwhile I will try on my side as
> >> well with the .config you sent me in another email.
> >> 
> >>>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >>>>>> index 08605ce7379d..40ae36904825 100644
> >>>>>> --- a/include/linux/rcupdate.h
> >>>>>> +++ b/include/linux/rcupdate.h
> >>>>>> @@ -108,6 +108,13 @@ static inline int rcu_preempt_depth(void)
> >>>>>> 
> >>>>>> #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> >>>>>> 
> >>>>>> +#ifdef CONFIG_RCU_LAZY
> >>>>>> +void call_rcu_flush(struct rcu_head *head, rcu_callback_t func);
> >>>>>> +#else
> >>>>>> +static inline void call_rcu_flush(struct rcu_head *head,
> >>>>>> +        rcu_callback_t func) {  call_rcu(head, func); }
> >>>>>> +#endif
> >>>>>> +
> >>>>>> /* Internal to kernel */
> >>>>>> void rcu_init(void);
> >>>>>> extern int rcu_scheduler_active;
> >>>>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >>>>>> index f53ad63b2bc6..edd632e68497 100644
> >>>>>> --- a/kernel/rcu/Kconfig
> >>>>>> +++ b/kernel/rcu/Kconfig
> >>>>>> @@ -314,4 +314,12 @@ config TASKS_TRACE_RCU_READ_MB
> >>>>>>      Say N here if you hate read-side memory barriers.
> >>>>>>      Take the default if you are unsure.
> >>>>>> 
> >>>>>> +config RCU_LAZY
> >>>>>> +    bool "RCU callback lazy invocation functionality"
> >>>>>> +    depends on RCU_NOCB_CPU
> >>>>>> +    default n
> >>>>>> +    help
> >>>>>> +      To save power, batch RCU callbacks and flush after delay, memory
> >>>>>> +      pressure or callback list growing too big.
> >>>>>> +
> >>>>>> 
> >>>>> Do you think you need this kernel option? Can we just consider and make
> >>>>> it a run-time configurable? For example much more users will give it a try,
> >>>>> so it will increase a coverage. By default it can be off.
> >>>>> 
> >>>>> Also you do not need to do:
> >>>>> 
> >>>>> #ifdef LAZY
> >>>> 
> >>>> How does the "LAZY" macro end up being runtime-configurable? That's static /
> >>>> compile time. Did I miss something?
> >>>> 
> >>> I am talking about removing if:
> >>> 
> >>> config RCU_LAZY
> >>> 
> >>> we might run into issues related to run-time switching though.
> >> 
> >> When we started off, Paul said he wanted it kernel CONFIGurable. I will defer
> >> to Paul on a decision for that. I prefer kernel CONFIG so people don't forget
> >> to pass a boot param.
> > 
> > I am fine with a kernel boot parameter for this one.  You guys were the
> > ones preferring Kconfig options.  ;-)
> 
> Yes I still prefer that.. ;-)
> 
> > But in that case, the CONFIG_RCU_NOCB_CPU would come into play to handle
> > the case where there is no bypass.
> 
> If you don’t mind, let’s do both like we did for NOCB_CPU_ALL. In which case, Vlad since this was your suggestion, would you be so kind to send a patch adding a boot parameter on top of the series? ;-). I’ll include it in the next version. I’d suggest keep the boot param default off and add a CONFIG option that forces the boot param to be turned on.

NOCB_CPU_ALL?  If you are thinking in terms of laziness/flushing being
done on a per-CPU basis among the rcu_nocbs CPUs, that sounds like
something for later.

Are you thinking in terms of Kconfig options that allow: (1) No laziness.
(2) Laziness on all rcu_nocbs CPUs, but only if specified by a boot
parameter.  (3) Laziness on all rcu_nocbs CPUs regardless of boot
parameter.  I could get behind that.

							Thanx, Paul
