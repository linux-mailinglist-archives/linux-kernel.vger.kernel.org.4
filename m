Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3368D855
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjBGNIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjBGNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:08:40 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A239CD5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:08:10 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 317D7KXf001231;
        Tue, 7 Feb 2023 22:07:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 07 Feb 2023 22:07:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 317D7Kmo001228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Feb 2023 22:07:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
Date:   Tue, 7 Feb 2023 22:07:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <Y95h7Vop9t5Li0HD@kroah.com>
 <a236ab6b-d38c-3974-d4cb-5e92d0877abc@I-love.SAKURA.ne.jp>
 <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/07 0:45, Alan Stern wrote:
> On Mon, Feb 06, 2023 at 11:13:38PM +0900, Tetsuo Handa wrote:
>> On 2023/02/05 10:23, Alan Stern wrote:
>>> I suppose we could create separate lockdep classes for every bus_type 
>>> and device_type combination, as well as for the different sorts of 
>>> devices -- treat things like class devices separately from normal 
>>> devices, and so on.  But even then there would be trouble.
>>
>> Sorry, since I'm not familiar with devices, I can't interpret what you
>> are talking about in this response. But why don't you try test5() approach
>> in an example module shown below (i.e. treat all dev->mutex instances
>> independent to each other) ?
>>
>> Sharing mutex_init() (like test2() approach) causes false positives,
>> but allocating a key on each dev->mutex (like test5() approach) should
>> avoid false positives.
> 
> Interesting idea.  I'm doubtful that it will accomplish all that you 
> want.  After all, one of lockdep's biggest advantages is that it can 
> detect the potential for deadlocks without a deadlock actually 
> occurring.  By putting each mutex into its own class, you lose much of 
> this ability.
> 
> But who knows?  Maybe it will be a big help.
> 
> Anyway, below is a patch you can try, based on the code for your test5.  
> Let me know what happens.
> 

It boots, except lockdep_register_key() hit WARN_ON_ONCE() at
device_register(&platform_bus) from platform_bus_init(), for
platform_bus is a static object.

  struct device platform_bus = {
  	.init_name	= "platform",
  };

We need to skip lockdep_register_key()/lockdep_unregister_key() on
static "struct device" instances...

----------
[    0.550046][    T1] smpboot: Total of 12 processors activated (74513.31 BogoMIPS)
[    0.559082][    T1] devtmpfs: initialized
[    0.560054][    T1] ------------[ cut here ]------------
[    0.562046][    T1] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:1223 lockdep_register_key+0x1a2/0x230
[    0.564046][    T1] Modules linked in:
[    0.565050][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc7+ #16
[    0.567046][    T1] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[    0.569077][    T1] RIP: 0010:lockdep_register_key+0x1a2/0x230
[    0.571046][    T1] Code: 89 03 4a 89 1c e5 60 b1 e8 84 48 85 c0 0f 84 27 ff ff ff 8b 3d c7 68 f8 01 48 89 58 08 85 ff 0f 85 54 ff ff ff e9 1a ff ff ff <0f> 0b 5b 41 5c 41 5d 41 5e 5d c3 89 c6 48 c7 c7 70 41 05 85 e8 35
[    0.573046][    T1] RSP: 0000:ffffadbb00017e80 EFLAGS: 00010202
[    0.575046][    T1] RAX: 0000000000000001 RBX: ffffffff8443f5d0 RCX: 0000000000000000
[    0.577054][    T1] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff8443f5d0
[    0.579069][    T1] RBP: ffffadbb00017ea0 R08: 0000000000000003 R09: 0000000000000000
[    0.581069][    T1] R10: d6bf87c490213bdc R11: 0000000000000001 R12: ffffffff8443f5d0
[    0.583069][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.585058][    T1] FS:  0000000000000000(0000) GS:ffff9b7ef6e00000(0000) knlGS:0000000000000000
[    0.587046][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.589046][    T1] CR2: ffff9b7df0202000 CR3: 000000012f011001 CR4: 0000000000370ef0
[    0.591046][    T1] Call Trace:
[    0.592310][    T1]  <TASK>
[    0.594046][    T1]  device_initialize+0x5f/0x170
[    0.595046][    T1]  device_register+0xd/0x20
[    0.597046][    T1]  platform_bus_init+0x16/0x4d
[    0.598061][    T1]  driver_init+0x2e/0x3a
[    0.600054][    T1]  kernel_init_freeable+0xc3/0x1d2
[    0.601051][    T1]  ? rest_init+0x190/0x190
[    0.603051][    T1]  kernel_init+0x15/0x120
[    0.604273][    T1]  ret_from_fork+0x1f/0x30
[    0.606058][    T1]  </TASK>
[    0.607069][    T1] irq event stamp: 38345
[    0.608284][    T1] hardirqs last  enabled at (38357): [<ffffffff830d9953>] __up_console_sem+0x53/0x60
[    0.610046][    T1] hardirqs last disabled at (38370): [<ffffffff830d9938>] __up_console_sem+0x38/0x60
[    0.613054][    T1] softirqs last  enabled at (38314): [<ffffffff838d54db>] __do_softirq+0x30b/0x46f
[    0.615061][    T1] softirqs last disabled at (38309): [<ffffffff8306e859>] irq_exit_rcu+0xb9/0xf0
[    0.617059][    T1] ---[ end trace 0000000000000000 ]---
[    0.622102][    T1] ACPI: PM: Registering ACPI NVS region [mem 0xbfeff000-0xbfefffff] (4096 bytes)
[    0.625130][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
----------


