Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C7612B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJ3PWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3PV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C3B6307
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667143262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tf0fjcXSTbIxb+bJXdEwwDfCxOqOPnTnkYmD4K9mG8o=;
        b=hpRIlwg/bULkP9YpWuS22So3shfwGdLEXZySLPdrDzfThjHSs6nUxHdHI5ix3qiwGjJfSk
        CzpPt09Mg5/Vqoa2myF/hopYbc6DYvGljDE4GFm2oBy2zQq1tZchComoguJaExd26fQiy+
        EID6oCLnrennRPGm3/6wcOcvpXKgFjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-4_fh9qS_ObeTX-KHs3abGA-1; Sun, 30 Oct 2022 11:21:00 -0400
X-MC-Unique: 4_fh9qS_ObeTX-KHs3abGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0B57185A79C;
        Sun, 30 Oct 2022 15:20:59 +0000 (UTC)
Received: from [10.22.8.21] (unknown [10.22.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2024EA5B;
        Sun, 30 Oct 2022 15:20:59 +0000 (UTC)
Message-ID: <728c68cc-fef0-c48d-056b-6ed7352b443a@redhat.com>
Date:   Sun, 30 Oct 2022 11:20:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] locking/lockdep: Remove unused variable in
 __lockdep_count*()
To:     wuchi <wuchi.zero@gmail.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20221030111759.95092-1-wuchi.zero@gmail.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221030111759.95092-1-wuchi.zero@gmail.com>
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

On 10/30/22 07:17, wuchi wrote:
> The target_entry variable will never be referenced because the
> function noop_count() always returns false in __bfs().
> So just remove that.
>
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>   kernel/locking/lockdep.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e3375bc40dad..04d2ce5d0215 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2075,9 +2075,8 @@ static bool noop_count(struct lock_list *entry, void *data)
>   static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
>   {
>   	unsigned long  count = 0;
> -	struct lock_list *target_entry;
>   
> -	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +	__bfs_forwards(this, (void *)&count, noop_count, NULL, NULL);
>   
>   	return count;
>   }
> @@ -2100,9 +2099,8 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
>   static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
>   {
>   	unsigned long  count = 0;
> -	struct lock_list *target_entry;
>   
> -	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
> +	__bfs_backwards(this, (void *)&count, noop_count, NULL, NULL);
>   
>   	return count;
>   }

There is no target_entry NULL check in __bfs(), so target_entry is 
always expected to point to a valid memory location. You will need to 
add the NULL check if you want to remove it from these two functions.

BTW, have you actually exercised the code to make sure that there was no 
unexpected side effect from this change?

Cheers,
Longman

