Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404F17070CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEQSdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3659F6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684348375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWirlWWlCUUsr8UZmipN+8l7jgoXYLY/EkGHRTVlLyg=;
        b=AUqKf/wETCEoQbjE0lxx0heW/SsCaH5rx1URufID57Ir/u6uPP5x5QZG2jd/iLcdKDLVZw
        OJotl4HwYeN2x5cWglT+ETsSHCHFSON7NLStiscaacuytDsyXHu++FDw9XXIoNpnsXT/Rl
        XQAIg4h1ArnNBZ9o8IwFlCkrjsuXqH8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-3V2wh-1BNrG6c420O4UTYw-1; Wed, 17 May 2023 14:32:54 -0400
X-MC-Unique: 3V2wh-1BNrG6c420O4UTYw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3062dedf7d9so786191f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684348373; x=1686940373;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWirlWWlCUUsr8UZmipN+8l7jgoXYLY/EkGHRTVlLyg=;
        b=bLnN0d8IFiyq8yKsXXQIXHGw4p09LCAEAsTC8aunPmoUdn02Q+bC0W7ua+kO6Q0+9L
         Loe1dVE9/QEGk42V/YIqpco2mnimyDjGCgkHAKO8jK9pG8Whiw4pee4fBOfhe6L6cRHv
         tntXQJ/VwcF8JeFozyP/Of1NHKSvJAZG41NpaSNVH5tLe6FOaQP4/+xL4MS/Xcq+qpVz
         o8oRqtpac1k2qDsiR6jQWhfJui8PkyDatPuLpZlxsKK++/PYwDL0NiRtKgI5o9ubC47F
         FvK8KAt8P4RLvA+YYzz2Os5T5xjmGAakyfsSQjK+Kw2WLwijIGIYFqMnFpQEZf3SK2zE
         bHrg==
X-Gm-Message-State: AC+VfDwq2eFpuu37Mhgmy3x+gO3nfTHZz42MtvjRlvKg7YMl1nRz1BNW
        JX8iepFp7tIE0u2vhm8q7nS07GlDWoM8oRuyQ94isfPeEpMf8CkCKCDYcIBgMZnIFPKtI9zfInN
        qBTOMDpn9qN/Zw/51GPeGkeYmry4s5qDe
X-Received: by 2002:a05:6000:1b02:b0:306:32fa:6750 with SMTP id f2-20020a0560001b0200b0030632fa6750mr1586268wrz.33.1684348373176;
        Wed, 17 May 2023 11:32:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pxxZHXbgxjBtssu1Seqb0hRfntY6UXqemn9lgw482zixUcCJCgZXrri/08JLB/NFvO0TxuQ==
X-Received: by 2002:a05:6000:1b02:b0:306:32fa:6750 with SMTP id f2-20020a0560001b0200b0030632fa6750mr1586259wrz.33.1684348372847;
        Wed, 17 May 2023 11:32:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3900:757e:83f8:a99d:41ae? (p200300cbc7073900757e83f8a99d41ae.dip0.t-ipconnect.de. [2003:cb:c707:3900:757e:83f8:a99d:41ae])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003f19b3d89e9sm2903695wmc.33.2023.05.17.11.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:32:52 -0700 (PDT)
Message-ID: <c34e3768-8a01-d155-1970-8eada8c80ba7@redhat.com>
Date:   Wed, 17 May 2023 20:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, steven.sistare@oracle.com,
        ying.huang@intel.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
In-Reply-To: <20230517161555.84776-1-khalid.aziz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.23 18:15, Khalid Aziz wrote:
> Pages pinned in memory through extra refcounts can not be migrated.
> Currently as isolate_migratepages_block() scans pages for
> compaction, it skips any pinned anonymous pages. All non-migratable
> pages should be skipped and not just the anonymous pinned pages.
> This patch adds a check for extra refcounts on a page to determine
> if the page can be migrated.  This was seen as a real issue on a
> customer workload where a large number of pages were pinned by vfio
> on the host and any attempts to allocate hugepages resulted in
> significant amount of cpu time spent in either direct compaction or
> in kcompactd scanning vfio pinned pages over and over again that can
> not be migrated.

How will this change affect alloc_contig_range(), such as used for CMA 
allocations or virtio-mem? alloc_contig_range() ends up calling 
isolate_migratepages_range() -> isolate_migratepages_block().

We don't want to fail early in case there is a short-term pin that might 
go away any moment after we isolated ... that will make the situation 
worse for these use cases, especially if MIGRATE_CMA or ZONE_MOVABLE is 
involved.

-- 
Thanks,

David / dhildenb

