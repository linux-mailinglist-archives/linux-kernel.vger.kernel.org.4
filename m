Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5165FC64D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJLNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJLNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89F474DB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665580797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GcZ45yRu2GyW+Co6nWRGGRC1Ai53wvLIU4B5zOXWM2E=;
        b=h3qV9/TmyHZO6Vw18huYnprzTw8FrX5iunOtGqIk9EFOLIzZ4ENY+ClsPNmiPZtyOPoh9f
        kpiF7jwiBrpUnSAuzYlUuGbpH1DL17LLOQZEYTdIlHT7xV322r6B1gHqvb2S3pGJgrxOiK
        HzTItL4rx2fx7dkSCUj8Cj4OF2TMEwE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-sbiD5b3-M0mfKTYos3RZwA-1; Wed, 12 Oct 2022 09:19:54 -0400
X-MC-Unique: sbiD5b3-M0mfKTYos3RZwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE48A1C05AF3;
        Wed, 12 Oct 2022 13:19:53 +0000 (UTC)
Received: from [10.22.33.120] (unknown [10.22.33.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 788EE492CA2;
        Wed, 12 Oct 2022 13:19:53 +0000 (UTC)
Message-ID: <c8b590a0-3535-51f1-3c7d-a67da4bcfc5e@redhat.com>
Date:   Wed, 12 Oct 2022 09:19:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221012040410.403-1-hdanton@sina.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221012040410.403-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 00:04, Hillf Danton wrote:
>> you mean, you want to check and change waiter->handoff_set on every run
>> rwsem_try_write_lock().
>>
> Yes, with RWSEM_FLAG_HANDOFF set, it is too late for non first waiters to
> spin, and with both RWSEM_LOCK_MASK and RWSEM_FLAG_HANDOFF set, the rivals
> in the RWSEM_LOCK_MASK have an uphand over the first waiter wrt acquiring
> the lock, and it is not a bad option for the first waiter to take a step
> back off.
>
> 		if (count & RWSEM_LOCK_MASK) {
> 			if (has_handoff || (!rt_task(waiter->task) &&
> 					    !time_after(jiffies, waiter->timeout)))
> 				return false;
>
> 			new |= RWSEM_FLAG_HANDOFF;
> 		} else {
>
>> But does it break optimistic spinning ? @waiman ?
> Waiters spin for acquiring lock instead of lockup and your report shows
> spinning too much makes trouble. The key is stop spinning neither too
> late nor too early. My proposal is a simple one with as few heuristics
> added as possible.

Yes, too much spinning is bad if we have RT tasks in the mix, otherwise 
it should be fine.

Cheers,
Longman

