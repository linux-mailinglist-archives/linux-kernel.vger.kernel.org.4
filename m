Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCC65F01A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjAEPav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjAEPah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A64EC8F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672932587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK648xItnrxXKGxe6QMGc/XWpXJ5JcGUn31yBFqg+Lg=;
        b=NowIiVabGe/sZws1z3xMaWcjIKE7o8Bg7boCB9BP85lU6QZQnI/hvzESbAFciAevh+3ieU
        oRmZRkwtxSBhAiESEqqc3WQDS71da4/vsjSdfeOkXaLg7N9+AsOmOxNzo9vBGJBmWy7REP
        AAmu8fAqrOWrWXwOHa7i9fN4VGRkZY8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-yC8UUxK1MqC5M5vIiYS2fg-1; Thu, 05 Jan 2023 10:29:45 -0500
X-MC-Unique: yC8UUxK1MqC5M5vIiYS2fg-1
Received: by mail-wm1-f71.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so18389719wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RK648xItnrxXKGxe6QMGc/XWpXJ5JcGUn31yBFqg+Lg=;
        b=1Xa7mLgzhwwJXGKoSrJxxk0vC4rEHZ8pe5By9GpRQU6gtzsqalwvbR8dxfAwcvgeQc
         mpAP4sHbhS+QxXdi64mDsg18TlgSvjfIyfXrr3X6viuKKDxezbYX1mJIywiXl3PuMpD8
         NifxxV1hroL+P6ZpPhz18Ymrx/4y/x6ccgBMcteCzXXU+dt0zh1vYhdZcZDRADjiZrKX
         L5+wOGPMeqLA5EL4mdAsu4k4cWnRINyEdHuSOA0XVmdAjsQK7x8LD3YH7mGgfCqGGPjy
         syXHC/H/d+lNucaPjb7Nepide5RE2OkFGl58tYK2buLlSobPE+KqZ3PME4g3xQjqtDEn
         IOPQ==
X-Gm-Message-State: AFqh2ko8coEV+vIxbajXPRg8nleb6ZzJ1Nn9rftkA0o114rgmkcYc+OW
        B0cLgnDbEsUJlp6brFjSIhhFcjBhtjyMza3srnPekQ+izY2qrZAn8y45txeL1LZ0VqJwBt/4tES
        f6ArvPcK1b4aFTA4/F8XJr0AB
X-Received: by 2002:a05:600c:3b21:b0:3d9:bad8:4e9e with SMTP id m33-20020a05600c3b2100b003d9bad84e9emr8966753wms.40.1672932584645;
        Thu, 05 Jan 2023 07:29:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujEgAJNEc1+gF/eVyy/27BrhmaFM+C8eLfee8wAo6Xcs1n+GlEiEUnqu5t95tSfepWEncVLg==
X-Received: by 2002:a05:600c:3b21:b0:3d9:bad8:4e9e with SMTP id m33-20020a05600c3b2100b003d9bad84e9emr8966737wms.40.1672932584395;
        Thu, 05 Jan 2023 07:29:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003cf75213bb9sm2664963wma.8.2023.01.05.07.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 07:29:43 -0800 (PST)
Message-ID: <797b85c0-ec50-f340-30dd-5a63b51dc45a@redhat.com>
Date:   Thu, 5 Jan 2023 16:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 09/46] mm: add MADV_SPLIT to enable HugeTLB HGM
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-10-jthoughton@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230105101844.1893104-10-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 11:18, James Houghton wrote:
> Issuing ioctl(MADV_SPLIT) on a HugeTLB address range will enable
> HugeTLB HGM. MADV_SPLIT was chosen for the name so that this API can be
> applied to non-HugeTLB memory in the future, if such an application is
> to arise.
> 
> MADV_SPLIT provides several API changes for some syscalls on HugeTLB
> address ranges:
> 1. UFFDIO_CONTINUE is allowed for MAP_SHARED VMAs at PAGE_SIZE
>     alignment.
> 2. read()ing a page fault event from a userfaultfd will yield a
>     PAGE_SIZE-rounded address, instead of a huge-page-size-rounded
>     address (unless UFFD_FEATURE_EXACT_ADDRESS is used).
> 
> There is no way to disable the API changes that come with issuing
> MADV_SPLIT. MADV_COLLAPSE can be used to collapse high-granularity page
> table mappings that come from the extended functionality that comes with
> using MADV_SPLIT.
> 
> For post-copy live migration, the expected use-case is:
> 1. mmap(MAP_SHARED, some_fd) primary mapping
> 2. mmap(MAP_SHARED, some_fd) alias mapping
> 3. MADV_SPLIT the primary mapping
> 4. UFFDIO_REGISTER/etc. the primary mapping
> 5. Copy memory contents into alias mapping and UFFDIO_CONTINUE the
>     corresponding PAGE_SIZE sections in the primary mapping.
> 
> More API changes may be added in the future.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   arch/alpha/include/uapi/asm/mman.h     |  2 ++
>   arch/mips/include/uapi/asm/mman.h      |  2 ++
>   arch/parisc/include/uapi/asm/mman.h    |  2 ++
>   arch/xtensa/include/uapi/asm/mman.h    |  2 ++
>   include/linux/hugetlb.h                |  2 ++
>   include/uapi/asm-generic/mman-common.h |  2 ++
>   mm/hugetlb.c                           |  3 +--
>   mm/madvise.c                           | 26 ++++++++++++++++++++++++++
>   8 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 763929e814e9..7a26f3648b90 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -78,6 +78,8 @@
>   
>   #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>   
> +#define MADV_SPLIT	26		/* Enable hugepage high-granularity APIs */

I think we should make a split more generic, such that it also splits 
(pte-maps) a THP. Has that been discussed?

-- 
Thanks,

David / dhildenb

