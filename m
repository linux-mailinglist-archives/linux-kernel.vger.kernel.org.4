Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704AB5EB2C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIZVC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiIZVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:02:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746183213
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:02:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id ay9so4966216qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mYdDalWMvcjIKCsdJOFYlDSxqC6W9ji+KL0JRvVs6bw=;
        b=Fh+oMyH5NDN5M1UfEEx9JBX3Nrp6XBdWV8pfH2suAo6w7b2bc193zDT6IOAJBe4+bG
         Xp2kYLkqtkuMQjxnekJEwdXP6dePH7F3NpQxdfke+1P7y8nmWjPIR7xGUpDxkUrUEeXS
         Arw5O/cURNxRl9NaKIny6j/kV9AqVebI2J0wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mYdDalWMvcjIKCsdJOFYlDSxqC6W9ji+KL0JRvVs6bw=;
        b=N9TOzF0Y1Mu6f5miG3A1oavHFtt8/Luannlv0a588kNSSa1gnJL08YKVIZ1fes4GIt
         dclrMpzFgmbpmugdvjoe81s7KtsSsHtDYnerX+zMSatnTzneMUIiBkhCqdqe6lZraPT5
         LiwWu75V8IAPbBFwm5JCsBprCAjNGbL5nsz4tufuDIPHot+EiuMg9r5rDhpDrxY9up1w
         ov4RRASsDsej3JnMwu7P7IXZIG9EvI8ScbNHMuN5H4MC3NAdY5IeB3GiUECkmv5eynMd
         Q3QKreCjlXihFLEWF0ubDqPGwDlUoTW0yWaCJP1Mdcro70j05n9TsDASnJBpyOHaifXE
         Jf5g==
X-Gm-Message-State: ACrzQf0PXFDIzmJ/Ng7d0WPNB1YhrtN+2cVvK1lu8HgyQHHPJqANTdpK
        CTe+IKhkFuP8Kn9GR+BD7lzjdw==
X-Google-Smtp-Source: AMsMyM6QYMCl/7bPftnCUtsASux0y/Pl7A/NDYUMTYBrw38dwH1v+Ne1J+A110lUw+Z2ogDQbgWIzQ==
X-Received: by 2002:ac8:59c4:0:b0:35d:fa7:324b with SMTP id f4-20020ac859c4000000b0035d0fa7324bmr18889014qtf.533.1664226142272;
        Mon, 26 Sep 2022 14:02:22 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id s5-20020a05620a254500b006b98315c6fbsm13047269qko.1.2022.09.26.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:02:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 21:02:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzITXYGIqfRIebIH@google.com>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <20220926174846.GQ4196@paulmck-ThinkPad-P17-Gen-1>
 <YzH+XAVSlHpuWYoD@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzH+XAVSlHpuWYoD@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:32:44PM +0200, Uladzislau Rezki wrote:
[...]
> > > > On my KVM machine the boot time is affected:
> > > > 
> > > > <snip>
> > > > [    2.273406] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
> > > > [   11.945283] e1000 0000:00:03.0 ens3: renamed from eth0
> > > > [   22.165198] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
> > > > [   22.165206] cdrom: Uniform CD-ROM driver Revision: 3.20
> > > > [   32.406981] sr 1:0:0:0: Attached scsi CD-ROM sr0
> > > > [  104.115418] process '/usr/bin/fstype' started with executable stack
> > > > [  104.170142] EXT4-fs (sda1): mounted filesystem with ordered data mode. Quota mode: none.
> > > > [  104.340125] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
> > > > [  104.340193] systemd[1]: Detected virtualization kvm.
> > > > [  104.340196] systemd[1]: Detected architecture x86-64.
> > > > [  104.359032] systemd[1]: Set hostname to <pc638>.
> > > > [  105.740109] random: crng init done
> > > > [  105.741267] systemd[1]: Reached target Remote File Systems.
> > > > <snip>
> > > > 
> > > > 2 - 11 and second delay is between 32 - 104. So there are still users which must
> > > > be waiting for "RCU" in a sync way.
> > > 
> > > I was wondering if you can compare boot logs and see which timestamp does the
> > > slow down start from. That way, we can narrow down the callback. Also another
> > > idea is, add "trace_event=rcu:rcu_callback,rcu:rcu_invoke_callback
> > > ftrace_dump_on_oops" to the boot params, and then manually call
> > > "tracing_off(); panic();" from the code at the first printk that seems off in
> > > your comparison of good vs bad. For example, if "crng init done" timestamp is
> > > off, put the "tracing_off(); panic();" there. Then grab the serial console
> > > output to see what were the last callbacks that was queued/invoked.
> > 
> > We do seem to be in need of some way to quickly and easily locate the
> > callback that needed to be _flush() due to a wakeup.
> >
> <snip>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index aeea9731ef80..fe1146d97f1a 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1771,7 +1771,7 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
>  
>         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
>                 rwork->wq = wq;
> -               call_rcu(&rwork->rcu, rcu_work_rcufn);
> +               call_rcu_flush(&rwork->rcu, rcu_work_rcufn);
>                 return true;
>         }
>  
> <snip>
> 
> ?
> 
> But it does not fully solve my boot-up issue. Will debug tomorrow further.

Ah, but at least its progress, thanks. Could you send me a patch to include
in the next revision with details of this?

> > Might one more proactive approach be to use Coccinelle to locate such
> > callback functions?  We might not want -all- callbacks that do wakeups
> > to use call_rcu_flush(), but knowing which are which should speed up
> > slow-boot debugging by quite a bit.
> > 
> > Or is there a better way to do this?
> > 
> I am not sure what Coccinelle is. If we had something automated that measures
> a boot time and if needed does some profiling it would be good. Otherwise it
> is a manual debugging mainly, IMHO.

Paul, What about using a default-off kernel CONFIG that splats on all lazy
call_rcu() callbacks that do a wake up. We could use the trace hooks to do it
in kernel I think. I can talk to Steve to get ideas on how to do that but I
think it can be done purely from trace events (we might need a new
trace_end_invoke_callback to fire after the callback is invoked). Thoughts?

thanks,

 - Joel

