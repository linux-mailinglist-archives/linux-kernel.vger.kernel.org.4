Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21D4730456
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbjFNP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjFNP6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9411721
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686758266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBEkKn5fELdXle4Y33cuC2dwRJcYuUrgCYNnAHpQ2ZE=;
        b=XPY5paQ2q8RltU1/4zZzWoImwjKXBt3avg50FVXy+hqZWx8O7ovgoaYx85q7WzkOqDk8UO
        W2uYkkzGq/brzcBkN6Oqma9glm+3NQvVs90bgSaAi4YRN75EplJW9ZHc0ELOjsLL1Q60or
        6+0UIyCD3dYDxz8hm/EPZizELZ43B+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-DIzVLYT1Ok2cSjtIHRGVdg-1; Wed, 14 Jun 2023 11:57:44 -0400
X-MC-Unique: DIzVLYT1Ok2cSjtIHRGVdg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f81bdf4716so4103145e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758263; x=1689350263;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBEkKn5fELdXle4Y33cuC2dwRJcYuUrgCYNnAHpQ2ZE=;
        b=DWTli3whBscxPB3fyMl+D4PXBP7VcAF8mVjBC0TvTgBScZ6649YQHEbiZ/TaklrQvr
         Qh4tKT4sZyV+dHdLy01ctYlTG6Un+giujBKwfKvagPiTTNlR7zXr7WGoXOZYvnLfHx0f
         PxsLTzR6ZwMSApZp3dWb6CJyTNHIvsSpvj5GgT4kTmdD/EVXRYcPB0kUQcpnCB4j+/k4
         9RwzpngBXDSd7A/XSq+SPtU+j2+xv0rY0Jw6W0AF7m+GN8sMH9/xZnLxhaApkxUZilgI
         SK8FydWMxZfc8ID6dIUWDlg7DHKkKIGYCQsnelc4Wrb2UxAgPDUENKm+2m3eMGOtVmoe
         EP+A==
X-Gm-Message-State: AC+VfDxlnjcNc+7yvmON+JHJ8J8FoH9BQ2jxoP0xKXXd+rMDeLk1jdnM
        VmHVs7QVAXJF0uRSa85NQotkh2tv3ANBPZ1pyZrYvT92VSjbES93u6Aczw+JcFuxTW+2++nJ5w+
        u0q9aHIeD3rOuyH57/OGJZEPU
X-Received: by 2002:a05:600c:4f96:b0:3f7:f302:161 with SMTP id n22-20020a05600c4f9600b003f7f3020161mr1999673wmq.8.1686758263554;
        Wed, 14 Jun 2023 08:57:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53Um/PvnitZJvGvInqSSXPNb7PBP0CKxlPpICpz1jpz3DwV4ttJBoSmVIIf0i8BB9A0MPD2Q==
X-Received: by 2002:a05:600c:4f96:b0:3f7:f302:161 with SMTP id n22-20020a05600c4f9600b003f7f3020161mr1999658wmq.8.1686758263212;
        Wed, 14 Jun 2023 08:57:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm17926102wma.24.2023.06.14.08.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 08:57:42 -0700 (PDT)
Message-ID: <ec8d0f27-a3e8-3b93-6703-9935e009ceb2@redhat.com>
Date:   Wed, 14 Jun 2023 17:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/7] mm/hugetlb: Fix hugetlb_follow_page_mask() on
 permission checks
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-3-peterx@redhat.com>
 <24bc512a-b5c2-b7ea-fa83-5752cec7455b@redhat.com> <ZIng1SQ0xZ+eBua8@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZIng1SQ0xZ+eBua8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 17:46, Peter Xu wrote:
> On Wed, Jun 14, 2023 at 05:31:36PM +0200, David Hildenbrand wrote:
>> On 13.06.23 23:53, Peter Xu wrote:
>>> It seems hugetlb_follow_page_mask() was missing permission checks.  For
>>> example, one follow_page() can get the hugetlb page with FOLL_WRITE even if
>>> the page is read-only.
>>
>> I'm curious if there even is a follow_page() user that operates on hugetlb
>> ...
>>
>> s390x secure storage does not apply to hugetlb IIRC.
> 
> You're the expert, so I'll rely on you. :)
> 

Hehe, there is a comment in gmap_destroy_page(), above one of the 
follow_page() users:

	/*
	 * Huge pages should not be able to become secure
	 */
	if (is_vm_hugetlb_page(vma))
		goto out;


-- 
Cheers,

David / dhildenb

