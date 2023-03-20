Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4129C6C0F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjCTKkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjCTKjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B225E0E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3q/VrYNqGMx2nbuJd3OpHcyuerGqYFRs5YEB6SDNJQ=;
        b=cOt3/HGhxeCWKbSpzQfyN6gbnOl3tUPzZObW7xg2v+iQhP/Em8z9Ijk2iinxoSqTkzJJqR
        4U82vRvFUOKZswZyan9JjjIf2TZdMEFQ96rA/gVO3JdePIEPMG66yIvIT4s9RhcLLbisCw
        FhEzDbm6EfKRbkKGZ30021Kbb9sVU4I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-FK6fZAtvMe26gfSDURf-PQ-1; Mon, 20 Mar 2023 06:37:45 -0400
X-MC-Unique: FK6fZAtvMe26gfSDURf-PQ-1
Received: by mail-wm1-f72.google.com with SMTP id j16-20020a05600c1c1000b003edfa11fa91so746757wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308664;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3q/VrYNqGMx2nbuJd3OpHcyuerGqYFRs5YEB6SDNJQ=;
        b=gKL3z+hnGva9JDpBhNdZKJp/0YgscLx697WEkv1TzM3pQLDss+/2TJdnv2Cs43a6tY
         pjYa34V/Wbi+h98esTxJ2Kc9YCjbWV6359qM0H6rzewy728T01wgCHsY+6NL8lZy2RaH
         R2w8e0ayHzTic2OQieMGkY78TDW7Qk73r8VrPbxtKOvWIKxXuyAW4km9eT+xQYEteIe8
         4UJxfma8BxMix6hcZUTpk0lsbv7nBJeH1mfm5xWZ9prM+k8X7aZPrf9GFKAc5euPQR3d
         lF754F7a2PjIXBSGFQ8a3dOQHAF9NoPRNCStZOoZgkwdIWlKQ4/5k6xCjn/jxUsIVgwG
         MZMw==
X-Gm-Message-State: AO0yUKVca9RBbr/MWnH5T7smqu9D9GgT8j/vBgaTw+wY7cU0sBD1S27s
        eBZxmPvpWPRZB6V5L2NaXBMMtAKelEcsUjaH0ghVV+Zse0z7/M8ngBA1UVd2zmaQ2rD0bgiX4tD
        HY0cnwuHsxSMQdA41pv3bMecB
X-Received: by 2002:a05:600c:2193:b0:3ed:af6b:7fb3 with SMTP id e19-20020a05600c219300b003edaf6b7fb3mr6429624wme.2.1679308664207;
        Mon, 20 Mar 2023 03:37:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set9nu9AUM11EMOey9gw9s7r1RxvuKD2hoESr3zs9Dn3KEhaTkAv9L39m+Xqo0Tr0kNa2Gefx7A==
X-Received: by 2002:a05:600c:2193:b0:3ed:af6b:7fb3 with SMTP id e19-20020a05600c219300b003edaf6b7fb3mr6429607wme.2.1679308663897;
        Mon, 20 Mar 2023 03:37:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b003edcc2223c6sm5338002wmc.28.2023.03.20.03.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:37:43 -0700 (PDT)
Message-ID: <99391ca1-a9b8-401d-0042-c8b7d1cfab9c@redhat.com>
Date:   Mon, 20 Mar 2023 11:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/15] mm: move pgtable_init() to mm/mm_init.c and make it
 static
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-10-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-10-rppt@kernel.org>
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
> pgtable_init() is only called from mm_core_init().
> 
> Move it close to the caller and make it static.

Why not inline it completely into the single caller? I don't see too 
much value of this indirection.

-- 
Thanks,

David / dhildenb

