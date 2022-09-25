Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8B25E9382
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIYNxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiIYNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:53:27 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF592C136
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 06:53:24 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 28PDquPj028689;
        Sun, 25 Sep 2022 22:52:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 25 Sep 2022 22:52:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 28PDquLX028686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 25 Sep 2022 22:52:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e37e3b18-401e-f319-9006-2e2a09111c74@I-love.SAKURA.ne.jp>
Date:   Sun, 25 Sep 2022 22:52:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] kernfs: fix UAF race condition in __kernfs_remove()
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Christian A. Ehrhardt" <lk@c--e.de>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+8bee3285b9e190f1509e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>
References: <000000000000646c9605e714ec6e@google.com>
 <7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp>
 <YzBT+hJ/fmp75j1P@kroah.com>
 <83be5776-4038-90d5-f202-9a6e97b6d551@I-love.SAKURA.ne.jp>
 <YzBaYHqldB39zD17@kroah.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YzBaYHqldB39zD17@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/09/25 22:40, Greg Kroah-Hartman wrote:
> On Sun, Sep 25, 2022 at 10:20:27PM +0900, Tetsuo Handa wrote:
>> On 2022/09/25 22:13, Greg Kroah-Hartman wrote:
>>> Isn't this already handled by:
>>> 	https://lore.kernel.org/r/20220913121723.691454-1-lk@c--e.de
>>>
>>> that will show up in the next linux-next tree.
>>
>> Oh, I didn't know that patch.
>>
>> But is that patch complete, for there are three __kernfs_remove() callers?
>>
> 
> syzbot seems to think it works :)

syzbot's reproducer tested only kernfs_remove_by_name_ns() case.
I'm not sure whether e.g. __kernfs_remove() from kernfs_remove() is safe.

