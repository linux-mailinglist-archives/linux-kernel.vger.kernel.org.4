Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A2634070
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiKVPk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiKVPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:40:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039ADF4E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669131566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFMQg1WGJdofDL9AFGBJOdk7f5Ay22oSAcjU2kzdoHg=;
        b=XffsvvXHu1GAVx8B7n5JDO9dqttF2R0Qo8/RiueudVgSD5iqJ6uDeyCCJJHkihhXCc81zX
        tJjkBQ3USUkUqMO/0LKTWhV7g/m4pW+iuD4Y//22CTziR7EbySUCV6NrS9Uk+Wicx4/Cj5
        RKHA567RpTARO+6BD+seP3xGC0h2dJU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-FNCUMzeBO9G0PXlUn5VfSA-1; Tue, 22 Nov 2022 10:39:15 -0500
X-MC-Unique: FNCUMzeBO9G0PXlUn5VfSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D949229DD983;
        Tue, 22 Nov 2022 15:39:14 +0000 (UTC)
Received: from [10.22.17.223] (unknown [10.22.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39C73C159CD;
        Tue, 22 Nov 2022 15:39:14 +0000 (UTC)
Message-ID: <a7fb3cac-176f-3928-f3a3-23c25ab9677e@redhat.com>
Date:   Tue, 22 Nov 2022 10:39:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/1] sched: fix user_mask double free
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, wangbiao3@xiaomi.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, brauner@kernel.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, wenjieli@qti.qualcomm.com,
        chenguanyou@xiaomi.com, Will Deacon <will@kernel.org>
References: <cover.1669020858.git.wangbiao3@xiaomi.com>
 <b8970a530d420109ee9fe0b268e097fb839211b0.1669020858.git.wangbiao3@xiaomi.com>
 <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y3zXDZeTUgDz2hJ8@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/22 09:05, Peter Zijlstra wrote:
> So you failed:
>
>   - to Cc the original author of this code (Will Deacon)
>   - to report what version this is against (apparently Linus' tree)
>   - to check if this still applies to the latest tree (it doesn't)
>   - to Cc the author of the code it now conflicts with (Waiman)
>   - write something coherent in the changelog.
>   - to include a Fixes tag.
>
> Still, let me try and make sense of things...
>
> On Mon, Nov 21, 2022 at 06:04:20PM +0800, wangbiao3@xiaomi.com wrote:
>> From: wangbiao3 <wangbiao3@xiaomi.com>
>>
>> Clone/Fork a new task,call dup_task_struct->arch_dup_task_struct(tsk,orig)
>> which copy the data of parent/sibling task inclding p->user_cpus_ptr,so
>> the user_cpus_ptr of newtask is the same with orig task's.When
>> dup_task_struct call dup_user_cpus_ptr(tsk, orig, node),it return 0
>> dircetly if src->user_cpus_ptris free by other task,in this case ,
>> the newtask's address of user_cpus_ptr is not changed.
> (even just inserting some whitespace would've made it so much easier to
> read)
>
> But, the only way that would be possible is if
> force_compatible_cpus_allowed_ptr() were to be called on !current, and
> that just doesn't happen, the only callsite is:
>
> arch/arm64/kernel/process.c:                    force_compatible_cpus_allowed_ptr(current);
>
> And you can't be in fork() and exec() at the same time.
>
> If it were possible to call restrict_cpus_allowed_ptr() on a non-current
> task then yes, absolutely, which is why:
>
>    8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
>
> also wraps the thing in pi_lock, but looking at it now, perhaps it needs
> to do the alloc/copy first and swap under pi_lock instead.

With the latest change, user_cpus_ptr, once set, will not be cleared 
until when the task dies. That is why I don't recheck if user_cpus_ptr 
is NULL under pi_lock. The user_cpus_ptr value can certainly changes 
during its lifetime, but it will be stable under pi_lock. 
clear_user_cpus_ptr() is called by release_user_cpus_ptr() only. As said 
before, it is only call when the task dies at free_task() and so there 
shouldn't be any other racing conditions that can happen at the same time.

David, can you try the latest tip tree to see if the problem is still 
reproducible ?

Thanks,
Longman

