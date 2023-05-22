Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF970BCE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjEVMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjEVMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36919B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684757170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuXWj6x5wwVD+5iQQsnKFnyHh9i2kfkjkc5BqJvFz/A=;
        b=SXcJrOx5fYFi8S/7LAymcj05hcg5MnJIpfkK35xKLwL9+Jnh0rkAF3SNZBnCdg/nTSMpN1
        CdGMTRiwP6QQz+RYjJY0alre9PGwtHARAji8YWm1IvrHUfoHRrD6bC8kV8k1Gf8phr2icp
        eij7YCjkIUnVB+OXTCWK7PGbN2Q+O4c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-PuElw12aPaKqNtDfpZRe7g-1; Mon, 22 May 2023 08:06:08 -0400
X-MC-Unique: PuElw12aPaKqNtDfpZRe7g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-309579be13cso1842307f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684757167; x=1687349167;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuXWj6x5wwVD+5iQQsnKFnyHh9i2kfkjkc5BqJvFz/A=;
        b=UYSinreo5tn1mNODixCbIOxCEzxeruz9mbJuIE2qs5996C/lqiCAY7FydlfXRmfFUc
         vog72QHCL/LgZcVenrqyYTezxiH0Zib6FnRPJ199mHX5RjdMTI8bqDki/4Phh0mY/qtq
         6tkIGnQUIanPL6xaQp2IfUPPJKiyPR4iI9tHBPiDG/RKv1ZJhZJClhEhbK5DkVaP8Fnq
         r9d6LS6n3Bniyv5HPbCszbcj3SiTa9+ySeYqqQlatm6NUBHcjpEYcD0VjIPKFmdffMfC
         LC7EzqoveLd7OxWMk+7valEM5cXEl5twWBNPVzxfInmaokQmp1xU1GaiUZpJ+5QJ35h0
         N6AQ==
X-Gm-Message-State: AC+VfDwnhc3BqiSKUSBRqlSoE0D5/pZv8F+3YAThtOShq9c90zzqTa0L
        h2KmgRO8NGrQAHwkAsskWWqnuh1KdMt00HJ+ZX0XEGoBHb1f8SdtWrtNvYipAOZSSkRptbecXiz
        fUORhq1qLI5pOj/fBifWxcURg
X-Received: by 2002:a5d:590c:0:b0:306:2c5b:9da6 with SMTP id v12-20020a5d590c000000b003062c5b9da6mr6347441wrd.56.1684757167252;
        Mon, 22 May 2023 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Ss4E8BoZe344FBKqcpTBeR0JGtUNN3AchR0PtaG/dWQhjUMQZUW7Jg3YDVmcSBsuE4mBbpg==
X-Received: by 2002:a5d:590c:0:b0:306:2c5b:9da6 with SMTP id v12-20020a5d590c000000b003062c5b9da6mr6347422wrd.56.1684757166933;
        Mon, 22 May 2023 05:06:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558? (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de. [2003:cb:c742:c800:d74f:aec6:f8ac:558])
        by smtp.gmail.com with ESMTPSA id w4-20020adfee44000000b0030785b864f1sm7529723wro.65.2023.05.22.05.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 05:06:06 -0700 (PDT)
Message-ID: <9cbd93e0-721a-01c2-14dd-87f89363a830@redhat.com>
Date:   Mon, 22 May 2023 14:06:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -V2 4/5] swap: remove get/put_swap_device() in
 __swap_duplicate()
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
References: <20230522070905.16773-1-ying.huang@intel.com>
 <20230522070905.16773-5-ying.huang@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522070905.16773-5-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 09:09, Huang Ying wrote:
> __swap_duplicate() is called by
> 
> - swap_shmem_alloc(): the page lock of the swap cache is held.

page lock of the swap cache? Did you really mean to say that or am I 
confused?

"Page lock of the page that is in the swap cache?"

> 
> - copy_nonpresent_pte() -> swap_duplicate() and try_to_unmap_one() ->
>    swap_duplicate(): the page table lock is held.
> 
> - __read_swap_cache_async() -> swapcache_prepare(): enclosed with
>    get/put_swap_device() in __read_swap_cache_async() already.
> 
> So, it's safe to remove get/put_swap_device() in __swap_duplicate().



-- 
Thanks,

David / dhildenb

