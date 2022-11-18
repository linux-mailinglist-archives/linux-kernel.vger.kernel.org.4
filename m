Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F9162EA97
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 01:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiKRAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 19:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240703AbiKRAxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 19:53:46 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C38B19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:53:44 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2AI0rhoG067372;
        Fri, 18 Nov 2022 09:53:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 18 Nov 2022 09:53:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2AI0rgbY067369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Nov 2022 09:53:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d38fe3c3-1f0b-b5f6-2895-aee9476b20bf@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Nov 2022 09:53:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [syzbot] WARNING in call_timer_fn
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>
References: <0000000000009d5daa05ed9815fa@google.com>
 <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com> <87wn7tlg4n.ffs@tglx>
 <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
 <CABBYNZJYbzX9xoqU8_KEArTJ2=5eMTiDTjMbNjEYNVmi1rkp+A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CABBYNZJYbzX9xoqU8_KEArTJ2=5eMTiDTjMbNjEYNVmi1rkp+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/18 6:16, Luiz Augusto von Dentz wrote:
> Wasn't the following patch suppose to address such problem:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=deee93d13d385103205879a8a0915036ecd83261
> 
> It was merged in the last pull request to net-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=a507ea32b9c2c407012bf89109ac0cf89fae313c
> 

No. Commit deee93d13d38 ("Bluetooth: use hdev->workqueue when queuing hdev->{cmd,ncmd}_timer works")
is for handling queue_work() from hci_cmd_timeout(struct work_struct *work) from process_one_work()
(that is, called from a kernel workqueue thread from process context).

But this report says that queue_work() is called from timer interrupt handler from interrupt context
while drain_workqueue(hdev->workqueue) is in progress from process context.

But... is is_chained_work() check appropriate?
Why can't we exclude "timer interrupt handler" from "somebody else" ?

The comment for drain_workqueue() says

 * Wait until the workqueue becomes empty.  While draining is in progress,
 * only chain queueing is allowed.  IOW, only currently pending or running
 * work items on @wq can queue further work items on it.  @wq is flushed
 * repeatedly until it becomes empty.  The number of flushing is determined
 * by the depth of chaining and should be relatively short.  Whine if it
 * takes too long.

but why limited to "only currently pending or running work items on @wq" (that is,
only process context) ?

Although drain_workqueue() is also called from destroy_workqueue() (which would cause
use-after-free bug if interrupt handler calls queue_work() some time after drain_workqueue()),
I think that we can wait for drain_workqueue() to call __flush_workqueue() again if a further
work item is queued from interrupt handler...

Anyway, stopping all works and delayed works before calling drain_workqueue() would address
this problem.

