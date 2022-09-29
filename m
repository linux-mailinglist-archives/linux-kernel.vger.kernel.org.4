Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561A5EF366
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiI2KZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiI2KZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:25:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF180F70
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:25:13 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28TAOxeI086108;
        Thu, 29 Sep 2022 19:24:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 29 Sep 2022 19:24:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28TAOxoW086105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Sep 2022 19:24:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <14313951-15f1-0ceb-259c-f251eb140706@I-love.SAKURA.ne.jp>
Date:   Thu, 29 Sep 2022 19:24:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [syzbot] unexpected kernel reboot (8)
Content-Language: en-US
To:     Dmitry Vyukov <dvyukov@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <0000000000008af58705e9b32b1d@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-kernel@vger.kernel.org,
        syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
In-Reply-To: <0000000000008af58705e9b32b1d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a kernel bug but a fuzzer's bug.

Looking at https://syzkaller.appspot.com/text?tag=ReproC&x=155622df080000 ,
this reproducer is reading data from /dev/vcs to [0x20001dc0,0x20003DE0) range,
and passing subset of this range [0x20002300,0x20003300) as "const void *data"
argument of mount() syscall which is interpreted as a string.

That is, this problem happens when console screen buffer by chance contained
kernel messages which the kernel has printk()ed upon boot.

(I defer "#syz invalid" because we need to somehow fix this problem on the fuzzer side.)

On 2022/09/28 11:03, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1707c39ae309 Merge tag 'driver-core-6.0-rc7' of git://git...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17324288880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=8346a1aeed52cb04c9ba
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca1f54880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155622df080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com

