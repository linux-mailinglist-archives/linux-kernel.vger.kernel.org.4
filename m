Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8905F7DF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJGT3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJGT3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:29:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC3492F5C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:29:15 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z18so3692403qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYryUS2xuHauk4mJPmehH5XKZvG419V6lD5kRhyvW5g=;
        b=rGkDDmk+AsZBmrCNm6pcUYrnZ0arzoGsV5hgOOKtxg4Twt67aKAdzmb1SFfz/CFUut
         YlAruChVAba4VfX2qnnw9PYpscKh+Ggu7B7LoXZdJIE6S9GSI/usKj2OCxQ0q/vHlxh8
         3K8f3apoxURwkNB/lhfVs+zH6pwqM53/sPU/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYryUS2xuHauk4mJPmehH5XKZvG419V6lD5kRhyvW5g=;
        b=TtXk5nbsOvZOqg7S+QRLXvpykx0J1ePmyphfESd8Xjbqqx37gn5HGofsxqPZZ6VZ3G
         5GgeBfhiv2CkYp+K8i6DtowuhYSQUxx4ircDP9m51nxdXyFwQ6FhWWIHvP5Sy0lwsjVZ
         nL4ltqLvkx1uilVRzZAjdJ3U503cG29Ghe4vTIHSEz77K7ofhbo+B+QrDKEn+0xBTM+w
         nqCbGQaPy7mdwHcZSPgton02FmknnA3bmo9aXTppfDMz7S8/S835JVK1gUYG1XrLURYq
         WzMHHB8Eg8QaOVrRjfE4/a40fGQMO/HUDpBIf9ptUbK/ziH4kLdpv+TsMIja/gCHN0Ry
         z14g==
X-Gm-Message-State: ACrzQf2xd1FqRXqhl44klzpORr5GEiB52WdYrlbOHHu60Dx9TUEjHXCx
        CPM4DIAh48+gH7I9VAxLR/dTpA==
X-Google-Smtp-Source: AMsMyM792W67wc2OQ0xtUb6bnfv+RooYRrp7jQnqISRIhWCiio/6zsZq/sgo7Nqy3U33xIOFeqw1Fg==
X-Received: by 2002:a0c:f589:0:b0:4b3:d58a:b1f1 with SMTP id k9-20020a0cf589000000b004b3d58ab1f1mr928819qvm.89.1665170955041;
        Fri, 07 Oct 2022 12:29:15 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id y9-20020a05622a004900b0034454d0c8f3sm2794496qtw.93.2022.10.07.12.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:29:14 -0700 (PDT)
Date:   Fri, 7 Oct 2022 19:29:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead
 of call_rcu()
Message-ID: <Y0B+CqZVP3bqQyn5@google.com>
References: <Y0BfvzpF1DE10nOg@google.com>
 <00F8CD19-98E7-4CEB-AC8E-4E86642E91A7@joelfernandes.org>
 <20221007175208.GI4196@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221007175208.GI4196@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:52:08AM -0700, Paul E. McKenney wrote:
> On Fri, Oct 07, 2022 at 01:31:23PM -0400, Joel Fernandes wrote:
> > 
> > 
> > > On Oct 7, 2022, at 1:19 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > 
> > > ﻿On Fri, Oct 07, 2022 at 03:18:26AM +0000, Joel Fernandes wrote:
> > >>> On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:
> > >>> From: Uladzislau Rezki <urezki@gmail.com>
> > >>> 
> > >>> Slow boot time is seen on KVM running typical Linux distributions due to
> > >>> SCSI layer calling call_rcu(). Recent changes to save power may be
> > >>> causing this slowness. Using call_rcu_flush() fixes the issue and brings
> > >>> the boot time back to what it originally was. Convert it.
> > >>> 
> > >>> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > >>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >> 
> > >> And I successfully setup Debian on KVM and verified that this fixes it, so
> > >> now I have a nice reproducible rig for my
> > >> 'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks to
> > >> ideas from Steve, and will finish the other half tomorrow or so).
> > >> 
> > >> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Looks like I can catch Vlad's issue with the below patch. Thoughts? Does this
> > > look reasonable for mainline? (I think so as it is self-contained and the
> > > debug option is default off, and could be useful down the line).
> 
> Excellent as a debug patch!!!  Let's see how it goes -- if it proves
> sufficiently useful, some form should go into mainline.  Or at least
> be feature prominently somewhere public.

Ok that sounds good.

> > > [    6.887033 ] rcu: *****************************************************
> > > [    6.891242 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > [    6.895377 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > [    6.899084 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > [    6.902405 ] rcu: This could cause performance issues! Check the stack.
> > > [    6.906532 ] rcu: *****************************************************
> > > 
> > > 
> > > [   17.127128 ] rcu: *****************************************************
> > > [   17.131397 ] rcu: RCU: A wake up has been detected from a lazy callback!
> > > [   17.135703 ] rcu: The callback name is: scsi_eh_inc_host_failed
> > > [   17.139485 ] rcu: The task it woke up is: scsi_eh_1 (61)
> > > [   17.142828 ] rcu: This could cause performance issues! Check the stack.
> > > [   17.146962 ] rcu: *****************************************************
> > > 
> > > And thanks to Steve for the binary search code.
> > > 
> > > One thing I found is I have to ignore kworkers because there are times when a
> > > work item is queued from a callback and those callbacks don't seem to
> > > contribute to performance issues. So I am filtering these:
> > > 
> > > [   38.631724 ] rcu: The callback name is: thread_stack_free_rcu
> > > [   38.635317 ] rcu: The task it woke up is: kworker/3:2 (143)
> > > 
> > > [   39.649332 ] rcu: The callback name is: delayed_put_task_struct
> > > [   39.653037 ] rcu: The task it woke up is: kworker/0:1 (40)
> > > 
> > > ---8<-----------------------
> > > 
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Subject: [PATCH] lazy wake debug
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > > kernel/rcu/Kconfig      |   7 ++
> > > kernel/rcu/lazy-debug.h | 149 ++++++++++++++++++++++++++++++++++++++++
> > > kernel/rcu/tree.c       |   9 +++
> > > 3 files changed, 165 insertions(+)
> > > create mode 100644 kernel/rcu/lazy-debug.h
> > > 
> > > diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> > > index edd632e68497..08c06f739187 100644
> > > --- a/kernel/rcu/Kconfig
> > > +++ b/kernel/rcu/Kconfig
> > > @@ -322,4 +322,11 @@ config RCU_LAZY
> > >      To save power, batch RCU callbacks and flush after delay, memory
> > >      pressure or callback list growing too big.
> > > 
> > > +config RCU_LAZY_DEBUG
> > > +    bool "RCU callback lazy invocation debugging"
> > > +    depends on RCU_LAZY
> > > +    default n
> > > +    help
> > > +      Debugging to catch issues caused by delayed RCU callbacks.
> > > +
> > > endmenu # "RCU Subsystem"
> > > diff --git a/kernel/rcu/lazy-debug.h b/kernel/rcu/lazy-debug.h
> > > new file mode 100644
> > > index 000000000000..fc1cc1cb89f0
> > > --- /dev/null
> > > +++ b/kernel/rcu/lazy-debug.h
> > > @@ -0,0 +1,149 @@
> > > +#include <linux/string.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +#ifdef CONFIG_RCU_LAZY_DEBUG
> > > +#include <linux/preempt.h>
> > > +#include <trace/events/sched.h>
> > > +
> > > +static DEFINE_PER_CPU(bool, rcu_lazy_cb_exec) = false;
> > > +static DEFINE_PER_CPU(void *, rcu_lazy_ip) = NULL;
> > > +
> > > +static DEFINE_RAW_SPINLOCK(lazy_funcs_lock);
> > > +
> > > +#define FUNC_SIZE 1024
> > 
> > And I know this array can overflow in the future so I will add checks for that in the code if we are going with this patch.
> 
> I believe that there are fewer than 300 RCU callback functions, but yes,
> there would need to at least be a check at some point.
> 
> I still strongly suggest the static search in addition to this.  Yes, this
> is a cool patch, but it should be mostly used for the difficult-to-find
> instances.

I wrote some scripts shared below (could be improves) which search for "wake"
in code following an RCU callback's reference. This catches SCSI too but I
did find one more:

(1)
rxrpc_destroy_connection()

	which does:
	wake_up_var(&conn->params.local->rxnet->nr_conns);


I think I'll change this to call_rcu_flush() to be safe.

========

All others are harmless / false-positives which I inspected and didn't have
anything concerning.

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] debug: look for wake references after rcu callback body

First run search-call-rcu.sh which generates some files, then run
search-wakers.sh to see the references to wake.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 search-call-rcu.sh | 19 +++++++++++++++++++
 search-wakers.sh   | 15 +++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 search-call-rcu.sh
 create mode 100755 search-wakers.sh

diff --git a/search-call-rcu.sh b/search-call-rcu.sh
new file mode 100755
index 000000000000..21406355888c
--- /dev/null
+++ b/search-call-rcu.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+rm func-list
+touch func-list
+
+for f in $(find . \( -name "*.c" -o -name "*.h" \) | grep -v rcu); do
+
+	funcs=$(perl -0777 -ne 'while(m/call_rcu\([&]?.+,\s?(.+)\).*;/g){print "$1\n";}' $f)
+
+	if [ "x$funcs" != "x" ]; then
+		for func in $funcs; do
+			echo "$f $func" >> func-list
+			echo "$f $func"
+		done
+	fi
+
+done
+
+cat func-list | sort | uniq | tee func-list-sorted
diff --git a/search-wakers.sh b/search-wakers.sh
new file mode 100755
index 000000000000..a96d60a7e16b
--- /dev/null
+++ b/search-wakers.sh
@@ -0,0 +1,15 @@
+#!/bin/bash
+
+while read fl; do
+	file=$(echo $fl | cut -d " " -f1)
+	func=$(echo $fl | cut -d " " -f2)
+
+	grep -A 30 $func $file | grep wake > /dev/null
+
+	if [ $? -eq 0 ]; then
+		echo "keyword wake found after function reference $func in $file"
+		echo "Output:"
+		grep -A 30 $func $file 
+		echo "==========================================================="
+	fi
+done < func-list-sorted
-- 
2.38.0.rc1.362.ged0d419d3c-goog

