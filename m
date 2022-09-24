Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6853F5E87E0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiIXDQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 23:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiIXDQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:16:45 -0400
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BDE19C1A;
        Fri, 23 Sep 2022 20:16:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=cambda@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQYdkqQ_1663989398;
Received: from smtpclient.apple(mailfrom:cambda@linux.alibaba.com fp:SMTPD_---0VQYdkqQ_1663989398)
          by smtp.aliyun-inc.com;
          Sat, 24 Sep 2022 11:16:39 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Syscall kill() can send signal to thread ID
From:   Cambda Zhu <cambda@linux.alibaba.com>
In-Reply-To: <874jwx4wjl.fsf@email.froward.int.ebiederm.org>
Date:   Sat, 24 Sep 2022 11:16:38 +0800
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <797881AA-14C7-49EF-AEBB-70D544942ECE@linux.alibaba.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
 <87k05v5sqn.fsf@email.froward.int.ebiederm.org>
 <59403595-9F9B-49C4-AB62-259DD2C40196@linux.alibaba.com>
 <874jwx4wjl.fsf@email.froward.int.ebiederm.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 24, 2022, at 05:21, Eric W. Biederman <ebiederm@xmission.com> wrote:
> 
> "cambda@linux.alibaba.com" <cambda@linux.alibaba.com> writes:
> 
>>> On Sep 22, 2022, at 23:33, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> 
>>> cambda@linux.alibaba.com writes:
>>> 
>>>> I found syscall kill() can send signal to a thread id, which is
>>>> not the TGID. But the Linux manual page kill(2) said:
>>>> 
>>>> "The kill() system call can be used to send any signal to any
>>>> process group or process."
>>>> 
>>>> And the Linux manual page tkill(2) said:
>>>> 
>>>> "tgkill() sends the signal sig to the thread with the thread ID
>>>> tid in the thread group tgid.  (By contrast, kill(2) can be used
>>>> to send a signal only to a process (i.e., thread group) as a
>>>> whole, and the signal will be delivered to an arbitrary thread
>>>> within that process.)"
>>>> 
>>>> I don't know whether the meaning of this 'process' should be
>>>> the TGID? Because I found kill(tid, 0) will return ESRCH on FreeBSD,
>>>> while Linux sends signal to the thread group that the thread belongs
>>>> to.
>>>> 
>>>> If this is as expected, should we add a notice to the Linux manual
>>>> page? Because it's a syscall and the pids not equal to tgid are not
>>>> listed under /proc. This may be a little confusing, I guess.
>>> 
>>> How did you come across this?  Were you just experimenting?
>>> 
>>> I am wondering if you were tracking a bug, or a portability problem
>>> or something else.  If the current behavior is causing problems in
>>> some way instead of just being a detail that no one really cares about
>>> either way it would be worth considering if we want to maintain the
>>> current behavior.
>>> 
>>> Eric
>> 
>> I have found I can cd into /proc/tid, and the proc_pid_readdir()
>> uses next_tgid() to filter tid. Also the 'ps' command reads the
>> /proc dir to show processes. That's why I was confused with kill().
>> 
>> And yes, I'm tracking a bug. A service monitor, like systemd or
>> some watchdog, uses kill() to check if a pid is valid or not:
>>  1. Store service pid into cache.
>>  2. Check if pid in cache is valid by kill(pid, 0).
>>  3. Check if pid in cache is the service to watch.
>> 
>> So if kill(pid, 0) returns success but no process info shows on 'ps'
>> command, the service monitor could be confused. The monitor could
>> check if pid is tid, but this means the odd behavior would be used
>> intentionally. And this workaround may be unsafe on other OS?
>> 
>> I'm agreed with you that this behavior shouldn't be removed, in case
>> some userspace applications use it now.
> 
> As has already been mentioned using pids and api's like kill is
> fundamentally racy.  We try and to keep from reusing pids too quickly.
> Unfortunately what we have is that on average there will be some time
> between pid reuse not an kind of worst case guarantee.
> 
> We have slowly been introducing techniques into linux allow combatting
> that.  A directory processes directory in proc that you have open will
> never point to another process even after the pid is reused.  Similarly
> we have pidfd that will associate with a specific process and will not
> associate with any other process even if the processes pid is reused.
> 
> That is we have userspace pid value reuse, but we don't reuse struct pid
> in the kernel.
> 
> Unfortunately I don't think there is anything that allows these races to
> be addressed in a portable manner.
> 
> Eric

I got it. Thank you!

Regards,
Cambda
