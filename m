Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7F60B402
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiJXRY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiJXRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA94ABD4D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666626958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DePSS/k3251fhpetLo0djO6EgK928r04EW3rQUElRSQ=;
        b=JBQ6bDNI1shnIZpTp+oqYCr5pR5cE60qoZpJpdSAplZlCiHkQUlMXrlLcRgNU5K+bve66N
        0ds7BDypr0605D5wJwiG51C6OnBDqpjoOZNr3ORgtWrXuYOcTYnInYWq5sRszTN5P97R7a
        u5NoIDt8ki9s/UoZvyugl/SyCbiP/+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-wmdK6Nh6MfiJDIUnwq4YQw-1; Mon, 24 Oct 2022 11:55:55 -0400
X-MC-Unique: wmdK6Nh6MfiJDIUnwq4YQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCB7F811E84;
        Mon, 24 Oct 2022 15:55:53 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB511121315;
        Mon, 24 Oct 2022 15:55:53 +0000 (UTC)
Message-ID: <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
Date:   Mon, 24 Oct 2022 11:55:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/5] locking/rwsem: Limit # of null owner retries for
 handoff writer
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-3-longman@redhat.com>
 <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y1aTpYba1Wwly48+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 09:31, Peter Zijlstra wrote:
> On Mon, Oct 17, 2022 at 05:13:53PM -0400, Waiman Long wrote:
>> Commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically
>> spin on owner") assumes that when the owner field is changed to NULL,
>> the lock will become free soon.  That assumption may not be correct
>> especially if the handoff writer doing the spinning is a RT task which
>> may preempt another task from completing its action of either freeing
>> the rwsem or properly setting up owner.
> I'm confused again -- rwsem_*_owner() has
> lockdep_assert_preemption_disabled(). But more specifically; why can the
> RT task preempt a lock-op like that?

There is a special case raised by Mukesh that can happen. I quoted his 
text here:

---------------------------

Looks like, There is still a window for a race.

There is a chance when a reader who came first added it's BIAS and goes 
to slowpath and before it gets added to wait list it got preempted by RT 
task which  goes to slowpath as well and being the first waiter gets its 
hand-off bit set and not able to get the lock due to following condition 
in rwsem_try_write_lock()

  630                 if (count & RWSEM_LOCK_MASK) {  ==> reader has 
sets its bias
..
...

  634
  635                         new |= RWSEM_FLAG_HANDOFF;
  636                 } else {
  637                         new |= RWSEM_WRITER_LOCKED;


---------------------->----------------------->-------------------------

First reader (1)          writer(2) RT task             Lock holder(3)

It sets
RWSEM_READER_BIAS.
while it is going to
slowpath(as the lock
was held by (3)) and
before it got added
to the waiters list
it got preempted
by (2).
                         RT task also takes
                         the slowpath and add              release the
                         itself into waiting list          rwsem lock
             and since it is the first         clear the
                         it is the next one to get         owner.
                         the lock but it can not
                         get the lock as (count &
                         RWSEM_LOCK_MASK) is set
                         as (1) has added it but
                         not able to remove its
             adjustment.

----------------------

To fix that we either has to disable preemption in down_read() and 
reenable it in rwsem_down_read_slowpath after decrementing the 
RWSEM_READER_BIAS or to limit the number of trylock-spinning attempt 
like this patch. The latter approach seems a bit less messy and I am 
going to take it back out anyway in patch 4. I will put a summary of 
that special case in the patch description.

Cheers,
Longman

