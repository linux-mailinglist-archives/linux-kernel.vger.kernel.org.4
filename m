Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5822563ABFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiK1PMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiK1PMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:12:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360620986
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669648319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+TN9hP6pZ4DRKDCz+V1dUYAB9I5oUrteAvF0crrcJI=;
        b=alzunQAhskjQiS5PphfPxaf1jc5p4R/T7WY/ApzVORF2djwju53dC52XfTCZ2r+3fN/MLs
        NMcl8IMBR4dYQXG2MFbaPe2xQPKGUiodETpm3qW6OJqLm5WBtjRuOhM3Y5XZZa3obBDKmX
        WnGwrmkqQ9oYlreoVhzd08KWof4NU8U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-XLRQ24AjN--Pt_9xiqlJYg-1; Mon, 28 Nov 2022 10:11:56 -0500
X-MC-Unique: XLRQ24AjN--Pt_9xiqlJYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEFB33C0DDA5;
        Mon, 28 Nov 2022 15:11:55 +0000 (UTC)
Received: from [10.22.10.34] (unknown [10.22.10.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA8611121314;
        Mon, 28 Nov 2022 15:11:54 +0000 (UTC)
Message-ID: <d49a78bb-dce1-92b1-0f67-d71259609263@redhat.com>
Date:   Mon, 28 Nov 2022 10:11:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-tip v4] sched: Fix NULL user_cpus_ptr check in
 dup_user_cpus_ptr()
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Wenjie Li <wenjieli@qti.qualcomm.com>,
        =?UTF-8?B?RGF2aWQgV2FuZyDnjovmoIc=?= <wangbiao3@xiaomi.com>,
        linux-kernel@vger.kernel.org
References: <20221125023943.1118603-1-longman@redhat.com>
 <92b99a5e-1588-4e08-a652-72e9c51421cf@redhat.com>
 <20221128120008.GA25090@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221128120008.GA25090@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 07:00, Will Deacon wrote:
> On Sun, Nov 27, 2022 at 08:43:27PM -0500, Waiman Long wrote:
>> On 11/24/22 21:39, Waiman Long wrote:
>>> In general, a non-null user_cpus_ptr will remain set until the task dies.
>>> A possible exception to this is the fact that do_set_cpus_allowed()
>>> will clear a non-null user_cpus_ptr. To allow this possible racing
>>> condition, we need to check for NULL user_cpus_ptr under the pi_lock
>>> before duping the user mask.
>>>
>>> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>> This is actually a pre-existing use-after-free bug since commit 07ec77a1d4e8
>> ("sched: Allow task CPU affinity to be restricted on asymmetric systems").
>> So it needs to be fixed in the stable release as well. Will resend the patch
>> with an additional fixes tag and updated commit log.
> Please can you elaborate on the use-after-free here? Looking at
> 07ec77a1d4e8, the mask is only freed in free_task() when the usage refcount
> has dropped to zero and I can't see how that can race with fork().
>
> What am I missing?

I missed that at first. The current task cloning process copies the 
content of the task structure over to the newly cloned/forked task. IOW, 
if user_cpus_ptr had been set up previously, it will be copied over to 
the cloned task. Now if user_cpus_ptr of the source task is cleared 
right after that and before dup_user_cpus_ptr() is called. The obsolete 
user_cpus_ptr value in the cloned task will remain and get used even if 
it has been freed. That is what I call as use-after-free and double-free.

Cheers,
Longman

