Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF162B67C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiKPJ1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiKPJ1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:27:50 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658A1CC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:27:49 -0800 (PST)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2AG9RkBP048011;
        Wed, 16 Nov 2022 18:27:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 16 Nov 2022 18:27:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2AG9RkVe048008
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Nov 2022 18:27:46 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8a3964bd-41fa-5179-1916-565decd11f50@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Nov 2022 18:27:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [syzbot] INFO: task hung in rfkill_global_led_trigger_worker (2)
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+2e39bc6569d281acbcfb@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
References: <20221116041716.2797-1-hdanton@sina.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221116041716.2797-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/16 13:17, Hillf Danton wrote:
> No deadlock was reported for syz-executor145/4505 and syz-executor145/4516.
> Why?

Lockdep should be able to report this real deadlock case. But unfortunately,

>> INFO: task syz-executor145:4505 blocked for more than 143 seconds.
>>       Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz-executor145 state:D stack:21896 pid:4505  ppid:3645   flags:0x00004002
>> 
>> 2 locks held by syz-executor145/4505:
>>  #0: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>>  #0: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x87/0x290 net/nfc/core.c:1165
>>  #1: ffffffff8e787b08 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unregister+0xcb/0x220 net/rfkill/core.c:1130
>> 
>> INFO: task syz-executor145:4516 blocked for more than 144 seconds.
>>       Not tainted 6.1.0-rc5-syzkaller-00008-ge01d50cbd6ee #0
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:syz-executor145 state:D stack:23096 pid:4516  ppid:3647   flags:0x00004004
>> 
>> 2 locks held by syz-executor145/4516:
>>  #0: ffffffff8e787b08 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x1b3/0x790 net/rfkill/core.c:1278
>>  #1: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
>>  #1: ffff88807268e100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down+0x33/0x260 net/nfc/core.c:143

device_initialize() hides dev->mutex from lockdep tests; explained at
https://groups.google.com/g/syzkaller-bugs/c/Uj9LqEUCwac/m/BhdTjWhNAQAJ .


