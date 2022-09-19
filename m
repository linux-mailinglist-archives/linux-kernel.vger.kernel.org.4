Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E730D5BC3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiISHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISHuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030F13F30
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663573817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/iLQ4kdAhzUU0VWkseG+c5vX7QQyvDlfGs9j2AsJDU=;
        b=IkX3gN4iMoE45fXU6P1OwWTCIVHLBSwrw311FS9GL6HNdzOljMHNJcvHsVrB4aMxRGBaD3
        noHn4eQ4mKKHBX4y7Lb31aBjs5s6d5ioZDooG28QmRkTvPf1o3TKsOWk3rlgXtVtNk0hcN
        Iuw/VNW1TAgMfqB0BHhzhp/fuaHu9Y0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-rWjWs78yMK27zLI1Iv4r2A-1; Mon, 19 Sep 2022 03:50:15 -0400
X-MC-Unique: rWjWs78yMK27zLI1Iv4r2A-1
Received: by mail-wr1-f69.google.com with SMTP id v22-20020adf8b56000000b0022af189148bso577729wra.22
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=i/iLQ4kdAhzUU0VWkseG+c5vX7QQyvDlfGs9j2AsJDU=;
        b=0MzszpfXjRkISSNsSv5LkYXJ9Fzx2micbfmL3wZp82Qk7NFxgHWkTr9gZ3K3Wl32cI
         p0T4JsprdaJk5f780t8dsIciEeLkTtONzj48PJRNLMh69JVgSACixC9y8JFZy2gJywJt
         Yr7MVcKjKRozfZwC8kHqo6jjd1yCL36u8IJc9sR4HXy+j5bdw5N4eblNbFC0nfCsNntS
         5IlN+StKIuN00+Nr22MTpjKBy04TMkAKRbExzMXWvhS7FyRAU9mruivZLEMx5k3gQwcF
         EyNjV2RK0Xn/zhp7/UdFd0SkFMqi89ERAESTCdOpnSqlwlimOTttxPizEx5F22Tpq7k4
         ZXWg==
X-Gm-Message-State: ACrzQf2oDlE9lZbAI+2vlbCQZAl5qJY6mNcxS+jh8XOeFx+jm0Ie4k8J
        13ZrRj+mLBxJn9YPIxEWqZKm9OylYbvrSNzkLANYZDMkcs7TbtYOU1+l/iiwFt3VQBD4kOS7ivy
        u9mXT9APuRogAh/+YBEbQtD0k
X-Received: by 2002:adf:a50e:0:b0:22a:ede1:57e with SMTP id i14-20020adfa50e000000b0022aede1057emr5797015wrb.63.1663573814678;
        Mon, 19 Sep 2022 00:50:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69yWPQ71p10ovzZwsnci+6il7uBFgZ4x37tHZjCyhjLk1+HnJ2naaRkgKbADZjLobyfndxig==
X-Received: by 2002:adf:a50e:0:b0:22a:ede1:57e with SMTP id i14-20020adfa50e000000b0022aede1057emr5796994wrb.63.1663573814405;
        Mon, 19 Sep 2022 00:50:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:c100:c136:f914:345f:f5f3? (p200300cbc703c100c136f914345ff5f3.dip0.t-ipconnect.de. [2003:cb:c703:c100:c136:f914:345f:f5f3])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d67c2000000b0021badf3cb26sm15174363wrw.63.2022.09.19.00.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 00:50:13 -0700 (PDT)
Message-ID: <3d2fc74b-7496-6691-aec0-8d4ed30df139@redhat.com>
Date:   Mon, 19 Sep 2022 09:50:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3] hugetlb: simplify hugetlb handling in follow_page_mask
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220919021348.22151-1-mike.kravetz@oracle.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220919021348.22151-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.22 04:13, Mike Kravetz wrote:
> During discussions of this series [1], it was suggested that hugetlb
> handling code in follow_page_mask could be simplified.  At the beginning
> of follow_page_mask, there currently is a call to follow_huge_addr which
> 'may' handle hugetlb pages.  ia64 is the only architecture which provides
> a follow_huge_addr routine that does not return error.  Instead, at each
> level of the page table a check is made for a hugetlb entry.  If a hugetlb
> entry is found, a call to a routine associated with that entry is made.
> 
> Currently, there are two checks for hugetlb entries at each page table
> level.  The first check is of the form:
>          if (p?d_huge())
>                  page = follow_huge_p?d();
> the second check is of the form:
>          if (is_hugepd())
>                  page = follow_huge_pd().
> 
> We can replace these checks, as well as the special handling routines
> such as follow_huge_p?d() and follow_huge_pd() with a single routine to
> handle hugetlb vmas.
> 
> A new routine hugetlb_follow_page_mask is called for hugetlb vmas at the
> beginning of follow_page_mask.  hugetlb_follow_page_mask will use the
> existing routine huge_pte_offset to walk page tables looking for hugetlb
> entries.  huge_pte_offset can be overwritten by architectures, and already
> handles special cases such as hugepd entries.
> 
> [1] https://lore.kernel.org/linux-mm/cover.1661240170.git.baolin.wang@linux.alibaba.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

