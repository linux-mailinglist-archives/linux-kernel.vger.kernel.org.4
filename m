Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C43368B591
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBFGXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBFGXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:23:04 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B064B750
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:22:55 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id j7so11573526vsl.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 22:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynrCrA1+knokV0dXoyzZReuKJceQqN5l3Tsi4apnR3Y=;
        b=uahW6+YnhsfiMMFyR9frf6fGI/xz17H2d0nydFF8gvXJmd0WLchpwKE39XaDirMbnk
         w5hrvx/7xgjd8p34AvEQyKJyaoZVWIrDQAOgULTc9SgE3bWvi3ocZDdePBsKnQKUcZDE
         0acxBfrh6WwI0dIJxTi6aL+2hlwuacTIAH+GIegXVx1BoABOvxlg27i/fZognfC+dsHd
         OyxMpd3/0FX2H+Y/CzGeGr86LgXlxleiQyj7a3voGXKHoJbDDLzo0h9ESQLcLmPlsqyq
         21tXuel94sxAr08wrf96LMDxOwiJKMoaR5yz2IvSyJlPavteSYie3GGfj+UyBi4u+/ze
         t4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynrCrA1+knokV0dXoyzZReuKJceQqN5l3Tsi4apnR3Y=;
        b=WuOS37EJyBmAEjXlngM6ZsPeb4SHXObmCGuBw89bIILgsVTfrrmN+1I0loALr5VieE
         4i1aIkHUB8/8zsdBDgBQuW+uqWRze3aMYF/gDa0lzhRW+RcNzb9qI7ZWQquLYukfmtes
         IH7DeKLnlbWq2Q7Vo8qK0sDh8zL/+Pye9sx3s7cPaJigJNx3T4fSfpIFYg66lYG4/AER
         ocRG3rxGurvpfc9JRZo7rJp6GHoOEOwJTsGEAjoGQHXZAn+oN02epf2EQzj7mljuc7sZ
         14IKgD2WmCFbiBjw2pAW3vQpH2Xqqo3EV+bBLBGNauAW7DBotavR8kH0U1NdN6iNCyP2
         skww==
X-Gm-Message-State: AO0yUKV9tLPgaHajyfVGQKOC+AzGzdqgFUIl7JMf/YJ97WmDUi4faVzK
        eMyp2bRh6OyZk5VEe1GqDcrTCUC5AJER7AVr2EAo7Q==
X-Google-Smtp-Source: AK7set/Else6edw9TgC+morr2lkXlm+Q1jjv3sTFx00yZIbme3IfsWPhIhz3bmsawg1Ju1IIuZBVQqTgruzBDFfLh5c=
X-Received: by 2002:a05:6102:2378:b0:3ce:8835:de03 with SMTP id
 o24-20020a056102237800b003ce8835de03mr2728482vsa.50.1675664574674; Sun, 05
 Feb 2023 22:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 11:52:43 +0530
Message-ID: <CAFA6WYM5tzs3T1tDgspA=R=VxfWrknm2YPHMCZihx405pF-ftA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Remove get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
>
> Sumit,
>
> I did not see a follow up on this series per your last email.[1]  I'd like to
> move forward with getting rid of kmap_to_page().  So Hopefully this can land
> and you can build on this rather than the other way around?

Apologies Ira for keeping you waiting. Actually I was fully involved
with other high priority work with my upstream review backlog
increasing. So I wasn't able to devote time to this work. Sure I will
rebase my work on top of your changes.

-Sumit

>
> All,
>
> Al Viro found[2] that kmap_to_page() is broken.  But not only is it broken, it
> presents confusion over how highmem should be used because kmap() and friends
> should not be used for 'long term' mappings.
>
> get_kernel_pages() is a caller of kmap_to_page().  It only has one caller
> [shm_get_kernel_pages()] which does not need the functionality.
>
> Alter shm_get_kernel_pages() to no longer call get_kernel_pages() and remove
> get_kernel_pages().  Along the way it was noted that shm_get_kernel_pages()
> does not have any need to support vmalloc'ed addresses either.  Remove that
> functionality to clean up the logic.
>
> This series also fixes is_kmap_addr() and uses it to ensure no kmap addresses
> slip in later.
>
> [1] https://lore.kernel.org/all/CAFA6WYMqEVDVW-ifoh-V9ni1zntYdes8adQKf2XXAUpqdaW53w@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/YzSSl1ItVlARDvG3@ZenIV
>
> To: Sumit Garg <sumit.garg@linaro.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Al Viro" <viro@zeniv.linux.org.uk>
> Cc: "Christoph Hellwig" <hch@lst.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: op-tee@lists.trustedfirmware.org
> Cc: linux-mm@kvack.org
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes in v2:
> - Al Viro: Avoid allocating the kiov.
> - Sumit: Update cover letter to clarify the motivation behind removing
>   get_kernel_pages()
> - Link to v1: https://lore.kernel.org/r/20221002002326.946620-1-ira.weiny@intel.com
>
> ---
> Ira Weiny (4):
>       highmem: Enhance is_kmap_addr() to check kmap_local_page() mappings
>       tee: Remove vmalloc page support
>       tee: Remove call to get_kernel_pages()
>       mm: Remove get_kernel_pages()
>
>  drivers/tee/tee_shm.c            | 37 ++++++++++---------------------------
>  include/linux/highmem-internal.h |  5 ++++-
>  include/linux/mm.h               |  2 --
>  mm/swap.c                        | 30 ------------------------------
>  4 files changed, 14 insertions(+), 60 deletions(-)
> ---
> base-commit: 0136d86b78522bbd5755f8194c97a987f0586ba5
> change-id: 20230203-get_kernel_pages-199342cfba79
>
> Best regards,
> --
> Ira Weiny <ira.weiny@intel.com>
