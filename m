Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94A6C99B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjC0CsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjC0CsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:48:20 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC77EC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:47:55 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i10so6229724vss.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVYybNewVCUGIqlidPD+XnZB+0DT8ZQE8hA51H8g5lY=;
        b=nrKyJZoSZOLvRdvdah1XBHmiBQPlhejAs6Noz0yni0AOhMTvNYiq08DZ9m+ap7x3O2
         dY56EZKctpmqiNkTSQONXOJkoi61DrcWIU8YUpZ6XnOhakY2a/LKHWfW07Od6Xtf3+3f
         itL6A8fliVYnbFW8vp7X7QelVrMrQAsnFZN+eamytjiuo+2QH5c0e26tSryZk8rVsJGD
         6h85l2NvY4o6ep9w3LGHMpCAnpoAbl0VloR1B8AGEXxASkxiuegrzKvDmWz2RwEmpOPG
         411pkCKo0e8oi2uQ9RACupqgNgNHeff+Ftg74Ot2/mZIJbNDddd3kjYNI4k9NkF8rPon
         zbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVYybNewVCUGIqlidPD+XnZB+0DT8ZQE8hA51H8g5lY=;
        b=CwaC1bjI37CJ0WSC5zuagRK+0yOHQpQ74X9fMz9WAd6C7L7nuVv0sV91YYJ4aX9Uku
         vcB1FuTkajgYKARYYpF8OjOweMJlvVfaacFDBzRQAV7GYWWKfbc6zV4r3N1NF3+LNP1h
         JerxEsF7ViqhFhfXkPWh0pT2L/UTGRfxYUN7EB1stdWi8cr3CnJJizsvHg6aWC2qiGyr
         y+/WbLjVdlJEY94zyx1LKZ809X9py7ks+GA5rQK63lWy2gzi1nDFBIOroPmiE/DpXmfC
         b8qG8NVfn2n9V9VMc/KvsuhXZqGB68OJ5Mjbtl9Eo+AdqDvY14yJ7ovo0333FWktQwi3
         QIZg==
X-Gm-Message-State: AO0yUKWUFHInda62QT3q5MWyH2avy5ci0g72gGUijYWE6eFPqG8Hki06
        G20TIrRb8+TbhDplJZA2QBJjic1b76Jpucw91+k=
X-Google-Smtp-Source: AK7set9pttu/SbRRsNRw63OJRSZtjAbF7ctNuFQw/5evaDxrdE27zd5/N5zwTbrosIObJghyEQ2fcPMbPsKxJaOVlHQ=
X-Received: by 2002:a05:6102:3385:b0:426:6d5:a55a with SMTP id
 i5-20020a056102338500b0042606d5a55amr8700427vsh.1.1679885274358; Sun, 26 Mar
 2023 19:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
In-Reply-To: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 27 Mar 2023 10:47:18 +0800
Message-ID: <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Mon, 13 Mar 2023 at 15:51, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
> V3:
> * Split into two patches;
> * Added support reattching an existing domain;
> * Release DMA buffer only when domain freed.
>
> V2: https://lkml.org/lkml/2023/3/7/1717
> * Added some comment in sprd_iommu_attach_device() for the reason
>   of calling sprd_iommu_cleanup().
>
> V1: https://lkml.org/lkml/2023/2/10/198
>
> Chunyan Zhang (2):
>   iommu: sprd: release dma buffer to avoid memory leak
>   iommu: sprd: Add support for reattaching an existing domain

Not sure if you received this patchset, since I received a rejection
letter from mail.8bytes.org.

If you didn't receive it, I can resend it with another email address.

Otherwise, would you please pick up this series if there are no more comments.

Thanks,
Chunyan


>
>  drivers/iommu/sprd-iommu.c | 54 +++++++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 13 deletions(-)
>
> --
> 2.25.1
>
