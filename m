Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4C611283
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJ1NRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ1NRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6797D4B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666962970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DCIhC8zsshoND/IKtTdIBlXsbzziW2vFBGZp5eT8E28=;
        b=fK14zDOC3Quv0XLAW8rWlL/m+iczHI4t6FB2niZtJKVm5N+KzpxC/br2cRo6bQtMZTmtsk
        7tz37haOTgmT/w4bBqRrtM2ril1l+CO3SXM3FqmU+hMsW4uY0aCt6rbNge9Hj79j6XuGD4
        AwS6AVvCojohYdQhI3m331Vkc4WKKiI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-sPEDBmrDMKyXarkZEuZGPg-1; Fri, 28 Oct 2022 09:16:01 -0400
X-MC-Unique: sPEDBmrDMKyXarkZEuZGPg-1
Received: by mail-il1-f197.google.com with SMTP id x6-20020a056e021ca600b002ffe4b15419so5126661ill.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCIhC8zsshoND/IKtTdIBlXsbzziW2vFBGZp5eT8E28=;
        b=rAYVHbRpZFEoP3Z1utlIOTbY3IdG2SGU7Hp0ImsbLK1xIWhL12B/jTHOA0YpEIXyUJ
         4cESmFau3YOIhxJmGMFM3ZxDzc/vMLlIhY1VHAkeU2GgLSRWZDD4F+SfUhdO997f4c0d
         UcEfLm0BN4OdplCs73/5sB+SOUec6L6PZcqQIZa9MF+6yLtfurQir9ZvZSqCgYtpwT/H
         e7L8cR9aO84RpxRkQp2eVFOnR6S8arkz/Tt5eImD6A6bwYgubHcP5wFkfb2bLeqv8wKm
         pdGiS2WIl5/D1Cp0Q6hw30WCqqXG/VMFn/UcgKYxpLgFpTWixGmS5UoHpfQMttiyh9+A
         kCBQ==
X-Gm-Message-State: ACrzQf2SvSbAvxmN2rcQTzne4G+yaqga8rUJDQYaE36pa1D+T3Dkrg+j
        9QEfg1QlqlropqYqCb/SZ93qRmP/gT1ggVQCzKYeM6whxVHFO871o9NBXRgQkgPzcod4MD2tHKv
        3MTUMaao5tOtWBCoWd5brwN8m
X-Received: by 2002:a05:6e02:1583:b0:2d7:a75d:888f with SMTP id m3-20020a056e02158300b002d7a75d888fmr32576757ilu.13.1666962960214;
        Fri, 28 Oct 2022 06:16:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6Go9xf8PhE/RwBk9BCvHfOp+3vYphyvr54+fn/Xwd77w4wrhKWARDKobHygJ+1ZMb3LmhZFQ==
X-Received: by 2002:a05:6e02:1583:b0:2d7:a75d:888f with SMTP id m3-20020a056e02158300b002d7a75d888fmr32576741ilu.13.1666962959923;
        Fri, 28 Oct 2022 06:15:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id ay31-20020a5d9d9f000000b006c75c702342sm1493014iob.14.2022.10.28.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 06:15:59 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:15:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, hughd@google.com,
        gregkh@linuxfoundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH STABLE 5.10 v2] mm/memory: add non-anonymous page check
 in the copy_present_page()
Message-ID: <Y1vWDbRhXd8jTw8N@x1n>
References: <20221028030705.2840539-1-songyuanzheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221028030705.2840539-1-songyuanzheng@huawei.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:07:05AM +0000, Yuanzheng Song wrote:
> The vma->anon_vma of the child process may be NULL because
> the entire vma does not contain anonymous pages. In this
> case, a BUG will occur when the copy_present_page() passes
> a copy of a non-anonymous page of that vma to the
> page_add_new_anon_rmap() to set up new anonymous rmap.
> 
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:1044!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 2 PID: 3617 Comm: test Not tainted 5.10.149 #1
> Hardware name: linux,dummy-virt (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : __page_set_anon_rmap+0xbc/0xf8
> lr : __page_set_anon_rmap+0xbc/0xf8
> sp : ffff800014c1b870
> x29: ffff800014c1b870 x28: 0000000000000001
> x27: 0000000010100073 x26: ffff1d65c517baa8
> x25: ffff1d65cab0f000 x24: ffff1d65c416d800
> x23: ffff1d65cab5f248 x22: 0000000020000000
> x21: 0000000000000001 x20: 0000000000000000
> x19: fffffe75970023c0 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000
> x15: 0000000000000000 x14: 0000000000000000
> x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000
> x9 : ffffc3096d5fb858 x8 : 0000000000000000
> x7 : 0000000000000011 x6 : ffff5a5c9089c000
> x5 : 0000000000020000 x4 : ffff5a5c9089c000
> x3 : ffffc3096d200000 x2 : ffffc3096e8d0000
> x1 : ffff1d65ca3da740 x0 : 0000000000000000
> Call trace:
>  __page_set_anon_rmap+0xbc/0xf8
>  page_add_new_anon_rmap+0x1e0/0x390
>  copy_pte_range+0xd00/0x1248
>  copy_page_range+0x39c/0x620
>  dup_mmap+0x2e0/0x5a8
>  dup_mm+0x78/0x140
>  copy_process+0x918/0x1a20
>  kernel_clone+0xac/0x638
>  __do_sys_clone+0x78/0xb0
>  __arm64_sys_clone+0x30/0x40
>  el0_svc_common.constprop.0+0xb0/0x308
>  do_el0_svc+0x48/0xb8
>  el0_svc+0x24/0x38
>  el0_sync_handler+0x160/0x168
>  el0_sync+0x180/0x1c0
> Code: 97f8ff85 f9400294 17ffffeb 97f8ff82 (d4210000)
> ---[ end trace a972347688dc9bd4 ]---
> Kernel panic - not syncing: Oops - BUG: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: 0x43095d200000 from 0xffff800010000000
> PHYS_OFFSET: 0xffffe29a80000000
> CPU features: 0x08200022,61806082
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 
> This problem has been fixed by the commit <fb3d824d1a46>
> ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap()
> and page_try_dup_anon_rmap()"), but still exists in the
> linux-5.10.y branch.
> 
> This patch is not applicable to this version because
> of the large version differences. Therefore, fix it by
> adding non-anonymous page check in the copy_present_page().
> 
> Cc: stable@vger.kernel.org
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

