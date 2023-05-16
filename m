Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C67704BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjEPLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjEPLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574B7D94
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684235168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cffqgY240u6LKhQiohGL7llXzs3YEJD7Cg0tf+vxCaM=;
        b=OhQ1obOw3rykwQW9wW0fjL/ZJgDQtWccLQmSZLxIjDVLXBAdwUHsZp2Z/RsQCiOSCjky3j
        VChE17bIzDlAutV8spRM8/rbMG92rr/Fk2ko9OVMXwPwkVytf5m8KxaN1ookzehinUL5eL
        ym2gs9/2OHlylqa4FzVK30vrVURd+SI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-SZVILWIdOp-7ksl196chbw-1; Tue, 16 May 2023 07:06:07 -0400
X-MC-Unique: SZVILWIdOp-7ksl196chbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3062dedf7d9so8354547f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235165; x=1686827165;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cffqgY240u6LKhQiohGL7llXzs3YEJD7Cg0tf+vxCaM=;
        b=h5rPvcNRXuJi14cZh9eW9bWDulcr46/L7ytW0xG6u2kUYEk6DhXtDlXKKHM+2xUgrn
         QOwx1IymP5wZinyVuGpxCtl/DeoJSRY/JsxkFkniSMcf1PJDlNdBXr1KZxBvhtkBrqbY
         UKazNIir8y0a6FQukbOzVBld5uEfidHXVCDxQtCGC1Vj3tbCChVNnjkK2hUS/DhSbRwJ
         nl/8p4d+oeaMY+I8bSBXzwzybwwVZaQk9O1sjc2Jc3JAzhPz0cYvOzoDxb35GeTWMy66
         zWtPwTbyUSWnXaaxDVnRPN9QNY6k2/vjhUzlsEO4L6p6htxz0E/SkHVCztdpISc4jMvd
         MFFA==
X-Gm-Message-State: AC+VfDzSuBwjVx7ojN8yxPzBcN9xIHo1oSo7XHzi4zv/bCXYFG7CXRxd
        sIA3+Uofsdr63t6UqAgIpfEm/8ssyvswp7YnrkjZ4QaEqZ5PNkcVlcmZjqOhWZjWFmPFCSwks/G
        2UPdt1VlyoI1ynmcstvzlZ9Ba
X-Received: by 2002:adf:e547:0:b0:2e4:bfa0:8c30 with SMTP id z7-20020adfe547000000b002e4bfa08c30mr27781219wrm.47.1684235165595;
        Tue, 16 May 2023 04:06:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4K9rbW0popZUr4vxTzQqMSMKba7jC9OqdpcSblcqHA+87lbMWIehFQ7VRpuGfRuPp2LzRt5Q==
X-Received: by 2002:adf:e547:0:b0:2e4:bfa0:8c30 with SMTP id z7-20020adfe547000000b002e4bfa08c30mr27781204wrm.47.1684235165222;
        Tue, 16 May 2023 04:06:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id y12-20020a5d614c000000b003062c609115sm2222988wrt.21.2023.05.16.04.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:06:04 -0700 (PDT)
Message-ID: <d1b054d0-d083-d35c-e547-7e8756fd802a@redhat.com>
Date:   Tue, 16 May 2023 13:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] swap: cleanup get/put_swap_device usage
Content-Language: en-US
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>
References: <20230516052957.175432-1-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230516052957.175432-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 07:29, Huang Ying wrote:
> The general rule to use a swap entry is as follows.
> 
> When we get a swap entry, if there isn't some other way to prevent
> swapoff, such as page lock for swap cache, page table lock, etc., the
> swap entry may become invalid because of swapoff.  Then, we need to
> enclose all swap related functions with get_swap_device() and
> put_swap_device(), unless the swap functions call
> get/put_swap_device() by themselves.
> 
> Add the rule as comments of get_swap_device(), and cleanup some
> functions which call get/put_swap_device().
> 
> 1. Enlarge the get/put_swap_device() protection range in
> __read_swap_cache_async().  This makes the function a little easier to
> be understood because we don't need to consider swapoff.  And this
> makes it possible to remove get/put_swap_device() calling in some
> function called by __read_swap_cache_async().
> 
> 2. Remove get/put_swap_device() in __swap_count().  Which is call in
> do_swap_page() only, which encloses the call with get/put_swap_device()
> already.
> 
> 3. Remove get/put_swap_device() in __swp_swapcount().  Which is call
> in __read_swap_cache_async() only, which encloses the call with
> get/put_swap_device() already.
> 
> 4. Remove get/put_swap_device() in __swap_duplicate(). Which is called
> by
> 
> - swap_shmem_alloc(): the swap cache is locked.
> 
> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
> swap_duplicate(): the page table lock is held.
> 
> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
> get/put_swap_device() already.
> 
> Other get/put_swap_device() usages are checked too.

I suggest splitting this patch up into logical pieces as outlined here 
by you already.

-- 
Thanks,

David / dhildenb

