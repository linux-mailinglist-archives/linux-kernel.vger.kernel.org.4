Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2273678941
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjAWVKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjAWVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:10:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6138676
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674508210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD0949dGhYDPuf0JgJXrgXRGmrFBrADtWPvx9ah78C4=;
        b=W4YK9PNrsfPu5t2B+h0oajvIlbS3D0yXb1HYRo0D6F3uj0U7C+UDUuEG5qp1jjs7iiDsUN
        uvZOCrA3T3lcGhw0DAYqhZtndNU4HTdGKGIRsHJTi+vii38/WiNWmmfnzw1rUqG0hhhzah
        uRxi7kbecinqUPQW0Aujt/qRiZEGs8A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-bjUwKGCCPN-2tHvJG1b4mg-1; Mon, 23 Jan 2023 16:10:03 -0500
X-MC-Unique: bjUwKGCCPN-2tHvJG1b4mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C64591859187;
        Mon, 23 Jan 2023 21:10:02 +0000 (UTC)
Received: from [10.22.34.140] (unknown [10.22.34.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36BF8C15BAD;
        Mon, 23 Jan 2023 21:10:02 +0000 (UTC)
Message-ID: <f00bff72-c923-2552-f181-f1bcc034bff9@redhat.com>
Date:   Mon, 23 Jan 2023 16:10:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 0/6] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221118022016.462070-1-longman@redhat.com>
 <Y80+SLxrdEVyJHMo@hirez.programming.kicks-ass.net>
 <8eea871c-eed0-cb4b-1b81-3a6b502c3c34@redhat.com>
In-Reply-To: <8eea871c-eed0-cb4b-1b81-3a6b502c3c34@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/23 22:40, Waiman Long wrote:
>
> On 1/22/23 08:46, Peter Zijlstra wrote:
>> On Thu, Nov 17, 2022 at 09:20:10PM -0500, Waiman Long wrote:
>>
>>> Waiman Long (6):
>>>    locking/rwsem: Prevent non-first waiter from spinning in 
>>> down_write() slowpath
>>>    locking/rwsem: Disable preemption at all down_read*() and 
>>> up_read() code paths
>>>    locking/rwsem: Disable preemption at all down_write*() and 
>>> up_write() code paths
>>>    locking/rwsem: Change waiter->hanodff_set to a handoff_state enum
>> After all these we still have down_read_non_owner() using
>> __rwsem_set_reader_owner() outside of the preempt_disable() region.
>>
>> Now, let me go stare at this one:
>
> Thanks for spotting that. I kind of overlook the fact we have a 
> down_read_non_owner(). Will update that as well.

After looking further into this, we will need to either pass one more 
parameter to __down_read() for this special case or to do 
preempt_disable/enable in each of the higher level down_read functions. 
As down_read_non_owner() is a rarely called function, I doubt it is 
worth the extra effort to do that since the owner value (other than the 
RWSEM_READER_OWNED bit) is for debugging purpose only and is not 
critical to the correct functioning of a rwsem. I will add a comment to 
note that.

Cheers,
Longman



