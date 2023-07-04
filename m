Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027E747027
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGDLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGDLuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:50:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0325135
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:49:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso66927935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688471396; x=1691063396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAiyEsWCWyq2z78cMUwk6PNMXTnMW8+o+CyEZeXTGIU=;
        b=i8YlNS8TuNFPRBmKNbTcjHjWmx1z1P+n4az1iMaWnaI6OM0PhnyBYanuGfZiZIZfMC
         bfaszxk52zrYyUNYk2n6WzRhTLtx05UseaVVqtMT7ohajYVrvJN2XAKQiGkzRKFw4x38
         /b6XufE3lh4MMXzSBt35McFuVAn86A/akbaCIDKO540u5XJ5JXo/C2gXS/O5Y6+2nZue
         p95wOB/CKUYpQ0YV3U1yBkSELXnB1nWSbxSPfe1FJAMJEmUYoZsD9KO1Gg+2+6FBLlLq
         M998Q4V1goU5/s/6opq2KGKAYGtlFmn3g5F3+lBbrV4YGVdf2ouRn+3ksJYr6Ff39L0a
         MFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688471396; x=1691063396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAiyEsWCWyq2z78cMUwk6PNMXTnMW8+o+CyEZeXTGIU=;
        b=Saz2eNj+pFCL6gHALLm34CZYDhnv0hxw4uas3mH2Jvzt7Os+EXCttS6Z23SRncMpZZ
         M2GAaxbSmiqOsWzHLpuMssgWSt+HdSNp3t8BwIyc2eS6OGdXLoqdLn1Ypee0gUuqKe+n
         9LjgTUiBvykoi/wwO6gFjW/isqa84lqhUHEO72pOWtUvA/1ht90bpHb4NZZeLcFa8fDy
         AwqWnNvBT2DoIWf42UnjrQ07h9ORUYubZBCfXJnh+QEmH+pjO6YfiKeTDaCMzVw0LYTJ
         0iZSeFdS+Bh55uTwEpy07yQgMJ5NpyaimLAZIQu8MWC/G2wE0e077M7P2J8gqDkcZf55
         XIgQ==
X-Gm-Message-State: ABy/qLYXRKT+St1/utNvxaIngV49RnlS1WLWrJKQL5Xp9vIMvr7GISZJ
        SukM3OpyQDwb7Z2d/QCLI0FZEIgTH0UIV3ukrt6Wb0/Ju3iJMpNp3IPlAEVJ
X-Google-Smtp-Source: APBJJlGgDeT+qBnFnwG8Fv3KXGKcHZ/mCoM8rtmuTMWCmGe1dFobVMzSABUtI1suGCSRJjAfkQvrh7D5GpXTdSWmmYE=
X-Received: by 2002:a05:6000:12d2:b0:30f:c7e4:d207 with SMTP id
 l18-20020a05600012d200b0030fc7e4d207mr10129430wrx.61.1688471396138; Tue, 04
 Jul 2023 04:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230704101942.2819426-1-liushixin2@huawei.com>
In-Reply-To: <20230704101942.2819426-1-liushixin2@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 4 Jul 2023 19:49:18 +0800
Message-ID: <CAMZfGtWW_LhaZe4uUNMiLVs0n48vdA+xdbG14UPz6u0Y3RbvNQ@mail.gmail.com>
Subject: Re: [External] [PATCH] bootmem: remove the vmemmap pages from
 kmemleak in free_bootmem_page
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:23=E2=80=AFPM Liu Shixin <liushixin2@huawei.com> w=
rote:
>
> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
> put_page_bootmem") fix an overlaps existing problem of kmemleak. But the
> problem still existed when HAVE_BOOTMEM_INFO_NODE is disabled, because in
> this case, free_bootmem_page() will call free_reserved_page() directly.
>
> Fix the problem by adding kmemleak_free_part() in free_bootmem_page()
> when HAVE_BOOTMEM_INFO_NODE is disabled.
>
> Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with=
 each HugeTLB page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
