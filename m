Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE06D43E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjDCL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30154691
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680523089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OVIwWquixww+JFF4EZop7Ld7XWMwZqHJw07biyoMhrs=;
        b=D5fF3joTCY0fkbdaP27EX0/SkQL1BTwWcuz5aCesP0xdQERYv41LhhkrW2mHIVRTd3AxXz
        PybsCgkuCluNKcYAbwQp1xAr2ErDw8/P22ladIbwGG1BIWMJ2d7bVUZkDTTSdIv68WVMgs
        4A+mWnFEFd6s4Wy6HX1tEh2AeEim+Lo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-3RS8N5dZNcqfRxHCExDAiQ-1; Mon, 03 Apr 2023 07:58:08 -0400
X-MC-Unique: 3RS8N5dZNcqfRxHCExDAiQ-1
Received: by mail-wm1-f70.google.com with SMTP id m27-20020a05600c3b1b00b003ee502f1b16so14420374wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680523087;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVIwWquixww+JFF4EZop7Ld7XWMwZqHJw07biyoMhrs=;
        b=xpKO1KSwzBjdqWtJqxQPyrTAXbCYcUOetLk6XztSRS15y31nzjsLklOAXsfxSGpXUe
         lTyDdVF6tGyGlIMC5FvLANTI5igjCOcHdIMfBoWocRqwUx3l4jmeOxE//im58Ds/zCkQ
         Q/2SQO4Y7SIbBuYY6/QaU0vXYk1b0OfGWUJufq1Tba4rZZy1OF9rVM7wszoO4xPeDD5P
         3yiXPQyK/xH57g5rIKTJ+IhBM3+EASdDMjlY8T48DSXmDTajyn7jHFPvM9G3pQ2CZMF/
         OY9jFUijW/wvcxnMDMY97uqAnH1aj8WpLZE9yd88fcf5TgyzLxy4WAk+7zePsNBF///O
         nneA==
X-Gm-Message-State: AAQBX9dvJ7P29QP4iWJJFX3sQ48GBfvd0QwpSPIcDUk9treC+MpiriOu
        vm8uQNEYXRpmEYLXK1sL+C+qFiYZffUYPivajgJS8mCVeS/KKOXlDgyJz8dntfAJgszF7TQSNnB
        NGIDJhFd2A9TuC3fJurLmPYWq
X-Received: by 2002:a7b:c4c3:0:b0:3f0:3d47:2cbe with SMTP id g3-20020a7bc4c3000000b003f03d472cbemr9925361wmk.10.1680523086945;
        Mon, 03 Apr 2023 04:58:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350auUP6YlKdUMeXPodnB2zUsvo68kS9KkPE7VXHPKr8F7AMGTQxl3KOOakGGn6pcXGVH/lLRFw==
X-Received: by 2002:a7b:c4c3:0:b0:3f0:3d47:2cbe with SMTP id g3-20020a7bc4c3000000b003f03d472cbemr9925348wmk.10.1680523086654;
        Mon, 03 Apr 2023 04:58:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003ee1e07a14asm19260533wmq.45.2023.04.03.04.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 04:58:05 -0700 (PDT)
Message-ID: <cba955a3-e41e-adce-954a-9a55d6d97065@redhat.com>
Date:   Mon, 3 Apr 2023 13:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     stsp <stsp2@yandex.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org,
        =?UTF-8?Q?Jakub_Mat=c4=9bna?= <matenajakub@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <18c36a78-4082-fab6-c7c9-69a249516803@yandex.ru>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: MREMAP_FIXED unmaps dest on error
In-Reply-To: <18c36a78-4082-fab6-c7c9-69a249516803@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 17:48, stsp wrote:
> Hello.
> 
> The attached test-case demonstrates a
> bug in mremap(). If MREMAP_FIXED is used
> over an existing mapping and mremap() fails,
> destination area gets unmapped.
> AFAIK the failed syscall should have no
> observable effects.

I remember that holds for various mapping-related syscalls: if something 
goes wrong, the end result is not guaranteed to be what we had before 
the syscall.

For example, if you use mmap(MAP_FIXED) to replace part of an exiting 
mapping, we first munmap what's there and then try to mmap the new 
mapping. If something goes wrong while doing that, we cannot simple undo 
what we already did.

Long story short: the semantics of these syscalls has never been to 
leave the system in the state as it was before in case anything goes wrong.


As another example, if you do an mprotect() that covers multiple VMAS, 
and there is an issue with the last VMA, all but the last VMA will have 
their permissions changed.

-- 
Thanks,

David / dhildenb

