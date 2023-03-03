Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F096A936D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCCJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCCJL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:11:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8F71814F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677834641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HXI/KwXPhFbkBH6af+6R7enVWQYOnZi8AQZj8HTOjaU=;
        b=A+hERbnKHtn4yv/d0bZhUDNopqXvOwbJaygUJkugst4OsSSHzWtSuhz5q+50VjdMxXoN/d
        9B9qw/IsObnPlgw0fT/IRzlegEFZN52zy+xVlmnAvMV/ghjdgyTwTVZ0KEvumF9la1yaIq
        sFKKeycBYWj3j+mkEINBGwgbaBVNuPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-RuKdtVfxOBOGsGQ1PYYrdg-1; Fri, 03 Mar 2023 04:10:40 -0500
X-MC-Unique: RuKdtVfxOBOGsGQ1PYYrdg-1
Received: by mail-wm1-f71.google.com with SMTP id s18-20020a7bc392000000b003deaf780ab6so728464wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:10:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXI/KwXPhFbkBH6af+6R7enVWQYOnZi8AQZj8HTOjaU=;
        b=U6r/yD4Q0v2k9Ttu4NTX5iT2OeFnlwXS7hC2WDRETL1O1VFXr8RbvKiWJGPKw6ZdBV
         36jGyIZvAicFn1W1ZrAjI2oeTFtTBjR3muh7ijlF6LnJhgIyJtarqn1Hb912+mYqOMZw
         GzADNlxf3iM3eMcxuRa2Am/dfkWdv2x4d8XSQbKkDH7xONz4sGc6IYAHt0q0+2GQ6c1n
         TtmOai4FXbVeJjKh6kUTLSmdQBynJBYbxu+iag25h+IhGv6o+pRNrJKOJtdC8m5LDNZi
         /1eSMTkea18LvBKcmk77Sq13Ot/WUQ78D9LnZVqF6IwckK7Lb3GT8dmONbcLOckBeVNK
         DuIg==
X-Gm-Message-State: AO0yUKVwV3itykyBbU2vwpAKGhFuX15K/nDUhAUgo8r8IlpLd1Bj/jsL
        FdYf9yg46cI3H4ANbmzyWW1nsRZ+O6Y0dtx3Voke3Ek3ME5JEfo3paYhbMvKCkPkmt72may+0p0
        DW+Lx/m0fvC18L3p0SdvUl2/6
X-Received: by 2002:a05:600c:3506:b0:3e2:153e:6940 with SMTP id h6-20020a05600c350600b003e2153e6940mr928705wmq.3.1677834639427;
        Fri, 03 Mar 2023 01:10:39 -0800 (PST)
X-Google-Smtp-Source: AK7set+nfWELVtc6ZcZE0RJVtqWlo1SAKeb38bjkeXY1Tqv3v2p5b+b/BgiTKzEB/8+zsdo8s/cDHQ==
X-Received: by 2002:a05:600c:3506:b0:3e2:153e:6940 with SMTP id h6-20020a05600c350600b003e2153e6940mr928690wmq.3.1677834639084;
        Fri, 03 Mar 2023 01:10:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:6100:f5c9:50a5:3310:d8ac? (p200300cbc7026100f5c950a53310d8ac.dip0.t-ipconnect.de. [2003:cb:c702:6100:f5c9:50a5:3310:d8ac])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003eb2e33f327sm8915498wmc.2.2023.03.03.01.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 01:10:38 -0800 (PST)
Message-ID: <69e08e1c-88f6-bf93-523a-b65ffb9235c5@redhat.com>
Date:   Fri, 3 Mar 2023 10:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: teach mincore_hugetlb about pte markers
Content-Language: en-US
To:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Anish Moorthy <amoorthy@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230302222404.175303-1-jthoughton@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230302222404.175303-1-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.23 23:24, James Houghton wrote:
> By checking huge_pte_none(), we incorrectly classify PTE markers as
> "present". Instead, check huge_pte_none_mostly(), classifying PTE
> markers the same as if the PTE were completely blank.
> 
> PTE markers, unlike other kinds of swap entries, don't reference any
> physical page and don't indicate that a physical page was mapped
> previously. As such, treat them as non-present for the sake of
> mincore().
> 
> Fixes: 5c041f5d1f23 ("mm: teach core mm about pte markers")
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>   mm/mincore.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mincore.c b/mm/mincore.c
> index cd69b9db0081..d359650b0f75 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -33,7 +33,7 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
>   	 * Hugepages under user process are always in RAM and never
>   	 * swapped out, but theoretically it needs to be checked.
>   	 */
> -	present = pte && !huge_pte_none(huge_ptep_get(pte));
> +	present = pte && !huge_pte_none_mostly(huge_ptep_get(pte));
>   	for (; addr != end; vec++, addr += PAGE_SIZE)
>   		*vec = present;
>   	walk->private = vec;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

