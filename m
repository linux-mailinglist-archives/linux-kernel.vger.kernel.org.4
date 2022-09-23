Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473125E73EF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiIWGZN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Sep 2022 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIWGZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:25:10 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A7E9C23D;
        Thu, 22 Sep 2022 23:25:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=cambda@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVe2Tc_1663914306;
Received: from smtpclient.apple(mailfrom:cambda@linux.alibaba.com fp:SMTPD_---0VQVe2Tc_1663914306)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:25:06 +0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Syscall kill() can send signal to thread ID
From:   "cambda@linux.alibaba.com" <cambda@linux.alibaba.com>
In-Reply-To: <87r102ejwo.fsf@oldenburg.str.redhat.com>
Date:   Fri, 23 Sep 2022 14:25:05 +0800
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0CC7D0E7-71C5-4DAC-8A01-F9E13659F864@linux.alibaba.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
 <87pmfn5tu1.fsf@email.froward.int.ebiederm.org>
 <87r102ejwo.fsf@oldenburg.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 23, 2022, at 13:31, Florian Weimer <fweimer@redhat.com> wrote:
> 
> * Eric W. Biederman:
> 
>> cambda@linux.alibaba.com writes:
>> 
>>> I found syscall kill() can send signal to a thread id, which is
>>> not the TGID. But the Linux manual page kill(2) said:
>>> 
>>> "The kill() system call can be used to send any signal to any
>>> process group or process."
>>> 
>>> And the Linux manual page tkill(2) said:
>>> 
>>> "tgkill() sends the signal sig to the thread with the thread ID
>>> tid in the thread group tgid.  (By contrast, kill(2) can be used
>>> to send a signal only to a process (i.e., thread group) as a
>>> whole, and the signal will be delivered to an arbitrary thread
>>> within that process.)"
>>> 
>>> I don't know whether the meaning of this 'process' should be
>>> the TGID? Because I found kill(tid, 0) will return ESRCH on FreeBSD,
>>> while Linux sends signal to the thread group that the thread belongs
>>> to.
>>> 
>>> If this is as expected, should we add a notice to the Linux manual
>>> page? Because it's a syscall and the pids not equal to tgid are not
>>> listed under /proc. This may be a little confusing, I guess.
>> 
>> This is as expected.
>> 
>> The bit about is /proc is interesting.  On linux try
>> "cd /proc; cd tid" and see what happens.
>> 
>> Using the thread id in kill(2) is used to select the process, and the
>> delivery happens just the same as if the TGID had been used.
>> 
>> It is one of those odd behaviors that we could potentially remove.  It
>> would require hunting through all of the userspace applications to see
>> if something happens to depend upon that behavior.  Unless it becomes
>> expensive to maintain I don't expect we will ever do that.
> 
> It would just replace one odd behavior by another because kill for the
> TID of the main thread will still send the signal to the entire process
> (because the TID is equal to the PID), but for the other threads, it
> would just send it to the thread.  So it would still be inconsistent.
> 
> Thanks,
> Florian

I don't quite understand what you mean, sorry. But if kill() returns -ESRCH for
tid which is not equal to tgid, kill() can only send signal to thread group via
main thread id, that is what BSD did and manual said. It seems not odd?

Regards,
Cambda
