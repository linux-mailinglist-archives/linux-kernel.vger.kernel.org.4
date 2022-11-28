Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553163B127
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiK1SW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiK1SWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:22:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A42494A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669658888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yI2lsl64MrMPLmal/4OD6FwI+XLJK3nNMXWiQLT1Jqw=;
        b=HMa9n6nZw0qpNGTpZqZXnIgglYVt9zaIoLZJ491ueTXkCDBDwaCZ13l2XQUVJNXXcc5bue
        K4LljMt3ErgDq+xkosfhm4q+2dItajteadgzJ3mnaUUthBUUGHOLgeya20RdRkjNnBugmb
        xpI8vWEqgWLqkMCMzRKjK5Gu4M3Jt48=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-kqJduKCcNHqDGbOHcS1u9g-1; Mon, 28 Nov 2022 13:08:06 -0500
X-MC-Unique: kqJduKCcNHqDGbOHcS1u9g-1
Received: by mail-wr1-f71.google.com with SMTP id v2-20020adfa1c2000000b002420d780a32so1212746wrv.14
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI2lsl64MrMPLmal/4OD6FwI+XLJK3nNMXWiQLT1Jqw=;
        b=sknINeqUm4sOlflvjZvh9jVeWEDtRtqvzrsSzFoRzd5RD/5dZVRtZQ+zZnRVoGJ94e
         hh+I03K1Lh2kxt2vB7jv9P/IixjbzhQhR2TeoA5Gu75EDp1QWeig0JmxTAjzxVqI50by
         xOWSWkH1A1XM/TjaSyYeZ8+0V8Neyn9jsy0mmC7CNC4B4Sm34oT46faGJEGeqZMEOuwX
         uC07/HCsSt3mU/uq7KaeEQLAW6xLnChfIq/GJPHqfe4GaEnC5mcc+JgrOYlo1a5Raeeg
         yaMrH1KHRF49e8bvm0iem7H4GcnBNAuUfjpjLAVO+WLNpop9KKmIGUoiYV8RSft8eueF
         EMlQ==
X-Gm-Message-State: ANoB5plLy55AYccWS6M974r8cF3hpKUSuL9SsLg5bHHAx0b3fd8j8ZkU
        oNb4fY/H7zzmqB3zO3hdGqDhvV0/M+ekoLDsrzY2f/BXHWFUMf8NGdLhXSyw6h2C1cozop4l2Yd
        QiULNc/O0EGSKjuRSlsGI9npg
X-Received: by 2002:a5d:4fc6:0:b0:236:84b5:b039 with SMTP id h6-20020a5d4fc6000000b0023684b5b039mr32459785wrw.411.1669658885495;
        Mon, 28 Nov 2022 10:08:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5PfclJpDOqqhzg0sSU9jZLgacXx1x55ckr6K2eNBuU5r6lDcL8O09WxxAR6aI4jWSnvUS8RA==
X-Received: by 2002:a5d:4fc6:0:b0:236:84b5:b039 with SMTP id h6-20020a5d4fc6000000b0023684b5b039mr32459749wrw.411.1669658885174;
        Mon, 28 Nov 2022 10:08:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c4e4500b003b492753826sm15354156wmq.43.2022.11.28.10.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 10:08:04 -0800 (PST)
Message-ID: <b07f70ee-fa2e-387d-fb69-64b2607c387f@redhat.com>
Date:   Mon, 28 Nov 2022 19:08:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 3/3] mm/khugepaged: Invoke MMU notifiers in shmem/file
 collapse paths
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, security@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221128180252.1684965-1-jannh@google.com>
 <20221128180252.1684965-3-jannh@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221128180252.1684965-3-jannh@google.com>
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

On 28.11.22 19:02, Jann Horn wrote:
> Any codepath that zaps page table entries must invoke MMU notifiers to
> ensure that secondary MMUs (like KVM) don't keep accessing pages which
> aren't mapped anymore. Secondary MMUs don't hold their own references to
> pages that are mirrored over, so failing to notify them can lead to page
> use-after-free.
> 
> I'm marking this as addressing an issue introduced in commit f3f0e1d2150b
> ("khugepaged: add support of collapse for tmpfs/shmem pages"), but most of
> the security impact of this only came in commit 27e1f8273113 ("khugepaged:
> enable collapse pmd for pte-mapped THP"), which actually omitted flushes
> for the removal of present PTEs, not just for the removal of empty page
> tables.
> 
> Cc: stable@kernel.org
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

