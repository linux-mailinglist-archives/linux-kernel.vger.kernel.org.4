Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BAB715E38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjE3L7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjE3L7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:59:03 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B974E77
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:58:35 -0700 (PDT)
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 34UBvhEC088902;
        Tue, 30 May 2023 20:57:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Tue, 30 May 2023 20:57:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 34UBvg9Y088899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 May 2023 20:57:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
Date:   Tue, 30 May 2023 20:57:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] tty: tty_io: remove hung_up_tty_fops
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
References: <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023053005-alongside-unvisited-d9af@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/05/30 19:44, Greg Kroah-Hartman wrote:
> On Sun, May 14, 2023 at 10:02:26AM +0900, Tetsuo Handa wrote:
>> If we care about only NULL pointer dereference, implementing missing
>> callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
>> reports, we will need to wrap all filp->f_op usages which are reachable
>> via tty_fops callbacks using data_race().
> 
> I'm missing something here.  Why would KCSAN report problems if we
> implement the needed callbacks in hung_up_tty_fops?  And what reports
> would they be?

Unlike atomic operations such as atomic_read()/atomic_set(), normal read/write
operations are not atomic for KCSAN. KCSAN reports some value being changed
during a read/write.

In this report, KCSAN detected that __tty_hangup() changed the value of
filp->f_op from 0xffffffff84e91ed0 to 0xffffffff84e91dc0 at

  filp->f_op = &hung_up_tty_fops;

line when __fput() was reading the value of filp->f_op at

  if (file->f_op->release)

line.

Even if we implement the needed callbacks in hung_up_tty_fops,
KCSAN will continue reporting that the value of filp->f_op changes.

> 
> And why would data_race() help here?

data_race() tells KCSAN not to report.
data_race() is used when the race KCSAN checks is harmless.



>> @@ -182,7 +182,7 @@ int tty_alloc_file(struct file *file)
>>  {
>>  	struct tty_file_private *priv;
>>  
>> -	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> 
> Why is this zeroing out everything now?  Just because you added one
> bool?  Why not just set the bool properly instead?

Because I consider that this function is not performance critical where
avoid increasing code size by zeroing out everything is acceptable.



>> -static long hung_up_tty_compat_ioctl(struct file *file,
>> +static inline long hung_up_tty_compat_ioctl(struct file *file,
>>  				     unsigned int cmd, unsigned long arg)
>>  {
>>  	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
>>  }
> 
> Marking these as inline, and then treating them as a function pointer,
> seems like a horrid way to work around a compiler warning.  As they
> really are not inline functions anymore, but yet the compiler doesn't
> know that.  Odds are once the compiler gets smarter, the warnings will
> return, so please, solve this properly.

Since this patch removes "struct file_operations hung_up_tty_fops"
which was the only source of treating as a function pointer,
these inlined functions are no longer treated as a function pointer.



>> @@ -619,7 +608,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
>>  			continue;
>>  		closecount++;
>>  		__tty_fasync(-1, filp, 0);	/* can't block */
>> -		filp->f_op = &hung_up_tty_fops;
>> +		/* Accept race with tty_hung_up_p() test. */
>> +		data_race(priv->hung = true);
> 
> Why accept it?  Say why it's not really an issue here.

Because whether tty_hung_up_p() sees true or false due to concurrent
access does not matter. The race KCSAN reported is harmless (unless
callbacks suddenly disappear).



>> @@ -743,7 +733,9 @@ void tty_vhangup_session(struct tty_struct *tty)
>>   */
>>  int tty_hung_up_p(struct file *filp)
>>  {
>> -	return (filp && filp->f_op == &hung_up_tty_fops);
>> +	return filp && filp->f_op == &tty_fops &&
>> +		/* Accept race with __tty_hangup(). */
>> +		data_race(((struct tty_file_private *) filp->private_data)->hung);
> 
> Same here.

Because whether __tty_hangup() already changed from false to true due to
concurrent access does not matter. The race KCSAN reported is harmless (unless
callbacks suddenly disappear).



>> @@ -911,6 +903,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
>>  	struct tty_struct *tty = file_tty(file);
>>  	struct tty_ldisc *ld;
>>  
>> +	if (tty_hung_up_p(file))
>> +		return hung_up_tty_read(iocb, to);
> 
> What happens if you hang up _right_ after this check?  There's no
> locking here, right?  Same everywhere else you have this pattern, you
> made the race window smaller, but it's still there from what I can see.

We cannot close the race window without introducing locking,
but we don't need to close the race window.

The race KCSAN found in this report is harmless, as long as callbacks
reachable via filp->f_op does not disappear.

This patch prevents filp->f_op from suddenly disappearing callbacks,
by not changing the value of filp->f_op.



>> @@ -255,6 +255,7 @@ struct tty_file_private {
>>  	struct tty_struct *tty;
>>  	struct file *file;
>>  	struct list_head list;
>> +	bool hung;
> 
> No hint as to what "hung" means here?

Whether __tty_hangup() was called or not.

