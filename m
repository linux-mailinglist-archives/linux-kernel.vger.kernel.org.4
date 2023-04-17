Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021196E46AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDQLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17F7287
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681731600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dK3YDQscuz7YARntLdvlf6Mm4uVD1HP03aUvW3aEuQE=;
        b=hkPpkcFzbd/2A6PuBwijE9ZDCB714hj1Og+N3/isYKTCvtH5QLhkK+jkHeSFD+5AgN/SvY
        pFUe35EzEMNyeiXZQXGFjHkSxPqaxXSYUpeFzJrsASWT2kXxaBsTVlPHQmvLneHbTUZeKt
        Sos19gjs0+KnFHQ49u3iEu7rCjsHfPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-IDnCHoDmPP6J_IcbDTpJYQ-1; Mon, 17 Apr 2023 07:15:18 -0400
X-MC-Unique: IDnCHoDmPP6J_IcbDTpJYQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f168827701so6299955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681730117; x=1684322117;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dK3YDQscuz7YARntLdvlf6Mm4uVD1HP03aUvW3aEuQE=;
        b=KmcLhaYMzjFexXcfHmT/ZPeWhkOLUSiRTUWmd2jjrxng1/5DVvmfadLUPQ1A1M8eJx
         64BusYCrsL66xc2tIHAmruiwF1w0Ot/J4MHVwW+Qyv0JjjAlTI7bd3E/6+cVLypNk/kY
         PTaE66nly7DG87bwY1CBwN6fZngkMJ55wNvvlzp09VlSwGkYmc3NOrKBb1z9B0Kkzobj
         eMFKEYlmTsgIZi1i1gYsTJ7VKf2UVG2R9TSfeFIto5TszQCOJQRQ1GScPUpbOEAbFM5Y
         u+33BFcAD+VOf+QuXIjgLdwylexD4plRVV91GTdrOXYCc9m+I98wv1fYXdRUtE5WBTgA
         dTZg==
X-Gm-Message-State: AAQBX9fZATGTPqoGB8FiI3tbjqJAa7oOJqtWe1qHRSTxcBiGMsn3wi5H
        bohsv6ABiJQx1zeUkWQN0xihMoRZdtNCwMMCAcBG7cARlh/ef2sRp71hpqXJJiCXrKRW52rdyrO
        bsaF53hlH0cBgxHGRdrclCr/9
X-Received: by 2002:adf:d4c7:0:b0:2cf:edd8:12d3 with SMTP id w7-20020adfd4c7000000b002cfedd812d3mr4920041wrk.66.1681730117463;
        Mon, 17 Apr 2023 04:15:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZPingJuVUImVb5bdJCXh3X5iMgw5vkOxKMjXUaLY0s0KRuA8IYcOK2uyIkVl4uUVkDE5Dlpg==
X-Received: by 2002:adf:d4c7:0:b0:2cf:edd8:12d3 with SMTP id w7-20020adfd4c7000000b002cfedd812d3mr4920018wrk.66.1681730117168;
        Mon, 17 Apr 2023 04:15:17 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:db07:68a9:6af5:ecdf? (p200300cbc700fc00db0768a96af5ecdf.dip0.t-ipconnect.de. [2003:cb:c700:fc00:db07:68a9:6af5:ecdf])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe3d2000000b002c55de1c72bsm10258441wrm.62.2023.04.17.04.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 04:15:16 -0700 (PDT)
Message-ID: <4150a48f-8c6c-4631-d61a-abbd0ba83eeb@redhat.com>
Date:   Mon, 17 Apr 2023 13:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 7/7] mm/gup: remove vmas array from internal GUP
 functions
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>
References: <cover.1681558407.git.lstoakes@gmail.com>
 <217d9369b15d657128746beeaf6d65c03214df42.1681558407.git.lstoakes@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <217d9369b15d657128746beeaf6d65c03214df42.1681558407.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.23 14:09, Lorenzo Stoakes wrote:
> Now we have eliminated all callers to GUP APIs which use the vmas
> parameter, eliminate it altogether.
> 
> This eliminates a class of bugs where vmas might have been kept around
> longer than the mmap_lock and thus we need not be concerned about locks
> being dropped during this operation leaving behind dangling pointers.
> 
> This simplifies the GUP API and makes it considerably clearer as to its
> purpose - follow flags are applied and if pinning, an array of pages is
> returned.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

