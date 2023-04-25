Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD246EEA30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjDYWJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:09:54 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44764524B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 15:09:52 -0700 (PDT)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33PM9XGS055803;
        Wed, 26 Apr 2023 07:09:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 26 Apr 2023 07:09:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33PM9XpN055799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Apr 2023 07:09:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
Date:   Wed, 26 Apr 2023 07:09:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000013aaac05f9d44e7a@google.com>
 <CACT4Y+bj7jCOjGV5jCUPzN5zjgdHxRn9vkwQEBuPWVzMbMCnXw@mail.gmail.com>
 <6ff6fdea-c955-f9dd-289e-b0d613a28280@I-love.SAKURA.ne.jp>
 <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230425160344.GS3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/04/26 1:03, Al Viro wrote:
> On Tue, Apr 25, 2023 at 11:47:20PM +0900, Tetsuo Handa wrote:
>> @@ -743,7 +733,8 @@ void tty_vhangup_session(struct tty_struct *tty)
>>   */
>>  int tty_hung_up_p(struct file *filp)
>>  {
>> -	return (filp && filp->f_op == &hung_up_tty_fops);
>> +	/* Accept race with __tty_hangup(). */
>> +	return filp && data_race(((struct tty_file_private *) filp->private_data)->hung);
>>  }
>>  EXPORT_SYMBOL(tty_hung_up_p);
> 
> Umm...  Are you sure we never call that for non-TTY files?  Seeing that
> it's exported and all such...  For internal uses (tty_read(), etc.) the
> check for file being NULL is pointless; for general-purpose primitive
> we probably want to check ->f_op as well...

Indeed. Since drivers/tty/hvc/hvsi.c drivers/tty/n_hdlc.c drivers/tty/n_tty.c
are calling tty_hung_up_p(), this check should be

  filp && filp->f_op == &tty_fops && data_race(((struct tty_file_private *) filp->private_data)->hung);

.

>> I don't know what changes are required for tty_open() and tty_show_fdinfo().
>> I assume that making no change for tty_show_fdinfo() is harmless.
>> But how does "hung_up_tty_fops does not call tty_open()" affects here?
> 
> It doesn't - file->f_op->open() is only called once, and only on fresh
> struct file.

OK. Then, we can continue tty_hung_up_p() approach.

