Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECEC639F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiK1CSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK1CSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:18:36 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477BC745;
        Sun, 27 Nov 2022 18:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1669601913; x=1701137913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vJFL7sJjfRts0fZCfvtWxpeLKsNZ5FaBTVjgn+B3VlA=;
  b=RYsQH383js8gJFjNoFOMW6ZN+IN8p0e50JBi3Gj/dAIGv5Dua3T2dDkh
   bO77Heb30g3w+mFahFJ1wx7l9MlyMQ/lMnHy6S16juckcTGTs2ZRcNYpu
   /+XJ6IVAnmGzL382cyLRPP3bx014cWVeiWWYIJcNuxxNIZWaodrMykQF5
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Nov 2022 18:18:33 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 18:18:33 -0800
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 27 Nov
 2022 18:18:31 -0800
Message-ID: <3c166721-2957-95c4-eb5e-a7ec9ffe00f0@quicinc.com>
Date:   Mon, 28 Nov 2022 10:18:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <414aacb1-e68b-a9a7-3b99-12bc56494f6f@quicinc.com>
 <20221102180350.GA1733006@p14s>
 <4c3d38c9-a43e-97bd-c7f9-3d21240e9d0e@quicinc.com>
 <20221104155915.GC1873068@p14s>
 <0f2b805c-5b01-138d-3e76-f6ed866be7ef@quicinc.com>
 <CANLsYkwxY_UPw4552XdM=jcGS7NGC1L9OsVYG_D9C4JFHXSE=Q@mail.gmail.com>
 <18baf686-ab5f-3d5b-fb9e-c8edb8e2ca4e@quicinc.com>
 <20221114211830.GB8042@p14s>
 <9a64696f-5cd1-56af-3a1f-19d0b3420f46@quicinc.com>
 <20221118185246.GB262671@p14s> <20221125183723.GB622847@p14s>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20221125183723.GB622847@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2022 2:37 AM, Mathieu Poirier wrote:
> On Fri, Nov 18, 2022 at 11:52:46AM -0700, Mathieu Poirier wrote:
>> On Tue, Nov 15, 2022 at 09:30:58AM +0800, Aiqun(Maria) Yu wrote:
>>> Hi,
>>>
>>> On 11/15/2022 5:18 AM, Mathieu Poirier wrote:
>>>> On Fri, Nov 11, 2022 at 08:52:11AM +0800, Aiqun(Maria) Yu wrote:
>>>>> On 11/11/2022 4:50 AM, Mathieu Poirier wrote:
>>>>>> I had a couple of good discussions with our power management expert
>>>>>> and even then, the way forward isn't as clear as I would have liked.
>>>>>> I am currently travelling and as such don't have the required time to
>>>>>> go into greater details, something I will be doing next week.
>>>>>>
>>>>> Thx Mathieu for the info updated.
>>>>> I'll wait for your update next week then.
>>>>> let me know any initial questions that you have, perhaps I can also discuss
>>>>> that with our power team at the same time.
>>>>
>>>> The problem is to determine exactly what the WQ_FREEZABLE flag does to the
>>>> rproc_recovery_wq workueue.  The documentation [1] indicate that work items on the WQ are
>>>> drained before the system is suspended.  What I understand from this is that if
>>>> two work items are queued and one is executing at the time a system suspend is
>>>> initiated, all three items will be executed before the system is allowed to be
>>>> suspended.  _If_ that is the case, there would not be a need to call
>>>> pm_stay_awake() and pm_relax() at all.
>>>>
>>>> On the other hand, the PM resource I spoke to thought that in reality things
>>>> don't happen that way.  Taking the same above scenario where 2 work items are
>>>> queued and one is executing at the time of the suspend, only the work item that
>>>> is executing will be allowed to execute to completion before the system is
>>>> suspended.  The remaining two items that were queued will not execute.
>>>>
>>>> If that is the case then we do need to call pm_stay_awake() and pm_relax(), and
>>>> find another strategy to fix this situation.
>>>>
>>>> Until we have a clear view of how the WQ_FREEZABLE flag works, we won't be able
>>>> to move forward with this patchset.  Unfortunately, I currently do not have the
>>>> time to look into this.
>>> I had a check on the WQ_FREEZABLE flag, here is my understanding:
>>>
>>> when the interrupt happened, it still need pm_stay_awake to make sure
>>> queue_work action can active the work instead of susepend the device.
>>>
>>> 1. If  WQ_FREEZABLE, pwq->max_active = 0; // maximum number of in-flight
>>> work items is set to 0.
>>>
>>> [1].
>>> https://elixir.bootlin.com/linux/v6.1-rc4/source/kernel/workqueue.c#L3748
>>>
>>> 2. If  WQ_FREEZABLE, will only check pwq->nr_active to see if there is still
>>> freeze_workqueues_busy.
>>> [2].
>>> https://elixir.bootlin.com/linux/v6.1-rc4/source/kernel/workqueue.c#L5270
>>>
>>> 3. When in queue_work, if max_active is 0, when do queue_work it will not
>>> actually active the work.
>>> [3].
>>> https://elixir.bootlin.com/linux/v6.1-rc4/source/kernel/workqueue.c#L1418
>>>
>>> for the current issue, the work is already complete and forget to set
>>> pm_relax in some condition that make the system cannot be suspended.
>>
>> What you have above does not describe what happens to work already queue to a
>> WQ_FREEZABLE workqueue when the system gets suspended, and that is the most
>> important thing.
>>
>> I ended up doing that investigation myself and found the documentation on
>> WQ_FREEZABLE seems to be accurate.  I am still discussing this with the Linaro
>> power management team and will get back to you when we reach a conclusion.
>>
> 
> I finally have time to get back to this problem...
> 
> As I reported above I went down to the bottom of how WQ_FREEZABLE workqueues
> work.  The conclusion of that research is that _any_ work, queued or currently
> executing, will finish before the system is suspended.  As such, as soon as
> queue_work() returns in rproc_report_crash(), you can be guaranteed what was
> just queued will be executed.  Therefore, calling pm_stay_awake() in
> rproc_report_crash() and pm_relax() in rproc_crash_handler_work() should not be
> needed because the system will not suspend for as long as there is work to be
> done by the freezable worqueues.
> 
The problem is when crash interrupt happened in a later point(after 
freeze_kernel_thread), the queue_work will result with the state of 
WORK_STRUCT_INACTIVE and insert to inactive_works.
And this is the senario that pm_stay_awake wanted to address inside the 
interrupt handler call.

refer to:
[1] 
https://elixir.bootlin.com/linux/v6.1-rc4/source/kernel/workqueue.c#L1512

the current suspend simple flow can be:

         +-+-------------------+
         |   freeze_processes  |
         +----------+----------+
                    |
                    |
        +-----------|-----------+
        | freeze_kernel_thread  |
        +-----------+-----------+
                    |
         +-+--------|----------+
         |   device_suspend    |
         +----------|----------+
                    |
                    |
        +-----------+-----------+
        | pm_wakeup_pending     |
        +-----------|-----------+
                    |
                    |
  +-----------------+-------------------+
  | suspend_ops->enter (machine suspend)|
  +-------------------------------------+


refer to:
suspend_prepare -> suspend_freeze_processes -->freeze_processes and 
freeze_kernel_threads



refer to:

suspend_devices_and_enter -->
dpm_suspend_start -> dpm_suspend --> device_suspend --> device suspend 
callbacks
suspend_enter -->dpm_suspend_late-->device_suspend_late

[2] 
https://elixir.bootlin.com/linux/v6.1-rc4/source/kernel/power/suspend.c#L582

> I don't have details on what Rishabh - the author of the patch that added the
> calls - was facing but based on the my understanding of freezable workqueues, it
> seem to have been the wrong solution.
In my opinion, the freezable workqueues are in the right solution. It 
only protect for the system freeze state.
While if we want the crash interrupt to be handled to prevent current 
suspend process, it still need to deal with other suspend state to 
machin suspend senarios.
Typical example can be before disable the device interrupt in device 
suspend callbacks, it will flush the necessary workqueues.

while in our case, since the crash handler will invoke a subsystem 
restart process which reply on user thread uevent firmware loaders, so 
it need to abort the suspend process with pm_stay_awake called.

So in a word, pm_stay_awake is necessary per my understanding.

> 
> Until we have a clear vision on what Rishabh was trying to fix, nothing in that
> area will be changing.  I suggest you touch base with him and sort it out.  If
> that is not possible then calls to pm_stay_awake() and pm_relax() should be
> removed.
> 
>>>
>>>>
>>>> If you want to take on this investigation, keep in mind that any conclusion will
>>>> need to be backed by a proof.  That can be debug messages on a console output or
>>>> a code reference in the workqueue core.
>>>>
>>>> [1]. https://elixir.bootlin.com/linux/v6.1-rc4/source/Documentation/core-api/workqueue.rst#L184
>>>>
>>>>
>>>>>> On Sun, 6 Nov 2022 at 18:14, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>> On 11/4/2022 11:59 PM, Mathieu Poirier wrote:
>>>>>>>> On Thu, Nov 03, 2022 at 10:03:49AM +0800, Aiqun(Maria) Yu wrote:
>>>>>>>>> On 11/3/2022 2:03 AM, Mathieu Poirier wrote:
>>>>>>>>>> On Wed, Nov 02, 2022 at 06:53:49PM +0800, Aiqun(Maria) Yu wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> Let me think about this carefully.
>>>>>>>>>>>
>>>>>>>>>>> When in RPROC_RECOVERY_FAIL case we want to re-do the recovery process again
>>>>>>>>>>> or just leave the pm_relax?
>>>>>>>>>>
>>>>>>>>>> Neither.
>>>>>>>>>>
>>>>>>>>>> When a recovery fail we don't want to call pm_relax().  The code in
>>>>>>>>>> rproc_crash_handler_work() becomes:
>>>>>>>>>>
>>>>>>>>>>        if (rproc->state == RPROC_OFFLINE) {
>>>>>>>>>>                      /* We have raced with rproc_shutdown() */
>>>>>>>>>>                      pm_relax()
>>>>>>>>>>                mutex_unlock(&rproc->lock);
>>>>>>>>>>                return;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>>        if (rproc->state == RPROC_CRASHED ||
>>>>>>>>>>                  rproc->state == RPROC_RECOVERY_FAILED) {
>>>>>>>>>>                /* handle only the first crash detected */
>>>>>>>>>>                mutex_unlock(&rproc->lock);
>>>>>>>>>>                return;
>>>>>>>>>>        }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> RPROC_RECOVERY_FAILED gets set in rproc_boot_recovery() if request_firmware() or
>>>>>>>>>> rproc_start() fail.  Function rproc_trigger_recovery() needs to allow for the
>>>>>>>>>> recovery the the remote processor is in RPROC_RECOVERY_FAILED state.  As such
>>>>>>>>>> the condition becomes:
>>>>>>>>>>
>>>>>>>>>>              /* State could have changed before we got the mutex */
>>>>>>>>>>        if (rproc->state != RPROC_CRASHED &&
>>>>>>>>>>                  rproc->state != RPROC_RECOVERY_FAILED)
>>>>>>>>>>                goto unlock_mutex;
>>>>>>>>>>
>>>>>>>>>> Start with that and we can look at corner cases (if some exists) with a fresh
>>>>>>>>>> patchset.  Note that I have not addressed the attach/detach() scenario in the
>>>>>>>>>> above.
>>>>>>>>>
>>>>>>>>> If we didn't deal with the recovery failed case with correct pm_relax call,
>>>>>>>>> it may left the device in a state that cannot enter to suspend state.
>>>>>>>>
>>>>>>>> That is what I am looking for.  We don't want to give the impression that
>>>>>>>> everything is fine by allowing the device to suspend.  If the remote processor
>>>>>>>> can't be recovered than it needs to be dealth with.
>>>>>>> For the normal recovery failed case, it still need to do pm_relax to not
>>>>>>> prevent the device goes to suspend. It is what in normal recovery failed
>>>>>>> case we do in rproc_crash_handler_work as well.
>>>>>>> rproc_crash_handler_work will not check the result of the
>>>>>>> rproc_trigger_recovery return value, and will always do pm_relax.
>>>>>>>
>>>>>>> For current conconrency cornor case as well, it is better to consistant
>>>>>>> with the current design of recovery fail senarios in normal cases.
>>>>>>>
>>>>>>> I personally agree that we shouldn't do nothing when it is a
>>>>>>> RPROC_RECOVERY_FAILED senario when it is in rproc_crash_handler_work
>>>>>>> check, because it maybe crash happened when it is trying to do the recovery.
>>>>>>> So I suggested to do a continue try of trigger recovery again instead of
>>>>>>> doing nothing and bail out if it is a RPROC_RECOVERY_FAILED state.
>>>>>>>
>>>>>>>>
>>>>>>>>> Because first PROC_RECOVERY_FAIL case cannot ensure it have pm_relax called
>>>>>>>>> before the second crash handler call pm_stay_awake or not.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I've been thinking about that part.  I don't think adding a wake_count to
>>>>>>>> control calls to pm_stay_awake()/pm_relax() is the best way to go.  There is a
>>>>>>>> similar count happening in the PM runtime subsystem and that is what we should
>>>>>>>> be using.  I have asked a power management expert at Linaro for guidance with
>>>>>>>> this matter.  I should be able to get back to you with a way forward by the end
>>>>>>>> of next week.
>>>>>>>>
>>>>>>> Thx for the specific date provided as well. I will wait until your reply
>>>>>>> for next patchset then.
>>>>>>>
>>>>>>>>> So, What about the atomic count along with pm_relax and pm_stay_awake ?
>>>>>>>>>
>>>>>>>>> struct rproc{
>>>>>>>>> ...
>>>>>>>>> atomic_t wake_count;
>>>>>>>>> ...
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> rproc_pm_stay_awake()
>>>>>>>>> {
>>>>>>>>>         atomic_inc(&wake_count);
>>>>>>>>>         pm_stay_awake();
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> rproc_pm_relax()
>>>>>>>>> {
>>>>>>>>>         if (atomic_dec_return(&wake_count) == 0)
>>>>>>>>>                 pm_stay_awake();
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> can refer code like:
>>>>>>>>>
>>>>>>>>> rproc_report_crash()
>>>>>>>>> {
>>>>>>>>>         ...
>>>>>>>>>         rproc_pm_stay_awake();
>>>>>>>>>         queue_work();
>>>>>>>>>         ...
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> rproc_crash_handler_work()
>>>>>>>>> {
>>>>>>>>>         ...
>>>>>>>>>         if (rproc->state == RPROC_OFFLINE || rproc->state == RPROC_CRASHED) {
>>>>>>>>>                       /* We have raced with rproc_shutdown() */
>>>>>>>>>                       rproc_pm_relax();
>>>>>>>>>                 mutex_unlock(&rproc->lock);
>>>>>>>>>                 return;
>>>>>>>>>               }
>>>>>>>>>         ...
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Mathieu
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> recovery fail case 1:
>>>>>>>>>>> |                                      |firstcrash interrupt issued
>>>>>>>>>>> | second crashed interrupt issued      | rproc_report_crash()
>>>>>>>>>>> | rproc_report_crash()                 |          pm_stay_awake()
>>>>>>>>>>> |          pm_stay_awake()             |          queue_work()
>>>>>>>>>>> |          queue_work()                |rproc_crash_handler_work()
>>>>>>>>>>> |                                      |mutex_lock(&rproc->lock);
>>>>>>>>>>> |                                      |rproc_stop()
>>>>>>>>>>> |rproc_crash_handler_work()            |rproc->state = RPROC_OFFLINE;
>>>>>>>>>>> |                                      |RPROC_RECOVERY_FAIL //new
>>>>>>>>>>> |                                      |mutex_unlock(&rproc->lock);
>>>>>>>>>>> |mutex_lock(&rproc->lock);             |pm_relax()
>>>>>>>>>>> |if (rproc->state == RPROC_OFFLINE)    |
>>>>>>>>>>> |return // shouldn't do pm_relax if RPROC_RECOVERY_FAIL?  |
>>>>>>>>>>> |mutex_unlock(&rproc->lock);           |
>>>>>>>>>>> |                                      |
>>>>>>>>>>> |                                      |
>>>>>>>>>>> |                                      |
>>>>>>>>>>>
>>>>>>>>>>> recovery fail case 2:
>>>>>>>>>>> |                                      |firstcrash interrupt issued
>>>>>>>>>>> |                                      | rproc_report_crash()
>>>>>>>>>>> |                                      |          pm_stay_awake()
>>>>>>>>>>> |                                      |          queue_work()
>>>>>>>>>>> |                                      |rproc_crash_handler_work()
>>>>>>>>>>> |                                      |mutex_lock(&rproc->lock);
>>>>>>>>>>> |                                      |rproc_stop()
>>>>>>>>>>> |                                      |rproc->state = RPROC_OFFLINE;
>>>>>>>>>>> |                                      |RPROC_RECOVERY_FAIL //new
>>>>>>>>>>> |                                      |mutex_unlock(&rproc->lock);
>>>>>>>>>>> |                                      |pm_relax()
>>>>>>>>>>> |
>>>>>>>>>>> | second crashed interrupt issued      |
>>>>>>>>>>> | rproc_report_crash()                 |
>>>>>>>>>>> |          pm_stay_awake()             |
>>>>>>>>>>> |          queue_work()                |
>>>>>>>>>>> |pm_stay_awake()
>>>>>>>>>>> |mutex_lock(&rproc->lock);
>>>>>>>>>>> |if (rproc->state == RPROC_OFFLINE)    |
>>>>>>>>>>> |return // still need do pm_relax if RPROC_RECOVERY_FAIL?  |
>>>>>>>>>>> |mutex_unlock(&rproc->lock);           |
>>>>>>>>>>> |                                      |
>>>>>>>>>>> |                                      |
>>>>>>>>>>> |                                      |
>>>>>>>>>>>
>>>>>>>>>>> Maybe I can have:
>>>>>>>>>>> 1. the pm_stay_awake and pm_relax with count based and call with paired for
>>>>>>>>>>> fix current concurency issue.
>>>>>>>>>>> 2. RPROC_RECOVERY_FAIL can be another patch for continue try to do recovery
>>>>>>>>>>> work.
>>>>>>>>>>> 3. handle RPROC_DETACHED case.
>>>>>>>>>>>
>>>>>>>>>>> On 11/2/2022 4:11 AM, Mathieu Poirier wrote:
>>>>>>>>>>>> On Fri, 28 Oct 2022 at 09:31, Arnaud POULIQUEN
>>>>>>>>>>>> <arnaud.pouliquen@foss.st.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 10/24/22 05:17, Aiqun(Maria) Yu wrote:
>>>>>>>>>>>>>> On 10/22/2022 3:34 AM, Mathieu Poirier wrote:
>>>>>>>>>>>>>>> On Wed, 19 Oct 2022 at 23:52, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 10/14/2022 2:03 AM, Mathieu Poirier wrote:
>>>>>>>>>>>>>>>>> On Thu, Oct 13, 2022 at 11:34:42AM -0600, Mathieu Poirier wrote:
>>>>>>>>>>>>>>>>>> On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
>>>>>>>>>>>>>>>>>>> Hi Mathieu,
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
>>>>>>>>>>>>>>>>>>>> Please add what has changed from one version to another, either in a cover
>>>>>>>>>>>>>>>>>>>> letter or after the "Signed-off-by".  There are many examples on how to
>>>>>>>>>>>>>>>>>>>> do that
>>>>>>>>>>>>>>>>>>>> on the mailing list.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thx for the information, will take a note and benefit for next time.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
>>>>>>>>>>>>>>>>>>>>> RPROC_OFFLINE state indicate there is no recovery process
>>>>>>>>>>>>>>>>>>>>> is in progress and no chance to do the pm_relax.
>>>>>>>>>>>>>>>>>>>>> Because when recovering from crash, rproc->lock is held and
>>>>>>>>>>>>>>>>>>>>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>>>>>>>>>>>>>>>>>>>>> and then unlock rproc->lock.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> You are correct - because the lock is held rproc->state should be set to
>>>>>>>>>>>>>>>>>>>> RPROC_RUNNING
>>>>>>>>>>>>>>>>>>>> when rproc_trigger_recovery() returns.  If that is not the case then
>>>>>>>>>>>>>>>>>>>> something
>>>>>>>>>>>>>>>>>>>> went wrong.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before
>>>>>>>>>>>>>>>>>>>> returning,
>>>>>>>>>>>>>>>>>>>> so we know the remote processor was stopped.  Therefore if rproc->state
>>>>>>>>>>>>>>>>>>>> is set
>>>>>>>>>>>>>>>>>>>> to RPROC_OFFLINE something went wrong in either request_firmware() or
>>>>>>>>>>>>>>>>>>>> rproc_start().  Either way the remote processor is offline and the system
>>>>>>>>>>>>>>>>>>>> probably
>>>>>>>>>>>>>>>>>>>> in an unknown/unstable.  As such I don't see how calling pm_relax() can help
>>>>>>>>>>>>>>>>>>>> things along.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
>>>>>>>>>>>>>>>>>>> finished.
>>>>>>>>>>>>>>>>>>> Even if it is multi crash rproc_crash_handler_work contention issue, and
>>>>>>>>>>>>>>>>>>> last rproc_trigger_recovery bailed out with only
>>>>>>>>>>>>>>>>>>> rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
>>>>>>>>>>>>>>>>>>> Since the subsystem may still can be recovered with customer's next trigger
>>>>>>>>>>>>>>>>>>> of rproc_start, and we can make each error out path clean with pm resources.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> I suggest spending time understanding what leads to the failure when
>>>>>>>>>>>>>>>>>>>> recovering
>>>>>>>>>>>>>>>>>>>> from a crash and address that problem(s).
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> In current case, the customer's information is that the issue happened when
>>>>>>>>>>>>>>>>>>> rproc_shutdown is triggered at similar time. So not an issue from error out
>>>>>>>>>>>>>>>>>>> of rproc_trigger_recovery.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> That is a very important element to consider and should have been mentioned
>>>>>>>>>>>>>>>>>> from
>>>>>>>>>>>>>>>>>> the beginning.  What I see happening is the following:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> rproc_report_crash()
>>>>>>>>>>>>>>>>>>                 pm_stay_awake()
>>>>>>>>>>>>>>>>>>                 queue_work() // current thread is suspended
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> rproc_shutdown()
>>>>>>>>>>>>>>>>>>                 rproc_stop()
>>>>>>>>>>>>>>>>>>                         rproc->state = RPROC_OFFLINE;
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> rproc_crash_handler_work()
>>>>>>>>>>>>>>>>>>                 if (rproc->state == RPROC_OFFLINE)
>>>>>>>>>>>>>>>>>>                         return // pm_relax() is not called
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> The right way to fix this is to add a pm_relax() in rproc_shutdown() and
>>>>>>>>>>>>>>>>>> rproc_detach(), along with a very descriptive comment as to why it is needed.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Thinking about this further there are more ramifications to consider.  Please
>>>>>>>>>>>>>>>>> confirm the above scenario is what you are facing.  I will advise on how to
>>>>>>>>>>>>>>>>> move
>>>>>>>>>>>>>>>>> forward if that is the case.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Not sure if the situation is clear or not. So resend the email again.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The above senario is what customer is facing. crash hanppened while at
>>>>>>>>>>>>>>>> the same time shutdown is triggered.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Unfortunately this is not enough details to address a problem as
>>>>>>>>>>>>>>> complex as this one.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> And the device cannto goes to suspend state after that.
>>>>>>>>>>>>>>>> the subsystem can still be start normally after this.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If the code flow I pasted above reflects the problem at hand, the
>>>>>>>>>>>>>>> current patch will not be sufficient to address the issue.  If Arnaud
>>>>>>>>>>>>>>> confirms my suspicions we will have to think about a better solution.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hi Mathiew,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Could you pls have more details of any side effects other then power issue of
>>>>>>>>>>>>>> the current senario?
>>>>>>>>>>>>>> Why the current patch is not sufficient pls?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Have the current senario in details with rproc->lock information in details:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> | subsystem crashed interrupt issued      | user trigger shutdown
>>>>>>>>>>>>>> | rproc_report_crash()                    |
>>>>>>>>>>>>>> |          pm_stay_awake()                |
>>>>>>>>>>>>>> |          queue_work()                   |
>>>>>>>>>>>>>> |                                         |rproc_shutdown
>>>>>>>>>>>>>> |                                         |mutex_lock(&rproc->lock);
>>>>>>>>>>>>>> |                                         |rproc_stop()
>>>>>>>>>>>>>> |rproc_crash_handler_work()               |rproc->state = RPROC_OFFLINE;
>>>>>>>>>>>>>> |                                         |mutex_unlock(&rproc->lock);
>>>>>>>>>>>>>> |mutex_lock(&rproc->lock);                |
>>>>>>>>>>>>>> |if (rproc->state == RPROC_OFFLINE)       |
>>>>>>>>>>>>>> |return // pm_relax() is not called       |rproc_boot
>>>>>>>>>>>>>> |mutex_unlock(&rproc->lock);              |
>>>>>>>>>>>>>> |                                         |mutex_lock(&rproc->lock);
>>>>>>>>>>>>>> |                                         |rproc_start()
>>>>>>>>>>>>>> |                                         |mutex_unlock(&rproc->lock);
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Agree with Mathieu, this is not so simple.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks for looking into this.
>>>>>>>>>>>>
>>>>>>>>>>>>> Here is my view  hoping I haven't missed a point in your discussion or
>>>>>>>>>>>>> an other corner cases.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I tried to analyze the issues (in what follows, the term "condition" means
>>>>>>>>>>>>> the "if" condition in which Aiqun proposes to add the fix) :
>>>>>>>>>>>>>
>>>>>>>>>>>>> I can see 4 use cases with race condition
>>>>>>>>>>>>>
>>>>>>>>>>>>> 1) crash report while already one is treated (rproc_boot_recovery called)
>>>>>>>>>>>>>            => not a real use case as if the remote processor is crashed we
>>>>>>>>>>>>>                     should not have a second crash report
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> That part is of great concern to me.  *Theoretically* we should not
>>>>>>>>>>>> get a new crash report while one has already been dispatched but the
>>>>>>>>>>>> current code accounts for this scenario and as such the possibility
>>>>>>>>>>>> can't be dismissed.  Therefore we need to expect rproc_report_crash()
>>>>>>>>>>>> to be called multiple times before a single instance of
>>>>>>>>>>>> rproc_boot_recovery() is scheduled.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> 2) rproc_stop executed between the queuing of the crash work and the call of
>>>>>>>>>>>>>         rproc_crash_handler_work
>>>>>>>>>>>>>          => rproc->state = RPROC_OFFLINE
>>>>>>>>>>>>>          => we enter in the "condition" and the pm_relax has to be called
>>>>>>>>>>>>>          => This commit fix should solve this use case
>>>>>>>>>>>>>
>>>>>>>>>>>>> 3) rproc_detach executed between the queue of the crash work and the call of
>>>>>>>>>>>>>         rproc_crash_handler_work
>>>>>>>>>>>>>          => rproc->state = RPROC_DETACHED;
>>>>>>>>>>>>>          => we don't go in "the condition" and issue because the recovery reattach
>>>>>>>>>>>>>             to the remote processor
>>>>>>>>>>>>>          => but pm_relax is called
>>>>>>>>>>>>>          => probably need an extra fix to avoid to re-attach
>>>>>>>>>>>>>
>>>>>>>>>>>>> 4) crash report while already one is treated (rproc_attach_recovery called)
>>>>>>>>>>>>>          this one corresponds to an auto reboot of the remote processor, with a
>>>>>>>>>>>>>          new crash
>>>>>>>>>>>>>          => rproc->state = RPROC_CRASHED or rproc->state = RPROC_DETACHED;
>>>>>>>>>>>>>          4)a) rproc->state = RPROC_CRASHED if rproc->recovery_disabled = true
>>>>>>>>>>>>>               => should call pm_relax if rproc->recovery_disabled = true
>>>>>>>>>>>>>               => commit does not work for this use case
>>>>>>>>>>>>>
>>>>>>>>>>>>>          4)b) rproc->state = RPROC_DETACHED if recovery fails
>>>>>>>>>>>>>              => error case with an unstable state
>>>>>>>>>>>>>              => how to differentiate it from the use case 3) ?
>>>>>>>>>>>>>              => introduce a RPROC_RECOVERY_FAIL state?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> The case where a recovery fails needs to be considered and is the
>>>>>>>>>>>> reason the original patch doesn't work.  Right now in
>>>>>>>>>>>> rproc_crash_handler_work(), it is not possible to differentiate
>>>>>>>>>>>> between a legitimate shutdown request (scenario #2 above) and a
>>>>>>>>>>>> recovery that went wrong.  I think introducing RPROC_RECOVERY_FAIL
>>>>>>>>>>>> would greatly simplify things.
>>>>>>>>>>>>
>>>>>>>>>>>> My initial evaluation had not considered the attach/detach scenarios -
>>>>>>>>>>>> thanks for adding that in the mix.
>>>>>>>>>>>>
>>>>>>>>>>>> Aiqun, please send a new patchset that adds a new remote processor
>>>>>>>>>>>> state, i.e RPROC_RECOVERY_FAIL.  There should also be another patch in
>>>>>>>>>>>> that set that takes attach/detach scenarios into account.  The code
>>>>>>>>>>>> between the v6.0 and v6.1 cycle has changed a lot in that area so make
>>>>>>>>>>>> sure to properly rebase.
>>>>>>>>>>>>
>>>>>>>>>>> I will try.
>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Then pm_stay_awake is called when the crash work is queued.
>>>>>>>>>>>>> It seems to me coherent to call the pm_relax in the work handler.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Here is a quick and dirty patch (not tested) that should take into account the
>>>>>>>>>>>>> main use cases ( except 1) and 4)b) )
>>>>>>>>>>>>>
>>>>>>>>>>>>> @@ -2009,8 +2009,18 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>>>>>>>>>>>>
>>>>>>>>>>>>>               mutex_lock(&rproc->lock);
>>>>>>>>>>>>>
>>>>>>>>>>>>> -       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>>>>>>>>>>>>> +       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE ||
>>>>>>>>>>>>> +           rproc->state == RPROC_DETACHED) {
>>>>>>>>>>>>>                       /* handle only the first crash detected */
>>>>>>>>>>>>> +
>>>>>>>>>>>>> +               /*
>>>>>>>>>>>>> +                * call pm-relax in following use cases:
>>>>>>>>>>>>> +                * - the remote processor has been stopped by the user
>>>>>>>>>>>>> +                * - the remote processor is detached
>>>>>>>>>>>>> +                + - the remote proc has an autonomous reset but recovery_disabled is true.
>>>>>>>>>>>>> +                */
>>>>>>>>>>>>> +               if(rproc->state != RPROC_CRASHED || rproc->recovery_disabled)
>>>>>>>>>>>>> +                       pm_relax(rproc->dev.parent);
>>>>>>>>>>>>>                       mutex_unlock(&rproc->lock);
>>>>>>>>>>>>>                       return;
>>>>>>>>>>>>>               }
>>>>>>>>>>>>>
>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>> Arnaud
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>> Mathieu
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> When the state is in RPROC_OFFLINE it means separate request
>>>>>>>>>>>>>>>>>>>>> of rproc_stop was done and no need to hold the wakeup source
>>>>>>>>>>>>>>>>>>>>> in crash handler to recover any more.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>           drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>>>>>>>>>>>>>>>>>>>>>           1 file changed, 11 insertions(+)
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c
>>>>>>>>>>>>>>>>>>>>> b/drivers/remoteproc/remoteproc_core.c
>>>>>>>>>>>>>>>>>>>>> index e5279ed9a8d7..6bc7b8b7d01e 100644
>>>>>>>>>>>>>>>>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>>>>>>>>>>>>>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>>>>>>>>>>>>>>>>>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct
>>>>>>>>>>>>>>>>>>>>> work_struct *work)
>>>>>>>>>>>>>>>>>>>>>                  if (rproc->state == RPROC_CRASHED || rproc->state ==
>>>>>>>>>>>>>>>>>>>>> RPROC_OFFLINE) {
>>>>>>>>>>>>>>>>>>>>>                          /* handle only the first crash detected */
>>>>>>>>>>>>>>>>>>>>>                          mutex_unlock(&rproc->lock);
>>>>>>>>>>>>>>>>>>>>> +         /*
>>>>>>>>>>>>>>>>>>>>> +          * RPROC_OFFLINE state indicate there is no recovery process
>>>>>>>>>>>>>>>>>>>>> +          * is in progress and no chance to have pm_relax in place.
>>>>>>>>>>>>>>>>>>>>> +          * Because when recovering from crash, rproc->lock is held and
>>>>>>>>>>>>>>>>>>>>> +          * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>>>>>>>>>>>>>>>>>>>>> +          * and then unlock rproc->lock.
>>>>>>>>>>>>>>>>>>>>> +          * RPROC_OFFLINE is only an intermediate state in recovery
>>>>>>>>>>>>>>>>>>>>> +          * process.
>>>>>>>>>>>>>>>>>>>>> +          */
>>>>>>>>>>>>>>>>>>>>> +         if (rproc->state == RPROC_OFFLINE)
>>>>>>>>>>>>>>>>>>>>> +                 pm_relax(rproc->dev.parent);
>>>>>>>>>>>>>>>>>>>>>                          return;
>>>>>>>>>>>>>>>>>>>>>                  }
>>>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>>>> 2.7.4
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>> Thx and BRs,
>>>>>>>>>>>>>>>>>>> Aiqun(Maria) Yu
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>> Thx and BRs,
>>>>>>>>>>>>>>>> Aiqun(Maria) Yu
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> --
>>>>>>>>>>> Thx and BRs,
>>>>>>>>>>> Aiqun(Maria) Yu
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> Thx and BRs,
>>>>>>>>> Aiqun(Maria) Yu
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Thx and BRs,
>>>>>>> Aiqun(Maria) Yu
>>>>>
>>>>>
>>>>> -- 
>>>>> Thx and BRs,
>>>>> Aiqun(Maria) Yu
>>>
>>>
>>> -- 
>>> Thx and BRs,
>>> Aiqun(Maria) Yu


-- 
Thx and BRs,
Aiqun(Maria) Yu
