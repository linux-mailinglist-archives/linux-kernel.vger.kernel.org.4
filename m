Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF0363D2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiK3KMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiK3KM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1032B85
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SH27Slsouj00dLidJeYoe+PORUNdekUcaagS5Y6tfm4=;
        b=WVtJ/i7MSyZF6npcQuxUJZoCjl+vTDXq7QS78B/YR+cnXoF100sFrnKWd1qWRPHPluAMhN
        Q2yGQ59IgHqPjmXH3j/btoF3KTWRzg71OLBK8o8Cp1zJstTmUPHh2C/zJU0whCpmWWhLWj
        yTln0TLuhYKXyObzZNYNYMC4j6F9SRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-YGX2kvf6N22i_xrvmV3bjg-1; Wed, 30 Nov 2022 05:11:26 -0500
X-MC-Unique: YGX2kvf6N22i_xrvmV3bjg-1
Received: by mail-wm1-f72.google.com with SMTP id p14-20020a05600c204e00b003cf4cce4da5so475907wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SH27Slsouj00dLidJeYoe+PORUNdekUcaagS5Y6tfm4=;
        b=uxAWAZ2qTRMC7HzsNj9ja1dEjDe37K3wCgKnECGKw/eHrZN66Miz4XVNSth5z/TmHF
         LMp7t6o6SHTzXFHB5nKDLFVNTpiEmDzWg1y0F6gckf1axZj2+OWVhkMbfZFisMLYJxv7
         hFpCt+rkqU6Ls7tgZn1zVKBnYB4NASpBv8+a4xzEJDtOzw4ETGEypV+6jbvJR0n1VZl/
         q6i92ztXwlVim/OeMvpvDR3t5UT3vYjm8PdGOq9zFdoPGiqKmEJBayw6Jdp4nykXodCz
         /qf6tkquvMvg/39yhydpQp7MRTokBbdcnURhcL9HuQEpniIUb6LvxMJdnBSglAtUcro/
         59qA==
X-Gm-Message-State: ANoB5pkAAJSjmqPB76uxijbh8ymwaIoyctFsFE1ex3c9p+Pz52cfuFcc
        NvnpWux5vTnzP5BXfK3N9B+kSRCd/+zpC3fLhSNgAx4rxSKgvCCPfwUDvbkc+ywp5nxZA3Sh3gi
        j2UVkRY9hy/rjgDxkasy7cqha
X-Received: by 2002:a5d:52cb:0:b0:236:4a87:2c25 with SMTP id r11-20020a5d52cb000000b002364a872c25mr36267353wrv.19.1669803084714;
        Wed, 30 Nov 2022 02:11:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+KpD1E7gNGYpwXrZp+0JqgVnfC8gVUoc+Iv0/fDTkcFi2v2R4M7bL0kmdvamjefN52ZEAkg==
X-Received: by 2002:a5d:52cb:0:b0:236:4a87:2c25 with SMTP id r11-20020a5d52cb000000b002364a872c25mr36267337wrv.19.1669803084433;
        Wed, 30 Nov 2022 02:11:24 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6655.dip0.t-ipconnect.de. [91.12.102.85])
        by smtp.gmail.com with ESMTPSA id n5-20020adff085000000b00236c1f2cecesm1313464wro.81.2022.11.30.02.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:11:23 -0800 (PST)
Message-ID: <ee6a1830-7218-d01d-e860-c4d19536a5d4@redhat.com>
Date:   Wed, 30 Nov 2022 11:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-2-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 01/10] mm/hugetlb: Let vma_offset_start() to return start
In-Reply-To: <20221129193526.3588187-2-peterx@redhat.com>
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

On 29.11.22 20:35, Peter Xu wrote:
> Even though vma_offset_start() is named like that, it's not returning "the
> start address of the range" but rather the offset we should use to offset
> the vma->vm_start address.
> 
> Make it return the real value of the start vaddr, and it also helps for all
> the callers because whenever the retval is used, it'll be ultimately added
> into the vma->vm_start anyway, so it's better.

... the function name is a bit unfortunate ("offset" what?, "start" what?).

But it now matches the semantics of vma_offset_end() and the actual 
"v_start" variables.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

