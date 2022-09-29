Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DD05EFCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiI2SHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiI2SHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ADC1B95E9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664474825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRzdq8mq9arpjI/e/1rqcxjVTskm5LfNGtLLpdc1IU0=;
        b=f51KM3qKEi53q72iduCQLTMNYtcrDMCmq4MjYGDW4V6GE40rFzlX/zjsddFsq7GuwFkWEc
        jZ6bd6G3ssryWo9N3QOMY95mcV4+aI4CEBBolwG2Gz8zGhd8clbsvnO0mE1w/f219FAArV
        yCvFxLgPduFsQTuAb2OVckbrskRBk+8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-PJ7P_HZ5OEeGIqvd5K4rqw-1; Thu, 29 Sep 2022 14:07:00 -0400
X-MC-Unique: PJ7P_HZ5OEeGIqvd5K4rqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E2B2833948;
        Thu, 29 Sep 2022 18:07:00 +0000 (UTC)
Received: from [10.22.8.248] (unknown [10.22.8.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFBBB42238;
        Thu, 29 Sep 2022 18:06:59 +0000 (UTC)
Message-ID: <6530f135-e8ac-bb6c-4715-1ea8f76cf4c4@redhat.com>
Date:   Thu, 29 Sep 2022 14:06:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] locking/rwsem: Prevent non-first waiter from spinning in
 down_write() slowpath
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20220929180413.107374-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220929180413.107374-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 14:04, Waiman Long wrote:
> A non-first waiter can potentially spin in the for loop of
> rwsem_down_write_slowpath() without sleeping but fail to acquire the
> lock even if the rwsem is free if the following sequence happens:
>
>    Non-first waiter       First waiter      Lock holder
>    ----------------       ------------      -----------
>    Acquire wait_lock
>    rwsem_try_write_lock():
>      Set handoff bit if RT or
>        wait too long
>      Set waiter->handoff_set
>    Release wait_lock
>                           Acquire wait_lock
>                           Inherit waiter->handoff_set
>                           Release wait_lock
> 					   Clear owner
>                                             Release lock
>    if (waiter.handoff_set) {
>      rwsem_spin_on_owner(();
>      if (OWNER_NULL)
>        goto trylock_again;
>    }
>    trylock_again:
>    Acquire wait_lock
>    rwsem_try_write_lock():
>       if (first->handoff_set && (waiter != first))
>       	return false;
>    Release wait_lock
>
> It is especially problematic if the non-first waiter is an RT task and
> it is running on the same CPU as the first waiter as this can lead to
> live lock.
>
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rwsem.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)

Mukesh, can you test if this patch can fix the RT task lockup problem?

Thanks,
Longman

