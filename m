Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106D86EC052
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjDWOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDWOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:19:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B4330DA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:19:03 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33NEI1bK057487;
        Sun, 23 Apr 2023 23:18:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 23 Apr 2023 23:18:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33NEI1va057479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 23 Apr 2023 23:18:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8904e414-6b3e-8fa3-67e1-709d51965372@I-love.SAKURA.ne.jp>
Date:   Sun, 23 Apr 2023 23:17:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6bec279c-07b3-d6f1-0860-4d6b136a2025@I-love.SAKURA.ne.jp>
 <2023042347-vaguely-monsieur-63ed@gregkh>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023042347-vaguely-monsieur-63ed@gregkh>
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

On 2023/04/23 23:03, Greg Kroah-Hartman wrote:
>> Next step is to convert from
>>
>>   if (!f_op->$callbackname) {
>>     return error;
>>   }
>>   return f_op->$callbackname($args);
>>
>> to
>>
>>   fn = READ_ONCE(f_op->$callbackname);
>>   if (!fn) {
>>     return error;
>>   }
>>   return fn($args);
>>
>> pattern.
> 
> Why?  What does this solve differently than the first one?  What can
> change the fops pointer between the check and call path?  If something
> can change it, then do NOT make that type of check in the first place
> (or put a proper lock in place.)

__tty_hangup() is changing filp->f_op like

	spin_lock(&tty->files_lock);
	/* This breaks for file handles being sent over AF_UNIX sockets ? */
	list_for_each_entry(priv, &tty->tty_files, list) {
		filp = priv->file;
		if (filp->f_op->write_iter == redirected_tty_write)
			cons_filp = filp;
		if (filp->f_op->write_iter != tty_write)
			continue;
		closecount++;
		__tty_fasync(-1, filp, 0);	/* can't block */
		filp->f_op = &hung_up_tty_fops;
	}
	spin_unlock(&tty->files_lock);

but filp->f_op readers are (of course) not protected by tty->files_lock.
Like Dmitry mentioned

  hung_up_tty_fops does not have splice_read, while other fops have.

, patterns like

	if (unlikely(!in->f_op->splice_read))
	    return warn_unsupported(in, "read");
	return in->f_op->splice_read(in, ppos, pipe, len, flags);

is not safe (if compiler generates a code that re-reads the pointer).

Using READ_ONCE() is for preventing the compiler to re-read, and using data_race()
is for teaching KCSAN that race while happens during READ_ONCE()/WRITE_ONCE()
is acceptable.

>> First step (which Dmitry mentioned) is to avoid potential NULL pointer dereferences
>> caused by
>>
>>   if (!f_op->$callbackname) {
>>     return error;
>>   }
>>   return f_op->$callbackname($args);
>>
>> pattern, for the next step will touch too many locations to change all at once whereas
>> the first step could be handled by implementing dummy function for all missing $callbackname.
> 
> I do not understand, what "callbackname" is the problem here?  Just
> splice_read?  Something else?

I haven't checked.

>                                And where would it need to be modified
> and why can't we do it in one place only (i.e. install a default handler
> instead.)

Yes, adding a dummy splice_read callback handler to hung_up_tty_fops is
what I call the first step.

