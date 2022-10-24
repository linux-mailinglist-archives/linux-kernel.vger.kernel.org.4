Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE89B60B653
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiJXSyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJXSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:53:46 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC2650525
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:34:56 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id q1so9219107pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h7u5l49jw0uI8snMuGlN/qKzrSpvO9jQze7XHi24T1M=;
        b=krW7g60IFvrJDYp67iygKygcrvrEEsYceB5aIjV0J3CnDXzbclR9DuN0MYgqT7CSUk
         y5AmAy6+a31rgWDTx6CdnADzKE/bjT2J0ghQViTdmp6COPxYJldt4rb/oRIlNFSe5p//
         UVxmaylAYn54r5+KzPbkyIWqzez4+2EWIgm6F5yIc0OP4aZuMA6nfAKaw1Os9BGP6nOn
         JMwxKFpIjokKj2qc3rP3ND4bZRP2mdOSteRe10uXMbXelesYYv96NjcDyXZohe1g71Yq
         pD03Md9HbgjUZfREvL+whScKnRnTQKIR4q2hLoyCqcx259GZW1EhqqCt7ewQZqmOhx6g
         Y4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7u5l49jw0uI8snMuGlN/qKzrSpvO9jQze7XHi24T1M=;
        b=ZJix1uyI8EywjtVyBVAgXh3DtzFBILrdeNu18aOF42+luQFHv7Xx7aC+VMIXAA8xX7
         n69CaIdQiJIRbqOUyzSEJPH0yp8jNrzY3BtLONBqFHZ0maimUdd5GbkmQ3hQ4gCOOA0w
         fo2JaS2pnUaq4KedxDMr+camMrNrGhxmudkRTBEZ5ju26R3Cho2tGOXHOwxX4EQjBbPB
         8BSTljWrdQwHzS7kR7Jzk8K2jy26UqHI089DzyGVMp4onU04mUfq0Y3EgTrvMpnDYRMr
         MaE0llOdKaAAt+GH2Mfq+DFt7/VE4tOFPBCvIqLs5NR1SQKgpP8Hb+VZoA2fZQ6apg/Q
         kgXQ==
X-Gm-Message-State: ACrzQf3GXmMdC+caus3TwakEa+Wzcpr6Cizl+uXXy10AcgE1h1pDzhlC
        5SHXb54Fu3NuZzxibeLjk99bF9TmOTG03PVgthHfLlzB
X-Google-Smtp-Source: AMsMyM5hS6FGZqfULF7ZSRo0Ys8XJvXP8Iyo2AZMzh3DCMYIzwpnh8fDjR3yXJE2xbllZDPeVrCJXF/oboyQrooxPlc=
X-Received: by 2002:a05:6a02:20c:b0:461:74e5:ce9f with SMTP id
 bh12-20020a056a02020c00b0046174e5ce9fmr29467846pgb.294.1666632082324; Mon, 24
 Oct 2022 10:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <de386aa864be9158d2f3b344091419ea7c38b2f7.1666599848.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 24 Oct 2022 10:21:09 -0700
Message-ID: <CAHbLzko529=DehnHqqvRkhNA4NkgGjCLOvt1c=kmHV1LCKZpGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: migrate: Fix return value if all subpages of
 THPs are migrated successfully
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        ziy@nvidia.com, apopple@nvidia.com, jingshan@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 1:34 AM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> During THP migration, if THPs are not migrated but they are split and all
> subpages are migrated successfully, migrate_pages() will still return the
> number of THP pages that were not migrated.  This will confuse the callers
> of migrate_pages().  For example, the longterm pinning will failed though
> all pages are migrated successfully.
>
> Thus we should return 0 to indicate that all pages are migrated in this
> case
>
> Fixes: b5bade978e9b ("mm: migrate: fix the return value of migrate_pages()")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> Changes from v2:
>  - Add Fixes tag suggested by Yang Shi and Huang, Ying.
>  - Drop 'nr_thp_split' validation suggested by Alistair.
>  - Add reviewed tag from Alistair.
>  - Update the commit message suggested by Andrew.
> Changes from v1:
>  - Fix the return value of migrate_pages() instead of fixing the
>    callers' validation.
> ---
>  mm/migrate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e5eb6e..2eb16f8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1582,6 +1582,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>          */
>         list_splice(&ret_pages, from);
>
> +       /*
> +        * Return 0 in case all subpages of fail-to-migrate THPs are
> +        * migrated successfully.
> +        */
> +       if (list_empty(from))
> +               rc = 0;
> +
>         count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>         count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
>         count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> --
> 1.8.3.1
>
