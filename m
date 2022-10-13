Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE45FDAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJMNda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJMNd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117E10692D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665668005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TlxHg1DEsmNT2KFP6zuBipJtjYUKYkAljx6KzxumBA=;
        b=cxqedgHp54+VrlTLpJp3XKif3nkm7U297d8P6ZvVmPThR94XLUYQxzBDxmdNgZadfp43OR
        q0uTxhOZiaDBaGLMlZg9LpSHlYfFs+9YdpgFaPLnzErjh4oI51FkhFycjMhn/qt433T0O2
        4lm+uqI4bSk7I9d/CDgzHNRt8Fuufok=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-h3vKZ8-NOpyWz8tqG3AgxA-1; Thu, 13 Oct 2022 09:33:19 -0400
X-MC-Unique: h3vKZ8-NOpyWz8tqG3AgxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D4202999B5C;
        Thu, 13 Oct 2022 13:33:18 +0000 (UTC)
Received: from [10.22.17.27] (unknown [10.22.17.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF15B1121314;
        Thu, 13 Oct 2022 13:33:17 +0000 (UTC)
Message-ID: <ee1ea64f-f4b3-15b2-b46c-9b8ad7217962@redhat.com>
Date:   Thu, 13 Oct 2022 09:33:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] locking/rwsem: Prevent non-first waiter from
 spinning in down_write() slowpath
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221012133333.1265281-1-longman@redhat.com>
 <20221012133333.1265281-2-longman@redhat.com>
 <Y0fiIdxA+Jip1vve@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y0fiIdxA+Jip1vve@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 06:02, Peter Zijlstra wrote:
> On Wed, Oct 12, 2022 at 09:33:32AM -0400, Waiman Long wrote:
>> A non-first waiter can potentially spin in the for loop of
>> rwsem_down_write_slowpath() without sleeping but fail to acquire the
>> lock even if the rwsem is free if the following sequence happens:
>>
>>    Non-first waiter       First waiter      Lock holder
>>    ----------------       ------------      -----------
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>      Set handoff bit if RT or
>>        wait too long
>>      Set waiter->handoff_set
>>    Release wait_lock
>>                           Acquire wait_lock
>>                           Inherit waiter->handoff_set
>>                           Release wait_lock
>> 					   Clear owner
>>                                             Release lock
>>    if (waiter.handoff_set) {
>>      rwsem_spin_on_owner(();
>>      if (OWNER_NULL)
>>        goto trylock_again;
>>    }
>>    trylock_again:
>>    Acquire wait_lock
>>    rwsem_try_write_lock():
>>       if (first->handoff_set && (waiter != first))
>>       	return false;
>>    Release wait_lock
>>
>> It is especially problematic if the non-first waiter is an RT task and
>> it is running on the same CPU as the first waiter as this can lead to
>> live lock.
>>
> So why not do a better handoff? Specifically, have the owner set owner
> to first-waiter instead of NULL ? (like the normal mutex code)

I understand your desire to make the rwsem handoff process more like 
what mutex is currently doing. I certainly think it is doable and will 
put this in my todo list. However, that needs to be done at unlock and 
wakeup time. I expect that will require moderate amount of code changes 
which will make it not that suitable for backporting to the stable releases.

I would like to see these simple fixes get merged first and then we can 
work on a major revamp of the handoff code. What do you think?

Cheers,
Longman

