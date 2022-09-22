Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00E45E6626
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiIVOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiIVOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BDDF6869
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663858143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PelATbzyfPdBhYOjywaV0ybFNhVQac/LDmSa6zRJ17Q=;
        b=hLzss3t65vnte9yWfWZNyUQMlvhKipMSWBBnVZ5ndTNt7Oe2U3/GBzkUcC1MSGGx4O3TBH
        q3vGnMCjuJrPF0vTB68HxeDAcKjCevfZ/u9X7l+ZzI32CCsWjTlEavFOkXJbmsRDff6Hgv
        LMVTUE69m+rR1vCJFJTd4Bt1wQ3PVSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-BvBq0iVfPfqWn5qszcN6Ow-1; Thu, 22 Sep 2022 10:49:00 -0400
X-MC-Unique: BvBq0iVfPfqWn5qszcN6Ow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7B75858282;
        Thu, 22 Sep 2022 14:48:59 +0000 (UTC)
Received: from [10.22.33.6] (unknown [10.22.33.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0BE6352E;
        Thu, 22 Sep 2022 14:48:59 +0000 (UTC)
Message-ID: <03d87746-8454-c7eb-6698-af2d02abdc42@redhat.com>
Date:   Thu, 22 Sep 2022 10:48:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] tracing: Disable interrupt or preemption before
 acquiring arch_spinlock_t
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <20220922133158.1731333-1-longman@redhat.com>
 <Yyxx0jhmN6ZTRYhd@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yyxx0jhmN6ZTRYhd@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/22 10:31, Peter Zijlstra wrote:
> On Thu, Sep 22, 2022 at 09:31:58AM -0400, Waiman Long wrote:
>> It was found that some tracing functions in kernel/trace/trace.c acquire
>> an arch_spinlock_t with preemption and irqs enabled. An example is the
>> tracing_saved_cmdlines_size_read() function which intermittently causes
>> a "BUG: using smp_processor_id() in preemptible" warning when the LTP
>> read_all_proc test is run.
>>
>> That can be problematic in case preemption happens after acquiring the
>> lock. Add the necessary preemption or interrupt disabling code in the
>> appropriate places before acquiring an arch_spinlock_t.
>>
>> The convention here is to disable preemption for trace_cmdline_lock and
>> interupt for max_lock.
>>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> This seems to be missing a Fixes: tag :-)

Sorry for the omission. The patch should have the following fixes tags.

Fixes: a35873a0993b ("tracing: Add conditional snapshot")
Fixes: 939c7a4f04fc ("tracing: Introduce saved_cmdlines_size file")

Cheers,
Longman

