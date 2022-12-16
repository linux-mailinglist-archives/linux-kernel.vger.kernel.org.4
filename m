Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA6564EEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiLPQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiLPQNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B13C29A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671207138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXgTNglDwNw3QzRYt0nVKdXtcIWSnTSnLY/hNQFklA8=;
        b=ZBGAJtR3jO7bLgW1cFl+Z76pfJtR6QRWAOJSJlg/Jy+ZfPXKQdWvPPPHTFE7Qajkub4Cmt
        c3zLq1eUmokI9IUul2RSSRtJ6Qda+HbHXtnVzXjlA+ySokFpIwN5b1BGa7ZShlqGPFaexm
        2XMs5ABRojUN8XCLqT0bX23/iszXKFY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-qWHA3TLVOJ6Qa7KAGsM7Ag-1; Fri, 16 Dec 2022 11:12:15 -0500
X-MC-Unique: qWHA3TLVOJ6Qa7KAGsM7Ag-1
Received: by mail-wr1-f70.google.com with SMTP id r10-20020adfa14a000000b0025ba73dff40so450496wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXgTNglDwNw3QzRYt0nVKdXtcIWSnTSnLY/hNQFklA8=;
        b=se/rSjbWpZPvGEiGOROrVz04WNBwHApFP74Bn1+n0o7bRZyTbtO9r5JfeYL3s94fSe
         4a5NHA2Uwh887m15xAQiMHHBX2ZUgKgoXiN+tuKwNtHLMIovAPX0inIXaFYUY7XCNr2q
         OLWdCKo4Pd0Pu+0YPPYkuSJ7zWvbT9rGckcejrle9rW6h4m/1hinSKgXMZ8tStHmmJXF
         CsN1Ev3H8bO93L7wdTn03D4Tbfjpd5e6DZoO/3Xx0E4eeG33kcVleuC0xWcJO/6Hownf
         MISTobK01KTzaaQ0vhK4IxcrZ0fhJtTXlzTexaClpieqAkFW1q4CU+BWge8yOMV0pdnq
         JnwQ==
X-Gm-Message-State: ANoB5plFOBjqHcxTBJxBZVtBhE+ow893EdSumA/W4DqkM1z0TA8KMgSl
        4MduB7ljFBSh6pFGuUspYGVyvTtMS7jmGEPwKpHSzBHtIub5pUsRrZ2KI4wu2qtsfgIyTAs9vgS
        jGvbamBq6phKkhBE9IUzzC67J
X-Received: by 2002:a05:600c:3d12:b0:3cf:7903:5646 with SMTP id bh18-20020a05600c3d1200b003cf79035646mr26187482wmb.24.1671207134415;
        Fri, 16 Dec 2022 08:12:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6BgraJ7ZC9QDnyV4jiSVGe5oF3oq7KBvgD7xPmW94b3HB58zDKJ25FA8Jg3t/JBZCZA8FMbA==
X-Received: by 2002:a05:600c:3d12:b0:3cf:7903:5646 with SMTP id bh18-20020a05600c3d1200b003cf79035646mr26187462wmb.24.1671207134189;
        Fri, 16 Dec 2022 08:12:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:3900:7211:d436:8d8b:531c? (p200300cbc71c39007211d4368d8b531c.dip0.t-ipconnect.de. [2003:cb:c71c:3900:7211:d436:8d8b:531c])
        by smtp.gmail.com with ESMTPSA id m22-20020a05600c3b1600b003cfd4cf0761sm11944714wms.1.2022.12.16.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 08:12:13 -0800 (PST)
Message-ID: <0616b909-b851-0f00-2bd9-f86562af6342@redhat.com>
Date:   Fri, 16 Dec 2022 17:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 9/9] mm/hugetlb: Introduce hugetlb_walk()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jann Horn <jannh@google.com>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221216155100.2043537-1-peterx@redhat.com>
 <20221216155229.2043750-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221216155229.2043750-1-peterx@redhat.com>
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

On 16.12.22 16:52, Peter Xu wrote:
> huge_pte_offset() is the main walker function for hugetlb pgtables.  The
> name is not really representing what it does, though.
> 
> Instead of renaming it, introduce a wrapper function called hugetlb_walk()
> which will use huge_pte_offset() inside.  Assert on the locks when walking
> the pgtable.
> 
> Note, the vma lock assertion will be a no-op for private mappings.
> 
> Document the last special case in the page_vma_mapped_walk() path where we
> don't need any more lock to call hugetlb_walk().

That looks cleaner and the lock assertions are IMHO a very good idea.

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

