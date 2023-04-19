Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5DC6E7D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDSPH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDSPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D6E5F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681916827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNMRMuDPRUofqdpcKxax9VPRmENaL6UlH4uiYpQa9Hc=;
        b=XOGX+VPBooEXFYI9JgF2MoEvx+dm2hCDGF2rZqatuHCXtDx0EWsr/s5PID0l0fTcbSOBuD
        ct2w66x0wle52StJ53EYW+jygvwtbl9cHy0vp8OeiDBg7jMhjcGRAYSFhG58IPA5wLBM9E
        38Q+44xhV0JA+bXMT5nzfXn2RKRQnv0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-r0csUHEcO028aZ6RXyMXXw-1; Wed, 19 Apr 2023 11:07:05 -0400
X-MC-Unique: r0csUHEcO028aZ6RXyMXXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D79E101A551;
        Wed, 19 Apr 2023 15:07:05 +0000 (UTC)
Received: from [10.22.9.10] (unknown [10.22.9.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E702A40C94A9;
        Wed, 19 Apr 2023 15:07:04 +0000 (UTC)
Message-ID: <9f92d530-1cfc-6e50-a717-321ac64ed1c2@redhat.com>
Date:   Wed, 19 Apr 2023 11:07:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
 <ZD9kKTsPVlzlEZLp@casper.infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZD9kKTsPVlzlEZLp@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 23:46, Matthew Wilcox wrote:
> On Tue, Apr 18, 2023 at 09:16:37PM -0400, Waiman Long wrote:
>>   1) App runs creating lots of threads.
>>   2) It mmap's 256K pages of anonymous memory.
>>   3) It writes executable code to that memory.
>>   4) It calls mprotect() with PROT_EXEC on that memory so
>>      it can subsequently execute the code.
>>
>> The above mprotect() will fail if the mmap'd region's VMA gets merged with
>> the VMA for one of the thread stacks.  That's because the default RHEL
>> SELinux policy is to not allow executable stacks.
> By the way, this is a daft policy.  The policy you really want is
> EXEC|WRITE is not allowed.  A non-writable stack is useless, so it's
> actually a superset of your current policy.  Forbidding _simultaneous_
> write and executable is just good programming.  This way, you don't need
> to care about the underlying VMA's current permissions, you just need
> to do:
>
> 	if ((prot & (PROT_EXEC|PROT_WRITE)) == (PROT_EXEC|PROT_WRITE))
> 		return -EACCESS;

I am not totally sure if the application changes the VMA to read-only 
first. Even if it does that, it highlights another possible issue when 
an anonymous VMA is merged with a stack VMA. Either the mprotect() to 
write-protect the VMA will fail or the application will segfault if it 
writes stuff to the stack. This particular issue is not related to 
SELinux. It provides another good idea why we should avoid merging stack 
VMA to anonymous VMA.

Cheers,
Longman

