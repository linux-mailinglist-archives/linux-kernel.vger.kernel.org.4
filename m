Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED0A63D306
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiK3KRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiK3KRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:17:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5945462E8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfIaBuBbISWu50WkIObdwLry5Mhmx0Lt/bXwxdM+I/4=;
        b=V3c3rAnBkOYOf3lbOYYa9q8tPsJxToQvXM5ex2MVRRNwzwYWXMmpY0yIfeDz0Cq8plgE87
        dAWxHmgZShGPX6epOorGhG9AErbydvwe3TZb3OtnqlsRR1kx4o7nUwW1WsLrRsAVFLuDmX
        B+S3trlr66At7f2yZGcdHe3VkPnDp3M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-616-laCdxOyXPna17wVkqTTK1Q-1; Wed, 30 Nov 2022 05:16:00 -0500
X-MC-Unique: laCdxOyXPna17wVkqTTK1Q-1
Received: by mail-wr1-f69.google.com with SMTP id l8-20020adfc788000000b00241ef50e89eso3410571wrg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfIaBuBbISWu50WkIObdwLry5Mhmx0Lt/bXwxdM+I/4=;
        b=Kzp5dE9hEyPvB4CfMsjXPWfA7f6YrGyszwnHicRQZ9pj2KqfvuLM8Ra9WcCZjrOVbF
         lqVqPKfXIlfu2YD6xvlhaTpjDMOtBjw+PJ8w2V1hEv1r0FegOF2eBI3QZKCDf8uVbOM+
         S37ffpMicIISKgjqxaic5VdXCZAy42Lq9Rya7i2ZmGXjhXsiY4PHh8BD/QlZMVOScVEi
         pd7LlYIhQILe1WHASg3j6x6/AvF02v+X0Wmu59ZFjlYk4MYDx0XRZCeZxBjGanlWBjfE
         Awj0QkPinLenK4bjvf4d3EqzeFIjPBmojpct3osUvLoGGnn7OnFH2okea7YbHmEQEBkn
         sIOQ==
X-Gm-Message-State: ANoB5plA8GW3a4Qr/+JdQnXV4uEbFGiGBA0hv69OQ0zgEnWbcxRuMGRw
        jREZekNjFKtZXh/ZOpRRT4pqcGhtlIjmM4o9kz6xLGLQKvDvr2mM4aXWUsWxJ+5Xe8k0MYyBA76
        2imrgY0doFoBSy6MM/0nypuJ2
X-Received: by 2002:a5d:594b:0:b0:242:213a:7f96 with SMTP id e11-20020a5d594b000000b00242213a7f96mr4602843wri.155.1669803358823;
        Wed, 30 Nov 2022 02:15:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7pBJBJ77zHfI+tM9lu2Kp4Kjcet0/UGqV40kRAYLTnaZOGCa9/Os5YU8PtMospqTVwMmzkNg==
X-Received: by 2002:a5d:594b:0:b0:242:213a:7f96 with SMTP id e11-20020a5d594b000000b00242213a7f96mr4602835wri.155.1669803358582;
        Wed, 30 Nov 2022 02:15:58 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6655.dip0.t-ipconnect.de. [91.12.102.85])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003cf7292c553sm1395364wml.13.2022.11.30.02.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:15:57 -0800 (PST)
Message-ID: <ad207b55-bab4-b71c-98d1-60b244edd29d@redhat.com>
Date:   Wed, 30 Nov 2022 11:15:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/10] mm/hugetlb: Don't wait for migration entry during
 follow page
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
 <20221129193526.3588187-3-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-3-peterx@redhat.com>
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
> That's what the code does with !hugetlb pages, so we should logically do
> the same for hugetlb, so migration entry will also be treated as no page.
> 
> This is probably also the last piece in follow_page code that may sleep,
> the last one should be removed in cf994dd8af27 ("mm/gup: remove
> FOLL_MIGRATION", 2022-11-16).

We only have a handful of follow_page() calls left. Most relevant for 
hugetlb should only be the ones from mm/migrate.c.

So this is now just consistent with ordinary pages/THP.

Happy so see that gone.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

