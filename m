Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA64C6F2429
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjD2KoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2KoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:44:13 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F5A1FCC
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 03:44:11 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33TAhme9028302;
        Sat, 29 Apr 2023 19:43:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sat, 29 Apr 2023 19:43:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33TAhmOP028299
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Apr 2023 19:43:48 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2a07bded-25e5-fd27-a2de-8b606e4d1d2c@I-love.SAKURA.ne.jp>
Date:   Sat, 29 Apr 2023 19:43:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tty: tty_io: remove hung_up_tty_fops
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <20230423233433.GF3390869@ZenIV>
 <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <20230428162718.GA1099174@dev-arch.thelio-3990X>
 <6dca757e-74ac-773d-2a50-4e48b2f56880@I-love.SAKURA.ne.jp>
 <20230428171145.GD3390869@ZenIV>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20230428171145.GD3390869@ZenIV>
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

On 2023/04/29 2:11, Al Viro wrote:
> On Sat, Apr 29, 2023 at 01:41:02AM +0900, Tetsuo Handa wrote:
>> On 2023/04/29 1:27, Nathan Chancellor wrote:
>>> I see this change has shown up in -next as commit 4c87e9e5479b ("tty:
>>> tty_io: remove hung_up_tty_fops"), where it causes the following warning
>>> for configurations without CONFIG_COMPAT (I used ARCH=arm defconfig):
>>>
>>>   drivers/tty/tty_io.c:446:13: warning: 'hung_up_tty_compat_ioctl' defined but not used [-Wunused-function]
>>>     446 | static long hung_up_tty_compat_ioctl(struct file *file,
>>>         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> I am not sure if you just added that patch for additional test coverage
>>> or for final acceptance but the following diff resolves this warning for
>>> me, perhaps it can be folded in for a v2?
>>
>> Thank you for reporting. Yes, moving the definition will solve the warning.
> 
> 	IDGI...  Why do you need to keep that function at all?  Compare it
> with hung_up_tty_ioctl() - they are token-for-token identical; the only
> difference is the function name...

Indeed hung_up_tty_ioctl() and hung_up_tty_compat_ioctl() are identical.
We can remove hung_up_tty_compat_ioctl() if we don't consider

 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
-		return hung_up_tty_compat_ioctl(file, cmd, arg);
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (ld->ops->compat_ioctl)
 		retval = ld->ops->compat_ioctl(tty, cmd, arg);

at tty_compat_ioctl() as strange looking.

Maybe adding "inline" keyword to hung_up_tty_*() definitions
because hung_up_tty_fops is removed?

