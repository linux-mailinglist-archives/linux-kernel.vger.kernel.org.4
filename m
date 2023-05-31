Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C697178F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjEaHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjEaHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E610F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1aeBJzatpJpgjRuxMCn5JWW+YK9YBd8odlhv1lWmlc=;
        b=PjJCBrhtJiN73SVtgm+uinM7yD9RJbBsA4S43623aLbKw5oVt5PNTX4uZROOUp0Ms0D+Sj
        MERXJDU4xflVdIQdUBFKe1cgKRFis8Y/U8gH0qp6Kq6V4Bh+/z8RwTFSA0dZ99Va4G4Uk2
        cVvfkt5MVZuTx+p4biGsZmhZeR1w79M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Z99OpKI9Oi-dl-AZH0wRRw-1; Wed, 31 May 2023 03:50:30 -0400
X-MC-Unique: Z99OpKI9Oi-dl-AZH0wRRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF2628032EF;
        Wed, 31 May 2023 07:50:29 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5B81C154D7;
        Wed, 31 May 2023 07:50:28 +0000 (UTC)
Date:   Wed, 31 May 2023 15:50:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/6] kexec: add helper __crash_shrink_memory()
Message-ID: <ZHb8Ms1T32K+Iyo2@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527123439.772-6-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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
> No functional change, in preparation for the next patch so that it is
> easier to review.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 50 +++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 69fe92141b0b62d..e82bc6d6634136a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1105,11 +1105,37 @@ ssize_t crash_get_memory_size(void)
>  	return size;
>  }
>  
> +int __crash_shrink_memory(struct resource *old_res, unsigned long new_size)

Other than the missing static, looks good,

Acked-by: Baoquan He <bhe@redhat.com>

> +{
> +	struct resource *ram_res;
> +
> +	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
> +	if (!ram_res)
> +		return -ENOMEM;
> +
> +	ram_res->start = old_res->start + new_size;
> +	ram_res->end   = old_res->end;
> +	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> +	ram_res->name  = "System RAM";
> +
> +	if (!new_size) {
> +		release_resource(old_res);
> +		old_res->start = 0;
> +		old_res->end   = 0;
> +	} else {
> +		crashk_res.end = ram_res->start - 1;
> +	}
> +
> +	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
> +	insert_resource(&iomem_resource, ram_res);
> +
> +	return 0;
> +}
> +
>  int crash_shrink_memory(unsigned long new_size)
>  {
>  	int ret = 0;
>  	unsigned long old_size;
> -	struct resource *ram_res;
>  
>  	if (!kexec_trylock())
>  		return -EBUSY;
> @@ -1125,27 +1151,7 @@ int crash_shrink_memory(unsigned long new_size)
>  		goto unlock;
>  	}
>  
> -	ram_res = kzalloc(sizeof(*ram_res), GFP_KERNEL);
> -	if (!ram_res) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	ram_res->start = crashk_res.start + new_size;
> -	ram_res->end = crashk_res.end;
> -	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
> -	ram_res->name = "System RAM";
> -
> -	if (!new_size) {
> -		release_resource(&crashk_res);
> -		crashk_res.start = 0;
> -		crashk_res.end = 0;
> -	} else {
> -		crashk_res.end = ram_res->start - 1;
> -	}
> -
> -	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
> -	insert_resource(&iomem_resource, ram_res);
> +	ret = __crash_shrink_memory(&crashk_res, new_size);
>  
>  unlock:
>  	kexec_unlock();
> -- 
> 2.25.1
> 

