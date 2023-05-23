Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D4D70D9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjEWKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjEWKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AB94
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684836101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0jmiNORGiyZJFJpIfdvkwSlqYGBcl3FERUWYSXrFwYI=;
        b=ZO7fQ6mBTOb+mJ3bDAQUpjpM4JSPuWeiXBpAxiZ/Hsqxax5h33EGVFRgo2eh948Scl1jpE
        pE/mLttgKddT9f5pUGxPxo2cQQVhVWtsJX/o6GdvvKJniV3gHz7dsxnKFYaZ/q5hjZ+GWj
        iTPaO5TUqS2VSY+ABfGGi8XrYjcA/MU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-xpY8084LNcW37PPM-kaKRw-1; Tue, 23 May 2023 06:01:40 -0400
X-MC-Unique: xpY8084LNcW37PPM-kaKRw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-306362a1607so4588921f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836099; x=1687428099;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jmiNORGiyZJFJpIfdvkwSlqYGBcl3FERUWYSXrFwYI=;
        b=XENchiDzSmVDfIxt4jVCSeEwsbO+9+fUgPuuleNxk15IPxImBISfbio8EIeEQl52+r
         XjGxi8KZOfK/bjOMBAWYTUmjjA/zOk5yOMjhI5cjatlkxJ59ycWfsAC++C1jFpuA2eoa
         M3laodRPo0opf6eKGMikPG1/ETWJFBn+1i3xX4672hFeE5JBH1LtpT/UuPrxnkpvGo6I
         A6HpdV1RrOjZjRyuy3JfgpfZnhT5GFF8gyW9UwoQrvdkEfEu4ocHU26p5AKXTJ5o4Szv
         zgyhixJSoQDSpNsk4shwPF1JDdYbaaQv0uJ7AScS4R0mk7rCjhQ3JwP82UI9C/iHY/Q1
         vghA==
X-Gm-Message-State: AC+VfDz4ropkbf8v00az57jQMmELgYsU/GwZ8lsly/PZORRRah1ngKIh
        cfyG7P/KabQLs5/1hU4OQdif34yQJC6JT+JeSmMLlpGOu3pTryM09J/K5T48JSOEvxuFWqOKdPv
        jFVbBQHO3ijGhhbIADOImuiqT
X-Received: by 2002:adf:f711:0:b0:306:35d2:c33a with SMTP id r17-20020adff711000000b0030635d2c33amr10262719wrp.50.1684836098808;
        Tue, 23 May 2023 03:01:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dmiDzcAlZXASpNOPRlqAvR9hodclk6X/X9b13ab7q3ukclNqy80UuPoTsUr3GxPBont2EMg==
X-Received: by 2002:adf:f711:0:b0:306:35d2:c33a with SMTP id r17-20020adff711000000b0030635d2c33amr10262694wrp.50.1684836098441;
        Tue, 23 May 2023 03:01:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id o2-20020a056000010200b002ca864b807csm10836709wrx.0.2023.05.23.03.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:01:38 -0700 (PDT)
Message-ID: <04d3ffe2-46ce-db30-8f1b-cb05cd21d328@redhat.com>
Date:   Tue, 23 May 2023 12:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 5/6] ksm: update the calculation of KSM profit
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn,
        Stefan Roesch <shr@devkernel.io>
References: <202305221842587200002@zte.com.cn>
 <20230522105402.4225-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522105402.4225-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 12:54, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 

I suggest changing the subject to

"ksm: consider KSM-placed zeropages when calculating KSM profit"

> When use_zero_pages is enabled, the calculation of ksm profit is not
> correct because ksm zero pages is not counted in. So update the
> calculation of KSM profit including the documentation.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>   Documentation/admin-guide/mm/ksm.rst | 18 +++++++++++-------
>   mm/ksm.c                             |  2 +-
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 019dc40a0d3c..dde7c152f0ae 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -204,21 +204,25 @@ several times, which are unprofitable memory consumed.
>   1) How to determine whether KSM save memory or consume memory in system-wide
>      range? Here is a simple approximate calculation for reference::
>   
> -	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
> +	general_profit =~ ksm_saved_pages * sizeof(page) - (all_rmap_items) *
>   			  sizeof(rmap_item);
>   
> -   where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> -   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
> +   where ksm_saved_pages equals to the sum of ``pages_sharing`` +
> +   ``ksm_zero_pages`` of the system, and all_rmap_items can be easily
> +   obtained by summing ``pages_sharing``, ``pages_shared``, ``pages_unshared``
> +   and ``pages_volatile``.
>   
>   2) The KSM profit inner a single process can be similarly obtained by the
>      following approximate calculation::
>   
> -	process_profit =~ ksm_merging_pages * sizeof(page) -
> +	process_profit =~ ksm_saved_pages * sizeof(page) -
>   			  ksm_rmap_items * sizeof(rmap_item).
>   
> -   where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
> -   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process profit
> -   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
> +   where ksm_saved_pages equals to the sum of ``ksm_merging_pages`` and
> +   ``ksm_zero_pages``, both of which are shown under the directory
> +   ``/proc/<pid>/ksm_stat``, and ksm_rmap_items is alos shown in

s/alos/also/

> +   ``/proc/<pid>/ksm_stat``. The process profit is also shown in
> +   ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
>   
>   From the perspective of application, a high ratio of ``ksm_rmap_items`` to
>   ``ksm_merging_pages`` means a bad madvise-applied policy, so developers or
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4e510f5c5938..d23a240c2519 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -3085,7 +3085,7 @@ static void wait_while_offlining(void)
>   #ifdef CONFIG_PROC_FS
>   long ksm_process_profit(struct mm_struct *mm)
>   {
> -	return mm->ksm_merging_pages * PAGE_SIZE -
> +	return (long)(mm->ksm_merging_pages + mm->ksm_zero_pages) * PAGE_SIZE -
>   		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
>   }
>   #endif /* CONFIG_PROC_FS */

Apart from that LGTM. CCing Stefan R.

-- 
Thanks,

David / dhildenb

