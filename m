Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AB36E70D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjDSBq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSBq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653A7AB9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681868738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxbho8QxMR+zxIIpkOmO13HkVCORBZijDHQqdGD2kSE=;
        b=fIfOQmKjIsgvch3FSliyF/AFqQ6D6T0w8ynhEks4NBaqeNrhBsHAITXvZRnfwNHyjAsS4F
        BLLfACAPliM9Xraoj5nSTZrvTNA6jidSY2Czbf0kahRrF5rIDKazt5T8qiraEuF5nFOOvL
        WoZqpaQjANkiOS5SR06vGWJYfrXjdV4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-nt_oy41jNOyHJiCmN5TsSg-1; Tue, 18 Apr 2023 21:45:35 -0400
X-MC-Unique: nt_oy41jNOyHJiCmN5TsSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E2E68996E0;
        Wed, 19 Apr 2023 01:45:35 +0000 (UTC)
Received: from [10.22.34.98] (unknown [10.22.34.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED1485AB7A;
        Wed, 19 Apr 2023 01:45:34 +0000 (UTC)
Message-ID: <22aee5ea-dd6b-ac2b-0b28-a25ee6602b48@redhat.com>
Date:   Tue, 18 Apr 2023 21:45:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
 <cffc7454-614-1939-f235-7b139dc46b41@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <cffc7454-614-1939-f235-7b139dc46b41@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/23 21:36, Hugh Dickins wrote:
> On Tue, 18 Apr 2023, Waiman Long wrote:
>> On 4/18/23 17:18, Andrew Morton wrote:
>>> On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wrote:
>>>
>>>> One of the flags of mmap(2) is MAP_STACK to request a memory segment
>>>> suitable for a process or thread stack. The kernel currently ignores
>>>> this flags. Glibc uses MAP_STACK when mmapping a thread stack. However,
>>>> selinux has an execstack check in selinux_file_mprotect() which disallows
>>>> a stack VMA to be made executable.
>>>>
>>>> Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
>>>> with an adjacent anonymous VMA. With that merging, using mprotect(2)
>>>> to change a part of the merged anonymous VMA to make it executable may
>>>> fail. This can lead to sporadic failure of applications that need to
>>>> make those changes.
>>> "Sporadic failure of applications" sounds quite serious.  Can you
>>> provide more details?
>> The problem boils down to the fact that it is possible for user code to mmap a
>> region of memory and then for the kernel to merge the VMA for that memory with
>> the VMA for one of the application's thread stacks. This is causing random
>> SEGVs with one of our large customer application.
>>
>> At a high level, this is what's happening:
>>
>>   1) App runs creating lots of threads.
>>   2) It mmap's 256K pages of anonymous memory.
>>   3) It writes executable code to that memory.
>>   4) It calls mprotect() with PROT_EXEC on that memory so
>>      it can subsequently execute the code.
>>
>> The above mprotect() will fail if the mmap'd region's VMA gets merged with the
>> VMA for one of the thread stacks.  That's because the default RHEL SELinux
>> policy is to not allow executable stacks.
> Then wouldn't the bug be at the SELinux end?  VMAs may have been merged
> already, but the mprotect() with PROT_EXEC of the good non-stack range
> will then split that area off from the stack again - maybe the SELinux
> check does not understand that must happen?

The SELinux check is done per VMA, not a region within a VMA. After VMA 
merging, SELinux is probably not able to determine which part of a VMA 
is a stack unless we keep that information somewhere and provide an API 
for SELinux to query. That can be quite a lot of work. So the easiest 
way to prevent this problem is to avoid merging a stack VMA with a 
regular anonymous VMA.

Cheers,
Longman

