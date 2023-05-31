Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D219717281
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjEaAel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjEaAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D211D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685493222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v9DIsXmdxClvcSIg28Mmd8pgsPz6Obkd4iWTsPHZoEc=;
        b=V3hKO1iU3fQKDnIVJzjVoD3a0Dpt1zZyXBJkEXKX6F457qhC89ewi18J7NO1411Vv4/Js6
        h1jd27ov6z02sQeHn/ZIVvvH0Z5Q6PcSqzchFZ0YxzpKH2PDwfhBxZzFjHoSLH+DsBSiU4
        3ej5yoc1P4urpLNbP+VFKYlYitSTQ6g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-KrBGifksNNmvdSLxs9mF8g-1; Tue, 30 May 2023 20:33:40 -0400
X-MC-Unique: KrBGifksNNmvdSLxs9mF8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D54629DD988;
        Wed, 31 May 2023 00:33:40 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 64F8A112132C;
        Wed, 31 May 2023 00:33:39 +0000 (UTC)
Date:   Wed, 31 May 2023 08:33:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/6] kexec: clear crashk_res if all its memory has been
 released
Message-ID: <ZHaVuJrlYhIlpkFE@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527123439.772-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
> If the resource of crashk_res has been released, it is better to clear
> crashk_res.start and crashk_res.end. Because 'end = start - 1' is not
> reasonable, and in some places the test is based on crashk_res.end, not
> resource_size(&crashk_res).

This looks reasonable, at least I haven't think of any risk it could
bring. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d1ab139dd49035e..bcc86a250ab3bf9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1137,15 +1137,18 @@ int crash_shrink_memory(unsigned long new_size)
>  	end = start + new_size;
>  	crash_free_reserved_phys_range(end, crashk_res.end);
>  
> -	if (start == end)
> -		release_resource(&crashk_res);
> -
>  	ram_res->start = end;
>  	ram_res->end = crashk_res.end;
>  	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  	ram_res->name = "System RAM";
>  
> -	crashk_res.end = end - 1;
> +	if (start == end) {
> +		release_resource(&crashk_res);
> +		crashk_res.start = 0;
> +		crashk_res.end = 0;
> +	} else {
> +		crashk_res.end = end - 1;
> +	}
>  
>  	insert_resource(&iomem_resource, ram_res);
>  
> -- 
> 2.25.1
> 

