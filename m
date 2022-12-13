Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E66464B15E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiLMIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiLMInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:43:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD112193C7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670920952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oo3SpYmVzFzB5/FBUFq/XhjE45kVHHL6DxTvof2O3/c=;
        b=h1YTWuaNq0JBDZAISu5r2pZHBYo/kMNOi1glFWeuRVZAnsg2v2fworx0ZWRBwqHacjsraJ
        Dd90gKaZl9HZuuVqU10vU7lg+Xjmlxg/C6nAdP2FZCXceh8qfXIbk4pSO2LSNQ695nsG50
        qEF1Zhp4rTgXrakCdEqNmqBqS6ZFPyw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-rccpt7yQP8ucuSVcWPN2uA-1; Tue, 13 Dec 2022 03:42:30 -0500
X-MC-Unique: rccpt7yQP8ucuSVcWPN2uA-1
Received: by mail-wr1-f69.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so2792128wrb.23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo3SpYmVzFzB5/FBUFq/XhjE45kVHHL6DxTvof2O3/c=;
        b=SBgSpW8Gs84953ZBYT9CEJ7iHUMkW/fdpfoLE4j+x8U0w+W90WXWnfqmfUo5s8C1cp
         cKSwrTZZ3CfRh9naDkAwY1sPhYvMh1UyApZ1idwm4pRhaOZ9Z/qP0tm4EhS7r2EzuDWF
         qQU6rJ1NaaK8pVLpbHtwF4AgEiF+rcP3ZY/VYEyvx50l3PL5aRPYjzZSv86/eUUYYCkD
         57MxFloxRh3sml7/R4mlrCWnmdK91Zn93eJu0vB4Bh84G3Y4+atsb3+K4y8J5GLM3Iz0
         safhqdlUnMMNlzDhfZp0TfURhJECczFKHsuWgIRll3PAy6Igr0Oa3vorzgLZgq3fonG+
         Q8Lw==
X-Gm-Message-State: ANoB5pk0qRnA2bZE9PY2lzkqx6tySJe7aN4VXDZvXh+Rs7+lRaWhKqAS
        jSKu+/rA4KobaFgvf0JksVVW1WmgAKraGdh4roWZwbBl54d2Kjouh03sjXY8W8HbevVfnxJINAK
        8Od+222UJHCrTgcyAS9adqDvK
X-Received: by 2002:a05:600c:35d3:b0:3c6:e63e:22e with SMTP id r19-20020a05600c35d300b003c6e63e022emr15042757wmq.5.1670920949288;
        Tue, 13 Dec 2022 00:42:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5iWTiMb84ghWMd3z8QM07b9H7SdcKMAsnLrbSi8N48ctay5iscoKt5xIlEygqW/FLvg6egXw==
X-Received: by 2002:a05:600c:35d3:b0:3c6:e63e:22e with SMTP id r19-20020a05600c35d300b003c6e63e022emr15042735wmq.5.1670920948988;
        Tue, 13 Dec 2022 00:42:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6e00:8b72:420e:df27:90c2? (p200300cbc7026e008b72420edf2790c2.dip0.t-ipconnect.de. [2003:cb:c702:6e00:8b72:420e:df27:90c2])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bcd0a000000b003d01b84e9b2sm11638819wmj.27.2022.12.13.00.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 00:42:28 -0800 (PST)
Message-ID: <87b0dd5c-f746-b60e-caf5-375ac342c7bd@redhat.com>
Date:   Tue, 13 Dec 2022 09:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mm-stable] mm/hugetlb: set head flag before setting
 compound_order in __prep_compound_gigantic_folio
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, tsahu@linux.ibm.com,
        jhubbard@nvidia.com
References: <20221212225529.22493-1-sidhartha.kumar@oracle.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221212225529.22493-1-sidhartha.kumar@oracle.com>
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

On 12.12.22 23:55, Sidhartha Kumar wrote:
> folio_set_compound_order() checks if the passed in folio is a large folio.
> A large folio is indicated by the PG_head flag. Call __folio_set_head()
> before setting the order.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> ---
> Hi David,
> I tested this by doing:
> 
> echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

Thanks, that should be good enough.

> 
> and checking dmesg. Let me know if there are other ways of testing
> you would like to see run.
> 
> Hi Andrew,
> This can be folded into d1c6095572d0cf00c0cd30378639ff9387b34edd
> mm/hugetlb: convert hugetlb prep functions to folios.
> 
> However, there is still ongoing discussion with this patch series,
> specifically with patch 1 9fd330582b2f mm: add folio dtor and order setter
> functions, so I'm not sure if this series should be a part of the 6.2 merge
> window. I am planning to send a v6 within the next few days to implement
> the suggested changes.

Whatever is in mm-stable is supposed to go upstream as-is and even the
commit ids will remain stable, meaning we an only queue fixes on top.

Therefore, mm-stable now contains:

commit c45bc55a99957b20e4e0333bcd42e12d1833a7f5 (mm/mm-stable)
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Mon Dec 12 14:55:29 2022 -0800

     mm/hugetlb: set head flag before setting compound_order in __prep_compound_gigantic_folio
     
     folio_set_compound_order() checks if the passed in folio is a large folio.
     A large folio is indicated by the PG_head flag.  Call __folio_set_head()
     before setting the order.
     
     Link: https://lkml.kernel.org/r/20221212225529.22493-1-sidhartha.kumar@oracle.com
     Fixes: d1c6095572d0 ("mm/hugetlb: convert hugetlb prep functions to folios")
     Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
     Reported-by: David Hildenbrand <david@redhat.com>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


So, best send any future changes against mm-stable instead of sending out a v6.

-- 
Thanks,

David / dhildenb

