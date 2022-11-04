Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99963619C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKDP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiKDP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:59:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9473134E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:59:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id l6so4897656pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 08:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unQcVjy+Rx2tEvMdVdz8Z5NcSoVggd7rvnDgjCA2EkY=;
        b=ZNXqS7MOHY6qfrquNrzzp6t2gxtMEY2V8l3hEduaPIz0bJYIOhUH2k3lNi/Roysyls
         Xd63/MUhDOUglwwozaTaZd53cQ1+jOrYNopbRATprgtKXymvyDWasJ1LzFl5gXJVopeU
         ZH6oFd1K7zHpmhhMCFHAOuHJmmPTcQjZS8zLK9ZC+RpdYO8yZ358ISdCuNcPkJ5cMaOs
         47Li3ftsdQk4/InmG2H8twil5gHYNr+7ry5ZuT6x0HgoACsuZNHr7wHXw1OOV1zSHJ36
         wa2uzPjNkecvUPRbYJOWqrDkJBfS8SYtLBUjHE1oWIWNqEvieDQMUo7BJL4g+ItYoAVS
         tWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unQcVjy+Rx2tEvMdVdz8Z5NcSoVggd7rvnDgjCA2EkY=;
        b=FEpALVIG2hPbRXVitLitOpxtgDUm+bhgmXh0qjZ/c8koDCbL8X95E8gDkJkdoq604Z
         eW5Diyeu+N3etWEk5gkK4NsPkxuK1VdWRM/1mROWMWKRFZz6g8hnIq3del/VTzLZM1Sc
         BVm4HbdD3fxJFlzBAMOhwruIBTfUPZIrTQEBWHYhBoGp47AEOHkKMVtAqUjFLgE+7/pB
         WM3T/ZkC9tnUAUOBjK2TnuTWUpscA9nrcQ6ZmU3/ef5pMgZ0//AeLZhWw2S06QFzb1NY
         Bt3gmYwYSnq5Q736FQB5MOuHGhf3yxpNi6MrOvSy1ipo7vm5AQyAYzI2znd+q1GOh5bb
         p8IA==
X-Gm-Message-State: ACrzQf3DRHUKaoqEVxJSnqZfLJ94AHnr5nF8ot03GzLTfAneHNl+d265
        VytCxEKe9hqwqEBnyMmN42BoknfZUR8cAQ==
X-Google-Smtp-Source: AMsMyM5r24y1+lrcS1/Q/3uZqstkpaHqWWB3+g5pk7LSbIiaEDiO9nHRx/L4b1lrx6FgAmbgRLb8SQ==
X-Received: by 2002:a17:90a:1657:b0:213:7c4d:768a with SMTP id x23-20020a17090a165700b002137c4d768amr46361362pje.199.1667577557978;
        Fri, 04 Nov 2022 08:59:17 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a3fc900b00200461cfa99sm1832503pjm.11.2022.11.04.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:59:17 -0700 (PDT)
Date:   Fri, 4 Nov 2022 09:59:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_clew@quicinc.com
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
Message-ID: <20221104155915.GC1873068@p14s>
References: <20221013173442.GA1279972@p14s>
 <20221013180334.GB1279972@p14s>
 <8807a9a6-d93d-aef5-15f4-88648a6ecbe2@quicinc.com>
 <CANLsYkx8Vcha9FpfRvJEkq2pd+mSYFeZQBXj65YoiSBv+WEY4A@mail.gmail.com>
 <70828854-8427-8ce1-1535-e14261fd122d@quicinc.com>
 <420faf00-d59e-57c6-55a5-fae08a411517@foss.st.com>
 <CANLsYkw1Ex0TfmG-tRhHJgn3LsdvNhS_6HjJXn=ogwcCOWbH_A@mail.gmail.com>
 <414aacb1-e68b-a9a7-3b99-12bc56494f6f@quicinc.com>
 <20221102180350.GA1733006@p14s>
 <4c3d38c9-a43e-97bd-c7f9-3d21240e9d0e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3d38c9-a43e-97bd-c7f9-3d21240e9d0e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:03:49AM +0800, Aiqun(Maria) Yu wrote:
> On 11/3/2022 2:03 AM, Mathieu Poirier wrote:
> > On Wed, Nov 02, 2022 at 06:53:49PM +0800, Aiqun(Maria) Yu wrote:
> > > Hi,
> > > 
> > > Let me think about this carefully.
> > > 
> > > When in RPROC_RECOVERY_FAIL case we want to re-do the recovery process again
> > > or just leave the pm_relax?
> > 
> > Neither.
> > 
> > When a recovery fail we don't want to call pm_relax().  The code in
> > rproc_crash_handler_work() becomes:
> > 
> > 	if (rproc->state == RPROC_OFFLINE) {
> >                  /* We have raced with rproc_shutdown() */
> >                  pm_relax()
> > 		mutex_unlock(&rproc->lock);
> > 		return;
> >          }
> > 
> > 	if (rproc->state == RPROC_CRASHED ||
> >              rproc->state == RPROC_RECOVERY_FAILED) {
> > 		/* handle only the first crash detected */
> > 		mutex_unlock(&rproc->lock);
> > 		return;
> > 	}
> > 
> > 
> > RPROC_RECOVERY_FAILED gets set in rproc_boot_recovery() if request_firmware() or
> > rproc_start() fail.  Function rproc_trigger_recovery() needs to allow for the
> > recovery the the remote processor is in RPROC_RECOVERY_FAILED state.  As such
> > the condition becomes:
> > 
> >          /* State could have changed before we got the mutex */
> > 	if (rproc->state != RPROC_CRASHED &&
> >              rproc->state != RPROC_RECOVERY_FAILED)
> > 		goto unlock_mutex;
> > 
> > Start with that and we can look at corner cases (if some exists) with a fresh
> > patchset.  Note that I have not addressed the attach/detach() scenario in the
> > above.
> 
> If we didn't deal with the recovery failed case with correct pm_relax call,
> it may left the device in a state that cannot enter to suspend state.

That is what I am looking for.  We don't want to give the impression that
everything is fine by allowing the device to suspend.  If the remote processor
can't be recovered than it needs to be dealth with.

> Because first PROC_RECOVERY_FAIL case cannot ensure it have pm_relax called
> before the second crash handler call pm_stay_awake or not.
> 

I've been thinking about that part.  I don't think adding a wake_count to
control calls to pm_stay_awake()/pm_relax() is the best way to go.  There is a
similar count happening in the PM runtime subsystem and that is what we should
be using.  I have asked a power management expert at Linaro for guidance with
this matter.  I should be able to get back to you with a way forward by the end
of next week.

> So, What about the atomic count along with pm_relax and pm_stay_awake ?
> 
> struct rproc{
> ...
> atomic_t wake_count;
> ...
> }
> 
> rproc_pm_stay_awake()
> {
> 	atomic_inc(&wake_count);
> 	pm_stay_awake();
> }
> 
> rproc_pm_relax()
> {
> 	if (atomic_dec_return(&wake_count) == 0)
> 		pm_stay_awake();
> }
> 
> can refer code like:
> 
> rproc_report_crash()
> {
> 	...
> 	rproc_pm_stay_awake();
> 	queue_work();
> 	...
> }
> 
> rproc_crash_handler_work()
> {
> 	...
> 	if (rproc->state == RPROC_OFFLINE || rproc->state == RPROC_CRASHED) {
>                   /* We have raced with rproc_shutdown() */
>                   rproc_pm_relax();
>  		mutex_unlock(&rproc->lock);
>  		return;
>           }
> 	...
> }
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > > 
> > > recovery fail case 1:
> > > |                                      |firstcrash interrupt issued
> > > | second crashed interrupt issued      | rproc_report_crash()
> > > | rproc_report_crash()                 |          pm_stay_awake()
> > > |          pm_stay_awake()             |          queue_work()
> > > |          queue_work()                |rproc_crash_handler_work()
> > > |                                      |mutex_lock(&rproc->lock);
> > > |                                      |rproc_stop()
> > > |rproc_crash_handler_work()            |rproc->state = RPROC_OFFLINE;
> > > |                                      |RPROC_RECOVERY_FAIL //new
> > > |                                      |mutex_unlock(&rproc->lock);
> > > |mutex_lock(&rproc->lock);             |pm_relax()
> > > |if (rproc->state == RPROC_OFFLINE)    |
> > > |return // shouldn't do pm_relax if RPROC_RECOVERY_FAIL?  |
> > > |mutex_unlock(&rproc->lock);           |
> > > |                                      |
> > > |                                      |
> > > |                                      |
> > > 
> > > recovery fail case 2:
> > > |                                      |firstcrash interrupt issued
> > > |                                      | rproc_report_crash()
> > > |                                      |          pm_stay_awake()
> > > |                                      |          queue_work()
> > > |                                      |rproc_crash_handler_work()
> > > |                                      |mutex_lock(&rproc->lock);
> > > |                                      |rproc_stop()
> > > |                                      |rproc->state = RPROC_OFFLINE;
> > > |                                      |RPROC_RECOVERY_FAIL //new
> > > |                                      |mutex_unlock(&rproc->lock);
> > > |                                      |pm_relax()
> > > |
> > > | second crashed interrupt issued      |
> > > | rproc_report_crash()                 |
> > > |          pm_stay_awake()             |
> > > |          queue_work()                |
> > > |pm_stay_awake()
> > > |mutex_lock(&rproc->lock);
> > > |if (rproc->state == RPROC_OFFLINE)    |
> > > |return // still need do pm_relax if RPROC_RECOVERY_FAIL?  |
> > > |mutex_unlock(&rproc->lock);           |
> > > |                                      |
> > > |                                      |
> > > |                                      |
> > > 
> > > Maybe I can have:
> > > 1. the pm_stay_awake and pm_relax with count based and call with paired for
> > > fix current concurency issue.
> > > 2. RPROC_RECOVERY_FAIL can be another patch for continue try to do recovery
> > > work.
> > > 3. handle RPROC_DETACHED case.
> > > 
> > > On 11/2/2022 4:11 AM, Mathieu Poirier wrote:
> > > > On Fri, 28 Oct 2022 at 09:31, Arnaud POULIQUEN
> > > > <arnaud.pouliquen@foss.st.com> wrote:
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > On 10/24/22 05:17, Aiqun(Maria) Yu wrote:
> > > > > > On 10/22/2022 3:34 AM, Mathieu Poirier wrote:
> > > > > > > On Wed, 19 Oct 2022 at 23:52, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
> > > > > > > > 
> > > > > > > > On 10/14/2022 2:03 AM, Mathieu Poirier wrote:
> > > > > > > > > On Thu, Oct 13, 2022 at 11:34:42AM -0600, Mathieu Poirier wrote:
> > > > > > > > > > On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
> > > > > > > > > > > Hi Mathieu,
> > > > > > > > > > > 
> > > > > > > > > > > On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
> > > > > > > > > > > > Please add what has changed from one version to another, either in a cover
> > > > > > > > > > > > letter or after the "Signed-off-by".  There are many examples on how to
> > > > > > > > > > > > do that
> > > > > > > > > > > > on the mailing list.
> > > > > > > > > > > > 
> > > > > > > > > > > Thx for the information, will take a note and benefit for next time.
> > > > > > > > > > > 
> > > > > > > > > > > > On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
> > > > > > > > > > > > > RPROC_OFFLINE state indicate there is no recovery process
> > > > > > > > > > > > > is in progress and no chance to do the pm_relax.
> > > > > > > > > > > > > Because when recovering from crash, rproc->lock is held and
> > > > > > > > > > > > > state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> > > > > > > > > > > > > and then unlock rproc->lock.
> > > > > > > > > > > > 
> > > > > > > > > > > > You are correct - because the lock is held rproc->state should be set to
> > > > > > > > > > > > RPROC_RUNNING
> > > > > > > > > > > > when rproc_trigger_recovery() returns.  If that is not the case then
> > > > > > > > > > > > something
> > > > > > > > > > > > went wrong.
> > > > > > > > > > > > 
> > > > > > > > > > > > Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before
> > > > > > > > > > > > returning,
> > > > > > > > > > > > so we know the remote processor was stopped.  Therefore if rproc->state
> > > > > > > > > > > > is set
> > > > > > > > > > > > to RPROC_OFFLINE something went wrong in either request_firmware() or
> > > > > > > > > > > > rproc_start().  Either way the remote processor is offline and the system
> > > > > > > > > > > > probably
> > > > > > > > > > > > in an unknown/unstable.  As such I don't see how calling pm_relax() can help
> > > > > > > > > > > > things along.
> > > > > > > > > > > > 
> > > > > > > > > > > PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
> > > > > > > > > > > finished.
> > > > > > > > > > > Even if it is multi crash rproc_crash_handler_work contention issue, and
> > > > > > > > > > > last rproc_trigger_recovery bailed out with only
> > > > > > > > > > > rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
> > > > > > > > > > > Since the subsystem may still can be recovered with customer's next trigger
> > > > > > > > > > > of rproc_start, and we can make each error out path clean with pm resources.
> > > > > > > > > > > 
> > > > > > > > > > > > I suggest spending time understanding what leads to the failure when
> > > > > > > > > > > > recovering
> > > > > > > > > > > > from a crash and address that problem(s).
> > > > > > > > > > > > 
> > > > > > > > > > > In current case, the customer's information is that the issue happened when
> > > > > > > > > > > rproc_shutdown is triggered at similar time. So not an issue from error out
> > > > > > > > > > > of rproc_trigger_recovery.
> > > > > > > > > > 
> > > > > > > > > > That is a very important element to consider and should have been mentioned
> > > > > > > > > > from
> > > > > > > > > > the beginning.  What I see happening is the following:
> > > > > > > > > > 
> > > > > > > > > > rproc_report_crash()
> > > > > > > > > >             pm_stay_awake()
> > > > > > > > > >             queue_work() // current thread is suspended
> > > > > > > > > > 
> > > > > > > > > > rproc_shutdown()
> > > > > > > > > >             rproc_stop()
> > > > > > > > > >                     rproc->state = RPROC_OFFLINE;
> > > > > > > > > > 
> > > > > > > > > > rproc_crash_handler_work()
> > > > > > > > > >             if (rproc->state == RPROC_OFFLINE)
> > > > > > > > > >                     return // pm_relax() is not called
> > > > > > > > > > 
> > > > > > > > > > The right way to fix this is to add a pm_relax() in rproc_shutdown() and
> > > > > > > > > > rproc_detach(), along with a very descriptive comment as to why it is needed.
> > > > > > > > > 
> > > > > > > > > Thinking about this further there are more ramifications to consider.  Please
> > > > > > > > > confirm the above scenario is what you are facing.  I will advise on how to
> > > > > > > > > move
> > > > > > > > > forward if that is the case.
> > > > > > > > > 
> > > > > > > > Not sure if the situation is clear or not. So resend the email again.
> > > > > > > > 
> > > > > > > > The above senario is what customer is facing. crash hanppened while at
> > > > > > > > the same time shutdown is triggered.
> > > > > > > 
> > > > > > > Unfortunately this is not enough details to address a problem as
> > > > > > > complex as this one.
> > > > > > > 
> > > > > > > > And the device cannto goes to suspend state after that.
> > > > > > > > the subsystem can still be start normally after this.
> > > > > > > 
> > > > > > > If the code flow I pasted above reflects the problem at hand, the
> > > > > > > current patch will not be sufficient to address the issue.  If Arnaud
> > > > > > > confirms my suspicions we will have to think about a better solution.
> > > > > > > 
> > > > > > 
> > > > > > Hi Mathiew,
> > > > > > 
> > > > > > Could you pls have more details of any side effects other then power issue of
> > > > > > the current senario?
> > > > > > Why the current patch is not sufficient pls?
> > > > > > 
> > > > > > 
> > > > > > Have the current senario in details with rproc->lock information in details:
> > > > > > 
> > > > > > | subsystem crashed interrupt issued      | user trigger shutdown
> > > > > > | rproc_report_crash()                    |
> > > > > > |          pm_stay_awake()                |
> > > > > > |          queue_work()                   |
> > > > > > |                                         |rproc_shutdown
> > > > > > |                                         |mutex_lock(&rproc->lock);
> > > > > > |                                         |rproc_stop()
> > > > > > |rproc_crash_handler_work()               |rproc->state = RPROC_OFFLINE;
> > > > > > |                                         |mutex_unlock(&rproc->lock);
> > > > > > |mutex_lock(&rproc->lock);                |
> > > > > > |if (rproc->state == RPROC_OFFLINE)       |
> > > > > > |return // pm_relax() is not called       |rproc_boot
> > > > > > |mutex_unlock(&rproc->lock);              |
> > > > > > |                                         |mutex_lock(&rproc->lock);
> > > > > > |                                         |rproc_start()
> > > > > > |                                         |mutex_unlock(&rproc->lock);
> > > > > > 
> > > > > > 
> > > > > 
> > > > > Agree with Mathieu, this is not so simple.
> > > > > 
> > > > 
> > > > Thanks for looking into this.
> > > > 
> > > > > Here is my view  hoping I haven't missed a point in your discussion or
> > > > > an other corner cases.
> > > > > 
> > > > > I tried to analyze the issues (in what follows, the term "condition" means
> > > > > the "if" condition in which Aiqun proposes to add the fix) :
> > > > > 
> > > > > I can see 4 use cases with race condition
> > > > > 
> > > > > 1) crash report while already one is treated (rproc_boot_recovery called)
> > > > >        => not a real use case as if the remote processor is crashed we
> > > > >                 should not have a second crash report
> > > > > 
> > > > 
> > > > That part is of great concern to me.  *Theoretically* we should not
> > > > get a new crash report while one has already been dispatched but the
> > > > current code accounts for this scenario and as such the possibility
> > > > can't be dismissed.  Therefore we need to expect rproc_report_crash()
> > > > to be called multiple times before a single instance of
> > > > rproc_boot_recovery() is scheduled.
> > > 
> > > 
> > > > 
> > > > > 2) rproc_stop executed between the queuing of the crash work and the call of
> > > > >     rproc_crash_handler_work
> > > > >      => rproc->state = RPROC_OFFLINE
> > > > >      => we enter in the "condition" and the pm_relax has to be called
> > > > >      => This commit fix should solve this use case
> > > > > 
> > > > > 3) rproc_detach executed between the queue of the crash work and the call of
> > > > >     rproc_crash_handler_work
> > > > >      => rproc->state = RPROC_DETACHED;
> > > > >      => we don't go in "the condition" and issue because the recovery reattach
> > > > >         to the remote processor
> > > > >      => but pm_relax is called
> > > > >      => probably need an extra fix to avoid to re-attach
> > > > > 
> > > > > 4) crash report while already one is treated (rproc_attach_recovery called)
> > > > >      this one corresponds to an auto reboot of the remote processor, with a
> > > > >      new crash
> > > > >      => rproc->state = RPROC_CRASHED or rproc->state = RPROC_DETACHED;
> > > > >      4)a) rproc->state = RPROC_CRASHED if rproc->recovery_disabled = true
> > > > >           => should call pm_relax if rproc->recovery_disabled = true
> > > > >           => commit does not work for this use case
> > > > > 
> > > > >      4)b) rproc->state = RPROC_DETACHED if recovery fails
> > > > >          => error case with an unstable state
> > > > >          => how to differentiate it from the use case 3) ?
> > > > >          => introduce a RPROC_RECOVERY_FAIL state?
> > > > > 
> > > > 
> > > > The case where a recovery fails needs to be considered and is the
> > > > reason the original patch doesn't work.  Right now in
> > > > rproc_crash_handler_work(), it is not possible to differentiate
> > > > between a legitimate shutdown request (scenario #2 above) and a
> > > > recovery that went wrong.  I think introducing RPROC_RECOVERY_FAIL
> > > > would greatly simplify things.
> > > > 
> > > > My initial evaluation had not considered the attach/detach scenarios -
> > > > thanks for adding that in the mix.
> > > > 
> > > > Aiqun, please send a new patchset that adds a new remote processor
> > > > state, i.e RPROC_RECOVERY_FAIL.  There should also be another patch in
> > > > that set that takes attach/detach scenarios into account.  The code
> > > > between the v6.0 and v6.1 cycle has changed a lot in that area so make
> > > > sure to properly rebase.
> > > > 
> > > I will try.
> > > 
> > > > > 
> > > > > Then pm_stay_awake is called when the crash work is queued.
> > > > > It seems to me coherent to call the pm_relax in the work handler.
> > > > > 
> > > > > 
> > > > > 
> > > > > Here is a quick and dirty patch (not tested) that should take into account the
> > > > > main use cases ( except 1) and 4)b) )
> > > > > 
> > > > > @@ -2009,8 +2009,18 @@ static void rproc_crash_handler_work(struct work_struct *work)
> > > > > 
> > > > >           mutex_lock(&rproc->lock);
> > > > > 
> > > > > -       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
> > > > > +       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE ||
> > > > > +           rproc->state == RPROC_DETACHED) {
> > > > >                   /* handle only the first crash detected */
> > > > > +
> > > > > +               /*
> > > > > +                * call pm-relax in following use cases:
> > > > > +                * - the remote processor has been stopped by the user
> > > > > +                * - the remote processor is detached
> > > > > +                + - the remote proc has an autonomous reset but recovery_disabled is true.
> > > > > +                */
> > > > > +               if(rproc->state != RPROC_CRASHED || rproc->recovery_disabled)
> > > > > +                       pm_relax(rproc->dev.parent);
> > > > >                   mutex_unlock(&rproc->lock);
> > > > >                   return;
> > > > >           }
> > > > > 
> > > > > Regards,
> > > > > Arnaud
> > > > > 
> > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > > > Thanks,
> > > > > > > > > > > > Mathieu
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > > When the state is in RPROC_OFFLINE it means separate request
> > > > > > > > > > > > > of rproc_stop was done and no need to hold the wakeup source
> > > > > > > > > > > > > in crash handler to recover any more.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >       drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
> > > > > > > > > > > > >       1 file changed, 11 insertions(+)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/drivers/remoteproc/remoteproc_core.c
> > > > > > > > > > > > > b/drivers/remoteproc/remoteproc_core.c
> > > > > > > > > > > > > index e5279ed9a8d7..6bc7b8b7d01e 100644
> > > > > > > > > > > > > --- a/drivers/remoteproc/remoteproc_core.c
> > > > > > > > > > > > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > > > > > > > > > > > @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct
> > > > > > > > > > > > > work_struct *work)
> > > > > > > > > > > > >              if (rproc->state == RPROC_CRASHED || rproc->state ==
> > > > > > > > > > > > > RPROC_OFFLINE) {
> > > > > > > > > > > > >                      /* handle only the first crash detected */
> > > > > > > > > > > > >                      mutex_unlock(&rproc->lock);
> > > > > > > > > > > > > +         /*
> > > > > > > > > > > > > +          * RPROC_OFFLINE state indicate there is no recovery process
> > > > > > > > > > > > > +          * is in progress and no chance to have pm_relax in place.
> > > > > > > > > > > > > +          * Because when recovering from crash, rproc->lock is held and
> > > > > > > > > > > > > +          * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
> > > > > > > > > > > > > +          * and then unlock rproc->lock.
> > > > > > > > > > > > > +          * RPROC_OFFLINE is only an intermediate state in recovery
> > > > > > > > > > > > > +          * process.
> > > > > > > > > > > > > +          */
> > > > > > > > > > > > > +         if (rproc->state == RPROC_OFFLINE)
> > > > > > > > > > > > > +                 pm_relax(rproc->dev.parent);
> > > > > > > > > > > > >                      return;
> > > > > > > > > > > > >              }
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 2.7.4
> > > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > --
> > > > > > > > > > > Thx and BRs,
> > > > > > > > > > > Aiqun(Maria) Yu
> > > > > > > > 
> > > > > > > > 
> > > > > > > > --
> > > > > > > > Thx and BRs,
> > > > > > > > Aiqun(Maria) Yu
> > > > > > 
> > > > > > 
> > > 
> > > 
> > > -- 
> > > Thx and BRs,
> > > Aiqun(Maria) Yu
> 
> 
> -- 
> Thx and BRs,
> Aiqun(Maria) Yu
