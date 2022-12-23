Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD30654E82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiLWJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:41:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C3379D0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671788421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYdCTqml4c7ljbUVU4kZcoEb18gRQ5azwzQzokRe0Yk=;
        b=Ygo1U0EuA50agyZTLi2oC0eSDAeSC9IeKdpr6hgEaMHA3SCnXg+/Sxb/bEcKWEVgINJuzR
        xg2poEFjTbGKxD+Xzjy765+GvC0fQ1dtFHf1F6UqBWmlndXatNxGVN50zKxkrHPVY4P7Kr
        urvNzG3PBl574Gh/F9nt0jczuAh1S9U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-524-OJBXW9XSNpuCd7Woer2New-1; Fri, 23 Dec 2022 04:40:19 -0500
X-MC-Unique: OJBXW9XSNpuCd7Woer2New-1
Received: by mail-wm1-f69.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so3570143wmb.8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYdCTqml4c7ljbUVU4kZcoEb18gRQ5azwzQzokRe0Yk=;
        b=Ac2qbwuHI22ZtrnAxEBZzfloHh3sYmCMYzIzxX3Tk9rtkfkXbMk6XEwyYoxLpEaAZ6
         y3f/QQTaJFbwUARZbSo1x4ss9X8pknKjZEEoLx7+0q5GmpV35wiyDa+R0vA4VYitgWsp
         omVTTAvz21eAee9NJw7qwHU+8VkyWLrOebvpHlXT9TDKyboRCOYT2GzUbm5RMFY15/4w
         oeBxxWAgLy+cNhqK0Q4+xq6x80RIpRsG5sBZEG91JTEfZdEy9hYzraKRRGzE1CCRaK0/
         PR1Oo9mSElwjoE945cLlKwRRyKBwPW3ouT3Y1Vzdcv13znmI6PaqhWEV7IyAIz2pESN/
         IRqw==
X-Gm-Message-State: AFqh2kp2pJpbgpyOTDAGUHusuFWISW5xqTMz1Dx5jUTbocWcYDKQuATm
        UZDJVjDpTmFGRnTTE74kLfTMUO2sokv6mxEcb7j1IOiwKSQLxt2w+C3Q1Boqn6q+w7lK1x7WibT
        xpq6nYxhSRCef5DWUmY1hb6c5
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id m34-20020a05600c3b2200b003c6e63e814bmr6654810wms.2.1671788418729;
        Fri, 23 Dec 2022 01:40:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtPQ3uPs0KjP5mtjfcVVsKM5D3DKI+aZQLipe0tFV+bETDeJScFVeATD1YLHh9iingWOI6IKw==
X-Received: by 2002:a05:600c:3b22:b0:3c6:e63e:814b with SMTP id m34-20020a05600c3b2200b003c6e63e814bmr6654789wms.2.1671788418429;
        Fri, 23 Dec 2022 01:40:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:ab00:3d8e:16c4:a38d:2827? (p200300cbc707ab003d8e16c4a38d2827.dip0.t-ipconnect.de. [2003:cb:c707:ab00:3d8e:16c4:a38d:2827])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003c6f8d30e40sm9565434wms.31.2022.12.23.01.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:40:18 -0800 (PST)
Message-ID: <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
Date:   Fri, 23 Dec 2022 10:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] virtio_balloon: high order allocation
Content-Language: en-US
To:     Soichiro Ueda <the.latticeheart@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, akpm@linux-foundation.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kalutes@google.com, mhiramat@kernel.org, cwd@google.com
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221223093527.12424-1-the.latticeheart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.22 10:35, Soichiro Ueda wrote:
> At present, the VirtIO balloon device driver allocates pages
> one by one using alloc_page(), and frees them using put_page().
> 
> This changes it so that the driver allocates high order pages
> by using alloc_pages(), and frees them using __free_pages() if possible.
> By doing so, the CPU performance of inflation and deflation
> should be improved.
> 
> The effect of this change has been confirmed by benchmarks that measure
> the elapsed time of inflation and deflation.
> 
> The results are here:
> 
> 16 pages inflation:
>    before: 119,779 ns
>    after : 115,655 ns (-3.4%)
> 64 pages inflation:
>    before: 156,977 ns
>    after : 150,961 ns (-3.8%)
> 256 pages inflation:
>    before: 218,649 ns
>    after : 208,490 ns (-4.6%)
> 16 pages deflation:
>    before: 78,112 ns
>    after : 68,288 ns (-12.6%)
> 64 pages deflation:
>    before: 97,205 ns
>    after : 80,491 ns (-17.194%)
> 256 pages deflation:
>    before: 122,742 ns
>    after : 107,526 ns (-12.4%)

How does this affect page migration / balloon compaction etc?

-- 
Thanks,

David / dhildenb

