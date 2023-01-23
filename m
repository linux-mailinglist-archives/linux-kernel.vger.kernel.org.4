Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142E677482
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 04:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAWDlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 22:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWDlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 22:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAE15CAB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 19:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674445227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ht9RNTqRQnsZV1p5JCrpuNpZ8Y3SVlkh3oPFyl8qImU=;
        b=iN8QB70zy/nP2WpGcW5WBWfRjPT+gZpBmFzBk+epp+CYBW4WfEsL4e/br8FkHosghtoJTX
        z8G7DMp+PwN049gYYVz/5G50zblxZO72Vkx2AyzKqxbDZgXFUkj4GFUWGyIyRq1OLg0Tru
        EocwEvUAtRcYtI2YbJLbY9+/0IHTE00=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-B9i4cS6SMbOS5fV-K9zqig-1; Sun, 22 Jan 2023 22:40:23 -0500
X-MC-Unique: B9i4cS6SMbOS5fV-K9zqig-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B0463C0E442;
        Mon, 23 Jan 2023 03:40:23 +0000 (UTC)
Received: from [10.22.8.163] (unknown [10.22.8.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 675A1492C3C;
        Mon, 23 Jan 2023 03:40:22 +0000 (UTC)
Message-ID: <8eea871c-eed0-cb4b-1b81-3a6b502c3c34@redhat.com>
Date:   Sun, 22 Jan 2023 22:40:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 0/6] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221118022016.462070-1-longman@redhat.com>
 <Y80+SLxrdEVyJHMo@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y80+SLxrdEVyJHMo@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/23 08:46, Peter Zijlstra wrote:
> On Thu, Nov 17, 2022 at 09:20:10PM -0500, Waiman Long wrote:
>
>> Waiman Long (6):
>>    locking/rwsem: Prevent non-first waiter from spinning in down_write() slowpath
>>    locking/rwsem: Disable preemption at all down_read*() and up_read() code paths
>>    locking/rwsem: Disable preemption at all down_write*() and up_write() code paths
>>    locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
> After all these we still have down_read_non_owner() using
> __rwsem_set_reader_owner() outside of the preempt_disable() region.
>
> Now, let me go stare at this one:

Thanks for spotting that. I kind of overlook the fact we have a 
down_read_non_owner(). Will update that as well.

Cheers,
Longman

>>    locking/rwsem: Enable direct rwsem lock handoff
>

