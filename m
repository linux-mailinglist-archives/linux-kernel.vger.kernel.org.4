Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8961719A00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjFAKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjFAKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1733CC0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685616025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UiSS9nj6xH+Um2NERpCFyQMVz8ELBfz4b0zRoYrjHKU=;
        b=P9nPDrIXVP9qko8mrhwHnsObBr1I3TO9UPBF0gJuHk+esnvOAMWORtdU7h2mn3H7GQP25i
        ZxQR2vzBBlzR0hye4Yp1PQrwZA0m6i+hTu5NlOv3ZeztbrNhsqC+4rw+rtQhSDCMq1MlhN
        PJJcFRQVW8WbIPyk7UsHG7MCW0UuSRY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-CsHaACKPPbm9rtHrH7kkMw-1; Thu, 01 Jun 2023 06:40:21 -0400
X-MC-Unique: CsHaACKPPbm9rtHrH7kkMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD136280AA26;
        Thu,  1 Jun 2023 10:40:20 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01D0A8162;
        Thu,  1 Jun 2023 10:40:19 +0000 (UTC)
Date:   Thu, 1 Jun 2023 18:40:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Avoid calculating array size twice
Message-ID: <ZHh1kBxfOf6hCvo8@MiWiFi-R3L-srv>
References: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25/23 at 04:26pm, Simon Horman wrote:
> Avoid calculating array size twice in kexec_purgatory_setup_sechdrs().
> Once using array_size(), and once open-coded.
> 
> Flagged by Coccinelle:
> 
>   .../kexec_file.c:881:8-25: WARNING: array_size is already used (line 877) to compute the same size

Amazingly smart. Thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  kernel/kexec_file.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f989f5f1933b..3f5677679744 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -867,6 +867,7 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  {
>  	unsigned long bss_addr;
>  	unsigned long offset;
> +	size_t sechdrs_size;
>  	Elf_Shdr *sechdrs;
>  	int i;
>  
> @@ -874,11 +875,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
>  	 * The section headers in kexec_purgatory are read-only. In order to
>  	 * have them modifiable make a temporary copy.
>  	 */
> -	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
> +	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
> +	sechdrs = vzalloc(sechdrs_size);
>  	if (!sechdrs)
>  		return -ENOMEM;
> -	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
> -	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
> +	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
>  	pi->sechdrs = sechdrs;
>  
>  	offset = 0;
> 

