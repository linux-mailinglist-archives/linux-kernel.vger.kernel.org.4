Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF9604AB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJSPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiJSPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F02D13F1B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666191747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuGHfrLsMCWGVahZJWXTgYQa14ARBbhcsNOf6vopbCQ=;
        b=bukGPRteUO5/IoMjs7p4qVtTch3El2uPHDuGXmOJVFNGRvC4SdGy66H3Yug5juy4Y8kE3g
        tbqnK9AtCGIAC1BhYF2MPF0UgRm4pVVZAtfFGqFX/dVnVKdsVT/JVOE6G0FJOZe3ilQfnA
        uYvUIzZ7eIB0ZyhdNwTWgXY+QBJoKQo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-tE1eHk-AO7i8LxfgR7FYyw-1; Wed, 19 Oct 2022 11:02:23 -0400
X-MC-Unique: tE1eHk-AO7i8LxfgR7FYyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BDFB18ABFB3;
        Wed, 19 Oct 2022 15:02:06 +0000 (UTC)
Received: from [10.22.33.65] (unknown [10.22.33.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3955D9D464;
        Wed, 19 Oct 2022 15:02:03 +0000 (UTC)
Message-ID: <28264558-5f3f-9521-ced2-2c94a27002ec@redhat.com>
Date:   Wed, 19 Oct 2022 11:02:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 4/5] locking/rwsem: Enable direct rwsem lock handoff
Content-Language: en-US
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
 <20221019022934.1166-1-hdanton@sina.com>
 <20221019070559.1220-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221019070559.1220-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/22 03:05, Hillf Danton wrote:
> On 18 Oct 2022 22:49:02 -0400 Waiman Long <longman@redhat.com>
>> On 10/18/22 22:29, Hillf Danton wrote:
>>> If handoff grants rwsem to a read waiter then the read fast path may revive.
>> I don't quite understand what you mean by "read fast path may revive".
> Subsequent readers may take rwsem without going the slow path after a
> read waiter is granted.
That may not be true. As long as there are still waiters in the wait 
queue, a reader has to go into the slow path and queued up in the wait 
queue. This is is to prevent a continuous stream of readers from 
starving writers in the wait queue.
>
> OTOH even after the check for single BIAS, another reader may come in
> and add its BIAS to count, which builds the same count as multiple
> readers came in before the check.

That is true, but hopefully we will eventually run out reader trying to 
get a read lock on a given rwsem.

Cheers,
Longman


