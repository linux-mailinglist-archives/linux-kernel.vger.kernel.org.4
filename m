Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64F16FC9F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjEIPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbjEIPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53773C3B
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683645003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aBON9BagCS1dEKC7O+dSyOIycB+7hV0ncW4/EcaZsns=;
        b=d8lM4A7csg/AvB4VLR0YJvGmJjtFCLUQdPiGi4llOpaF/jOkI9diHseRSlVWpNOryXJnIj
        45HZD3GRQfJwzQFM+BmK9VNmEfriceifA17wrFA1eL/D4XfoyXQ2vja0TP3UBtMxEdnSwV
        jWyMmeGxEL7drt+hw+Ms3LXt4q3TT2E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-ejCbP0-zOMWg-l7vwXJYLA-1; Tue, 09 May 2023 11:09:59 -0400
X-MC-Unique: ejCbP0-zOMWg-l7vwXJYLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03E2A280253D;
        Tue,  9 May 2023 15:09:58 +0000 (UTC)
Received: from [10.18.17.153] (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B76912166B2F;
        Tue,  9 May 2023 15:09:57 +0000 (UTC)
Message-ID: <1428e38f-6dee-a162-b2e0-03604d73f889@redhat.com>
Date:   Tue, 9 May 2023 11:09:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/1] locking/qspinlock: Fix state-transition changes in
 comments
Content-Language: en-US
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <IA1PR11MB6171282A1E2CF22740398F8989769@IA1PR11MB6171.namprd11.prod.outlook.com>
 <20230509072902.66284-1-qiuxu.zhuo@intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230509072902.66284-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 03:29, Qiuxu Zhuo wrote:
> 1. set_locked() only sets the locked field to 1 and doesn't touch
>     the pending field. So the correct lock state transition is:
>
>           *,*,0 -> *,*,1
>
> 2. The initial lock state when calling clear_pending_set_locked() is
>     the state just after waiting for the locker goes away. So the
>     state transition for clear_pending_set_locked() is:
>
>           *,1,0 -> *,0,1
>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>   v1->v2:
>   - Drop the state transition comments fixes (viewed from the current lock word value).
>   - Update the commit message accordingly.
>
>   kernel/locking/qspinlock.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..256021c87ac1 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -257,7 +257,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
>    * set_locked - Set the lock bit and own the lock
>    * @lock: Pointer to queued spinlock structure
>    *
> - * *,*,0 -> *,0,1
> + * *,*,0 -> *,*,1
>    */
>   static __always_inline void set_locked(struct qspinlock *lock)
>   {
> @@ -385,7 +385,7 @@ void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>   	/*
>   	 * take ownership and clear the pending bit.
>   	 *
> -	 * 0,1,0 -> 0,0,1
> +	 * *,1,0 -> *,0,1
>   	 */
>   	clear_pending_set_locked(lock);
>   	lockevent_inc(lock_pending);
Acked-by: Waiman Long <longman@redhat.com>

