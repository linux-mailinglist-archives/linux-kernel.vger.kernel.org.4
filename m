Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321860B668
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiJXS5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiJXSz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7317044E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666632936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwYdvhkDEoawPzz9Fu9slwvjSlEYhvpSzvJKdbC4+0k=;
        b=LOO7PBycd23QMXehKejXHqrT2dcR6NVOe1psV+BEsNvg564LN7uAl27yRl3rRpDf9WHh2W
        VSGg5fZ4ORc4YlYHp0HNlAn2epAWKjauSTY4D0z4Ssy9Nh8guZJd4VP5tgcHpyLHDsviN0
        0WinAmWMf72b7d6wCPyIvAZXk4Wxrn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-Bb6Dt_eOMdy_W3leHJ5I_Q-1; Mon, 24 Oct 2022 12:18:50 -0400
X-MC-Unique: Bb6Dt_eOMdy_W3leHJ5I_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C57D6804186;
        Mon, 24 Oct 2022 16:18:48 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46D791121315;
        Mon, 24 Oct 2022 16:18:48 +0000 (UTC)
Message-ID: <2535f304-789b-97e1-5c08-ee88761cf932@redhat.com>
Date:   Mon, 24 Oct 2022 12:18:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 4/5] locking/rwsem: Enable direct rwsem lock handoff
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20221017211356.333862-1-longman@redhat.com>
 <20221018111424.1007-1-hdanton@sina.com>
 <9b63611e-8d9a-529b-dcdc-05b10a8a712a@quicinc.com>
 <20221018235138.1088-1-hdanton@sina.com>
Content-Language: en-US
In-Reply-To: <20221018235138.1088-1-hdanton@sina.com>
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

On 10/18/22 19:51, Hillf Danton wrote:
> On 18 Oct 2022 13:37:20 -0400 Waiman Long<longman@redhat.com>
>> On 10/18/22 10:13, Mukesh Ojha wrote:
>>> On 10/18/2022 4:44 PM, Hillf Danton wrote:
>>>> On 17 Oct 2022 17:13:55 -0400 Waiman Long<longman@redhat.com>
>>>>> @@ -1067,13 +1119,33 @@ rwsem_down_read_slowpath(struct rw_semaphore
>>>>>                return sem;
>>>>>            }
>>>>>            adjustment += RWSEM_FLAG_WAITERS;
>>>>> +    } else if ((count & RWSEM_FLAG_HANDOFF) &&
>>>>> +          ((count & RWSEM_LOCK_MASK) == RWSEM_READER_BIAS)) {
>>>> Could a couple of CPUs go read slow path in parallel?
>>>>
>> This is under wait_lock protection. So no parallel execution is possible.
> They individually add RWSEM_READER_BIAS to count before taking wait_lock,
> and the check for BIAS here does not cover the case of readers in parallel.
> Is this intended?
>
> Hillf

As I said in the patch description, the lock handoff can only be done if 
we can be sure that there is no other active locks outstanding with the 
handoff bit set. If at the time of the check, another reader come in and 
adds its RWSEM_READER_BIAS, the check fail and the cpu will proceed to 
put its waiter in the queue and begin sleeping. Hopefully, the last one 
left will find that count has only its RWSEM_READER_BIAS and it can 
start the handoff process.

Cheers,
Longman

