Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC046C0F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCTKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCTKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFC4E395
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZO4MUoeLtjuclC4IgasEW8PXFINyJxVwxeCYDhy+TRc=;
        b=JeWj5G0U14sY5xB8XxlzPqMvvF5u2nl6937uKhYa/xVPcRZtQn9aaC9Kxd6SsegNhJqLJI
        6RcTFcD9YO89ZKC+Mx2oW7O7fDJWWCT5mgyobQDtGBVYZapl449gcbKfzezMgiSoixNI82
        spEgQIYlnlPKYQdtdDT1+df/Z6bUyuU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-woJ8ed2fN2Ovj3wnUhHRwQ-1; Mon, 20 Mar 2023 06:39:56 -0400
X-MC-Unique: woJ8ed2fN2Ovj3wnUhHRwQ-1
Received: by mail-wm1-f69.google.com with SMTP id bg13-20020a05600c3c8d00b003ed40f09355so5317156wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308795;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZO4MUoeLtjuclC4IgasEW8PXFINyJxVwxeCYDhy+TRc=;
        b=VYDr80jwGWknfUAnCNdZGDazoRj0ytCyeAo0R1ESlDSR/oJcipSR/6DsCyfZdsdhtF
         1MaVXi1Qik61nSoS1TrFt5PkHGocaAuuGSV5YZ0CQKOLMlSQ20wMe+zMZvpUCVrchZXa
         j2Krb6jD0KGus1H1r3EV6WzLC2xtW3f+tVWX3tBKqFYeJJHPE8L1k3qKrXpuda41AL1d
         riUdnTxKGuvn5mZqpCmAPOsosP/JkppL2eRqWDwWsAsUCCFo4VrnGlLUwd93WZCmCrzx
         hyNsId1Vd+cGG0iUCB5zwu7wpKShmDvEVobpBRpFBARBmzD7E6uMAI6Lw39ytKqm5U/8
         zt7Q==
X-Gm-Message-State: AO0yUKVcNNOsgumq/hhkDktMj3Of+PIsx2LIXOhyTjcJthDA7EOGZ77p
        6Yf3TXPIzZSs/4s/hB2LWAVFtzaO2RKKGXE1wqVykIiEmaj97v2FdIIrGB/dP7WXsd/9zCEutb6
        1x9gW0yBEnMlJZaBRj1rvtuQ1
X-Received: by 2002:adf:dc51:0:b0:2cf:ea5d:f607 with SMTP id m17-20020adfdc51000000b002cfea5df607mr13275616wrj.17.1679308795754;
        Mon, 20 Mar 2023 03:39:55 -0700 (PDT)
X-Google-Smtp-Source: AK7set+aFiFmynk07qyywt6B8QhkodUnWOCgklLUU0oFHRWH7B4MoXZR6V1fEuEUm9GaNTsT0EPSnA==
X-Received: by 2002:adf:dc51:0:b0:2cf:ea5d:f607 with SMTP id m17-20020adfdc51000000b002cfea5df607mr13275609wrj.17.1679308795562;
        Mon, 20 Mar 2023 03:39:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b002d84f0266b0sm189659wrb.18.2023.03.20.03.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:39:55 -0700 (PDT)
Message-ID: <685de938-79e2-1120-daba-74bc541a1766@redhat.com>
Date:   Mon, 20 Mar 2023 11:39:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/15] init,mm: fold late call to page_ext_init() to
 page_alloc_init_late()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-12-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-12-rppt@kernel.org>
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

On 19.03.23 23:00, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> When deferred initialization of struct pages is enabled, page_ext_init()
> must be called after all the deferred initialization is done, but there
> is no point to keep it a separate call from kernel_init_freeable() right
> after page_alloc_init_late().
> 
> Fold the call to page_ext_init() into page_alloc_init_late() and
> localize deferred_struct_pages variable.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

