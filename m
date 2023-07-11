Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0890874ED3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjGKLt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGKLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:49:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1A2E4B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689076151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ox1ybSLl45XwKkwvaJMisJ5/+NEAsrD7J+jcJG30/JQ=;
        b=AQaBdNI6PnPj0Gb0TGw5XmSsQZ4M/ID3LOZVmDGa12hvKpyfgSIs51McaD71LQB05edois
        Of8nzbn9QgP7pB8bXXJ6kv8QIJomxtatR4/o2YjoW0JMZ9uIkOWsPTFwfd+MFW1wW9ttzS
        d0i9u8Kk4DRtM4Wi4pkTBeR2tZWtlzc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-1i8beNSXMwetrV65OqujKA-1; Tue, 11 Jul 2023 07:49:09 -0400
X-MC-Unique: 1i8beNSXMwetrV65OqujKA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3143c9a3519so3923768f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689076148; x=1691668148;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ox1ybSLl45XwKkwvaJMisJ5/+NEAsrD7J+jcJG30/JQ=;
        b=JgA32WB4aZtdkbMflLUrXSUfQ4kApb7k4t3weK0079S600uW8czvfJYvlMGvzcDLnO
         VIwxT4VWG0mP5U8yqBVt5B40UmzYf8xPaVl5/L4ZbQYoyZq7sn1uOWtx1Mei/SuJC93f
         dbC5YeLgnzibatBLpVUFCXg6uRT8WDX9+R1LaMyykImGBx+rw3OEOi1IgjgHfcnHIoiH
         AMoq6wPWI7Ah/XujFzqko/uT6ILFRu5vu31HQo1DRPAqi9uKD5Ar6YOpIE7MlZcbT/yW
         41q4XPRhfhpWoMmsXVdwdKINTRRYBezc6g5VAAaQ6cwn2cZtV5BTSaqmYMzBJbiQ7hm6
         povg==
X-Gm-Message-State: ABy/qLaY35wMH0lBYVS59JSBgV6YEXb39Zd8dfTAhbWknL10ESH048y5
        e9JqaN5Blqe3nfpSmREzCOopdEU+JLJ6Lcz17uCwGekrGhHhZsKPi98dbUJt7Yr6vZLMSTboQkD
        KMWmHV91dTC4NmwzLgY1F7S9J
X-Received: by 2002:adf:f9c9:0:b0:314:2132:a277 with SMTP id w9-20020adff9c9000000b003142132a277mr17501680wrr.9.1689076148759;
        Tue, 11 Jul 2023 04:49:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZd89iKuySO+cfoLjyf2v2YUsX/u5t8p1LFxTJwVXW3pD745O+xFed6Np91H3kYcR2bhyjDw==
X-Received: by 2002:adf:f9c9:0:b0:314:2132:a277 with SMTP id w9-20020adff9c9000000b003142132a277mr17501654wrr.9.1689076148389;
        Tue, 11 Jul 2023 04:49:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:4000:13ad:ed64:37e6:115d? (p200300cbc745400013aded6437e6115d.dip0.t-ipconnect.de. [2003:cb:c745:4000:13ad:ed64:37e6:115d])
        by smtp.gmail.com with ESMTPSA id b7-20020a05600c11c700b003fc015ae1e1sm2386296wmi.3.2023.07.11.04.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:49:07 -0700 (PDT)
Message-ID: <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
Date:   Tue, 11 Jul 2023 13:49:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Content-Language: en-US
To:     Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        Linke Li <lilinke99@gmail.com>
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.23 10:32, Linke Li wrote:
> From: Linke Li <lilinke99@gmail.com>
> 
> 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> 	/* check for overflow */
> 	if (len < vma_len)
> 		return -EINVAL;
> 
> The existing code includes an integer overflow check, which indicates
> that the variable len has the potential to overflow, leading to undefined
>   behavior according to the C standard. However, both GCC and Clang
> compilers may eliminate this overflow check based on the assumption
> that there will be no undefined behavior. Although the Linux kernel
> disables these optimizations by using the -fno-strict-overflow option,
> there is still a risk if the compilers make mistakes in the future.

So we're adding code to handle eventual future compiler bugs? That 
sounds wrong, but maybe I misunderstood the problem you are trying to solve?

-- 
Cheers,

David / dhildenb

