Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4935B3663
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIILb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIILbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849712D559
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2oeKJx7G2NhC1w+c8eq8auddLUonMGciT45UzuZW/c=;
        b=QwHfF4nUkclSNwriH6nWVgWArpX9w/Fq8aGVdKTpt7zJquvvnwsYCbStpfB1xOpbjXL6J0
        ZtV717sPZfD3n9lRZX7ioR8WZ1zAYiQqHX0AgjNtw5lWi47mySEGvliQdMd745Y0fSdUqi
        li/h4zBJwveVB1v+jd1jxZZbQycaqlM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-70-gohRjwtqPXyZyW6Q3k2FRQ-1; Fri, 09 Sep 2022 07:31:53 -0400
X-MC-Unique: gohRjwtqPXyZyW6Q3k2FRQ-1
Received: by mail-wm1-f70.google.com with SMTP id bg2-20020a05600c3c8200b003b33080cff8so1071666wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=F2oeKJx7G2NhC1w+c8eq8auddLUonMGciT45UzuZW/c=;
        b=QqQU6x53jkSLHFoWrysZHGhe35QrSeOi3n+Q4xYodyAOzngoFNsFVPenKzSmPXrl4e
         hmeSZ+D4mqoUMmz5oaPg2xRxd4fxjLSF6qh3PAQpnAbgPCG2QRxIjPVYVu818sPeHRgD
         kO8IfgMBN2jmF7PDmRL5p4bH+aK7Y3B13Ahj/GNGQHD5dv8Byz1TmNEsCVCD4N/hbS8H
         e2/hrjJ6xWxbgJbSXE3xxZ5mH8oRg7lhDEDCe4+Ujua2esgXK5JEIuv2/AJgJYybeb4d
         ABznzy4eLZIzeqYnmVTe44+xkNd5pBOW5a06P3yM3dlucpbFx2lZKIPz8b6yUdEIf+la
         I76Q==
X-Gm-Message-State: ACgBeo3prZlL2q1LrMQqMXBzFGFX+nTFTRk5tLxM5CeBmOJgvzEEdIB0
        F7LD3QXyAv3k/k5zomz5kQHtJ4VMEjdKZlGpHTeefVUjUWQZsswrHIpRHpKe65NKZMXghebd68n
        OzNTfXUK8dLe0HwGuzi+ejduq
X-Received: by 2002:a05:600c:5106:b0:3a8:411c:7366 with SMTP id o6-20020a05600c510600b003a8411c7366mr5143741wms.204.1662723112174;
        Fri, 09 Sep 2022 04:31:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QJQF19h8ckQdSAMcJvVPq2I7tGt7Zut0J/2lOWjNSEOrT6l2tVEyQ/4I7Omip4It4QstTNg==
X-Received: by 2002:a05:600c:5106:b0:3a8:411c:7366 with SMTP id o6-20020a05600c510600b003a8411c7366mr5143728wms.204.1662723111895;
        Fri, 09 Sep 2022 04:31:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b003a8434530bbsm494211wms.13.2022.09.09.04.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:31:51 -0700 (PDT)
Message-ID: <270fbfd7-bf16-e3cc-85c3-21acd0587d94@redhat.com>
Date:   Fri, 9 Sep 2022 13:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 09/16] mm/page_alloc: use local variable zone_idx directly
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-10-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-10-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> Use local variable zone_idx directly since it holds the exact value of
> zone_idx(). No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 94baf33da865..3417232afa45 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6878,7 +6878,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>   	unsigned long start = jiffies;
>   	int nid = pgdat->node_id;
>   
> -	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
> +	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>   		return;
>   
>   	/*

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

