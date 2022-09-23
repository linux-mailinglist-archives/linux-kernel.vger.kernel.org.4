Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0F5E7377
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIWFbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIWFbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942055BF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663911105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4SivS2P1Lqk1gEN/PThsHZtMyz9MXzhKlSjuf2GxnOA=;
        b=WteIsAMpGNrJCEfMfMRj127hItlQXlPOQ7oNxuTwh2Nj8Fb5A2hpUCgCaenxkWA8R3Tuny
        VT/dS6GYJL4XNPji9NEFsO/SJ57PSdtLje8E6bDMLfXOc4b3kWHXCMDAEEDi018OVveX+m
        3Wu95v+0T7iRqqaL639aJpsVV8p9p20=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-dOvPbJjQOOaUzyCTInT3sw-1; Fri, 23 Sep 2022 01:31:39 -0400
X-MC-Unique: dOvPbJjQOOaUzyCTInT3sw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE9CE811E81;
        Fri, 23 Sep 2022 05:31:38 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E211B4B3FC6;
        Fri, 23 Sep 2022 05:31:36 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     cambda@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: Syscall kill() can send signal to thread ID
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
        <87pmfn5tu1.fsf@email.froward.int.ebiederm.org>
Date:   Fri, 23 Sep 2022 07:31:35 +0200
In-Reply-To: <87pmfn5tu1.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Thu, 22 Sep 2022 10:09:42 -0500")
Message-ID: <87r102ejwo.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric W. Biederman:

> cambda@linux.alibaba.com writes:
>
>> I found syscall kill() can send signal to a thread id, which is
>> not the TGID. But the Linux manual page kill(2) said:
>>
>> "The kill() system call can be used to send any signal to any
>> process group or process."
>>
>> And the Linux manual page tkill(2) said:
>>
>> "tgkill() sends the signal sig to the thread with the thread ID
>> tid in the thread group tgid.  (By contrast, kill(2) can be used
>> to send a signal only to a process (i.e., thread group) as a
>> whole, and the signal will be delivered to an arbitrary thread
>> within that process.)"
>>
>> I don't know whether the meaning of this 'process' should be
>> the TGID? Because I found kill(tid, 0) will return ESRCH on FreeBSD,
>> while Linux sends signal to the thread group that the thread belongs
>> to.
>>
>> If this is as expected, should we add a notice to the Linux manual
>> page? Because it's a syscall and the pids not equal to tgid are not
>> listed under /proc. This may be a little confusing, I guess.
>
> This is as expected.
>
> The bit about is /proc is interesting.  On linux try
> "cd /proc; cd tid" and see what happens.
>
> Using the thread id in kill(2) is used to select the process, and the
> delivery happens just the same as if the TGID had been used.
>
> It is one of those odd behaviors that we could potentially remove.  It
> would require hunting through all of the userspace applications to see
> if something happens to depend upon that behavior.  Unless it becomes
> expensive to maintain I don't expect we will ever do that.

It would just replace one odd behavior by another because kill for the
TID of the main thread will still send the signal to the entire process
(because the TID is equal to the PID), but for the other threads, it
would just send it to the thread.  So it would still be inconsistent.

Thanks,
Florian

