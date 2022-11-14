Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278E96278B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiKNJJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiKNJIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D51DA43
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668416782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MyDiWdKe1VYdsKgzDX1uadXsuftR4IzIbTjD84A1VBs=;
        b=YO4i5RnYA0Rru/9xonjpOJjOMHF7ng1JtR90/hS6BFrNRN6VHu0a0oxwsL4K+PRwh+jEyI
        dMjHWuAKCc+ylxik6y8PvTWKZCmm50B3kopUhPlTwFIhx083rD31bUd0bnNTdqwBQ14X8I
        JJhPUhoVXm/sM5CwHfBUe1zqF/IsNvQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-JIn3BtwpP_Cnmhwzy29xog-1; Mon, 14 Nov 2022 04:06:21 -0500
X-MC-Unique: JIn3BtwpP_Cnmhwzy29xog-1
Received: by mail-wr1-f69.google.com with SMTP id u13-20020adfa18d000000b00236566b5b40so1761390wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyDiWdKe1VYdsKgzDX1uadXsuftR4IzIbTjD84A1VBs=;
        b=yWoiFBf+YmBqcmciIx8T9wMJ0Hg9LLkgEWh5J+MV1+Kg1AFcaddzOzm1mwIqpFRoJO
         WOqVVWzHcdxdhBm0FVnkJh0FPGdwkIM0Z5ukPJwTlReOK2lPo0kfiiAnqLdq0KyxffB1
         Myp15Pv5nqFrn7URbwwWONzzbfB2t7xjg3P+7DDnAyRjsqo3WNMU9+xtLu8nz8WHB/sp
         P4CJXCqaDk8OVR/hY7ckJMO50RK6qk/9cLdCDi66HVyC/M2XKwp3P/LHI3idYnfwtntY
         EOSJcFTFbukky0PWXycJTOEvFDBP9aMlXoWQ0yt2RQHZFaZhoOtK/dmHPLluNkTIuJs0
         Ro1g==
X-Gm-Message-State: ANoB5pk0jKb03tJFMJmPeKTs2N3vxbL8d8co1lbX9+LP1DWRJ2O8WPMx
        I/V2qAwcWg53Oj68VMgNsRQR7FFLzDgFd0VBzoXl96opbQDnHR1ZKaWwjw7D0WKEc/UxsjaL+65
        nRdBQxB59yDeXPYBqUuU1OYWR
X-Received: by 2002:a05:6000:51:b0:241:553e:5040 with SMTP id k17-20020a056000005100b00241553e5040mr6948318wrx.578.1668416780275;
        Mon, 14 Nov 2022 01:06:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4l1B+wPdFoYaTSboiqdtBGcv+KQQAevPv9Adl6JHAVGpTZ8odXESHyxfOdy80t/1su8czTaA==
X-Received: by 2002:a05:6000:51:b0:241:553e:5040 with SMTP id k17-20020a056000005100b00241553e5040mr6948298wrx.578.1668416780032;
        Mon, 14 Nov 2022 01:06:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:d300:8765:6ef2:3111:de53? (p200300cbc703d30087656ef23111de53.dip0.t-ipconnect.de. [2003:cb:c703:d300:8765:6ef2:3111:de53])
        by smtp.gmail.com with ESMTPSA id i22-20020a05600c355600b003cf894c05e4sm19299080wmq.22.2022.11.14.01.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:06:19 -0800 (PST)
Message-ID: <cfb2e9de-3bf8-6380-f336-dc3d7a5ecc29@redhat.com>
Date:   Mon, 14 Nov 2022 10:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v9 2/3] hugetlb: remove duplicate mmu notifications
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Chen <harperchen1110@gmail.com>, stable@vger.kernel.org
References: <20221111232628.290160-1-mike.kravetz@oracle.com>
 <20221111232628.290160-3-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221111232628.290160-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.22 00:26, Mike Kravetz wrote:
> The common hugetlb unmap routine __unmap_hugepage_range performs mmu
> notification calls.  However, in the case where __unmap_hugepage_range
> is called via __unmap_hugepage_range_final, mmu notification calls are
> performed earlier in other calling routines.
> 
> Remove mmu notification calls from __unmap_hugepage_range.  Add
> notification calls to the only other caller: unmap_hugepage_range.
> unmap_hugepage_range is called for truncation and hole punch, so
> change notification type from UNMAP to CLEAR as this is more appropriate.
> 
> Fixes: 90e7e7f5ef3f ("mm: enable MADV_DONTNEED for hugetlb mappings")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Cc: <stable@vger.kernel.org>

Why exactly do we care about stable backports here? What's the 
user-visible impact?

-- 
Thanks,

David / dhildenb

