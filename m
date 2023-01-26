Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9541267CBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjAZNUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236703AbjAZNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:19:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF985DC3F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674739047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMUimJQBK8hdWS4zMwPJEN6KzePMp61KnndCJOD3Doc=;
        b=i4BpY0UarrWCTIdtHvyAPmhEFTYXLeSMtkF6i04+mICQU8Jp4UxRCD4VWHMxe5fLl9iQOo
        zaA+Cb3rDTnuG34IfRTfADFnoczXo5JfbEVU095pGAwesL7mD3Q7HAH82TKEIBx/mOx17a
        vNTeICpzzINEQrSpJQfeHxQgT6WFxFU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-U-Ljt_Q9M9aZwoh8xxPIzw-1; Thu, 26 Jan 2023 08:17:23 -0500
X-MC-Unique: U-Ljt_Q9M9aZwoh8xxPIzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73BD480D0E6;
        Thu, 26 Jan 2023 13:17:22 +0000 (UTC)
Received: from [10.22.33.13] (unknown [10.22.33.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9779051E5;
        Thu, 26 Jan 2023 13:17:21 +0000 (UTC)
Message-ID: <07ba0fcf-8842-27d8-9dac-862981734c3a@redhat.com>
Date:   Thu, 26 Jan 2023 08:17:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 0/4] lockinig/rwsem: Fix rwsem bugs & enable true lock
 handoff
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        =?UTF-8?B?VGluZzExIFdhbmcg546L5am3?= <wangting11@xiaomi.com>
References: <20230126003628.365092-1-longman@redhat.com>
 <Y9J2HkiyLDmGPWyn@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9J2HkiyLDmGPWyn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 07:46, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> v7:
>>   - Add a comment to down_read_non_owner() in patch 2.
>>   - Drop v6 patches 4 & 6 and simplify the direct rwsem lock handoff
>>     patch as suggested by PeterZ.
>>
>> v6:
>>   - Fix an error in patch 2 reported by kernel test robot.
>>
>> v5:
>>   - Drop patch 2 and replace it with 2 new patches disabling preemption on
>>     all reader functions and writer functions respectively. The other
>>     patches are adjusted accordingly.
>>
>> It turns out the current waiter optimistic spinning code does not work
>> that well if we have RT tasks in the mix. This patch series include two
>> different fixes to resolve those issues. The last 3 patches modify the
>> handoff code to implement true lock handoff similar to that of mutex.
>>
>> Waiman Long (4):
>>    locking/rwsem: Prevent non-first waiter from spinning in down_write()
>>      slowpath
>>    locking/rwsem: Disable preemption at all down_read*() and up_read()
>>      code paths
>>    locking/rwsem: Disable preemption at all down_write*() and up_write()
>>      code paths
>>    locking/rwsem: Enable direct rwsem lock handoff
>>
>>   kernel/locking/rwsem.c | 161 +++++++++++++++++++++++++++++------------
>>   1 file changed, 115 insertions(+), 46 deletions(-)
> So as a first step I've applied the first 3 patches to the locking tree,
> which are arguably fixes.

Thanks for merging into tip.

Cheers,
Longman

