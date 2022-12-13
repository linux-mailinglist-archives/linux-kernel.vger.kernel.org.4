Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6D64B458
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiLMLlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiLMLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055B1C418
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670931631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/wKFqPacuSwbRiY6CcY0zi15fYAnhBFmQsx8ZQhcxk=;
        b=h2fcLgqJdOqFCsd9/fFma3smdpAyu6sWUj2HDX8xiT5dzxLXer1+4Or0RTu/UiUETkMqy+
        tSmRXn1xV15M8Iv4rVcbj/WQGphkmVBMbPbHXr/S1OZmLEJfnYgzz2Ct0CaF9j3w+Czc0j
        Uh9xLb9YJlmzcMIkQ4TXMAlc3BnXIuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-1KGsc94qMlaeWFQThOIFmQ-1; Tue, 13 Dec 2022 06:40:30 -0500
X-MC-Unique: 1KGsc94qMlaeWFQThOIFmQ-1
Received: by mail-wm1-f69.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so5525423wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/wKFqPacuSwbRiY6CcY0zi15fYAnhBFmQsx8ZQhcxk=;
        b=0xxDaTqcJhtyqAm85xsARvrePHUZ3E1qs5XLydeCqWitGnHIFM4UptWr57E0Z7A77m
         h3j7CIEAydtom3MePSPjqEB+NDQ1ozou7PUmVlpubS6bUyfE0zsZHRisn7tRXBmWAqIw
         n/r2GxOQsgaPZab+ABER3A4ZKv2HDOxL97CC0AH4iEvt/LGX9FDDiaKdnVQsO3sik93M
         y1+uJawktUmjJQLNuvl8w95RJDSTemDKKRxZhFrHaHhgb7Y3VOcOZbjyvGwJMlw/mhaP
         2/Lb2qK9SfqWpnyZKLDC0uZVBdh2hUWHjUqFn49mPqmj8AZ9xPBf37zxSojVAyEJtq4v
         CD5g==
X-Gm-Message-State: ANoB5pkUXr569lnXhbUSCrEnpVlVYIBUItI3ZjnCeOQ+gr9cVhrDjMT0
        kCg6hNiHCvSQKIZXR7fYW9j7RTjZiuFmt6qEo/bIjgKA6an5l3pashXKMYmfXToom+hspLQEXiA
        gjmYaAfEEc2R3FWIl49FDxyt0
X-Received: by 2002:a05:600c:5109:b0:3cf:70e3:a6ad with SMTP id o9-20020a05600c510900b003cf70e3a6admr15630449wms.31.1670931628937;
        Tue, 13 Dec 2022 03:40:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6lKK8gIol22aYC/DrLGmzGYqhbxO4A+uFiCJajED3EbHfMJpJ8g1TU4b4n6DqANU2jz03mnQ==
X-Received: by 2002:a05:600c:5109:b0:3cf:70e3:a6ad with SMTP id o9-20020a05600c510900b003cf70e3a6admr15630427wms.31.1670931628479;
        Tue, 13 Dec 2022 03:40:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6e00:8b72:420e:df27:90c2? (p200300cbc7026e008b72420edf2790c2.dip0.t-ipconnect.de. [2003:cb:c702:6e00:8b72:420e:df27:90c2])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003d22528decesm8899801wms.43.2022.12.13.03.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:40:27 -0800 (PST)
Message-ID: <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
Date:   Tue, 13 Dec 2022 12:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/8] mm: memory_hotplug: add pfn_to_online_folio()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, vishal.moola@gmail.com, willy@infradead.org
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
 <20221213092735.187924-2-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221213092735.187924-2-wangkefeng.wang@huawei.com>
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

On 13.12.22 10:27, Kefeng Wang wrote:
> Introduce a wrapper function pfn_to_online_folio(), which calls
> pfn_to_online_page() and returns the folio of the page found,
> or null if no page.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   include/linux/memory_hotplug.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 9fcbf5706595..e841e4fb52a7 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
>   static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>   #endif /* ! CONFIG_MEMORY_HOTPLUG */
>   
> +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
> +{
> +	struct page *page = pfn_to_online_page(pfn);
> +
> +	return page ? page_folio(page) : NULL;
> +}

Who guarantees that page_folio() is safe and stable at that point?

IIRC, that's very tricky. We could have the page concurrently getting 
freed and the folio dissolved.

-- 
Thanks,

David / dhildenb

