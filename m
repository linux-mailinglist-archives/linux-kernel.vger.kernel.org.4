Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD86EBFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDWN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 09:29:28 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1223A170F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 06:29:26 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33NDT49p048095;
        Sun, 23 Apr 2023 22:29:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sun, 23 Apr 2023 22:29:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33NDT0FU048074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Apr 2023 22:29:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6bec279c-07b3-d6f1-0860-4d6b136a2025@I-love.SAKURA.ne.jp>
Date:   Sun, 23 Apr 2023 22:28:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/04/21 17:21, Dmitry Vyukov wrote:
> On Fri, 21 Apr 2023 at 10:18, syzbot
> <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fcd476ea6a88 Merge tag 'urgent-rcu.2023.03.28a' of git://g..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=146618b9c80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
>> dashboard link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/f3d8ce4faab0/disk-fcd476ea.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/fc53d9dee279/vmlinux-fcd476ea.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/22ad755d39b2/bzImage-fcd476ea.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com
> 
> If I am reading this correctly, this race can lead to NULL derefs
> among other things.
> hung_up_tty_fops does not have splice_read, while other fops have.
> 
> So the following code in splice can execute NULL callback:
> 
> if (unlikely(!in->f_op->splice_read))
>     return warn_unsupported(in, "read");
> return in->f_op->splice_read(in, ppos, pipe, len, flags);

Hmm, it seems to me that we need multiple patches (which would become too big to
backport) for fixing this bug.

First step (which Dmitry mentioned) is to avoid potential NULL pointer dereferences
caused by

  if (!f_op->$callbackname) {
    return error;
  }
  return f_op->$callbackname($args);

pattern, for the next step will touch too many locations to change all at once whereas
the first step could be handled by implementing dummy function for all missing $callbackname.

Next step is to convert from

  if (!f_op->$callbackname) {
    return error;
  }
  return f_op->$callbackname($args);

to

  fn = READ_ONCE(f_op->$callbackname);
  if (!fn) {
    return error;
  }
  return fn($args);

pattern.

Last step is to silence KCSAN by wrapping READ_ONCE()/WRITE_ONCE() using data_race() macro.
Each data_race() usage wants a comment, thus would want a macro if possible...

