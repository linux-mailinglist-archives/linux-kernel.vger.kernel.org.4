Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA10A6B31F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCIXJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCIXJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:09:40 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53709F6010
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 15:09:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o12so13458266edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 15:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678403378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L82LLAFa3yKPGqihEjumWOS8LCu91FNhSAsS82H2S9Y=;
        b=YL+yymwll8LWqsXH9BumplzZ1FYULA6wAuo2rS5NSlsw7qMzmpSEGnyuwl+92wgoKc
         AGVm89QmivXRyOWbYzZXYYYph8BTyq5K0zc71DpKbVqtD4WFI1xakRh0NWOM2Nh9hAS1
         A4jjCH0UULVIQXSPgrnVTD/KRjI/aSGFMD6a0f1si8McUSgFNqR02Wa+y7sZ36qBBD9I
         8ZZpg9j5LjzgrPBfzMgUvfgX/c/aiLKBSvQl0AAlBr/JpG69m9OZr16xmln/Sr/hlkgV
         qqKByUoCXeXt9wI3FjbXDE6q7akRssXth/EaIDXsy2HLRK+YpxcxfKvQMf/ou3eCkXp8
         7eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678403378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L82LLAFa3yKPGqihEjumWOS8LCu91FNhSAsS82H2S9Y=;
        b=s6uT1DWPgIXkyTixtj0xhIU0BsHFiDK3qM+8+P3qikvp5subGtSji9lWE9y6MdBWL1
         XAqbhq91YQQWwsM+Jj2lTb5aVE+FiM837raXN7SJMW/jMTMSImrMLrj2MvkHcpF8zSan
         G2VPhziheOFLm5u2pbrqIWYIsNLrkD+AU5qMwEwnFwLHQ6zbJQN56OHw+zsSeTHUcic8
         /wPL6g8d3rzpgxfFwS//mM+W3sQg3mNfXVH/nWq+YfYL5U+TcC9Dne8VAbyq0biP09B6
         flhyfch8UztQBsOZODBhZA4xsAPRM/leL8aPKYaIhRVl0hzSYqRTIyCwVv5EJIFT9Q+u
         2RtQ==
X-Gm-Message-State: AO0yUKWDbfZmaxLKl5s31cyN26fjwzuLOITeA8ZC/rBVtNX3c+nuSrmu
        tMzMXbIVIdwjsmKOppzzRxQATUZutRvgEwSOSNN26Q==
X-Google-Smtp-Source: AK7set8AcinN2hr2zJihYxX8vcj8C1IPM0eI53YU3Xrhk3kW37BWKt78hyHgHxxiBGSv7riWGLA37o19ds/90kmhRL0=
X-Received: by 2002:a17:906:b11:b0:8f3:9ee9:f1e2 with SMTP id
 u17-20020a1709060b1100b008f39ee9f1e2mr197745ejg.5.1678403377576; Thu, 09 Mar
 2023 15:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20230309230545.2930737-1-mcgrof@kernel.org> <20230309230545.2930737-5-mcgrof@kernel.org>
In-Reply-To: <20230309230545.2930737-5-mcgrof@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Mar 2023 15:09:01 -0800
Message-ID: <CAJD7tka+4gaEUHWcUQu9fgLrGmuoZDb3Yp7GT4fv=Tzrwobd4g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] shmem: skip page split if we're not reclaiming
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:05=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> In theory when info->flags & VM_LOCKED we should not be getting
> shem_writepage() called so we should be verifying this with a
> WARN_ON_ONCE(). Since we should not be swapping then best to ensure
> we also don't do the folio split earlier too. So just move the check
> early to avoid folio splits in case its a dubious call.
>
> We also have a similar early bail when !total_swap_pages so just move
> that earlier to avoid the possible folio split in the same situation.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/shmem.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 68e9970baf1e..dfd995da77b4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1350,6 +1350,12 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>         if (WARN_ON_ONCE(!wbc->for_reclaim))
>                 goto redirty;
>
> +       if (WARN_ON_ONCE(info->flags & VM_LOCKED))
> +               goto redirty;
> +
> +       if (!total_swap_pages)
> +               goto redirty;
> +
>         /*
>          * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "alway=
s" or
>          * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge p=
ages,
> @@ -1365,10 +1371,6 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>         }
>
>         index =3D folio->index;
> -       if (info->flags & VM_LOCKED)
> -               goto redirty;
> -       if (!total_swap_pages)
> -               goto redirty;
>
>         /*
>          * This is somewhat ridiculous, but without plumbing a SWAP_MAP_F=
ALLOC
> --
> 2.39.1
>
