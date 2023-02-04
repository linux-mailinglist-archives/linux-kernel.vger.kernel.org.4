Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4D68AB26
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 17:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBDQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 11:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBDQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 11:12:26 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49183E0;
        Sat,  4 Feb 2023 08:12:24 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 314GCF7C028562;
        Sun, 5 Feb 2023 01:12:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 05 Feb 2023 01:12:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 314GCFP1028559
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Feb 2023 01:12:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
Date:   Sun, 5 Feb 2023 01:12:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
References: <28a82f50-39d5-a45f-7c7a-57a66cec0741@I-love.SAKURA.ne.jp>
 <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/05 0:34, Alan Stern wrote:
>> A few of examples:
>>
>>   https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101
> 
> It's hard to figure out what's wrong from looking at the syzbot report.  
> What makes you think it is connected with dev->mutex?
> 
> At first glance, it seems that the ath6kl driver is trying to flush a 
> workqueue while holding a lock or mutex that is needed by one of the 
> jobs in the workqueue.  That's obviously never going to work, no matter 
> what sort of lockdep validation gets used.

That lock is exactly dev->mutex where lockdep validation is disabled.
If lockdep validation on dev->mutex were not disabled, we can catch
possibility of deadlock before khungtaskd reports real deadlock as hung.

Lockdep validation on dev->mutex being disabled is really annoying, and
I want to make lockdep validation on dev->mutex enabled; that is the
"drivers/core: Remove lockdep_set_novalidate_class() usage" patch.

-------- Forwarded Message --------
Message-ID: <5e4d20a0-08a3-9736-b6ef-cda00acca63f@I-love.SAKURA.ne.jp>
Date: Sun, 3 Jul 2022 23:29:16 +0900
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: INFO: task hung in ath6kl_usb_power_off

I finally found why lockdep was not able to report this deadlock.
device_initialize() was hiding dev->mutex from lockdep tests.
I hope we can get rid of this lockdep_set_novalidate_class()...

Below is a reproducer kernel module. If request_firmware_nowait() called

  INIT_WORK(&fw_work->work, request_firmware_work_func);
  schedule_work(&fw_work->work);

before hub_event() calls

  usb_lock_device(hdev);

, flush_scheduled_work() from hub_event() becomes responsible for flushing
fw_work->work. But flush_scheduled_work() can't flush fw_work->work because
dev->mutex is held by hub_event().

----------------------------------------
#include <linux/module.h>
#include <linux/sched.h>

static DEFINE_MUTEX(mutex);

static void request_firmware_work_func(struct work_struct *work)
{
	schedule_timeout_uninterruptible(HZ); // inject race window for allowing hub_event() to find this work
	mutex_lock(&mutex); // device_lock(parent) from ath9k_hif_usb_firmware_fail() waits for ath6kl_hif_power_off() to release dev->mutex
	mutex_unlock(&mutex); // device_unlock(parent) from ath9k_hif_usb_firmware_fail()
}
static void hub_event(struct work_struct *work)
{
	mutex_lock(&mutex); // usb_lock_device(hdev)
	flush_scheduled_work(); // ath6kl_usb_flush_all() from ath6kl_hif_power_off() waits for request_firmware_work_func() while holding dev->mutex
	mutex_unlock(&mutex); // usb_unlock_device(hdev)
}

static DECLARE_WORK(fw_work, request_firmware_work_func);
static DECLARE_WORK(hub_events, hub_event);

static int __init test_init(void)
{
	lockdep_set_novalidate_class(&mutex); // device_initialize() suppresses lockdep warning
	schedule_work(&fw_work); // request_firmware_nowait() from ath9k driver queues into system_wq
	queue_work(system_freezable_wq, &hub_events); // kick_hub_wq() from usb code queues into hub_wq
	return 0;
}

static void test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);
MODULE_LICENSE("GPL");
----------------------------------------

----------------------------------------
[   38.832553][ T2786] test: loading out-of-tree module taints kernel.
[  187.116969][   T35] INFO: task kworker/0:2:33 blocked for more than 143 seconds.
[  187.121366][   T35]       Tainted: G           O      5.19.0-rc4-next-20220701 #43
[  187.124830][   T35] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  187.128724][   T35] task:kworker/0:2     state:D stack:    0 pid:   33 ppid:     2 flags:0x00004000
[  187.133235][   T35] Workqueue: events_freezable hub_event [test]
[  187.136000][   T35] Call Trace:
[  187.137512][   T35]  <TASK>
[  187.138863][   T35]  __schedule+0x304/0x8f0
[  187.140923][   T35]  schedule+0x40/0xa0
[  187.142940][   T35]  schedule_timeout+0x300/0x3a0
[  187.145341][   T35]  ? mark_held_locks+0x55/0x80
[  187.147518][   T35]  ? wait_for_completion+0x6b/0x130
[  187.149257][   T35]  ? _raw_spin_unlock_irq+0x22/0x30
[  187.151187][   T35]  ? wait_for_completion+0x6b/0x130
[  187.152915][   T35]  ? trace_hardirqs_on+0x3b/0xd0
[  187.154388][   T35]  wait_for_completion+0x73/0x130
[  187.155547][   T35]  __flush_workqueue+0x17b/0x480
[  187.156710][   T35]  ? __mutex_lock+0x12b/0xe10
[  187.157703][   T35]  ? wait_for_completion+0x2d/0x130
[  187.158837][   T35]  hub_event+0x1e/0x30 [test]
[  187.160286][   T35]  ? hub_event+0x1e/0x30 [test]
[  187.161352][   T35]  process_one_work+0x292/0x570
[  187.162565][   T35]  worker_thread+0x2f/0x3d0
[  187.163590][   T35]  ? process_one_work+0x570/0x570
[  187.164779][   T35]  kthread+0xd6/0x100
[  187.165940][   T35]  ? kthread_complete_and_exit+0x20/0x20
[  187.167077][   T35]  ret_from_fork+0x1f/0x30
[  187.168319][   T35]  </TASK>
[  187.169190][   T35] INFO: task kworker/0:3:54 blocked for more than 143 seconds.
[  187.171458][   T35]       Tainted: G           O      5.19.0-rc4-next-20220701 #43
[  187.173380][   T35] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  187.175359][   T35] task:kworker/0:3     state:D stack:    0 pid:   54 ppid:     2 flags:0x00004000
[  187.177660][   T35] Workqueue: events request_firmware_work_func [test]
[  187.179221][   T35] Call Trace:
[  187.180381][   T35]  <TASK>
[  187.181170][   T35]  __schedule+0x304/0x8f0
[  187.182618][   T35]  schedule+0x40/0xa0
[  187.184207][   T35]  schedule_preempt_disabled+0x10/0x20
[  187.186318][   T35]  __mutex_lock+0x650/0xe10
[  187.188527][   T35]  ? request_firmware_work_func+0x1c/0x30 [test]
[  187.190094][   T35]  mutex_lock_nested+0x16/0x20
[  187.191905][   T35]  ? mutex_lock_nested+0x16/0x20
[  187.193159][   T35]  request_firmware_work_func+0x1c/0x30 [test]
[  187.194643][   T35]  process_one_work+0x292/0x570
[  187.195899][   T35]  worker_thread+0x2f/0x3d0
[  187.197031][   T35]  ? process_one_work+0x570/0x570
[  187.198489][   T35]  kthread+0xd6/0x100
[  187.199756][   T35]  ? kthread_complete_and_exit+0x20/0x20
[  187.201224][   T35]  ret_from_fork+0x1f/0x30
[  187.202374][   T35]  </TASK>
[  187.203293][   T35] 
[  187.203293][   T35] Showing all locks held in the system:
[  187.205200][   T35] 1 lock held by rcu_tasks_trace/10:
[  187.206489][   T35]  #0: ffffffffb25bdea0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x28/0x3b0
[  187.209383][   T35] 3 locks held by kworker/0:2/33:
[  187.210930][   T35]  #0: ffff9e2bc004d148 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x215/0x570
[  187.214012][   T35]  #1: ffffac448032fe68 (hub_events){+.+.}-{0:0}, at: process_one_work+0x215/0x570
[  187.217162][   T35]  #2: ffffffffc067b130 (&dev->mutex){....}-{3:3}, at: hub_event+0x12/0x30 [test]
[  187.220277][   T35] 1 lock held by khungtaskd/35:
[  187.221592][   T35]  #0: ffffffffb25be5c0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.56+0x0/0x30
[  187.224310][   T35] 3 locks held by kworker/0:3/54:
[  187.225596][   T35]  #0: ffff9e2bc004cb48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x215/0x570
[  187.228147][   T35]  #1: ffffac4480cebe68 (fw_work){+.+.}-{0:0}, at: process_one_work+0x215/0x570
[  187.230646][   T35]  #2: ffffffffc067b130 (&dev->mutex){....}-{3:3}, at: request_firmware_work_func+0x1c/0x30 [test]
[  187.234203][   T35] 2 locks held by agetty/2729:
[  187.235463][   T35]  #0: ffff9e2bc71740a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0xe/0x10
[  187.237864][   T35]  #1: ffffac448229f2f8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x168/0x5f0
[  187.240571][   T35] 2 locks held by agetty/2731:
[  187.241876][   T35]  #0: ffff9e2bc907b8a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0xe/0x10
[  187.244312][   T35]  #1: ffffac44822a72f8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x168/0x5f0
[  187.246938][   T35] 
[  187.247756][   T35] =============================================
[  187.247756][   T35] 
----------------------------------------

> However, it is always safe to acquire a child device's lock while 
> holding the parent's lock.  Lockdep isn't aware of this because it 
> doesn't understand the hierarchical device tree.  That's why lockdep 
> checking has to be disabled for dev->mutex; if it weren't disabled then 
> it would constantly report false positives.

Even if it is always safe to acquire a child device's lock while holding
the parent's lock, disabling lockdep checks completely on device's lock is
not safe.

