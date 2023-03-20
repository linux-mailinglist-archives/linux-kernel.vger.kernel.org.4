Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCAF6C0EE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCTKdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCTKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AE22C83
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43rMRY6SjfX/9JwvKE1nVnLGVIbTWakgfcUwvvx+E6k=;
        b=MACuYVfWFRLdACbUj264g8FLVIQvsVnQIdxl4B6g2w9vPI/UjZmkTg8Hd1Tysbnu495mOF
        kHH9gTBc2/mrgA1IwVeBqzPua1MD7C3J8C+qC0xp7Q3j6bcdzMg2K1abR0MYRj2XetMy4l
        H687T5ilip0mpMteBiedaNX2x1BUsCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-DLDqNnqtMuOZMiY1LW3Tug-1; Mon, 20 Mar 2023 06:32:29 -0400
X-MC-Unique: DLDqNnqtMuOZMiY1LW3Tug-1
Received: by mail-wm1-f72.google.com with SMTP id v8-20020a05600c470800b003ed3b575374so5305709wmo.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308348;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43rMRY6SjfX/9JwvKE1nVnLGVIbTWakgfcUwvvx+E6k=;
        b=EJOPBaz1O8s39VtCcMakWpONlM4Xou0345VJRlzFpAPO9FxLdlGXqb3LuWmrMEXGkH
         m059qIITeCPnTf2q2FxtbYWMkdhKN3pNVVt9Dqc9IU+sMCzF7hvxu/t3gQshN2oyh2Jf
         wFEkBwUKdkiLPJnxfFO37SMlZsZOfl1lPdK4UTqXUuLwb8SKoKlYQhIa0ty3Yt6/yLU2
         d9pTMtbtOcVv7FxnTFVEm9QjtQrdC+GjsGM2Z8OKmY7xZF183zpKJfMESTFoi6Q6PHTW
         bqA2PRJMe9ybeb8bjJkYt1c98Xn0VkLaXyCa961vM7qbKyMsVAiudfZcdSimk0kEyqIA
         f8DA==
X-Gm-Message-State: AO0yUKWV/I8yvzYfkxQbN3/jI8u4MbIPEuC1m4m66KyR4f5YBM2tD/ZL
        y2wTxwyBkYeybpdM24xaGNiIFaIWz0nrRNg1TEjr8KaidyYUWs48/PzkSvIIgLlgoWyMcNjcL74
        NmPfZ+5RHYXey73BJbEbLR5SL
X-Received: by 2002:a05:600c:2052:b0:3de:a525:1d05 with SMTP id p18-20020a05600c205200b003dea5251d05mr8913169wmg.8.1679308348002;
        Mon, 20 Mar 2023 03:32:28 -0700 (PDT)
X-Google-Smtp-Source: AK7set+R3NqzSzUf1HviLD50iA8mmqYrAa/Lz3xd8xA7Ael93+npyT3YMEXA4dskOadMmVtn+0VTFA==
X-Received: by 2002:a05:600c:2052:b0:3de:a525:1d05 with SMTP id p18-20020a05600c205200b003dea5251d05mr8913153wmg.8.1679308347678;
        Mon, 20 Mar 2023 03:32:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003b47b80cec3sm16170772wmq.42.2023.03.20.03.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:32:26 -0700 (PDT)
Message-ID: <45aa96a1-a5c3-9498-b445-916e807c0871@redhat.com>
Date:   Mon, 20 Mar 2023 11:32:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/15] mm: move most of core MM initialization to
 mm/mm_init.c
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-5-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.23 22:59, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The bulk of memory management initialization code is spread all over
> mm/page_alloc.c and makes navigating through page allocator
> functionality difficult.
> 
> Move most of the functions marked __init and __meminit to mm/mm_init.c
> to make it better localized and allow some more spare room before
> mm/page_alloc.c reaches 10k lines.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

