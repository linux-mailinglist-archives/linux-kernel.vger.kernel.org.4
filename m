Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3056375FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKXKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKXKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:10:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0FBB9607
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669284584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kAYquvyXCoEwzo0E+846zCjz/I/oFJHnxyQt8aQxnE=;
        b=CZ0k5cyC/4fESQvmDVkX+yXUSL1tCDwzWdtlDL8JtIN7avTIklpMuDWGQPi7TybI47H2ZZ
        oid1KiY9mZfCz/s8EbpDLMCVp5zrwjP/U/jfx4KEVTfxy+IfgMKIRvdYyX7CXdOWDj+jgO
        wQgyCacr6KUwmR7yazD6N5bXtwLxfYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-StVpu-4DPdKYW7pFIIwKKg-1; Thu, 24 Nov 2022 05:09:42 -0500
X-MC-Unique: StVpu-4DPdKYW7pFIIwKKg-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso2424474wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kAYquvyXCoEwzo0E+846zCjz/I/oFJHnxyQt8aQxnE=;
        b=tpS89gg4tatPXYIEkY8mbVXp6+azRmdzM/US6RwteHt2NZtlPn8tz6SL6/YwKz1QTn
         88CItqwzeZu6iNCBEz4On47V1wfJlv7HsIwz9scOHfSPyaZfOTvWW/vs8IkCCEF7BFnj
         YRpKb0/tAKBBQTZaJD1VeNpbNWZWoa9/NPCQhNS/iyVh+jzzViOAVFdIIXpGYG8G8wDe
         037Hio3j/a+xGjrXhsPRiwQ+guKHXQZOIee242a7mnLsbHuXjGr3dcNICFmgJQnntPv+
         MLN8czUWKJ810zCgril5iiXLnt933Iv29d65Rn7n+gAn4wd+hYkfxzCLz5rN+qFHTjYH
         OZ+w==
X-Gm-Message-State: ANoB5pmrIwKhg999737TVqYN2PmU+grNn1t6Xdi9IFZZ+BybkGklbVwx
        D25h/UDBA3NLS+H/+LD/nDQk9CLyRuC6yWDzJ7sji3s0KNiJVmHZZo6zzjA43H7tjWBgWTd1Ozj
        znawbUzNHfPL55LZnazDgWN7q
X-Received: by 2002:a05:600c:5541:b0:3cf:8896:e1d0 with SMTP id iz1-20020a05600c554100b003cf8896e1d0mr12515852wmb.177.1669284581735;
        Thu, 24 Nov 2022 02:09:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5IiZfBe8A2j1NQ2KOLuiJeEg4fjtIovyFu3MMuo6cT8u7xmm5WMD3j+Z35QMr44JBCleOkOA==
X-Received: by 2002:a05:600c:5541:b0:3cf:8896:e1d0 with SMTP id iz1-20020a05600c554100b003cf8896e1d0mr12515823wmb.177.1669284581266;
        Thu, 24 Nov 2022 02:09:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c1c9100b003c6b874a0dfsm1582715wms.14.2022.11.24.02.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:09:40 -0800 (PST)
Message-ID: <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
Date:   Thu, 24 Nov 2022 11:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
In-Reply-To: <20221124095523.31061-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.22 10:55, Gavin Shan wrote:
> The issue is reported when removing memory through virtio_mem device.
> The transparent huge page, experienced copy-on-write fault, is wrongly
> regarded as pinned. The transparent huge page is escaped from being
> isolated in isolate_migratepages_block(). The transparent huge page
> can't be migrated and the corresponding memory block can't be put
> into offline state.
> 
> Fix it by replacing page_mapcount() with total_mapcount(). With this,
> the transparent huge page can be isolated and migrated, and the memory
> block can be put into offline state. Besides, The page's refcount is
> increased a bit earlier to avoid the page is released when the check
> is executed.

Did you look into handling pages that are in the swapcache case as well?

See is_refcount_suitable() in mm/khugepaged.c.

Should be easy to reproduce, let me know if you need inspiration.

> 
> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
> Cc: stable@vger.kernel.org   # v5.7+
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Corrected fix tag and increase page's refcount before the check
> ---
>   mm/compaction.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c51f7f545afe..1f6da31dd9a5 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -984,29 +984,29 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			goto isolate_fail;
>   		}
>   
> +		/*
> +		 * Be careful not to clear PageLRU until after we're
> +		 * sure the page is not being freed elsewhere -- the
> +		 * page release code relies on it.
> +		 */
> +		if (unlikely(!get_page_unless_zero(page)))
> +			goto isolate_fail;
> +
>   		/*
>   		 * Migration will fail if an anonymous page is pinned in memory,
>   		 * so avoid taking lru_lock and isolating it unnecessarily in an
>   		 * admittedly racy check.
>   		 */
>   		mapping = page_mapping(page);
> -		if (!mapping && page_count(page) > page_mapcount(page))
> -			goto isolate_fail;
> +		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
> +			goto isolate_fail_put;
>   
>   		/*
>   		 * Only allow to migrate anonymous pages in GFP_NOFS context
>   		 * because those do not depend on fs locks.
>   		 */
>   		if (!(cc->gfp_mask & __GFP_FS) && mapping)
> -			goto isolate_fail;
> -
> -		/*
> -		 * Be careful not to clear PageLRU until after we're
> -		 * sure the page is not being freed elsewhere -- the
> -		 * page release code relies on it.
> -		 */
> -		if (unlikely(!get_page_unless_zero(page)))
> -			goto isolate_fail;
> +			goto isolate_fail_put;
>   
>   		/* Only take pages on LRU: a check now makes later tests safe */
>   		if (!PageLRU(page))

-- 
Thanks,

David / dhildenb

