Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034BE5F06BE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiI3Ioc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI3Ioa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4CD142E0A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664527469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+5P7WxpX9YzqjSjpN3Cg4iRUb1rI33yeq0uhwQY+XFQ=;
        b=IQsgu5uA7LLZtliRryuxyxhZJVdhYi109Wmy2B6jJllVFP7ldR+hjQuYQiSOErnl/m6uQ6
        TMc2luDL32UzH4cAbAFQvJ06i8/wAJs6ClGhSxg6rH1tJhrox0zahgWrVjaXtQupt12inN
        Q4WnOpGHBOZQ6gHk2yMvAMz9b09ofbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-RUzde2oKMbmna26-yHkgtw-1; Fri, 30 Sep 2022 04:44:24 -0400
X-MC-Unique: RUzde2oKMbmna26-yHkgtw-1
Received: by mail-wr1-f70.google.com with SMTP id e28-20020adfa45c000000b0022cc7d071b4so1322132wra.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=+5P7WxpX9YzqjSjpN3Cg4iRUb1rI33yeq0uhwQY+XFQ=;
        b=PYvUwzz6Z9pOvsNrSNQ2YCD0oXwqoQXOW2aOn9a+tqCSXeeKVH6OaaUbENE0MNkMPD
         j8DoRbWedzoBlkMOXybXnqbjp5rHPHyOBC79hy1JGH208aEPE+CEyFyE1x0n+5+9+cpA
         8a/gxFkNI7vZmfy6uXzrTF6jck8+wHYXpSg0Mva0sfLNh3v44DPA9+/N2SNs8RsTs6qQ
         TJq0bl3sUcmeeIWRgTuNCWzu7i5DNIsiWDB5SxUSVHvei6KHdxjKm1aMqhGNJZoxyCal
         w0y06+s61vb0hAyLDZfGjocZKUwZo+7sjHN5YvtCuEuG7AJL77hWvCxNLhj15R4adC9T
         gI7Q==
X-Gm-Message-State: ACrzQf2BvsBi6b9oY0jKO7hGxfn7gfQ9ga5XojJ6hoiJRXm+mEszGPNt
        KEoCN61JSLLD4+NRV9hHEj0t7VNFSKWGQUOZx3wzJdgzW/ArjRwlVqrXso2D1Gooy8NYYvr5uVx
        Vgk+Wc/1Nd3ZV+fGkL68Wnwre
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id n13-20020a05600c500d00b003b50234d7e9mr5096885wmr.57.1664527463087;
        Fri, 30 Sep 2022 01:44:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lSPxx9RSmxEw3e5Wn9C1Knh20ngmmeuWzgTOZVepdksSmhhhH7ldVQWOsiUQ6w2s0/Weahg==
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id n13-20020a05600c500d00b003b50234d7e9mr5096870wmr.57.1664527462765;
        Fri, 30 Sep 2022 01:44:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:c00:48b:b68a:f9e0:ebce? (p200300cbc70c0c00048bb68af9e0ebce.dip0.t-ipconnect.de. [2003:cb:c70c:c00:48b:b68a:f9e0:ebce])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d43ca000000b00228aea99efcsm1456462wrr.14.2022.09.30.01.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 01:44:22 -0700 (PDT)
Message-ID: <673e494c-eb91-470a-026b-59e414d0916e@redhat.com>
Date:   Fri, 30 Sep 2022 10:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        maobibo@loongson.cn, chenhuacai@loongson.cn,
        songmuchun@bytedance.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
 <20220929112318.32393-2-zhengqi.arch@bytedance.com>
 <0fecbcdc-7324-2d76-8452-b60b4638d074@redhat.com>
 <32a53a8f-f6f8-6efc-a5f6-a004ffab8c99@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <32a53a8f-f6f8-6efc-a5f6-a004ffab8c99@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.09.22 10:43, Qi Zheng wrote:
> 
> 
> On 2022/9/30 16:30, David Hildenbrand wrote:
>> On 29.09.22 13:23, Qi Zheng wrote:
>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>> if PTE entry exists") said, we should update local TLB only on the
>>> second thread. So in the do_anonymous_page() here, we should use
>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>
>>
>> Maybe mention here "This only affects performance, but not correctness."
> 
> Oh, this is better. Hi Andrew, do I need to resend the v4?
> 

I assume he can squash it, most probably no need to resend. :)

-- 
Thanks,

David / dhildenb

