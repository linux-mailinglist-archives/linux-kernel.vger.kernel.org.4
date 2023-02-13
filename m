Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8F569466A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBMM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjBMM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:56:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC594C25
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676292928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7lbPeB2qJ5bwP0jsTXbNUNTpNCyAZ/Q+c/87ZKKA3E=;
        b=iWvNxyKFrVD4HhuJysbECzTrK7G9gO4x5Nc2aInxI03VxGoyGSdqXzVCELPR4vONcf6+2K
        qZNzkEZUvyft1cW2oL8FHgrmrdn69pieJUjrkk6LmyOobgqR7hH9VV+dg9eY4JT/gXCYxO
        hl2R52X8UHnXVQVbifwPYBmJyAE6f8U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609-45DfMEReM0WGcPQv975WGg-1; Mon, 13 Feb 2023 07:55:25 -0500
X-MC-Unique: 45DfMEReM0WGcPQv975WGg-1
Received: by mail-wm1-f70.google.com with SMTP id ay19-20020a05600c1e1300b003dc54daba42so6105589wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7lbPeB2qJ5bwP0jsTXbNUNTpNCyAZ/Q+c/87ZKKA3E=;
        b=Mh4g2mP7DvlsnBFdxGrYmw+CMlDSorFvBrF0i8SY7PtdITOIgvsdQt7JyjzP/kTAG+
         v6V8VMtRGFBMgA3GRH/XMkLfVSpmCQRHPBJH2eF6IjcWRNLjywhOA6pFi+jnKX1nGTKK
         gSXCCCKUzjd/waZ+lE7tXuSutL6wf18e9xUZCCJOEyE3w2TkfLlOhHlCpoVkasquAB9c
         2sUZ7K9kaH0kDtq+f3qmnH2z2WNYrO6T6yddcDpuWdX0nD/dQUIKi1kX1uOLUUP3ZXzh
         P7dSXuSJ5Bjiuw16qLcaqeLyQazyPZpk8gHWSgXxcpf/f6oXjdToxqrKIihJ/jX0ogr6
         2trQ==
X-Gm-Message-State: AO0yUKVLcDsR0zBAbwVCSuOd6Iui2X9HZO40U6g68x9V1zEYtQ0tkiEf
        P/QTZSJDa2P5YN4H7X4Sh7RULGQVXRNk4iXSvTzHaEhv55CQ1gvYS03HolUHZciekxOV/JMRnaC
        fwxNBkFqZpP5k8dAkv56WyYpa
X-Received: by 2002:a5d:4b8e:0:b0:2c5:4de1:ba23 with SMTP id b14-20020a5d4b8e000000b002c54de1ba23mr5764551wrt.19.1676292924567;
        Mon, 13 Feb 2023 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AK7set+v1eiX6G85ak4hCenK3Vog4eJHErwXaWZmsbH1zchooYBdf/Sven/ZaqPEWPT2/w2kdVQjJQ==
X-Received: by 2002:a5d:4b8e:0:b0:2c5:4de1:ba23 with SMTP id b14-20020a5d4b8e000000b002c54de1ba23mr5764536wrt.19.1676292924285;
        Mon, 13 Feb 2023 04:55:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d550f000000b002c55ebe37ddsm1164222wrv.115.2023.02.13.04.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 04:55:23 -0800 (PST)
Message-ID: <2b62898c-2f39-bc0d-e801-20b5efe90dfd@redhat.com>
Date:   Mon, 13 Feb 2023 13:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 3/6] ksm: count all zero pages placed by KSM
Content-Language: en-US
To:     yang.yang29@zte.com.cn
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn
References: <202302092001576896055@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202302092001576896055@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.23 13:01, yang.yang29@zte.com.cn wrote:
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 652c088f9786..72c0722be280 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -276,6 +276,9 @@ static unsigned int zero_checksum __read_mostly;
>>>    /* Whether to merge empty (zeroed) pages with actual zero pages */
>>>    static bool ksm_use_zero_pages __read_mostly;
>>>
>>> +/* The number of zero pages placed by KSM use_zero_pages */
>>> +static unsigned long ksm_zero_pages_sharing;
>>
>> Does this count how many zero pages are currently placed or how many
>> rmap items with ZERO_PAGE_FLAG are in the system?
> 
> Yes, it counts how many ksm zero pages are currently placed. and we use
> rmap items with ZERO_PAGE_FLAG to record these zero page, similar to
> ksm_pages_sharing and ksm_pages_shared which are recorded by the rmap_items
> with STABLE_FLAG.
> 
>>
>> IOW, if someone triggers MADV_DONTNEED on such a zeropage, the counter
>> will not get updated, correct?
> 
> Well, the counter can get updated as someone triggers MADV_DONTNEED on such
> a zeropage. You might write a simple code to test it.

Interesting, I'll have a look how that will be triggered.

-- 
Thanks,

David / dhildenb

