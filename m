Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5C46DED62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDLISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA1C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681287443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzMYQVznDE4YkNJ+RQau1i1jLsAVGnKy89iPVH1EiHw=;
        b=Rtkql00SNsUGblwf+HH4vdI75t6S0iNJJq85mMvUNpVBRL3s5CCwb1cIekPrIM2ceZdmH0
        RDl4TDfUsYUidnIvLnmx9CGHhhnBqeO/TF7PgDWtVxHVu7oNs28BVFwOagOB7r82BjryZb
        wPaiHiVJugevgkO53txFAg3gukkaYto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-gFGSOCTQM3yuWJyw6cDR3Q-1; Wed, 12 Apr 2023 04:17:21 -0400
X-MC-Unique: gFGSOCTQM3yuWJyw6cDR3Q-1
Received: by mail-wr1-f69.google.com with SMTP id j6-20020adfa546000000b002d58b4b7698so1598515wrb.19
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287440; x=1683879440;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzMYQVznDE4YkNJ+RQau1i1jLsAVGnKy89iPVH1EiHw=;
        b=Eqll7525vg+GdDonQQfImflvNpZL2YpPcGBPHINBSSX39MFGbX0vh/lbcXj7p3kmW6
         iMuom/laid+RYjduz4RUmXxvZbekK0ARd6NfQJZ39b+bBPdIBh7KZKqO2SjU57uGdPE6
         A15C0CN4qX9zWvNmfYV6Ks4sObHePXfAwJhujFzRwvqBXh0CT/uR4I5cjs8Iv7wykcJR
         U08nv9iPFftJSgShnsgbTWGRXCiSYdODsy3Xa9MzkQhXfjSDqtmnCh8VlVr/svuMgMBP
         dtdYHrL7/0IEUs4mK0VdUn2rdJrGdnTFP/t8jyreh8fAq7OI0uL8wrkjY4nJNZ8Hixfk
         chVw==
X-Gm-Message-State: AAQBX9dzN8yqS1GM6x9sLxAjX/yabfZDJE8rbYCy+eGq0Lw/uj1O9Ccb
        /lnPsolMfr8j1QXyfrAQibCADraYrkmKrqczg0h2jdaHUyoXlegkDgnp4aCWg9a5xene4WHOzst
        6MQnFG/vbtzVokCp5Jg63vjYp
X-Received: by 2002:adf:fad1:0:b0:2ef:b8e3:46fd with SMTP id a17-20020adffad1000000b002efb8e346fdmr1163632wrs.38.1681287440686;
        Wed, 12 Apr 2023 01:17:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bxta8fTx0XSzSl2idHt++wEgxAIFvsbHiX+99XZip3kfVd1B+1ZY+Rz0OU4K0+23oEO6fX8g==
X-Received: by 2002:adf:fad1:0:b0:2ef:b8e3:46fd with SMTP id a17-20020adffad1000000b002efb8e346fdmr1163607wrs.38.1681287440285;
        Wed, 12 Apr 2023 01:17:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5308000000b002ce9f0e4a8fsm16626051wrv.84.2023.04.12.01.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:17:19 -0700 (PDT)
Message-ID: <93f2614e-4521-8bc8-2eca-e7ad03e7e399@redhat.com>
Date:   Wed, 12 Apr 2023 10:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: find_get_page() VS pin_user_pages()
In-Reply-To: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
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

On 11.04.23 21:43, Teterevkov, Ivan wrote:
> Hello folks,
> 
> I work with an application which aims to share memory in the userspace and
> interact with the NIC DMA. The memory allocation workflow begins in the
> userspace, which creates a new file backed by 2MiB hugepages with
> memfd_create(MFD_HUGETLB, MFD_HUGE_2MB) and fallocate(). Then the userspace
> makes an IOCTL to the kernel module with the file descriptor and size so that
> the kernel module can get the struct page with find_get_page(). Then the kernel
> module calls dma_map_single(page_address(page)) for NIC, which concludes the
> datapath. The allocated memory may (significantly) outlive the originating
> userspace application. The hugepages stay mapped with NIC, and the kernel
> module wants to continue using them and map to other applications that come and
> go with vm_mmap().
> 
> I am studying the pin_user_pages*() family of functions, and I wonder if the
> outlined workflow requires it. The hugepages do not page out, but they can move
> as they may be allocated with GFP_HIGHUSER_MOVABLE. However, find_get_page()
> must increment the page reference counter without mapping and prevent it from
> moving. In particular, https://docs.kernel.org/mm/page_migration.html:

I suspect that find_get_page() is not the kind of interface you want to 
use for the purpose you describe. find_get_page() is a wrapper around 
pagecache_get_page() and seems more like a helper for implementing an fs 
(looking at the users and the fact that it only considers pages that are 
in the pagecache).

Instead, you might want to mmap the memfd and pass the user space 
address range to the ioctl. There, you'd call pin_user_pages_*().

In general, for long-term pinning a page (possibly keeping the page 
pinned forever, controlled by user space, which seems to be what you are 
doing) you want so use pin_user_pages() with FOLL_LONGTERM. That will 
try migrating the page off of e.g., ZONE_MOVABLE or MIGRATE_CMA, where 
movability has to be guaranteed.


But I am no fs expert, so I'll cc some people that might know better if 
this would be an abuse of find_get_page().


-- 
Thanks,

David / dhildenb

