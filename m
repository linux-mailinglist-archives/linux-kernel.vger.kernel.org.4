Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F49717C77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjEaJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjEaJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BFE8
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685526829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xn2QBqttB+dOYYBuMERj9tPY3tQCj+h6bHqi72Etugo=;
        b=HL0Exjzd1A/K2FKRfX9G8gs4ikS2vnG4M4UyyM8aZcyJDeUHSlF4FeDRFaU9tdDDjX5obj
        qz0ofHYtggjofP6VSMjgGYxb1QrDm5MSLu7oQrBz7zf9rtiMSmVXFzdcBaQfUD8n/3SG7g
        MuEmyYoAeIfa+4qMb2E0GKiFA8tjnuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-YoT3WvbRNtq9mfbC6sguhg-1; Wed, 31 May 2023 05:53:39 -0400
X-MC-Unique: YoT3WvbRNtq9mfbC6sguhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9C96101A53A;
        Wed, 31 May 2023 09:53:38 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D80EB140E962;
        Wed, 31 May 2023 09:53:37 +0000 (UTC)
Date:   Wed, 31 May 2023 17:53:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/6] kexec: enable kexec_crash_size to support two crash
 kernel regions
Message-ID: <ZHcY/jsExa8t7hJW@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-7-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527123439.772-7-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/23 at 08:34pm, Zhen Lei wrote:
> The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
> to support two crash kernel regions. Since crashk_res manages the memory
> with high address and crashk_low_res manages the memory with low address,
> crashk_low_res is shrunken only when all crashk_res is shrunken. And
> because when there is only one crash kernel region, crashk_res is always
> used. Therefore, if all crashk_res is shrunken and crashk_low_res still
> exists, swap them.

This looks good, otherwise someone else won't stop attempting to add
support of crashk_low_res shrinking. Not sure if this will bring corner
case issue in testing, let's see. For the patch log, I tried to
rephrase, feel free to refer to.

=====
The crashk_low_res should be considered by /sys/kernel/kexec_crash_size
to support two crash kernel regions shrinking if existing.

While doing it, crashk_low_res will only be shrunk when the entire
crashk_res is empty; and if the crashk_res is empty and crahk_low_res
is not, change crashk_low_res to be crashk_res.
=====

With the log updated, you can add:

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index e82bc6d6634136a..c1d50f6566300d9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1091,6 +1091,11 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  	}
>  }
>  
> +static inline resource_size_t crash_resource_size(const struct resource *res)
> +{
> +	return !res->end ? 0 : resource_size(res);
> +}
> +
>  ssize_t crash_get_memory_size(void)
>  {
>  	ssize_t size = 0;
> @@ -1098,8 +1103,8 @@ ssize_t crash_get_memory_size(void)
>  	if (!kexec_trylock())
>  		return -EBUSY;
>  
> -	if (crashk_res.end != crashk_res.start)
> -		size = resource_size(&crashk_res);
> +	size += crash_resource_size(&crashk_res);
> +	size += crash_resource_size(&crashk_low_res);
>  
>  	kexec_unlock();
>  	return size;
> @@ -1135,7 +1140,7 @@ int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)
>  int crash_shrink_memory(unsigned long new_size)
>  {
>  	int ret = 0;
> -	unsigned long old_size;
> +	unsigned long old_size, low_size;
>  
>  	if (!kexec_trylock())
>  		return -EBUSY;
> @@ -1144,14 +1149,42 @@ int crash_shrink_memory(unsigned long new_size)
>  		ret = -ENOENT;
>  		goto unlock;
>  	}
> -	old_size = !crashk_res.end ? 0 : resource_size(&crashk_res);
> +
> +	low_size = crash_resource_size(&crashk_low_res);
> +	old_size = crash_resource_size(&crashk_res) + low_size;
>  	new_size = roundup(new_size, KEXEC_CRASH_MEM_ALIGN);
>  	if (new_size >= old_size) {
>  		ret = (new_size == old_size) ? 0 : -EINVAL;
>  		goto unlock;
>  	}
>  
> -	ret = __crash_shrink_memory(&crashk_res, new_size);
> +	/*
> +	 * (low_size > new_size) implies that low_size is greater than zero.
> +	 * This also means that if low_size is zero, the else branch is taken.
> +	 *
> +	 * If low_size is greater than 0, (low_size > new_size) indicates that
> +	 * crashk_low_res also needs to be shrunken. Otherwise, only crashk_res
> +	 * needs to be shrunken.
> +	 */
> +	if (low_size > new_size) {
> +		ret = __crash_shrink_memory(&crashk_res, 0);
> +		if (ret)
> +			goto unlock;
> +
> +		ret = __crash_shrink_memory(&crashk_low_res, new_size);
> +	} else {
> +		ret = __crash_shrink_memory(&crashk_res, new_size - low_size);
> +	}
> +
> +	/* Swap crashk_res and crashk_low_res if needed */
> +	if (!crashk_res.end && crashk_low_res.end) {
> +		crashk_res.start = crashk_low_res.start;
> +		crashk_res.end   = crashk_low_res.end;
> +		release_resource(&crashk_low_res);
> +		crashk_low_res.start = 0;
> +		crashk_low_res.end   = 0;
> +		insert_resource(&iomem_resource, &crashk_res);
> +	}
>  
>  unlock:
>  	kexec_unlock();
> -- 
> 2.25.1
> 

