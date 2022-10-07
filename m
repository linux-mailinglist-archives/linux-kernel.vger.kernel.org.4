Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3385F7EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJGUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiJGUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:24:27 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04F112584F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:24:25 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id g13so3096037ile.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 13:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7+kXfS3Ypp4tpiNNuZYWvfWhiQOP5kv7ZOoacB0ewhA=;
        b=WITtF1r7a59I3Llnq2W4vuzWvTwUu8n504Xjd0senswKpeYsCPKDFdLtwM8mxFvgA7
         a25ipzsMLOch0Eay5+x1p5dkRJC2t64xPXuEADMf76X4XAZVySrrQSXIR/KQEjyGYn7c
         /DAwtVmTCmAVEE0WqVV3nyxEa5A0q4tqO54us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+kXfS3Ypp4tpiNNuZYWvfWhiQOP5kv7ZOoacB0ewhA=;
        b=I3khm1owNW0YOPuRopswC9DkWgkpL02PiFdqQmWDinkcFwqxwLSY1sdzf+Ng+VtIt4
         TGAz9BSA0Peou74+MwrphKuCiT7YvQViKrIPieWpoR6XE0n1v3GnhQZpM/e01FFPix13
         yqGrx73imHgvyO++M8AdzhTo5Q5TDh9Yg75hPIDdLQE+2FvYlTasJRSIDzddXUA6+Mau
         b501vMcVfQGR30QsSejLD7ljmsZM13JSGUCLraUOCYObuenjUr/A55QLK3Z/CiC3FRmO
         s+UVwDNRNUsNr7KIsgx+70Cc01So0XZRaA0wuPsc57PkN2PEkG7ZMTVYGAWz5BoWSJmr
         1E7Q==
X-Gm-Message-State: ACrzQf0bOWwnc2oZ0TqUkrWFc/YjQoAs0LSS2GbuOMKEDSjNVFwxphTY
        V/g0Kt1x3LjDBMoZnggz9i5IASue2I08HWLh6P8mDg==
X-Google-Smtp-Source: AMsMyM5+Huguf0FBF1tGS8CNHuPcURK/7/RuTzh0B4lAxW+jr+dNvJaRw0vQzUfBEj9vohXotuvyWEoJJrTpNmRt8HQ=
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id
 p6-20020a92d686000000b002fa62266247mr3326132iln.79.1665174265292; Fri, 07 Oct
 2022 13:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <Y0BfvzpF1DE10nOg@google.com> <00F8CD19-98E7-4CEB-AC8E-4E86642E91A7@joelfernandes.org>
 <20221007175208.GI4196@paulmck-ThinkPad-P17-Gen-1> <Y0B+CqZVP3bqQyn5@google.com>
 <20221007195629.GK4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221007195629.GK4196@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 7 Oct 2022 16:24:14 -0400
Message-ID: <CAEXW_YQO_i7i9BK8JcCEJw7aekws3Q2MPbbhjJ3rv84ypf8PWA@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 3:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[..]
> > > > > [    6.887033 ] rcu: *****************************************************
> > > > > [    6.891242 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > > > [    6.895377 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > > > [    6.899084 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > > > [    6.902405 ] rcu: This could cause performance issues! Check the stack.
> > > > > [    6.906532 ] rcu: *****************************************************
> > > > >
> > > > >
> > > > > [   17.127128 ] rcu: *****************************************************
> > > > > [   17.131397 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > > > [   17.135703 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > > > [   17.139485 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > > > [   17.142828 ] rcu: This could cause performance issues! Check the stack.
> > > > > [   17.146962 ] rcu: *****************************************************
> > > > >
> > > > > And thanks to Steve for the binary search code.
> > > > >
> > > > > One thing I found is I have to ignore kworkers because there are times when a
> > > > > work item is queued from a callback and those callbacks don't seem to
> > > > > contribute to performance issues. So I am filtering these:
> > > > >
> > > > > [   38.631724 ] rcu: The callback name is: thread_stack_free_rcu
> > > > > [   38.635317 ] rcu: The task it woke up is: kworker/3:2 (143)
> > > > >
[..]
> > > > > +    help
> > > > > +      Debugging to catch issues caused by delayed RCU callbacks.
> > > > > +
> > > > > endmenu # "RCU Subsystem"
> > > > > diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
> > > > > new file mode 100644
> > > > > index 000000000000..fc1cc1cb89f0
> > > > > --- /dev/null
> > > > > +++ b/kernel/rcu/lazy-debug.h
> > > > > @@ -0,0 +1,149 @@
> > > > > +#include <linux/string.h>
> > > > > +#include <linux/spinlock.h>
> > > > > +
> > > > > +#ifdef CONFIG_RCU_LAZY_DEBUG
> > > > > +#include <linux/preempt.h>
> > > > > +#include <trace/events/sched.h>
> > > > > +
> > > > > +static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) = false;
> > > > > +static DEFINE_PER_CPU(void *, rcu_lazy_ip) = NULL;
> > > > > +
> > > > > +static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
> > > > > +
> > > > > +#define FUNC_SIZE 1024
> > > >
> > > > And I know this array can overflow in the future so I will add checks for that in the code if we are going with this patch.
> > >
> > > I believe that there are fewer than 300 RCU callback functions, but yes,
> > > there would need to at least be a check at some point.
> > >
> > > I still strongly suggest the static search in addition to this.  Yes, this
> > > is a cool patch, but it should be mostly used for the difficult-to-find
> > > instances.
> >
> > I wrote some scripts shared below (could be improves) which search for "wake"
> > in code following an RCU callback's reference. This catches SCSI too but I
> > did find one more:
> >
> > (1)
> > rxrpc_destroy_connection()
> >
> >       which does:
> >       wake_up_var(&conn->params.local->rxnet->nr_conns);
> >
> >
> > I think I'll change this to call_rcu_flush() to be safe.
> >
> > ========
> >
> > All others are harmless / false-positives which I inspected and didn't have
> > anything concerning.
>
> Very good, and thank you for doing this!

Thanks.

> Maybe include the script in the cover letter of the next version?

Good idea, thanks, I will do so.

 - Joel


>
>                                                         Thanx, Paul
>
> > ---8<-----------------------
> >
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] debug: look for wake references after rcu callback body
> >
> > First run search-call-rcu.sh which generates some files, then run
> > search-wakers.sh to see the references to wake.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  search-call-rcu.sh | 19 +++++++++++++++++++
> >  search-wakers.sh   | 15 +++++++++++++++
> >  2 files changed, 34 insertions(+)
> >  create mode 100755 search-call-rcu.sh
> >  create mode 100755 search-wakers.sh
> >
> > diff --git a/search-call-rcu.sh b/search-call-rcu.sh
> > new file mode 100755
> > index 000000000000..21406355888c
> > --- /dev/null
> > +++ b/search-call-rcu.sh
> > @@ -0,0 +1,19 @@
> > +#!/bin/bash
> > +
> > +rm func-list
> > +touch func-list
> > +
> > +for f in $(find . \( -name "*.c" -o -name "*.h" \) | grep -v rcu); do
> > +
> > +     funcs=$(perl -0777 -ne 'while(m/call_rcu\([&]?.+,\s?(.+)\).*;/g){print "$1\n";}' $f)
> > +
> > +     if [ "x$funcs" != "x" ]; then
> > +             for func in $funcs; do
> > +                     echo "$f $func" >> func-list
> > +                     echo "$f $func"
> > +             done
> > +     fi
> > +
> > +done
> > +
> > +cat func-list | sort | uniq | tee func-list-sorted
> > diff --git a/search-wakers.sh b/search-wakers.sh
> > new file mode 100755
> > index 000000000000..a96d60a7e16b
> > --- /dev/null
> > +++ b/search-wakers.sh
> > @@ -0,0 +1,15 @@
> > +#!/bin/bash
> > +
> > +while read fl; do
> > +     file=$(echo $fl | cut -d " " -f1)
> > +     func=$(echo $fl | cut -d " " -f2)
> > +
> > +     grep -A 30 $func $file | grep wake > /dev/null
> > +
> > +     if [ $? -eq 0 ]; then
> > +             echo "keyword wake found after function reference $func in $file"
> > +             echo "Output:"
> > +             grep -A 30 $func $file
> > +             echo "==========================================================="
> > +     fi
> > +done < func-list-sorted
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
