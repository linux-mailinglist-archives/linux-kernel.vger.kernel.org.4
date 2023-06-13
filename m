Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC6172DE65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjFMJ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241859AbjFMJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B541AC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686650168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvrBkfbXTrFvt9xpg7b0vA50fZzgeUiXz+5gnS6Sz5w=;
        b=bVAjuByUJrWwKOAgcq7vlEJYIK3GZkF9LeQQ3+jE8Ub0zTKB+XfOR2qjw0z0gSUaBbfSo6
        Hz0Vdjo7yiWDAMXlkJGUO8fkLQbxnmUHmcxkc5LzfAbuCwOM7Foa37BjQv7+Lx59Im5HxV
        f3573BJMR6xlVso6huQu3dGgXhvSJJs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-SfORpb5COFGDoBJz4sjo9g-1; Tue, 13 Jun 2023 05:56:05 -0400
X-MC-Unique: SfORpb5COFGDoBJz4sjo9g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso23190755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650164; x=1689242164;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvrBkfbXTrFvt9xpg7b0vA50fZzgeUiXz+5gnS6Sz5w=;
        b=cwTOH4uAd8RfdvqAbjvPm1HSPnKK47yb3HDrs2PYQzksHrBAcAdkuoQyt35JxHOyxg
         SJjlgbxYcm36hGBaYfY/RuLILnvqqIhh/6smUoou5BWyCqa6VqzucIKTpRYy/+iA+3SD
         CkKWGP1m4XZ9Xj02n2GgWO5VZiFWqVARzlHfq2sKUOaaRc/WI8IXXmG9SHY4r1I+NEaC
         12rnXsEReHds/NilWNhlKRsjlgcysjoDjdABNElZ3MS8qgqeNraWnlA1WQOQcwp4338h
         p0vqqyVGLNMKO97JYX2j7QlwkA1sp2IRqVxnK8e0R3o+NLWt4f9+OWwyqeHrMmkxBDAV
         JURg==
X-Gm-Message-State: AC+VfDyNg3rcSKhPoIBtwfVD5X2q/w5h2Ns5afO1aDrt1oy5eam1EmVP
        O3IaL7F6O1pXWBWn69qISS4cM3LUfFv+gV/1d57HQWYqJg4WT/6cgjrfQzyRq/zpz9197VixshH
        YxRRt5QNtli4nQKHc0iK+a0Zl
X-Received: by 2002:a05:600c:2190:b0:3f7:395e:46a2 with SMTP id e16-20020a05600c219000b003f7395e46a2mr7177737wme.16.1686650164096;
        Tue, 13 Jun 2023 02:56:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zPebV8XPYmc4AYit2iHCjKTKWTEAqgyzxHWw1iAXL7Bsz4Z7Na2oE2QS+oqByCVk1g65SPA==
X-Received: by 2002:a05:600c:2190:b0:3f7:395e:46a2 with SMTP id e16-20020a05600c219000b003f7395e46a2mr7177725wme.16.1686650163729;
        Tue, 13 Jun 2023 02:56:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c24ca00b003f7e4d143cfsm13803139wmu.15.2023.06.13.02.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 02:56:03 -0700 (PDT)
Message-ID: <c9384e52-3f3b-cb1b-a607-955cd7066422@redhat.com>
Date:   Tue, 13 Jun 2023 11:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
In-Reply-To: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.06.23 10:55, Baolin Wang wrote:
> On some machines, the normal zone can have a large memory hole like
> below memory layout, and we can see the range from 0x100000000 to
> 0x1800000000 is a hole. So when isolating some migratable pages, the
> scanner can meet the hole and it will take more time to skip the large
> hole. From my measurement, I can see the isolation scanner will take
> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
> 
> So adding a new helper to fast search next online memory section
> to skip the large hole can help to find next suitable pageblock
> efficiently. With this patch, I can see the large hole scanning only
> takes < 1us.
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
> Changes from v1:
>   - Fix building errors if CONFIG_SPARSEMEM is not selected.
>   - Use NR_MEM_SECTIONS instead of '-1' per Huang Ying.
> ---
>   include/linux/mmzone.h | 10 ++++++++++
>   mm/compaction.c        | 30 +++++++++++++++++++++++++++++-
>   2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 5a7ada0413da..5ff1fa2efe28 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2000,6 +2000,16 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>   	return -1;
>   }
>   
> +static inline unsigned long next_online_section_nr(unsigned long section_nr)
> +{
> +	while (++section_nr <= __highest_present_section_nr) {
> +		if (online_section_nr(section_nr))
> +			return section_nr;
> +	}
> +
> +	return NR_MEM_SECTIONS;
> +}
> +
>   /*
>    * These are _only_ used during initialisation, therefore they
>    * can use __initdata ...  They could have names to indicate
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 3398ef3a55fe..c31ff6123891 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -229,6 +229,28 @@ static void reset_cached_positions(struct zone *zone)
>   				pageblock_start_pfn(zone_end_pfn(zone) - 1);
>   }
>   
> +#ifdef CONFIG_SPARSEMEM
> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
> +{
> +	unsigned long next_online_nr;
> +	unsigned long start_nr = pfn_to_section_nr(start_pfn);
> +
> +	if (online_section_nr(start_nr))
> +		return 0;
> +
> +	next_online_nr = next_online_section_nr(start_nr);
> +	if (next_online_nr < NR_MEM_SECTIONS)
> +		return section_nr_to_pfn(next_online_nr);
> +

I would simply inline next_online_section_nr and simplify (and add a 
comment):

/*
  * If the PFN falls into an offline section, return the start PFN of the
  * next online section. If the PFN falls into an online section or if
  * there is no next online section, return 0.
  */
static unsigned long skip_hole_pageblock(unsigned long start_pfn)
{
	unsigned long nr = pfn_to_section_nr(start_pfn);

	if (online_section_nr(nr))
		return 0;

	while (++nr <= __highest_present_section_nr) {
		if (online_section_nr(nr))
			return section_nr_to_pfn(nr);
	}
	return 0
}

Easier, no?

And maybe just call that function "skip_offline_sections()" then? 
Because we're not operating on pageblocks.

> +	return 0;
> +}
> +#else
> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
> +{
> +	return 0;
> +}
> +#endif
> +
>   /*
>    * Compound pages of >= pageblock_order should consistently be skipped until
>    * released. It is always pointless to compact pages of such order (if they are
> @@ -1991,8 +2013,14 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   
>   		page = pageblock_pfn_to_page(block_start_pfn,
>   						block_end_pfn, cc->zone);
> -		if (!page)
> +		if (!page) {
> +			unsigned long next_pfn;
> +
> +			next_pfn = skip_hole_pageblock(block_start_pfn);
> +			if (next_pfn != 0)

if (next_pfn)

> +				block_end_pfn = next_pfn;
>   			continue;
> +		}
>   
>   		/*
>   		 * If isolation recently failed, do not retry. Only check the

-- 
Cheers,

David / dhildenb

