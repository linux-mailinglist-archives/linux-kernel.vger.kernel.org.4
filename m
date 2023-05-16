Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D817057A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjEPTma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjEPTmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:42:25 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD382690
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:42:09 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a00da4e53so250400267b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684266129; x=1686858129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSVEdvfoE0NUvW5V33KiQS8L9RpD2sackPRopDcvPwE=;
        b=SNLgzOql1dtAOa25t+JwnKc6KWkWjPXrHtQbeHGO+c4RB8ouqPaaR72cUjJan7sAbu
         kL0iLRykj6ryell+8/70lbSeGtmHAHYtK8lJKZ//CvvpTCdlgKiRGXsOVFQ9EDDtQGVB
         fAW1lTt1PUYUxcep6bTOavqM4A+1gSEwRP4JsnX1AdjtAtCLdUy+AsYme97+ytk/9/7b
         5L1XkYxErCMcWoJH8BnrHkDZF/uo+X8K++kCNw9Bd59BUkkuUD49ziuOahYCwf1lExyu
         dh0DUkqxfVm2yxbVDSA7QpjtC752jM5eYxid5230oV4am7giDUa6mqkLKS+cfsnwSxpP
         LVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684266129; x=1686858129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSVEdvfoE0NUvW5V33KiQS8L9RpD2sackPRopDcvPwE=;
        b=jFwS1/vcuzqV8XitC8FpiE4NRHYQ6qFtgwWmL1mlM/CCULNn6OcXPTMcT3JHfzx1n2
         PeZPQ9aEIh1MLqfWbL8Pp2pqXJxw4E6XJnlBxZ6521EKcXFRSI7LgXD2k+rtdeNKbC82
         /gQK9CJTdolI1QcU7QrnKpmoN9pR1S5rBL29GkQCMeUPgx45nSe4UapvNLYF0mIA5Qcm
         zB/1dFQtIf9IaJLVXDaec4LSwBBsFXTCa15WFl2RG7EcGc0DE4Y0RcRdPzDd0qOC7hP3
         f5GpOM625Q5i6MwBnnyz5TWC+JO8VYviizbfUFTZIpv2nDhy+7N8eSt9wwxl0/lcMkk6
         k+9A==
X-Gm-Message-State: AC+VfDzQDqd9g5owX9gdtv0Jh6gDCmr4VCXvnkuex4TGm6NOW1aSLk7Q
        PhsSIV5vzYfvCEZ6Z85keRMzzA+fT46PNm0+SZ7opQ==
X-Google-Smtp-Source: ACHHUZ5IjLWNrA5KAMjnxOuxBzdh5Srhi6z385N8RdZH7DOKNSGk6Bwy4ByuDZYp2+0YzOABrupx+f6k8dXErhFHLd4=
X-Received: by 2002:a0d:ffc1:0:b0:561:3fb7:1333 with SMTP id
 p184-20020a0dffc1000000b005613fb71333mr9398994ywf.43.1684266128865; Tue, 16
 May 2023 12:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <18448ae569e24dfd84e811081ede376f@hihonor.com>
In-Reply-To: <18448ae569e24dfd84e811081ede376f@hihonor.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 16 May 2023 12:41:56 -0700
Message-ID: <CAJuCfpEMqLUePoqaQYKOK5OTFGHft8igg+NZ-R1qrudNJ5VmSg@mail.gmail.com>
Subject: Re: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
To:     gaoxu 00016977 <gaoxu2@hihonor.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yipengxiang 00013268 <yipengxiang@hihonor.com>,
        wangbintian 00013160 <bintian.wang@hihonor.com>,
        hanfeng 00012985 <feng.han@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 12:33=E2=80=AFAM gaoxu 00016977 <gaoxu2@hihonor.com>=
 wrote:
>
> If dma_direct_alloc() alloc memory in size of 64MB, the inner function
> dma_common_contiguous_remap() will allocate 128KB memory by invoking
> the function kmalloc_array(). and the kmalloc_array seems to fail to try =
to
> allocate 128KB mem. work around by doing kvmalloc_array instead.

On systems like Android it's not unusual for order 5 allocation to
fail. The change seems safe to me with no downside since kvmalloc will
try kmalloc first.

>
> Signed-off-by: Gao Xu <gaoxu2@hihonor.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  kernel/dma/remap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c index b45266680..275=
96f3b4 100644
> --- a/kernel/dma/remap.c
> +++ b/kernel/dma/remap.c
> @@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, =
size_t size,
>         void *vaddr;
>         int i;
>
> -       pages =3D kmalloc_array(count, sizeof(struct page *), GFP_KERNEL)=
;
> +       pages =3D kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL=
);
>         if (!pages)
>                 return NULL;
>         for (i =3D 0; i < count; i++)
>                 pages[i] =3D nth_page(page, i);
>         vaddr =3D vmap(pages, count, VM_DMA_COHERENT, prot);
> -       kfree(pages);
> +       kvfree(pages);
>
>         return vaddr;
>  }
> --
> 2.17.1
>
