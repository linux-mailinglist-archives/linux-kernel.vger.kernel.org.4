Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06C65ECF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiI0VcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0VcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:32:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743E3105D4D;
        Tue, 27 Sep 2022 14:31:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lh5so23340950ejb.10;
        Tue, 27 Sep 2022 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=lgvUuls4LA+pgi1w9wEs9ntghlitkihGnUhsn9PZoAY=;
        b=WqKO99SnL8kPDOzr3xizo/uAbvjOHAUZwMDOxbxdRGUaB0Dnr3fJNDQiUcH2f8yczF
         8B2DlvrhbHrDsvVTJElTqHskn5jDcZ5ySuww+BXsa8eDPTXWymSUshmBt9JOiPnWvDOt
         Ls8AVo1pbXxcy6Ial6ZeM4oGZ2zfi1QMLOTswXydmlJrUQIM4E4Dk6OSFjauEiTAhz4v
         9n1Hk50wS8/rvvqW/Aifj/VHGzy0niRlJi+Yy/IDKAb8xMhoJs+bDivlYka2WOnjYC88
         UVp6D9rxUFKO2OLPsbsSVH/qvDuTqIpg3utxMX8xL6e3VuS6ZbFWU3GB7vIPZ6MremrO
         KOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lgvUuls4LA+pgi1w9wEs9ntghlitkihGnUhsn9PZoAY=;
        b=y3kwkvISPsVBazMuy3BJ4wCdYXvfuDptgCIZFZdWDcS6DFljN/99HccyjUdHb7dvEr
         1Qpz9nr205Mq3/aIfRtdIg4b4bBYfiN0h7DXPRNv3W2KPZD34U4p6uWixIOAmeifSun1
         rMN7LZmo39IArQISW0BtL5Yr/Q2AGOzdiCp5L9PM0YcvnFBxUDNdYUjpJ6XufD4QiLQm
         ga/ItcYHIV67ZcnqiclydY6MLqa0HlILTnYcc6JJqX0ioDYkekrjPhuUsBEMOpYUfm0p
         yrrTK6mxEge4Gh9EVbvPxObMbe57e5YWeGYSWv73kYGk371yasuEqTxyLrgDUitpQ2Uw
         USeg==
X-Gm-Message-State: ACrzQf1gMKjWAwZCAuXyvO7Bv6D/eZfXTxvHa4+irdcGdpAwlAv0r4rL
        Oc9NtCWm9K79FQ3p9Mqm3O8=
X-Google-Smtp-Source: AMsMyM4XwXk1y8z2/9ZCbclv6h8lQEyMt2lamkYD2O5wPXWSdD/UrkVcXpFGKyZQTujUb/GPV6ZGxg==
X-Received: by 2002:a17:907:6d9b:b0:783:4fe0:dac5 with SMTP id sb27-20020a1709076d9b00b007834fe0dac5mr12227481ejc.445.1664314316719;
        Tue, 27 Sep 2022 14:31:56 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id gh30-20020a1709073c1e00b0077a11b79b9bsm1323658ejc.133.2022.09.27.14.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:31:56 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 27 Sep 2022 23:31:53 +0200
To:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzNryczGDQZpvIa8@pc636>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <YzH/646RHxhHBy6+@pc636>
 <YzIRg2u2JYXN9bnK@google.com>
 <YzMD0pdR6rvGSZ/o@pc636>
 <YzMI68pbXXVWWKEN@google.com>
 <YzMP4LaIUY8Dh9Nw@pc636>
 <YzMTHgLT0wk2zzg0@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMTHgLT0wk2zzg0@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:13:34PM +0200, Uladzislau Rezki wrote:
> On Tue, Sep 27, 2022 at 04:59:44PM +0200, Uladzislau Rezki wrote:
> > On Tue, Sep 27, 2022 at 02:30:03PM +0000, Joel Fernandes wrote:
> > > On Tue, Sep 27, 2022 at 04:08:18PM +0200, Uladzislau Rezki wrote:
> > > > On Mon, Sep 26, 2022 at 08:54:27PM +0000, Joel Fernandes wrote:
> > > > > Hi Vlad,
> > > > > 
> > > > > On Mon, Sep 26, 2022 at 09:39:23PM +0200, Uladzislau Rezki wrote:
> > > > > [...]
> > > > > > > > On my KVM machine the boot time is affected:
> > > > > > > > 
> > > > > > > > <snip>
> > > > > > > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > > > > > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > > > > > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > > > > > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > > > > > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > > > > > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > > > > > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > > > > > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > > > > > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > > > > > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > > > > > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > > > > > > [  105.740109] random: crng init done
> > > > > > > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > > > > > > <snip>
> > > > > > > > 
> > > > > > > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > > > > > > be waiting for "RCU" in a sync way.
> > > > > > > 
> > > > > > > I was wondering if you can compare boot logs and see which timestamp does the
> > > > > > > slow down start from. That way, we can narrow down the callback. Also another
> > > > > > > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > > > > > > ftrace_dump_on_oops" to the boot params, and then manually call
> > > > > > > "tracing_off(); panic();" from the code at the first printk that seems off in
> > > > > > > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > > > > > > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > > > > > > output to see what were the last callbacks that was queued/invoked.
> > > > > 
> > > > > Would you be willing to try these steps? Meanwhile I will try on my side as
> > > > > well with the .config you sent me in another email.
> > > > >
> > > > Not exactly those steps. But see below:
> > > > 
> > > > <snip>
> > > > [    2.291319] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > > [   17.302946] e1000 0000:00:03.0 ens3: renamed from eth0
> > > > <snip>
> > > > 
> > > > 15 seconds delay between two prints. I have logged all call_rcu() users
> > > > between those two prints:
> > > > 
> > > > <snip>
> > > > # tracer: nop
> > > > #
> > > > # entries-in-buffer/entries-written: 166/166   #P:64
> > > > #
> > > > #                                _-----=> irqs-off/BH-disabled
> > > > #                               / _----=> need-resched
> > > > #                              | / _---=> hardirq/softirq
> > > > #                              || / _--=> preempt-depth
> > > > #                              ||| / _-=> migrate-disable
> > > > #                              |||| /     delay
> > > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > > #              | |         |   |||||     |         |
> > > >    systemd-udevd-669     [002] .....     2.338739: e1000_probe: Intel(R) PRO/1000 Network Connection
> > > >    systemd-udevd-665     [061] .....     2.338952: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....     2.338962: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-665     [061] .....     2.338965: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....     2.338968: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-665     [061] .....     2.338987: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-645     [053] .....     2.338989: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....     2.338999: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-645     [053] .....     2.339002: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....     2.339024: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >      kworker/0:3-546     [000] d..1.     6.329516: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70effe40a0
> > > >          rcuop/0-17      [000] b....     6.337320: __call_rcu_common: -> 0x0: exit_creds+0x63/0x70 <- 0x0
> > > >     kworker/38:1-744     [038] d..1.     6.841479: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f97e40a0
> > > >            <...>-739     [035] d..1.     6.841479: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f8be40a0
> > > >            <...>-732     [021] d..1.     6.841486: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f53e40a0
> > > >     kworker/36:1-740     [036] d..1.     6.841487: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f8fe40a0
> > > >         rcuop/21-170     [023] b....     6.849276: __call_rcu_common: -> 0x0: exit_creds+0x63/0x70 <- 0x0
> > > >         rcuop/38-291     [052] b....     6.849950: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/38-291     [052] b....     6.849957: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >      kworker/5:1-712     [005] d..1.     7.097392: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f13e40a0
> > > >     kworker/19:1-727     [019] d..1.     7.097392: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f4be40a0
> > > >            <...>-719     [007] d..1.     7.097392: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f1be40a0
> > > >     kworker/13:1-721     [013] d..1.     7.097392: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f33e40a0
> > > >     kworker/52:1-756     [052] d..1.     7.097395: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fcfe40a0
> > > >     kworker/29:1-611     [029] d..1.     7.097395: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f73e40a0
> > > >            <...>-754     [049] d..1.     7.097405: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fc3e40a0
> > > >     kworker/12:1-726     [012] d..1.     7.097405: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f2fe40a0
> > > >     kworker/53:1-710     [053] d..1.     7.097405: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fd3e40a0
> > > >            <...>-762     [061] d..1.     7.097405: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70ff3e40a0
> > > >            <...>-757     [054] d..1.     7.097408: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fd7e40a0
> > > >     kworker/25:1-537     [025] d..1.     7.097408: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f63e40a0
> > > >            <...>-714     [004] d..1.     7.097408: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f0fe40a0
> > > >            <...>-749     [044] d..1.     7.097413: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fafe40a0
> > > >     kworker/51:1-755     [051] d..1.     7.097413: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fcbe40a0
> > > >            <...>-764     [063] d..1.     7.097415: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70ffbe40a0
> > > >            <...>-753     [045] d..1.     7.097416: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fb3e40a0
> > > >     kworker/43:1-748     [043] d..1.     7.097416: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fabe40a0
> > > >     kworker/41:1-747     [041] d..1.     7.097416: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fa3e40a0
> > > >     kworker/57:1-760     [057] d..1.     7.097416: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fe3e40a0
> > > >            <...>-720     [008] d..1.     7.097418: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f1fe40a0
> > > >     kworker/58:1-759     [058] d..1.     7.097421: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fe7e40a0
> > > >     kworker/16:1-728     [016] d..1.     7.097424: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f3fe40a0
> > > >            <...>-722     [010] d..1.     7.097427: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f27e40a0
> > > >     kworker/22:1-733     [022] d..1.     7.097432: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f57e40a0
> > > >            <...>-731     [026] d..1.     7.097432: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f67e40a0
> > > >            <...>-752     [048] d..1.     7.097437: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fbfe40a0
> > > >     kworker/18:0-147     [018] d..1.     7.097437: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f47e40a0
> > > >     kworker/39:1-745     [039] d..1.     7.097437: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f9be40a0
> > > >            <...>-716     [003] d..1.     7.097437: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70f0be40a0
> > > >            <...>-703     [050] d..1.     7.097437: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fc7e40a0
> > > >     kworker/42:1-746     [042] d..1.     7.097444: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70fa7e40a0
> > > >         rcuop/13-113     [013] b....     7.105592: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/13-113     [013] b....     7.105595: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/10-92      [040] b....     7.105608: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/10-92      [040] b....     7.105610: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/16-135     [023] b....     7.105613: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/8-78      [039] b....     7.105636: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/8-78      [039] b....     7.105640: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/12-106     [040] b....     7.105651: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/12-106     [040] b....     7.105652: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/19-156     [000] b....     7.105727: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/19-156     [000] b....     7.105730: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/5-56      [058] b....     7.105808: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/5-56      [058] b....     7.105814: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/20-163     [023] b....    17.345648: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/20-163     [023] b....    17.345655: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/14-120     [013] b....    17.345675: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/14-120     [013] b....    17.345681: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/6-63      [013] b....    17.345714: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/6-63      [013] b....    17.345715: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/9-85      [000] b....    17.345753: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/9-85      [000] b....    17.345758: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/17-142     [000] b....    17.345775: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/17-142     [000] b....    17.345776: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/17-142     [000] b....    17.345777: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/11-99      [000] b....    17.345810: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/11-99      [000] b....    17.345811: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/15-127     [013] b....    17.345832: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/15-127     [013] b....    17.345834: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/1-28      [000] b....    17.345834: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >          rcuop/1-28      [000] b....    17.345835: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/15-127     [013] b....    17.345835: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >         rcuop/15-127     [013] b....    17.345837: __call_rcu_common: -> 0x0: file_free_rcu+0x32/0x50 <- 0x0
> > > >    systemd-udevd-633     [035] .....    17.346591: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-633     [035] .....    17.346609: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-633     [035] .....    17.346659: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-633     [035] .....    17.346666: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-669     [002] .....    17.347573: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >      kworker/2:2-769     [002] .....    17.347659: __call_rcu_common: -> 0x0: __wait_rcu_gp+0xff/0x120 <- 0x0
> > > >    systemd-udevd-675     [012] .....    17.347981: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-675     [012] .....    17.348002: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-675     [012] .....    17.348037: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348098: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348117: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-665     [061] .....    17.348120: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348156: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348166: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348176: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-642     [050] .....    17.348179: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348186: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348197: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348200: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348231: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348240: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348250: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348259: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348262: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348305: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348317: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348332: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348336: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348394: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348403: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348406: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.348503: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.348531: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-645     [053] .....    17.348535: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348536: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.348563: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-665     [061] .....    17.348575: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348628: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348704: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348828: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348884: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348904: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348954: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348983: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.348993: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349002: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349014: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349024: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349026: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349119: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349182: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349243: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349430: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349462: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349472: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349483: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349486: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349583: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349632: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349666: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349699: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.349727: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349733: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.349739: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-645     [053] .....    17.349742: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349765: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-645     [053] .....    17.349766: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-642     [050] .....    17.349780: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-665     [061] .....    17.349800: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-642     [050] .....    17.349815: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-642     [050] .....    17.349829: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-642     [050] .....    17.349832: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349834: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-675     [012] .....    17.349835: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-675     [012] .....    17.349853: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-642     [050] .....    17.349861: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >    systemd-udevd-675     [012] .....    17.349873: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.349879: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.350007: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.350011: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.350080: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.350175: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > > >    systemd-udevd-665     [061] .....    17.350362: dev_change_name: --> renamed from eth0
> > > > <snip>
> > > > 
> > > > First delay:
> > > > 
> > > > <snip>
> > > > systemd-udevd-645     [053] .....     2.339024: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > > >   kworker/0:3-546     [000] d..1.     6.329516: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70effe40a0
> > > > <snip>
> > > > 
> > > > __dentry_kill() function and after 4 seconds there is another one queue_rcu_work().
> > > > I have checked the __dentry_kill() if it can do any sync talk with RCU but from the
> > > > first glance i do not see anything critical. But more attention is required.
> > > 
> > > Can you log rcu_barrier() as well? It could be that the print is just a side
> > > effect of something else that is not being printed.
> > > 
> > It has nothing to do with rcu_barrier() in my case. Also i have checked
> > the synchronize_rcu() it also works as expected, i.e. it is not a
> > blocking reason.
> > 
> > Have you tried my config?
> > 
> > --
> > Uladzislau Rezki
> OK. Seems one place i have spot:
> 
> <snip>
> [    7.074847] calling  init_sr+0x0/0x1000 [sr_mod] @ 668
> [   22.422808] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> [   22.422815] cdrom: Uniform CD-ROM driver Revision: 3.20
> [   32.664590] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [   32.664642] initcall init_sr+0x0/0x1000 [sr_mod] returned 0 after 25589786 usecs
> <snip>
> 
> --
> Uladzislau Rezki

OK. Found the boot up issue. In my case i had 120 seconds delay:

<snip>
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..a56cfd612e3a 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
         * Ensure that all tasks observe the host state change before the
         * host_failed change.
         */
-       call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
+       call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
 }
 
 /**
<snip>

After this change the boot-up time settles back to normal 4 seconds.

--
Uladzislau Rezki
