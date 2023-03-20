Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5306C0F10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCTKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCTKgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9168E18D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7xiGdM8qiWWcZc5Y3ojCQP7Km8IWAa3x8WZuiHZfb+w=;
        b=g98WmRvuRYJUzRM1h4KPiW0xelF6+5AwFEwbZwXYYb4S3EgyYZev7vtJOq85RTgaVGbXul
        3DBhCxyh8K8rgTk3J8S32Q6r/m49oYMVV8h+r2DoZYxEilAONdR59QczWKQY6IiCT7nLnh
        O6BlWgKS7Q/icFnipRmwpZ5Cclg/JqU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-a97TByppMbieJU6wlul0NQ-1; Mon, 20 Mar 2023 06:34:59 -0400
X-MC-Unique: a97TByppMbieJU6wlul0NQ-1
Received: by mail-wm1-f69.google.com with SMTP id n38-20020a05600c3ba600b003ed29a0b729so5307655wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308498;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xiGdM8qiWWcZc5Y3ojCQP7Km8IWAa3x8WZuiHZfb+w=;
        b=W0OOQdGs4qXPgFjEAHRiZg0IlXmbzV4drDZqunGKGW354esBLRe9ekw5sqhoYBQk7w
         nlAAgRyL5AfwhybtEMH1cimJXNL27uBi6Osmrerb/pTJdxvIPPZnligBbNatOH6LUN6h
         XGDn4h/ch0IeQ64xFcmRO7JXg0Rs6HUjxWO0qeJfC9v+u0h5hJ84E5TNAx1/CAAHqCuB
         xu3vaSRVF+2+Hum/XYzV0CAePQYKqcEvviyW0okKudabuKfexRoXJUT/HhR890dmcP/e
         MQTuY0E1L3mdrpNzPMJ6QLtvVqGUKa9kGLCJ0xvGxsrXdwWZJwHtdDP1ZnaOc3YCvIsN
         7QhQ==
X-Gm-Message-State: AO0yUKVt6B8xONBQnfTB/GmNxoIS86qfB9vFpLSb2e818Jn/wcnvdD9T
        G5jWl4nuj9UFk6d48vo3zNuYwSVD+R1lEHMvZSdrX1NW9DAGHEZo/Kdb9k4yhb3V97CTc3d6hfw
        vCUEQ2A5sMiX/2vSJhGyXvlzK
X-Received: by 2002:a05:600c:3ac8:b0:3eb:3f2d:f237 with SMTP id d8-20020a05600c3ac800b003eb3f2df237mr32646786wms.6.1679308498326;
        Mon, 20 Mar 2023 03:34:58 -0700 (PDT)
X-Google-Smtp-Source: AK7set9cavkyeFK3piIOBCtuEs5AUwXm5PrMQ/83PE0I5uSMw3B5E8ySror6anfmRavZagCW6dcC/w==
X-Received: by 2002:a05:600c:3ac8:b0:3eb:3f2d:f237 with SMTP id d8-20020a05600c3ac800b003eb3f2df237mr32646764wms.6.1679308498009;
        Mon, 20 Mar 2023 03:34:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm10087783wmb.40.2023.03.20.03.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:34:57 -0700 (PDT)
Message-ID: <dbd54710-a030-ff08-bd66-1a42c1934138@redhat.com>
Date:   Mon, 20 Mar 2023 11:34:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/15] mm/page_alloc: rename page_alloc_init() to
 page_alloc_init_cpuhp()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-7-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-7-rppt@kernel.org>
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
> The page_alloc_init() name is really misleading because all this
> function does is sets up CPU hotplug callbacks for the page allocator.
> 
> Rename it to page_alloc_init_cpuhp() so that name will reflect what the
> function does.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

