Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0EE64B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiLMOnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E8B21814
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670942580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iyz/A4LFohBBU//HBmJQ22gEPbhzpd8wIR4AqycoUGI=;
        b=IlMKMJnqZ/72l7AexlJo/ZnWjvkyO824EkoDCGq3HJSgnQJISxJmTmx6GZXL5C+6n0Pzlk
        E40gG3EXdAaxM26PGhin+fzXtGRbT1UKjjaw1+LOHgU0l6qHTtlgBBw9TTM8CZYoNwxqUM
        qSYIz7Mpx1NPsXEcP3I6VijVLjirLpk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-TzOGML5BOiGzAusmnjhamw-1; Tue, 13 Dec 2022 09:42:59 -0500
X-MC-Unique: TzOGML5BOiGzAusmnjhamw-1
Received: by mail-wm1-f70.google.com with SMTP id p14-20020a05600c204e00b003cf4cce4da5so3139899wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iyz/A4LFohBBU//HBmJQ22gEPbhzpd8wIR4AqycoUGI=;
        b=MrXUMwrW+0cz4YqZPvTWEUF+o0Fi44Y5gtzOqlvVWHY8ARFCMInQQaBJ15ea7roFAg
         aoNsOIiyS6TM0QCi++jRP6un7/tglIgbRliZ0jzCrjNbBi7waG1FkZ/p0nJMW1ahloAW
         7DUsRkD8sz8RgR9HjCFqK9xSX/7tCy7eKSncIvYJ2HUeL1hepQi010nTknjRrNMJX7tc
         Sl6DaF5d6VaOdIbI6Eg2myS0Xrvg6ZQ5vSNEHeCFw0cxl6+IPTsiFYK00gZwtn23teJR
         qoOBpPFMRrpjT4z5B0dSbVscsDQCBFEiHhYTjlvmgCli+nGvWjNJmuTPA/1lgliHo+0m
         ob+w==
X-Gm-Message-State: ANoB5pn0/TE0VmOPgFI6BOFjiervWSrtCeJ4yG9qMm1qmL+asAy6hdoO
        dIZKEaqwoglXbbVRlKNhccieKPs8mRD8hTKLU93ugzZZPIfbZcVUTw4mKUYT9rqAkr2L7HZ1KkQ
        QacprF4WgF+REckNs1HkZB0wm
X-Received: by 2002:a05:600c:2101:b0:3cf:6cc7:5ba4 with SMTP id u1-20020a05600c210100b003cf6cc75ba4mr15310497wml.19.1670942577611;
        Tue, 13 Dec 2022 06:42:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YVRH9z0xBIs04mhAg7/iqONWkZSrvGqNUVa5oK78NIvIOfGackyHj8+SAieNUQWQadWXhtA==
X-Received: by 2002:a05:600c:2101:b0:3cf:6cc7:5ba4 with SMTP id u1-20020a05600c210100b003cf6cc75ba4mr15310477wml.19.1670942577355;
        Tue, 13 Dec 2022 06:42:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6e00:8b72:420e:df27:90c2? (p200300cbc7026e008b72420edf2790c2.dip0.t-ipconnect.de. [2003:cb:c702:6e00:8b72:420e:df27:90c2])
        by smtp.gmail.com with ESMTPSA id h67-20020a1c2146000000b003d1de805de5sm13076781wmh.16.2022.12.13.06.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 06:42:56 -0800 (PST)
Message-ID: <6d33b510-e913-5738-1e87-9f70da2ccee0@redhat.com>
Date:   Tue, 13 Dec 2022 15:42:55 +0100
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
 <f07d1c95-f13c-682b-0519-0b137ccdc631@redhat.com>
 <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <801ccbe2-08b8-e1cb-9aee-614d59a807d2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.12.22 13:13, Kefeng Wang wrote:
> 
> On 2022/12/13 19:40, David Hildenbrand wrote:
>> On 13.12.22 10:27, Kefeng Wang wrote:
>>> Introduce a wrapper function pfn_to_online_folio(), which calls
>>> pfn_to_online_page() and returns the folio of the page found,
>>> or null if no page.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>    include/linux/memory_hotplug.h | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/linux/memory_hotplug.h
>>> b/include/linux/memory_hotplug.h
>>> index 9fcbf5706595..e841e4fb52a7 100644
>>> --- a/include/linux/memory_hotplug.h
>>> +++ b/include/linux/memory_hotplug.h
>>> @@ -265,6 +265,13 @@ static inline void pgdat_kswapd_unlock(pg_data_t
>>> *pgdat) {}
>>>    static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
>>>    #endif /* ! CONFIG_MEMORY_HOTPLUG */
>>>    +static inline struct folio *pfn_to_online_folio(unsigned long pfn)
>>> +{
>>> +    struct page *page = pfn_to_online_page(pfn);
>>> +
>>> +    return page ? page_folio(page) : NULL;
>>> +}
>>
>> Who guarantees that page_folio() is safe and stable at that point?
>>
>> IIRC, that's very tricky. We could have the page concurrently getting
>> freed and the folio dissolved.
> So the caller should consider this,  lock or get the folio in the caller?
> 

I think the helper pfn_to_online_folio() as is might be wrong approach. 
The caller should convert to a folio after taking precautions that it is 
actually safe to do that (e.g., succeeded grabbing a reference first).

-- 
Thanks,

David / dhildenb

