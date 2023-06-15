Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97981730D63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjFOC6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOC6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:58:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502EF26AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686797847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NIislaoMeApemHv5x6Quq/pA/Iddn6wkpmNpNKXL1I=;
        b=BLeR1iVzJD9V82z/pI/5nDGlcO2v3ciDdV6D+IodlQzAIe5t6fqp/Ov9aJDq5ruQoUs2JK
        xI4oqYUTgBJHtXN9NudSGAJL/JW06QnQ8+XX0C0Fb6Vfvfw5Khrf86Qs2nIm9TeNpJz8Yu
        JBFotPwnGEiYpyW/Gxx726Wlf1TqxkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-dr9fIxELNaisgioBgFe7-g-1; Wed, 14 Jun 2023 22:57:24 -0400
X-MC-Unique: dr9fIxELNaisgioBgFe7-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85CAC101A52A;
        Thu, 15 Jun 2023 02:57:23 +0000 (UTC)
Received: from [10.22.16.11] (unknown [10.22.16.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 235AB400DEFC;
        Thu, 15 Jun 2023 02:57:22 +0000 (UTC)
Message-ID: <b8ec5185-f167-0b11-b823-51ba4fc3ca4f@redhat.com>
Date:   Wed, 14 Jun 2023 22:57:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] locking/osq_lock: Fix false sharing of
 optimistic_spin_node in osq_lock
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Guo Hui <guohui@uniontech.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, wangxiaohua@uniontech.com
References: <20230615012437.21087-1-guohui@uniontech.com>
 <9f5321f9-0b35-7f85-ee09-247d961e5a79@redhat.com>
In-Reply-To: <9f5321f9-0b35-7f85-ee09-247d961e5a79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/23 21:58, Waiman Long wrote:
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index d5610ad52b92..bdcd216b73c4 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -24,7 +24,7 @@ static inline int encode_cpu(int cpu_nr)
>>     static inline int node_cpu(struct optimistic_spin_node *node)
>>   {
>> -    return node->cpu - 1;
>> +    return node->prev_cpu - 1;
>>   }
>
> From the first glance, the patch looks OK. The only issue that I have 
> so far is the "node_cpu" name which is misleading in this case. You 
> should have renamed it to node_prev_cpu() instead as there is only one 
> caller.

One more thing. Unlike node->cpu, node->prev_cpu is subjected to change. 
So you should have use READ_ONCE() to read it to match the WRITE_ONCE() 
that modifies it.

Thanks,
Longman

