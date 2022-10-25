Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00A60D50A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiJYTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiJYTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA522BB3D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666727714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rsahskIW82j7Opr6zcxmIFVVHL4k7W5ic86oG0lZpM=;
        b=hjSnoaMI5iaeOSDpw1XJ5pxoqMRVLzOnx5AAEVLrzR4xkNYVdOboZF7ZowcJPKudWuTxAK
        EmnLMwZpzzfiyJa2/CJxs9CjqsG5O/QEy+GZT4N6GBfmKeUMtQ5qNBigBfFZTI0AmUfDjB
        lOaD4pxJNhEnvxT4ba0Cp6ApTf7hNYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-UG7250pGNUCosQds8y14Hw-1; Tue, 25 Oct 2022 15:55:11 -0400
X-MC-Unique: UG7250pGNUCosQds8y14Hw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50B5188606B;
        Tue, 25 Oct 2022 19:55:10 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCD874B3FC6;
        Tue, 25 Oct 2022 19:55:09 +0000 (UTC)
Message-ID: <d67740dc-d608-4b1a-0889-b9861153fdf3@redhat.com>
Date:   Tue, 25 Oct 2022 15:55:09 -0400
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
 <980d882c-01b8-2ce1-663f-41a8a337f350@redhat.com>
 <Y1fG7nQxiLyKIhQ6@hirez.programming.kicks-ass.net>
 <Y1fNJZ9SALWlmoon@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y1fNJZ9SALWlmoon@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 07:48, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 01:22:22PM +0200, Peter Zijlstra wrote:
>
>> Funny, I find the former approach much saner. Disabling preemption
>> around the whole thing fixes the fundamental problem while spin-limiting
>> is a band-aid.
>>
>> Note how rwsem_write_trylock() already does preempt_disable(), having
>> the read-side do something similar only makes sense.
> Something like the completely untested below perhaps...

That is quite a number of changes spread over many different functions. 
That is the kind of changes that may make it harder to backport to 
stable releases.

This patch is just a stop-gap measure for stable releases which I 
essentially revert in a later patch. I have no objection to disable 
preemption in within the rwsem code exception to be backported to a 
stable release. So I can add another patch on top of the series to 
essentially do that.

Cheers,
Longman

