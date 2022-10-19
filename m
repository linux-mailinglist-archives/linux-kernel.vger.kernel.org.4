Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48EA60501A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiJSTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJSTFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:05:44 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF648170DC2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:05:39 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so854007pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kG5EvpHdHM0iSYnlLwXpTJZuwX3mygkDwBW2OAorH0=;
        b=DH9wDXgr9Dv5QZiySC7aqkaYua1OmqQI4UrEt56K2skc8avmTLFW9aKxh0Wjpxm7QD
         tvLCc4NGFp+P6GGB2kH1DoKPDkXJvLnst77hTcw6S0W28QHsnYlOU5p2icS7n89OYdfq
         hW3Y2bvBFYvWU9qMWwL862ZykOKcoBGXFXUK2rwCdbDKudQlrTaUYu0GB+wlNYsAZ+hp
         KHSpPdrHNMxTT8LTzlE2Xq4GzsfkZrLDvZtmoOS8A6SXV8QmQrtgA6pGBPrDxWSpRRPd
         TpSzEZCSKxn4tKpfbj0yLnrt9A53bn1GXFKcy/R9O3DTzxgQO3s7LndeQKs5xbLqSDZ7
         6Drw==
X-Gm-Message-State: ACrzQf0G1fPNr9nwcDTMT9kA2ymczPwxz6tYDk+ypq6j9Q16Q0HgBVBL
        klXGRMbpCmXeIz7ENmo818A=
X-Google-Smtp-Source: AMsMyM6Y9lBLr2cALOtxodtksCh7r0lVmvlVAAZsXwkQQ4k9KxfE6GJbNgXOWeWRCnGCuD2w6nhliw==
X-Received: by 2002:a17:90b:3b92:b0:20d:4fae:1261 with SMTP id pc18-20020a17090b3b9200b0020d4fae1261mr11701057pjb.32.1666206339068;
        Wed, 19 Oct 2022 12:05:39 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.230])
        by smtp.gmail.com with ESMTPSA id r27-20020a63205b000000b00412a708f38asm10123555pgm.35.2022.10.19.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 12:05:38 -0700 (PDT)
Date:   Wed, 19 Oct 2022 12:05:35 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>
Subject: Re: signal: break out of wait loops on kthread_stop()
Message-ID: <Y1BKf4ol3YtKvLiG@sultan-box.localdomain>
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
 <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
 <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
 <Y1A+9kN6bwfXeqVt@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1A+9kN6bwfXeqVt@zx2c4.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:16:22PM -0600, Jason A. Donenfeld wrote:
> On Wed, Oct 19, 2022 at 06:57:38PM +0100, Tvrtko Ursulin wrote:
> > 
> > On 19/10/2022 17:00, Jason A. Donenfeld wrote:
> > > On Wed, Oct 19, 2022 at 7:31 AM Tvrtko Ursulin
> > > <tvrtko.ursulin@linux.intel.com> wrote:
> > >>
> > >>
> > >> Hi,
> > >>
> > >> A question regarding a7c01fa93aeb ("signal: break out of wait loops on
> > >> kthread_stop()") if I may.
> > >>
> > >> We have a bunch code in i915, possibly limited to self tests (ie debug
> > >> builds) but still important for our flows, which spawn kernel threads
> > >> and exercises parts of the driver.
> > >>
> > >> Problem we are hitting with this patch is that code did not really need
> > >> to be signal aware until now. Well to say that more accurately - we were
> > >> able to test the code which is normally executed from userspace, so is
> > >> signal aware, but not worry about -ERESTARTSYS or -EINTR within the test
> > >> cases itself.
> > >>
> > >> For example threads which exercise an internal API for a while until the
> > >> parent calls kthread_stop. Now those tests can hit unexpected errors.
> > >>
> > >> Question is how to best approach working around this change. It is of
> > >> course technically possible to rework our code in more than one way,
> > >> although with some cost and impact already felt due reduced pass rates
> > >> in our automated test suites.
> > >>
> > >> Maybe an opt out kthread flag from this new behavior? Would that be
> > >> acceptable as a quick fix? Or any other comments?
> > > 
> > > You can opt out by running `clear_tsk_thread_flag(current,
> > > TIF_NOTIFY_SIGNAL);` at the top of your kthread. But you should really
> > > fix your code instead. Were I your reviewer, I wouldn't merge code
> > > that took the lazy path like that. However, that should work, if you
> > > do opt for the quick fix.
> >
> > Also, are you confident that the change will not catch anyone else by 
> > surprise? In the original thread I did not spot any concerns about the 
> > kthreads being generally unprepared to start receiving EINTR/ERESTARTSYS 
> > from random call chains.
> 
> Pretty sure, yea. i915 is unique in its abuse of the API. Keep in mind
> that kthread_stop() also sets KTHREAD_SHOULD_STOP and such. Your code is
> abusing the API by calling kthread_run() followed by kthread_stop().
> 
> As evidence of how broken your code actually is, the kthread_stop()
> function has a comment that makes it clear, "This can also be called
> after kthread_create() instead of calling wake_up_process(): the thread
> will exit without calling threadfn()," yet i915 has attempted to hack
> around it with ridiculous yields and msleeps. For example:
> 
>                 threads[n] = kthread_run(__igt_breadcrumbs_smoketest,
>                                          &t, "igt/%d", n);
> ...
> 
>         yield(); /* start all threads before we begin */
>         msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
> ...
>                 err = kthread_stop(threads[n]);
> 
> 
> Or here's another one:
> 
>                 tsk = kthread_run(fn, &thread[i], "igt-%d", i);
> ...
>         msleep(10); /* start all threads before we kthread_stop() */
> ...
>                 status = kthread_stop(tsk);
> 
> I mean come on.
> 
> This is brittle and bad and kind of ridiculous that it shipped this way.
> Now you're asking to extend your brittleness, so that you can avoid the
> work of cleaning up 5 call sites. Just clean up those 5 call sites. It's
> only 5, as far as I can tell.
> 
> 
> > Right, but our hand is a bit forced at the moment. Since 6.1-rc1 has 
> > propagated to our development tree on Monday, our automated testing 
> > started failing significantly, which prevents us merging new work until 
> > resolved. So a quick fix trumps the ideal road in the short term. Just 
> > because it is quick.
> 
> "Short term" -- somehow I can imagine the short term hack will turn into
> a long term one.
> 
> Anyway, what I suspect you might actually want as a bandaid is a
> "kthread_wait()"-like function, that doesn't try to stop the thread with
> KTHREAD_SHOULD_STOP and such, but just waits for the completion:
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 30e5bec81d2b..2699cc45ad15 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
>  void kthread_bind(struct task_struct *k, unsigned int cpu);
>  void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
>  int kthread_stop(struct task_struct *k);
> +int kthread_wait(struct task_struct *k);
>  bool kthread_should_stop(void);
>  bool kthread_should_park(void);
>  bool __kthread_should_park(struct task_struct *k);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f97fd01a2932..d581d78a3a26 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -715,6 +715,22 @@ int kthread_stop(struct task_struct *k)
>  }
>  EXPORT_SYMBOL(kthread_stop);
> 
> +int kthread_wait(struct task_struct *k)
> +{
> +	struct kthread *kthread;
> +	int ret;
> +
> +	get_task_struct(k);
> +	kthread = to_kthread(k);
> +	wake_up_process(k);
> +	wait_for_completion(&kthread->exited);
> +	ret = kthread->result;
> +	put_task_struct(k);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kthread_stop);
> +
>  int kthreadd(void *unused)
>  {
>  	struct task_struct *tsk = current;
> 

Hi,

Given the need to ensure the kthreads are started and then synchronously
flushed, this seems like a good fit for the kthread_work API, which provides all
of the necessary plumbing for this usecase. No need for the eldritch kthread API
abuse and flimsy yield+msleep.

Sultan
