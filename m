Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145860BAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJXUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiJXUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FB2A725
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666637425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tuQ1z80Jxwl1KqjcwzqroneyxDi+hcFmfKt3WRAZA0=;
        b=ZxV9pQ/9+e2tTz+/AN1bQrVFim8A24DCrFwl+WtNM9PzLzaE690jHC7Lmht03QTgFX9GgG
        a7bqX71gppTaXy5/nqlPzYXbxuQZK6D9DFSOCxf37a+tDeRfXWVj/sWv58q4O68Jqpi9HD
        y/D6JCcBdqbdXk9YWA+2RY0IAAYdpi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-Du_a6b-eM-OZIubBtyqy8Q-1; Mon, 24 Oct 2022 14:47:08 -0400
X-MC-Unique: Du_a6b-eM-OZIubBtyqy8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FF3E88282F;
        Mon, 24 Oct 2022 18:47:07 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9944F40C955E;
        Mon, 24 Oct 2022 18:47:05 +0000 (UTC)
Message-ID: <4ac8ed1b-6f2c-5083-fae3-4b6fe9e8cf1b@redhat.com>
Date:   Mon, 24 Oct 2022 14:46:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 3/5] locking/rwsem: Change waiter->hanodff_set to a
 handoff_state enum
Content-Language: en-US
To:     john.p.donnelly@oracle.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>,
        Jack Vogel <jack.vogel@oracle.com>,
        Jorge Lopez <jorge.jo.lopez@oracle.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>
References: <20221024174418.796468-1-longman@redhat.com>
 <20221024174418.796468-4-longman@redhat.com>
 <e392155b-5c96-11a5-df32-6670139223da@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e392155b-5c96-11a5-df32-6670139223da@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 14:25, john.p.donnelly@oracle.com wrote:
> On 10/24/22 12:44 PM, Waiman Long wrote:
>> Change the boolean waiter->handoff_set to an enum type so that we can
>> have more states in some later patches. Also use READ_ONCE() outside
>> wait_lock critical sections for read and WRITE_ONCE() inside wait_lock
>> critical sections for write for proper synchronization. There is no
>> functional change.
>
> Hi,
>
> Do we need
>
>
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
> consistent")
>
> Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer 
> optimistically spin on owner")
>
> Cc: stable@vger.kernel.org
>
>
> clauses added to patches 3,4,5 so they are all picked up in one series ?
>
> Thank you,
>
> John.

I am not planning to do that. The handoff code rewrite represent a 
moderate amount of changes. So I don't want them to be backported to 
stable in case there are some hidden bugs inside. That is why I have 
patch 2 is essentially reverted in patch 4.

Cheers,
Longman

