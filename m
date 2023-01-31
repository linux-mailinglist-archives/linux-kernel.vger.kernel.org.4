Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAAF68269E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjAaIha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjAaIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65AF222EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675154130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gEXPkm2deTpGOq986t/LPngut+HkZZrd809/PA2mKmo=;
        b=IvKyLKXy6hos+O9BrB8JAa2XehHq039oeT9hmBHKby9R4sQSJ5wnAg0805RhacEvIqudBK
        Nz+gCWlmgZZWfEUQ+lje6/12s84JTe/6ssbbROYcCftWdwQoKHJqCs9HSpIK6sp9KTI3oc
        48EzpMIUSLVgwFjG3dXlp474TSC5pJw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-WALqZ0voMKegNvQRpdcJag-1; Tue, 31 Jan 2023 03:35:29 -0500
X-MC-Unique: WALqZ0voMKegNvQRpdcJag-1
Received: by mail-wm1-f69.google.com with SMTP id e38-20020a05600c4ba600b003dc434dabbdso6196183wmp.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEXPkm2deTpGOq986t/LPngut+HkZZrd809/PA2mKmo=;
        b=20hjzHOuHJWWQCl7cD4anIhRzFa5EY5Vqo6qoL4gwRQFClvejNxgMd1FWcTLTCTec7
         O2iGW8f6tGpjiH3lEhReamyk1SoywH+sZh+/6JtD4rTG95hlYhQe7f3ADkdVhOuwb1HU
         7InQ0dF6SJm5uMFo1208OFwXir0adMVtjTMFqo7l66J+nmRURaqmfZH6hMRcGJNRQIAT
         GSw6lQ+LvWEJDTsLi7irjAURg8qquaNMKguabpbID4t3c8hZaW3EPVftcBuuHDazd6Ee
         jiaDSfuonM8cSG97R8bEYrRZkCLSAlP/VPHRFpFi1W1cRlBhj6YGui/etFkqj62lURJK
         yZGg==
X-Gm-Message-State: AO0yUKWS6Y0Qj8OR6dFHuNir1fn4bmbMB9tUpjEnUgQG8nLvBMSxys7U
        9mflIi4+z0eDDuH9X07ohqZjb/2pBKcFE4BqoHNJ2SJ6AtubK7ifoG4PA9wCebwiMwTCij0m1fY
        YOeg3b8Mraam9PbIQDjcDRuvY
X-Received: by 2002:a05:600c:5022:b0:3dc:3398:cf7f with SMTP id n34-20020a05600c502200b003dc3398cf7fmr16251593wmr.26.1675154128202;
        Tue, 31 Jan 2023 00:35:28 -0800 (PST)
X-Google-Smtp-Source: AK7set/dIaNpMyEGuks53GD0rMx/xrUMoKEqNRXDdjxBQr9skCTr2hZwU95hHfmGy6R/UmFYPxh3oQ==
X-Received: by 2002:a05:600c:5022:b0:3dc:3398:cf7f with SMTP id n34-20020a05600c502200b003dc3398cf7fmr16251575wmr.26.1675154127920;
        Tue, 31 Jan 2023 00:35:27 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c341500b003da28dfdedcsm9456694wmp.5.2023.01.31.00.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:35:27 -0800 (PST)
Message-ID: <97ea66a4-54a0-68a3-c42b-f3c36c69768e@redhat.com>
Date:   Tue, 31 Jan 2023 09:35:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/mmap: Fix vma_merge() offset when expanding the next
 vma
Content-Language: en-US
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Cc:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
References: <20230130195713.2881766-1-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230130195713.2881766-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.01.23 20:57, Liam R. Howlett wrote:
> The vm_pgoff was being set incorrectly when expanding the next VMA to a
> lower address.  Fix the issue by using the mid->vm_pgoff value for this
> merge case (aka case 8).  Note that this does not change case 3's
> vm_pgoff as next and mid are the same VMA.
> 
> Reported-by: Sanan Hasanov <sanan.hasanov@knights.ucf.edu>
> Link: https://lore.kernel.org/linux-mm/IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com/
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>

Fixes: ?

> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   mm/mmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 00d90bbc250e..614ea2d93b0a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -978,7 +978,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   			vma = next;			/* case 3 */
>   			vma_start = addr;
>   			vma_end = next->vm_end;
> -			vma_pgoff = next->vm_pgoff;
> +			vma_pgoff = mid->vm_pgoff;
>   			err = 0;
>   			if (mid != next) {		/* case 8 */
>   				remove = mid;

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

