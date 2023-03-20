Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1386C0F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCTKgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCTKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEA0158BD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6ckZ2z0QKvMzR9VTDVT3Dh7KUskzJvhARj3Bq+OQ2A=;
        b=JFVjFVeei4bpyf9HyuZo6AHFKa7a8K1LUXG2a7OcMMdA+7L8Gu31xh9mwLbJKekYx6gIe5
        dUbmBeE1L+H+vaD31VnH9YY6OiDTsDj8c9BkoJTgRDJZ7ABJvuej5j+oM5V8Yh3w8cLujj
        mRMMA6zkKSrEUf8Z6zh1lH+VqUyOGTE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-V3RnUSrmPs2L-cZuMsPMQg-1; Mon, 20 Mar 2023 06:34:31 -0400
X-MC-Unique: V3RnUSrmPs2L-cZuMsPMQg-1
Received: by mail-wm1-f72.google.com with SMTP id j10-20020a05600c190a00b003eda80e8086so2643758wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308470;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6ckZ2z0QKvMzR9VTDVT3Dh7KUskzJvhARj3Bq+OQ2A=;
        b=Hfyat4mMKurX0Ekmj2ueLgAAr8F3aN4CLuNamd1SFEBZJCWL61ciQKAq+0i/9/2JPc
         K+kro6M+/O9i7fnap9n0iPiWVF3Ho0V4a2FAkx0/byZtcXNhoVhAgzLTpOOXkAPTPyYj
         ZOdT1qc1nUKnvigSQ3IapFBJ5t7lFvPzsUkZn9bDHteWZlH9pGB0y+hpM2wEYQAc0n1P
         JuOXbXimLMSNMReP0EdX6cYUn65EkXxKDO0NQOPdihngiCphScm3daEMEoP3u1TTAzV7
         Kvz3PBUmkPNQALlhALq1rrx2EObyejFbfJmJARsZwqI29M1W2d6HVYnjSYJqFMJTHIJl
         H+yQ==
X-Gm-Message-State: AO0yUKWD0aWh3/PnFyuFwdALsjC6iIzH5z48h3sBW7MSbF4Vasw8z7Ns
        WwnZVVDrHK++Fxcxqo/46vI61Dy7e0D06KqqDa5/FQmjE+zz3qtIZgHlMarz7E8VPMshOlSGiL2
        AZoULWzV+XMvwmCsLBadqHpxe
X-Received: by 2002:a7b:c5d9:0:b0:3ed:8780:f265 with SMTP id n25-20020a7bc5d9000000b003ed8780f265mr9478722wmk.21.1679308470402;
        Mon, 20 Mar 2023 03:34:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set/See1O1GCKcnrzZelLvg7ptH0BnavM+gCW64JwSqodSWr+QN8A6MohXbjNVVp77UiBLu/t9g==
X-Received: by 2002:a7b:c5d9:0:b0:3ed:8780:f265 with SMTP id n25-20020a7bc5d9000000b003ed8780f265mr9478710wmk.21.1679308470122;
        Mon, 20 Mar 2023 03:34:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003ee0d191539sm1071327wmi.10.2023.03.20.03.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:34:29 -0700 (PDT)
Message-ID: <a394472b-d091-d710-4bf5-53b2b41d681d@redhat.com>
Date:   Mon, 20 Mar 2023 11:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/15] mm: handle hashdist initialization in mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-6-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-6-rppt@kernel.org>
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

On 19.03.23 22:59, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The hashdist variable must be initialized before the first call to
> alloc_large_system_hash() and free_area_init() looks like a better place
> for it than page_alloc_init().
> 
> Move hashdist handling to mm/mm_init.c
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

