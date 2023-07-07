Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0817674B9FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGGXYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGGXYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B25C2106
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688772242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XNAe7PgV0fkePnBzfDbEzA+U1/1CfkmWpKX+HX/k7jo=;
        b=dKQlr39MqvEISdaVAJyq4n2uZQ/3nAcaIeqHKLfJiioc9+ZwQ30XfovoHPHUtCw+209zxY
        jRN9RbxfBjjwvvVeii6/Hw3gB2RVYMl+KZHXooyvK4I3ahX2TRKpN/7Muldd4u8xF67rNO
        87tnaoyngRvoNy76BxGY8nKSJibdLsk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214--j3nidQAMjSc7kd_HMjhaw-1; Fri, 07 Jul 2023 19:24:00 -0400
X-MC-Unique: -j3nidQAMjSc7kd_HMjhaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 864CD380451E;
        Fri,  7 Jul 2023 23:24:00 +0000 (UTC)
Received: from [10.22.34.12] (unknown [10.22.34.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5737BF643A;
        Fri,  7 Jul 2023 23:24:00 +0000 (UTC)
Message-ID: <9a3cb0c2-0b1a-28d0-0ebf-c29c6cb37f29@redhat.com>
Date:   Fri, 7 Jul 2023 19:24:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [BUG 6.4] sched/core: Possible buffer overflow in
 do_set_cpu_allowed
Content-Language: en-US
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230707202851.GA4231@zipoli.concurrent-rt.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230707202851.GA4231@zipoli.concurrent-rt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/23 16:28, Joe Korty wrote:
> In commit 9a5418bc48bab ("sched/core: Use kfree_rcu() in
> do_set_cpus_allowed()"), a kfree_rcu() is used to free a cpu mask.
> However, cpu masks can be as short as 8 bytes and this is a problem,
> as kfree_rcu requires the to-be freed buffer to be at least 16 bytes.
> Thus there is a chance of buffer overflow corruption when the number of
> possible cpus in the system is 64 or less.
>
> I have not seen this corruption in the wild.  I only noticed this possibility
> when reviewing the scheduler differences between 6.1 and 6.4.

We were aware of this known limitation. If you look at 
alloc_user_cpus_ptr():

static cpumask_t *alloc_user_cpus_ptr(int node)
{
         /*
          * See do_set_cpus_allowed() above for the rcu_head usage.
          */
         int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));

         return kmalloc_node(size, GFP_KERNEL, node);
}

We made sure that the allocated buffer is big enough to hold struct 
rcu_head.

Cheers,
Longman

