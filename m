Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25F717259
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjEaASw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjEaASl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E2F3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685492279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=baSFBqUUVIrLoDCDA2ucQJhIAa+yyQWxP1bD9ZLCVTk=;
        b=W1YqhH2OeA3C5Wws5uw8Asb0FfAV0MW+Ak5nOk/RzszWRT0Q0nVFnnCw2p9dduCUcOAKqV
        lQmfl+ZedAdpDLo0FTkMSyoMkMMmCF9JrByVgQ2uvSUBrZGHMlJJU1zOQ5MosuunZvERIp
        2sCJIeeEEN4IAILWKHRaTalrErmoVy0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-NsKU-DCeN1KOYrl-AbZAIQ-1; Tue, 30 May 2023 20:17:56 -0400
X-MC-Unique: NsKU-DCeN1KOYrl-AbZAIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECA7C1C05B04;
        Wed, 31 May 2023 00:17:55 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE9D3492B0A;
        Wed, 31 May 2023 00:17:54 +0000 (UTC)
Date:   Wed, 31 May 2023 08:17:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] kexec: delete a useless check in
 crash_shrink_memory()
Message-ID: <ZHaSF4EGNwSGhGAL@MiWiFi-R3L-srv>
References: <20230527123439.772-1-thunder.leizhen@huawei.com>
 <20230527123439.772-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527123439.772-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
> The check '(crashk_res.parent != NULL)' is added by
> commit e05bd3367bd3 ("kexec: fix Oops in crash_shrink_memory()"), but it's
> stale now. Because if 'crashk_res' is not reserved, it will be zero in
> size and will be intercepted by the above 'if (new_size >= old_size)'.
> 
> Ago:
> 	if (new_size >= end - start + 1)
> 
> Now:
> 	old_size = (end == 0) ? 0 : end - start + 1;
> 	if (new_size >= old_size)

Hmm, I would strongly suggest we keep that check. Even though the
current code like above can do the acutal checking, but its actual usage
is not obvious for checking of crashk_res existence. In the future,
someone may change above calculation and don't notice the hidden
functionality at all behind the calculation. The cost of the check is
almost zero, right?

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 22acee18195a591..d1ab139dd49035e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1137,7 +1137,7 @@ int crash_shrink_memory(unsigned long new_size)
>  	end = start + new_size;
>  	crash_free_reserved_phys_range(end, crashk_res.end);
>  
> -	if ((start == end) && (crashk_res.parent != NULL))
> +	if (start == end)
>  		release_resource(&crashk_res);
>  
>  	ram_res->start = end;
> -- 
> 2.25.1
> 

