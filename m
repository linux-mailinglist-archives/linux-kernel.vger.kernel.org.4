Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32CC5BCD56
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiISNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiISNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167781BEBF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663594458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+t2Fm2xukLMEPHf8ZaJI5wrWDEZGaB6Do9fL6MT3CtM=;
        b=f8mXZFWYv3KvIOs8MEws1vbA/7JKkB88wjBG+Z2HIdkFUMKs8ygQ2NrB7orUsYV6yECk4d
        1Ixc7QavKnC0nbb+tuYFvYDY2nvzu/o6Ozo67zgPqvCOlsvcWAunPoiomPSSK3yFWx6zfR
        +93ey8/ySXCW0ZEGXsIyjxAdBqQip0A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-oeutMdS6M_WTwv6_veBJGQ-1; Mon, 19 Sep 2022 09:34:12 -0400
X-MC-Unique: oeutMdS6M_WTwv6_veBJGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F288811E67;
        Mon, 19 Sep 2022 13:34:11 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E10640C6EC2;
        Mon, 19 Sep 2022 13:34:10 +0000 (UTC)
Message-ID: <34b2bb18-ad64-ee10-37ad-3c2ab2387a0e@redhat.com>
Date:   Mon, 19 Sep 2022 09:34:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/slab_common: fix possiable double free of kmem_cache
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
References: <20220919031241.1358001-1-feng.tang@intel.com>
 <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz> <Yyhlmq8GA5FnNoxq@feng-clx>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yyhlmq8GA5FnNoxq@feng-clx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 08:50, Feng Tang wrote:
> On Mon, Sep 19, 2022 at 05:12:38PM +0800, Vlastimil Babka wrote:
>> On 9/19/22 05:12, Feng Tang wrote:
> [...]
>>> The cause is inside kmem_cache_destroy():
>>>
>>> kmem_cache_destroy
>>>      acquire lock/mutex
>>>      shutdown_cache
>>>          schedule_work(kmem_cache_release) (if RCU flag set)
>>>      release lock/mutex
>>>      kmem_cache_release (if RCU flag set)
>> 				      ^ not set
>>
>> I've fixed that up.
> Oops.. Thanks for catching it!
>
>>> in some certain timing, the scheduled work could be run before
>>> the next RCU flag checking which will get a wrong state.
>>>
>>> Fix it by caching the RCU flag inside protected area, just like 'refcnt'
>>>
>>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> Thanks!
>>
>>> ---
>>>
>>> note:
>>>
>>> The error only happens on linux-next tree, and not in Linus' tree,
>>> which already has Waiman's commit:
>>> 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
>>> without holding slab_mutex/cpu_hotplug_lock")
>> Actually that commit is already in Linus' rc5 too, so I will send your fix
>> this week too. Added a Fixes: 0495e337b703 (...) too.
> Got it, thanks
>
> - Feng

Thanks for catching this bug.

Reviewed-by: Waiman Long <longman@redhat.com>

Cheers,
Longman


