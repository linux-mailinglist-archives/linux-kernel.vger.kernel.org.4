Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA91763BC03
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiK2Ito (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiK2Ith (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F038F24BCD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669711719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9/SG262uJs5aEn47977HgvoOkAGZaXesrmlGYL/QQU=;
        b=TRUplZ8JiMKfzb4Bc04YLrOyZbdADW/mzTd3ypL8o6Ck350NukTBLh+Ot4ffwSs8sCvA8Y
        xqdqKD3HkWgI+XVwWGSNFok9uKLvqdvaPxwB52tFiggUwNFsVNkZeE4d7tCDB7mYzpGkGT
        oQW14tfDht7LYRQhV9icYzLgV3epDCI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-I5tml8qPOT2mmeUzhLRDAw-1; Tue, 29 Nov 2022 03:48:37 -0500
X-MC-Unique: I5tml8qPOT2mmeUzhLRDAw-1
Received: by mail-wm1-f69.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso9880828wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9/SG262uJs5aEn47977HgvoOkAGZaXesrmlGYL/QQU=;
        b=6EiD9ESPa1jl8AkKOsykNips37T14mAWBnudsG+ZXk8jQoAShoeSSj1EpteCO915nC
         iAVcvo7xRf7XJNJxB3wkpn+4YwzNtxo6r0+4Wjysg0yLA5fOknwYofS3kA/X1h4yaMTM
         W/AB/Vy6zeEfQiP42vZNJGswlpXPKBJSALX8p2mHuB3d3ohmoKRJzmnSUo0WCWuuFpev
         N4ffp83A+foC8nHNFPxEP04IDGqrngqHfz3DFvqqf22XpMcw+b9UlTeQIfGS/0BI8p6X
         niVHczMbdImauWDywyOO3RKWiFnVNtVSFbZXooIspJe54+3m/xIZw+NqCgsOTaFexjKz
         f9gw==
X-Gm-Message-State: ANoB5pl03FVRJLA4DK4zL/ZYv9/IsenIJWDb/c9DzZH92BCFOM+uaXaA
        DAe4KejjbTuCtLL7GNyeoBQqOP6IVxWdZSOq37HAc3kFPvAYx8zKf27USZ0oENEWoCM58cscyR9
        Tv20897X2V7CtEjl9zk/NpgUb
X-Received: by 2002:adf:ed86:0:b0:236:4930:2468 with SMTP id c6-20020adfed86000000b0023649302468mr27266638wro.221.1669711716560;
        Tue, 29 Nov 2022 00:48:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5WObKFiHoIvjAvSDGoBWk7nZS9J8pydo8v+yQ7WbXm3jibFRxv0v14chgZsAxfMxQqYFXPxw==
X-Received: by 2002:adf:ed86:0:b0:236:4930:2468 with SMTP id c6-20020adfed86000000b0023649302468mr27266600wro.221.1669711716176;
        Tue, 29 Nov 2022 00:48:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:ca00:3fb8:c253:3bf7:b60e? (p200300cbc705ca003fb8c2533bf7b60e.dip0.t-ipconnect.de. [2003:cb:c705:ca00:3fb8:c253:3bf7:b60e])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b00225307f43fbsm13057331wrw.44.2022.11.29.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:48:35 -0800 (PST)
Message-ID: <22b1107b-0acc-5772-a883-8f3c4682eb1b@redhat.com>
Date:   Tue, 29 Nov 2022 09:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH mm-unstable v1 16/20] mm/frame-vector: remove FOLL_FORCE
 usage
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-17-david@redhat.com>
 <81fb0fa3-2e06-b765-56ac-a7d981194e59@redhat.com>
 <08b65ac6-6786-1080-18f8-d2be109c85fc@xs4all.nl>
 <9d0bf98a-3d6a-1082-e992-1338e1525935@redhat.com>
 <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221128145927.df895bf1966cfa125cae9668@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.22 23:59, Andrew Morton wrote:
> On Mon, 28 Nov 2022 09:18:47 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>>> Less chances of things going wrong that way.
>>>
>>> Just mention in the v2 cover letter that the first patch was added to
>>> make it easy to backport that fix without being hampered by merge
>>> conflicts if it was added after your frame_vector.c patch.
>>
>> Yes, that's the way I would naturally do, it, however, Andrew prefers
>> delta updates for minor changes.
>>
>> @Andrew, whatever you prefer!
> 
> I'm inclined to let things sit as they are.  Cross-tree conflicts
> happen, and Linus handles them.  I'll flag this (very simple) conflict
> in the pull request, if MM merges second.  If v4l merges second then
> hopefully they will do the same.  But this one is so simple that Linus
> hardly needs our help.
> 
> But Linus won't be editing changelogs so that the changelog makes more
> sense after both trees are joined.  I'm inclined to let the changelog
> sit as it is as well.

Works for me. Thanks Andrew!

-- 
Thanks,

David / dhildenb

