Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83165717891
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjEaHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjEaHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:46:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE17113
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685519164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KADJzQt78DjOkhXJxElYzWhBohOxFMyWxYB3IAT5tK8=;
        b=HrJ3+fDGRF6jqQYJMJVGd14Al3lgfahg2/ShUvLyIPadTg6/AXbntVTm9ThbA4Zni/4rv1
        AI/sEs2RrHdZ+1b+hK7zBW3tD1NCnyxA+9tjNJUJvGFTHhVQR3DnsOE3b39X5B5CBtdzzE
        EFdr+825XnDIXUudlcuM1rxF7AaF9p8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-BYHoI8llMCWSITXbVhg6bA-1; Wed, 31 May 2023 03:46:02 -0400
X-MC-Unique: BYHoI8llMCWSITXbVhg6bA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6ffc45209so3054075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685519161; x=1688111161;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KADJzQt78DjOkhXJxElYzWhBohOxFMyWxYB3IAT5tK8=;
        b=BXonbafMXtnqueZZkdEq5+u/t70P1L21RqFDMcIdrgAd6MbK1dosjLcG3RG+X5NcFL
         j2BuNn1wZ22nkOomRodYxKtRpcew/K2AqXWHks8XRlQZb6EhNmnpJd3r+ONbeE4uQaq7
         FJconZEbaDzLfPxCiLIDtIVVR64mxyD8fkxom5FJ2O3ot9WYIqBZnq8/fUt0jHlea0Xs
         aLQzUwkwLZfmyk9+XPQbJAlcedNN1ughF7XM1iepg9fmpapItQ+12nJFi3LWJIaAwbtX
         PJIy5+5acQdi1YBwOg6vnO4xgxNJNZyEwoRjWjFDDQ6aSJ7OiWLaZue5FQG7xm3dauXn
         liFA==
X-Gm-Message-State: AC+VfDwYtHX0MhUQFKwpfst73iF5DX1J9NONZbehKT+mi69qClgMpyeU
        ocQ8PzCQQs6A3erm1f578S8PQ+vDYvjKDibcG94j+XXWX71WqrmVUdBfd9QV9+xO6tFXdpbugcA
        V+yvI6GWml8boBkAkzpvoUMFI
X-Received: by 2002:a1c:f706:0:b0:3f7:5e1:f3fd with SMTP id v6-20020a1cf706000000b003f705e1f3fdmr3625240wmh.5.1685519161760;
        Wed, 31 May 2023 00:46:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ436UU61NczDYH9UaXW/YOC3HPN9Gmy77aR6LZ58EoWnnluA/iJOcFIqaN4LScHpULaPFgovQ==
X-Received: by 2002:a1c:f706:0:b0:3f7:5e1:f3fd with SMTP id v6-20020a1cf706000000b003f705e1f3fdmr3625231wmh.5.1685519161408;
        Wed, 31 May 2023 00:46:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:cb00:fc9f:d303:d4cc:9f26? (p200300cbc749cb00fc9fd303d4cc9f26.dip0.t-ipconnect.de. [2003:cb:c749:cb00:fc9f:d303:d4cc:9f26])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003f4ebeaa970sm19755583wml.25.2023.05.31.00.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:46:01 -0700 (PDT)
Message-ID: <465c83f4-10c1-b025-cae7-04e5ff5f7561@redhat.com>
Date:   Wed, 31 May 2023 09:45:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V3 3/5] swap: remove __swp_swapcount()
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
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Chris Li <chrisl@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
References: <20230529061355.125791-1-ying.huang@intel.com>
 <20230529061355.125791-4-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230529061355.125791-4-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.23 08:13, Huang Ying wrote:
> __swp_swapcount() just encloses the calling to swap_swapcount() with
> get/put_swap_device().  It is called in __read_swap_cache_async()
> only, which encloses the calling with get/put_swap_device() already.
> So, __read_swap_cache_async() can call swap_swapcount() directly.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

