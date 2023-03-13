Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B486B732F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCMJvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:51:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076F6A255;
        Mon, 13 Mar 2023 02:51:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j11so14861068lfg.13;
        Mon, 13 Mar 2023 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678701102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VRsmpqBO807GYQQIuzMLfXGfVa+JtFsWHXyi41I4F7o=;
        b=DduEFgOED/u8XRrxXNF1OT+W2y5FK/8F/hOBFHIPbXjUm/85Ix7YCt9G1lcaIMX2lv
         AjYbjEXf8QhEKOfjm25IkRBNz3DEt3neZoQi1pZ1LXOtZH0v9XhKYy4nSg4jEOWOV81a
         G/ZdjLKwSyase+FMRRIp2jyGT5bHFLdAf+ik1BvBuK/5SYhslIqI7YtSCCTcxwiI4sUw
         6ZxQ5X9jKV09hXylda6zoKldF4E/kD1+R/CPRi35Y69VVsB2i8RM5AJQ4jucH4iyZwMF
         pqYf4jIOXHVeoBqPh19qjXmpRMXle8xOXpXffKoP61IY2mlG4Fgq+RC5lWb2cpdoVKso
         Y3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678701102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRsmpqBO807GYQQIuzMLfXGfVa+JtFsWHXyi41I4F7o=;
        b=YUNAD+RylAJ8KJvlsZctEu9gQQY0cbe1Yp5UDbdb+0EqzHSDkRgFdLapqJWkAzEBir
         yD2UB0OwdUqzlH0R75gevt7UMk5A2XdZf9FUTyn5928PWEkfneXKvjtAgNwquhFOE+6p
         lvwTBx/wWOZKQCdbcTg9QuZdI51Z6N6DU18pjiZN9fxFRE1IVhZzarqjryJvFZg1HWC/
         O2XrkFd7HMbeGWk04BBH5rIcZ9M8DyiSVDARucCo0x6lgxo2i3w0/qlQ67Fji/RZ6lLo
         zkoCsbqXub576VDtQH116/qARIX8d1GWHF8TqSMKqERxFThokb3riFhge3AqdoBAMts2
         HHMg==
X-Gm-Message-State: AO0yUKW9GfaNlP9cDFr1IAX/WeQpWIA+jAKwnEkjQsXSIAYU/GZ6vFXL
        1ZuQRc/LDxy6JhF5bvTqo54=
X-Google-Smtp-Source: AK7set8dxeH7jyt6xp2uc3pgrfeENHgJWRIXNZ06a11BUma1PCMxcblV0Yr3RQZzNfXSnesdOvThsA==
X-Received: by 2002:ac2:51a8:0:b0:4cc:7308:8f40 with SMTP id f8-20020ac251a8000000b004cc73088f40mr10840654lfk.40.1678701102002;
        Mon, 13 Mar 2023 02:51:42 -0700 (PDT)
Received: from pc636 (host-78-79-233-41.mobileonline.telia.com. [78.79.233.41])
        by smtp.gmail.com with ESMTPSA id l25-20020ac25559000000b004d4ead86cb2sm913744lfk.20.2023.03.13.02.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:51:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 13 Mar 2023 10:51:39 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZA7yK6iznHqiBu5i@pc636>
References: <CAEXW_YRTLQpQpOW-+n+X59pmB=4TkV=gdsMiQfBkdK_4wO9Jug@mail.gmail.com>
 <20230307173313.GJ1301832@paulmck-ThinkPad-P17-Gen-1>
 <20230307185443.GA516865@google.com>
 <20230307192726.GL1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAhYP9a8u05hzsOn@pc636>
 <20230308144528.GR1301832@paulmck-ThinkPad-P17-Gen-1>
 <ZAnXxr9OyFT63xSx@pc636>
 <20230309221056.GB148448@google.com>
 <ZArwZjcEYXAYwmqi@pc636>
 <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8a40cd-8b1f-4121-98f7-7a1bdbcaf6a6@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:24:34PM -0800, Paul E. McKenney wrote:
> On Fri, Mar 10, 2023 at 09:55:02AM +0100, Uladzislau Rezki wrote:
> > On Thu, Mar 09, 2023 at 10:10:56PM +0000, Joel Fernandes wrote:
> > > On Thu, Mar 09, 2023 at 01:57:42PM +0100, Uladzislau Rezki wrote:
> > > [..]
> > > > > > > > > See this commit:
> > > > > > > > > 
> > > > > > > > > 3705b88db0d7cc ("rcu: Add a module parameter to force use of
> > > > > > > > > expedited RCU primitives")
> > > > > > > > > 
> > > > > > > > > Antti provided this commit precisely in order to allow Android
> > > > > > > > > devices to expedite the boot process and to shut off the
> > > > > > > > > expediting at a time of Android userspace's choosing.  So Android
> > > > > > > > > has been making this work for about ten years, which strikes me
> > > > > > > > > as an adequate proof of concept.  ;-)
> > > > > > > > 
> > > > > > > > Thanks for the pointer. That's true. Looking at Android sources, I
> > > > > > > > find that Android Mediatek devices at least are setting
> > > > > > > > rcu_expedited to 1 at late stage of their userspace boot (which is
> > > > > > > > weird, it should be set to 1 as early as possible), and
> > > > > > > > interestingly I cannot find them resetting it back to 0!.  Maybe
> > > > > > > > they set rcu_normal to 1? But I cannot find that either. Vlad? :P
> > > > > > > 
> > > > > > > Interesting.  Though this is consistent with Antti's commit log,
> > > > > > > where he talks about expediting grace periods but not unexpediting
> > > > > > > them.
> > > > > > > 
> > > > > > Do you think we need to unexpedite it? :))))
> > > > > 
> > > > > Android runs on smallish systems, so quite possibly not!
> > > > > 
> > > > We keep it enabled and never unexpedite it. The reason is a performance.  I
> > > > have done some app-launch time analysis with enabling and disabling of it.
> > > > 
> > > > An expedited case is much better when it comes to app launch time. It
> > > > requires ~25% less time to run an app comparing with unexpedited variant.
> > > > So we have a big gain here.
> > > 
> > > Wow, that's huge. I wonder if you can dig deeper and find out why that is so
> > > as the callbacks may need to be synchronize_rcu_expedited() then, as it could
> > > be slowing down other usecases! I find it hard to believe, real-time
> > > workloads will run better without those callbacks being always-expedited if
> > > it actually gives back 25% in performance!
> > > 
> > I can dig further, but on a high level i think there are some spots
> > which show better performance if expedited is set. I mean synchronize_rcu()
> > becomes as "less blocking a context" from a time point of view.
> > 
> > The problem of a regular synchronize_rcu() is - it can trigger a big latency
> > delays for a caller. For example for nocb case we do not know where in a list
> > our callback is located and when it is invoked to unblock a caller.
> 
> True, expedited RCU grace periods do not have this callback-invocation
> delay that normal RCU does.
> 
> > I have already mentioned somewhere. Probably it makes sense to directly wake-up
> > callers from the GP kthread instead and not via nocb-kthread that invokes our callbacks
> > one by one.
> 
> Makes sense, but it is necessary to be careful.  Wakeups are not fast,
> so making the RCU grace-period kthread do them all sequentially is not
> a strategy to win.  For example, note that the next expedited grace
> period can start before the previous expedited grace period has finished
> its wakeups.
> 
I hove done a small and quick prototype:

<snip>
diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
index 699b938358bf..e1a4cca9a208 100644
--- a/include/linux/rcupdate_wait.h
+++ b/include/linux/rcupdate_wait.h
@@ -9,6 +9,8 @@
 #include <linux/rcupdate.h>
 #include <linux/completion.h>

+extern struct llist_head gp_wait_llist;
+
 /*
  * Structure allowing asynchronous waiting on RCU.
  */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee27a03d7576..50b81ca54104 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -113,6 +113,9 @@ int rcu_num_lvls __read_mostly = RCU_NUM_LVLS;
 int num_rcu_lvl[] = NUM_RCU_LVL_INIT;
 int rcu_num_nodes __read_mostly = NUM_RCU_NODES; /* Total # rcu_nodes in use. */

+/* Waiters for a GP kthread. */
+LLIST_HEAD(gp_wait_llist);
+
 /*
  * The rcu_scheduler_active variable is initialized to the value
  * RCU_SCHEDULER_INACTIVE and transitions RCU_SCHEDULER_INIT just before the
@@ -1776,6 +1779,14 @@ static noinline void rcu_gp_cleanup(void)
                on_each_cpu(rcu_strict_gp_boundary, NULL, 0);
 }

+static void rcu_notify_gp_end(struct llist_node *llist)
+{
+       struct llist_node *rcu, *next;
+
+       llist_for_each_safe(rcu, next, llist)
+               complete(&((struct rcu_synchronize *) rcu)->completion);
+}
+
 /*
  * Body of kthread that handles grace periods.
  */
@@ -1811,6 +1822,9 @@ static int __noreturn rcu_gp_kthread(void *unused)
                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
                rcu_gp_cleanup();
                WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
+
+               /* Wake-app all users. */
+               rcu_notify_gp_end(llist_del_all(&gp_wait_llist));
        }
 }

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..1de7c328a3e5 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -426,7 +426,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
                if (j == i) {
                        init_rcu_head_on_stack(&rs_array[i].head);
                        init_completion(&rs_array[i].completion);
-                       (crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+
+                       /* Kick a grace period if needed. */
+                       (void) start_poll_synchronize_rcu();
+                       llist_add((struct llist_node *) &rs_array[i].head, &gp_wait_llist);
                }
        }
<snip>

and did some experiments in terms of performance and comparison. A test case is:

thread_X:
  synchronize_rcu();
  kfree(ptr);

below are results with running 10 parallel workers running 1000 times of mentioned
test scenario:

# default(NOCB)
[   29.322944] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 17286604 usec
[   29.325759] All test took worker0=63964052068 cycles
[   29.327255] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 23414575 usec
[   29.329974] All test took worker1=86638822563 cycles
[   29.331460] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 23357988 usec
[   29.334205] All test took worker2=86429439193 cycles
[   29.350808] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 17174001 usec
[   29.353553] All test took worker3=63547397954 cycles
[   29.355039] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 17141904 usec
[   29.357770] All test took worker4=63428630877 cycles
[   29.374831] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 23397952 usec
[   29.377577] All test took worker5=86577316353 cycles
[   29.398809] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 17142038 usec
[   29.401549] All test took worker6=63429124938 cycles
[   29.414828] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 17158248 usec
[   29.417574] All test took worker7=63489107118 cycles
[   29.438811] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 18102109 usec
[   29.441550] All test took worker8=66981588881 cycles
[   29.462826] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 23446042 usec
[   29.465561] All test took worker9=86755258455 cycles

# patch(NOCB)
[   14.720986] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837883 usec
[   14.723753] All test took worker0=32702015768 cycles
[   14.740386] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837750 usec
[   14.743076] All test took worker1=32701525814 cycles
[   14.760350] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837734 usec
[   14.763036] All test took worker2=32701466281 cycles
[   14.780369] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837707 usec
[   14.783057] All test took worker3=32701364901 cycles
[   14.800352] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837730 usec
[   14.803041] All test took worker4=32701449927 cycles
[   14.820355] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837724 usec
[   14.823048] All test took worker5=32701428134 cycles
[   14.840359] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837705 usec
[   14.843052] All test took worker6=32701356465 cycles
[   14.860322] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837742 usec
[   14.863005] All test took worker7=32701494475 cycles
[   14.880363] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837750 usec
[   14.883081] All test took worker8=32701525074 cycles
[   14.900362] Summary: kvfree_rcu_1_arg_vmalloc_test loops: 1000 avg: 8837918 usec
[   14.903065] All test took worker9=32702145379 cycles

--
Uladzislau Rezki
