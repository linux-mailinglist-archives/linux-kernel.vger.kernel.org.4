Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644F86484DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLIPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiLIPTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F11006E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670599096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0eu2Sx7RzvtaeptKcICpgSODE9eJn6k0GSRJ1eb03QI=;
        b=gzUkA6GJmHWD63Sdq2o1sIuLNxbjGcddopkkmcw11m00ychjzP7D1GYHUFTcVdjTIMLcK7
        eafB4D+UoyagYiMqmggcUj1hNGMx/k0LbQpSf4FiZGH5jQw+2n/j7QGkXjPef6Nlo3BTb3
        jYfdheoSlry6hooPXpSfQUl5nHEHjDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-O7QagYHOOsORyReZ3pZRQg-1; Fri, 09 Dec 2022 10:18:14 -0500
X-MC-Unique: O7QagYHOOsORyReZ3pZRQg-1
Received: by mail-wr1-f69.google.com with SMTP id d6-20020adfa346000000b0024211c0f988so1040582wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 07:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eu2Sx7RzvtaeptKcICpgSODE9eJn6k0GSRJ1eb03QI=;
        b=j9W5syib4zCPqwDvEb5ikeaQ2+mG2bFUJ3UqhhXBcVhQUDQSaH3z9Lg85DWpk6a5IL
         oOoBvS9rN4rDtBWtZhCrrp73/5zb5ZsTzYBuTGFlSgn9JxfW9sMNtyhuSiwzVz6t63Uo
         lm0QMvZR70gMtV2hQmP6w65mvn0pBD1hbSj9OrxdntAaLsblSzTW5Ea/ZR4P+37/6UOS
         qTj7H9n09F04j/xZZ+nVUdtB1ihCtG6whOCKC957VBENI1F10ee7vvDWjre5FKZ8qh35
         P6SzkYavzYm1qNK3DHx+mGhu1S1DrnzQqHSbOkliQ9CrnsSImf5019/veLpN11QubHjt
         mfkw==
X-Gm-Message-State: ANoB5pnBdUEtNuMsisC1Q/+AsjNz6jc2hizcQiBBEMylMebpG4iMFDrV
        In8H7LGxVXMSjW9C3ODf3ltInBMBGEcF07bXfMhQR0FTJW388c3Ia4WOA2S3qcdhwu+SM8mdkND
        mNir2Zl29qJ4HNptQRkoiCx0k
X-Received: by 2002:adf:f944:0:b0:236:d8ef:9efd with SMTP id q4-20020adff944000000b00236d8ef9efdmr3935390wrr.11.1670599093465;
        Fri, 09 Dec 2022 07:18:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KARRhY+Z5zQK6Yh9EJ5fVMlhw8pIH4mFjrrpb1FJnV8S84Jfmj9JV23bFZ0mT1TsAq+pj4A==
X-Received: by 2002:adf:f944:0:b0:236:d8ef:9efd with SMTP id q4-20020adff944000000b00236d8ef9efdmr3935374wrr.11.1670599093112;
        Fri, 09 Dec 2022 07:18:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:2e00:b9ea:114c:a3f5:327e? (p200300cbc7022e00b9ea114ca3f5327e.dip0.t-ipconnect.de. [2003:cb:c702:2e00:b9ea:114c:a3f5:327e])
        by smtp.gmail.com with ESMTPSA id ay2-20020a5d6f02000000b002366e3f1497sm1709649wrb.6.2022.12.09.07.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 07:18:12 -0800 (PST)
Message-ID: <56eecd5e-9f1a-0171-0e4f-934e3e6b495a@redhat.com>
Date:   Fri, 9 Dec 2022 16:18:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-9-peterx@redhat.com>
 <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com> <Y5JNXomE5eGo8DyF@x1n>
 <72a62bf5-7633-f35f-75fd-0222fd0ab49f@redhat.com> <Y5NIoqXlAvrXkCOM@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
 pmd unshare
In-Reply-To: <Y5NIoqXlAvrXkCOM@x1n>
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

On 09.12.22 15:39, Peter Xu wrote:
> On Fri, Dec 09, 2022 at 11:24:55AM +0100, David Hildenbrand wrote:
>> For such cases, it would be good to have any evidence that it really helps.
> 
> I don't know much on the s390 path, but if a process has a large hugetlb
> vma, even MADV_DONTNEED will be blocked for whatever long time if there's
> another process or thread scanning pagemap for this vma.
> 
> Would this justify a bit?

I get your point. But that raises the question if we should voluntarily 
drop the VMA lock already in the caller every now and then on such large 
VMAs and maybe move even the cond_resched() into the common page walker, 
if you get what I mean?

On a preemtible kernel you could reschedule just before you drop the 
lock and call cond_resched() ... hmm

No strong opinion here, it just looked a bit weird to optimize for a 
cond_resched() if we might just reschedule either way even without the 
cond_resched().

-- 
Thanks,

David / dhildenb

