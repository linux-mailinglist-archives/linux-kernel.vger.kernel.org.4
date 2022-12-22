Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54B16547C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbiLVVSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiLVVSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD81E73C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671743848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JvoMNsJvzMmJ+w485oCvbJgOGlOvC+kCcpkVN/ffzRU=;
        b=ZlhZvkt1ZHFOHoejwRn74jaguvWENAxne55JpkLWtaGEatWQdOssWVxRAFdUqrFfvJxAKP
        r6jh++bLpyHDQFAdnii73cHZaF7sW9tj8uCW4ZlwMsJjId5sYWOEU625rEOiDwCYKF42gd
        zM67RI2VPaAXlH9GXeIeD99HYN0zz/Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-VS9mfCa-NwCmbM8h7-6ixQ-1; Thu, 22 Dec 2022 16:17:25 -0500
X-MC-Unique: VS9mfCa-NwCmbM8h7-6ixQ-1
Received: by mail-qt1-f200.google.com with SMTP id e18-20020ac845d2000000b003a6a5cbbebcso1223593qto.20
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvoMNsJvzMmJ+w485oCvbJgOGlOvC+kCcpkVN/ffzRU=;
        b=huxXNPIzKO5qSlt2ldnbR0T7qj91S2D30VI17QzQonHwe8aS7h+bIQiXgVNLaRfgKO
         NoSbfc5NwZtSZ2+RtVlY7mt5lWAYu14MehDDls8RPgQz9US2n1j4U7D76acjvwZ5m52z
         L80l+fmb03UMcHLPUfAeh0cdtiVACH8/ocIwsIeej/UbbFsmYUTrCgvvCYdNoQIAosTf
         wdb1/TAqAwkc1Clux5NRqON+4d/J6Uo4gP4WbFNh7YHEzLm42foZSQX7fbij6yCw+H0B
         YuqK3IXINffeis6Hmfx6xFEbKSyEmv3UxiN6b/qeRLlpnZoyEhYIt3HiRn5+jULCqUmT
         JA/A==
X-Gm-Message-State: AFqh2krjfKi/wgDWqw0gAQfXhuFcv+rBPBln1zyuG6jL6P5Rh29v3pdb
        aC2AbIV5Xek7hUz6ZcuyhchdI55BRfTcUPclGNpOOqCO+AQxBTyzMFg2wmLUUl3JQw64GrADH2Z
        SVQdmhuQUx7TPOqUfXrOIZiBN
X-Received: by 2002:ac8:7616:0:b0:3ab:5f5f:a0d7 with SMTP id t22-20020ac87616000000b003ab5f5fa0d7mr10184620qtq.2.1671743845525;
        Thu, 22 Dec 2022 13:17:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvhBkL/MXLQzmxAc9KAb3d66sq1547AHHocyIzrLd9tSP4EgY9PF1B4tejCIsLJ9b9dDcuEcA==
X-Received: by 2002:ac8:7616:0:b0:3ab:5f5f:a0d7 with SMTP id t22-20020ac87616000000b003ab5f5fa0d7mr10184601qtq.2.1671743845312;
        Thu, 22 Dec 2022 13:17:25 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id fy15-20020a05622a5a0f00b003999d25e772sm898838qtb.71.2022.12.22.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 13:17:24 -0800 (PST)
Date:   Thu, 22 Dec 2022 16:17:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v1 0/2] mm/hugetlb: uffd-wp fixes for
 hugetlb_change_protection()
Message-ID: <Y6TJYl78od9XQuvj@x1n>
References: <20221222205511.675832-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221222205511.675832-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 09:55:09PM +0100, David Hildenbrand wrote:
> Playing with virtio-mem and background snapshots (using uffd-wp) on
> hugetlb in QEMU, I managed to trigger a VM_BUG_ON(). Looking into the
> details, hugetlb_change_protection() seems to not handle uffd-wp correctly
> in all cases.
> 
> Patch #1 fixes my test case. I don't have reproducers for patch #2, as
> it requires running into migration entries.
> 
> I did not yet check in detail yet if !hugetlb code requires similar care.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> 
> David Hildenbrand (2):
>   mm/hugetlb: fix PTE marker handling in hugetlb_change_protection()
>   mm/hugetlb: fix uffd-wp handling for migration entries in
>     hugetlb_change_protection()

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks, David.

-- 
Peter Xu

