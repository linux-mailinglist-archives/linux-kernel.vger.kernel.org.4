Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1460BBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiJXVRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiJXVQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22812D20F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666639266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJ+sn9mSIwJc3U9Lr4FXvoVDMOCsZpiHXpUK/fp4g5w=;
        b=bwH9Mu0f2a0OXOZkgY9h7ebKdwY1BD6UpPu6bay/cssFZokFjGrt+UF3auASxlvoqFygQr
        3SFlj7WMY7PvsRsrfzQX1KstD5ZqyyhHhon7O5vKiQkOiLB1pUd3Vv5m0L0DZVCdFe9i0+
        OgHsjmmH1MSuSztG+hK1GA0mWOyXNxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-KVGMneTUN6Ou4jwvCQbwOQ-1; Mon, 24 Oct 2022 09:50:57 -0400
X-MC-Unique: KVGMneTUN6Ou4jwvCQbwOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 223F2833A0D;
        Mon, 24 Oct 2022 13:50:57 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71B7340C2064;
        Mon, 24 Oct 2022 13:50:56 +0000 (UTC)
Message-ID: <2e9e8224-18c3-697e-aa8a-c485986d0cea@redhat.com>
Date:   Mon, 24 Oct 2022 09:50:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/5] locking/rwsem: Prevent non-first waiter from
 spinning in down_write() slowpath
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221017211356.333862-2-longman@redhat.com>
 <Y1aQdlf7E7OgwoqO@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y1aQdlf7E7OgwoqO@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 09:17, Peter Zijlstra wrote:
> On Mon, Oct 17, 2022 at 05:13:52PM -0400, Waiman Long wrote:
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
> I'm struggling to connect the Changelog to the actual patch. I see the
> problem, but I don't see how the below helps or is even related to the
> described problem.

Sorry if the description isn't clear, I will rephrase it to make it 
clearer. The basic idea is that a non-first waiter can mistakenly 
believe that it can spin on the lock. However, when 
rwsem_try_write_lock() is called, it can never acquire the lock and move 
on because it is not the first waiter:

                        if (first->handoff_set && (waiter != first))
                                 return false;

If that waiter happen to be an RT task, it can block the real first 
waiter to acquire the lock if it happen to run the same CPU.

Cheers,
Longman

