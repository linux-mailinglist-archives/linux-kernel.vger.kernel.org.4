Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1A5F06CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiI3IrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiI3IrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:47:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D511FD0E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:46:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b23so3662789pfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8hK7dYqCKStIL8sNiRk1FpqChl0J32g8Nhctqg2nLuU=;
        b=0tjV8GrNIcboxZN4wrH7rM15rjMbLej1jbDVZn20VtYLNd94oVs8Ee8H7+Ja75Egbn
         eTGagY4VmQjDZUY1at7dEC4QKmyxPYV883Lfw3mFEN6+0nfwAJHn+hyF4AL/jiHU8aVQ
         wM46ngsECs1F+RXc/M4v48VjBLAqpoAWeRjuBQFJ9F/2F8Lcw/fHYHpXuzEIAzrv0c/B
         E0vbYefd+CZ47jSUtCMnP0adCr3cz+qQxbdkbV9AhMtTI2QtnVNByShqp9PQjwIfi2nr
         794otsl6AIoTr5szIeDhsdumZtzEtHjLmVUDSGNuOZ/BTc9467/MYPRdne+owNmq+11r
         pXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8hK7dYqCKStIL8sNiRk1FpqChl0J32g8Nhctqg2nLuU=;
        b=IQwtJFjmHhsAgTRVzCFoInVWnWUfLR3KyXbg+6P6vWUl9udgmMBFIHXVX/cL2/2/i+
         7oc6Cts786HeCh9QDfoMwLN6JkzgwRtr6dHtZqAk3RiIDqXatOg/eNFoDEm4nYR0mCDA
         u6LVKCRv96MbfKv/BIJDiqUtKvr0EpQC3nVyjhz4w/EKywqJmJOrkx4bPrGDM+npaQoo
         60RadiGfBKUMU4uM1XvZdh32/4X7E8499YDQEqlr7EmX+07SUkIMy1kzwkPD1wxe2bsm
         pluedn0tqM6jZByoIhzgBY+B0ScKIzOJy70/pMKI9voRGBEvhgwsNCam6ww3GK1VCArr
         32VQ==
X-Gm-Message-State: ACrzQf1DEnUEgt2e/BM7RsBcKledvWcU1OPoDDCgniHSZJP5VXPC1uiA
        pzk6tHXhcKIrgESggOrcP9/x5w==
X-Google-Smtp-Source: AMsMyM5MsO7lJsf7zGV/70Gzqt+lyeK5x5cmUlNE18x3/SJYJwP6ccURIbPeCdRwNciVnzOezHod6g==
X-Received: by 2002:a63:df18:0:b0:43c:dbdb:2f24 with SMTP id u24-20020a63df18000000b0043cdbdb2f24mr6512793pgg.226.1664527617903;
        Fri, 30 Sep 2022 01:46:57 -0700 (PDT)
Received: from [10.4.189.225] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902eb8c00b0016bf5557690sm1338450plg.4.2022.09.30.01.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:46:56 -0700 (PDT)
Message-ID: <ade0363a-3075-4410-62c2-4eaaa7cb3b76@bytedance.com>
Date:   Fri, 30 Sep 2022 16:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        maobibo@loongson.cn, chenhuacai@loongson.cn,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
 <20220929112318.32393-2-zhengqi.arch@bytedance.com>
 <0fecbcdc-7324-2d76-8452-b60b4638d074@redhat.com>
 <32a53a8f-f6f8-6efc-a5f6-a004ffab8c99@bytedance.com>
 <673e494c-eb91-470a-026b-59e414d0916e@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <673e494c-eb91-470a-026b-59e414d0916e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/30 16:44, David Hildenbrand wrote:
> On 30.09.22 10:43, Qi Zheng wrote:
>>
>>
>> On 2022/9/30 16:30, David Hildenbrand wrote:
>>> On 29.09.22 13:23, Qi Zheng wrote:
>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>> if PTE entry exists") said, we should update local TLB only on the
>>>> second thread. So in the do_anonymous_page() here, we should use
>>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>>
>>>
>>> Maybe mention here "This only affects performance, but not correctness."
>>
>> Oh, this is better. Hi Andrew, do I need to resend the v4?
>>
> 
> I assume he can squash it, most probably no need to resend. :)

Got it. Both are fine for me. :)

> 

-- 
Thanks,
Qi
