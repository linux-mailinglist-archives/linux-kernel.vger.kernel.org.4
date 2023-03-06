Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372AC6ACE71
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCFTtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCFTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:49:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB9A42BD9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:49:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ec29so12611341edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678132181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ8HvqtIPLz0dPleZMUFGrq6mRjQgi/9JQx/mHQNyq0=;
        b=kwhTl84xw1eEGSpRl4nINA+Fb8qaW+LVjaA8ygTrihkdAL6mhBe3a7ZAxhV4a4XYAt
         LfUeTYmsw7/5A9B5IHXpimjSG+97CeqT+WyBHP23CjyPUipsVmwH7u9p0VQVBB+6nE3t
         Yc72D0GAT5pxx1HAAGuqT41MPTC3kG0eF5Y6220o6a4wIMHHsXdZSs5uxAc8xYC0cNxX
         leh0iHfa3+XV9sqnE2RSGzBGdl0PJgrwq2y/sxr2M5ic2hQ5INYHN5RTpBWgNFyB8Zgg
         o27AdMVtQX7HTfO+bTHJC33p1IsxsMgYUgDxVCUNX9hKgoTulqRzwfypBaEhWbn6sMgj
         PHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678132181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ8HvqtIPLz0dPleZMUFGrq6mRjQgi/9JQx/mHQNyq0=;
        b=VXiHgpCgYq/Jnx65gOBx4QNOeua3YqjIVGtgJY+GMLF1WRyYlHvcPz3tlo4rD7g+O7
         LGEoYayz4rlL0NMqV+lNdEvghMnZTc6A/GzX8Jd95UEKmSCbe+REK6M0dh94L/UE6SO0
         fxAY7LmOf9lXouWsLrpn/8K1rbYmZKbaPIqbVWSL9GqXowkPGtiGPc7ZHsO8Ux2jBhT1
         49KPQkt5EoMRhK/c41WRBoI7gRfkWV5tgjL1oCcW+p3Xf5dVMtW3icGl/Xd+6kdmtGZX
         IXTOVuYn9vyfMzg1yCcwo7PJK6ZCdE5V2CjC7RTM5BN8TnwAe8XPDXIpfETmLo57H9Fh
         MH3Q==
X-Gm-Message-State: AO0yUKX12MNuwDvT8awSh9h9xOmTqMQIpDyex+uEO4RXeiNiKhZ0sLb6
        cIix0IlRbS/+ovKiPj540aCRd9YP6WaliW9H1saqbw==
X-Google-Smtp-Source: AK7set8FGULDLLQMph8YO2LW0ePc9c3mdTd9Jl/SBfqAol+1SKDU4JBVK3PEMnT68gWQb4UIIIsccIaFHO7iwyFD07E=
X-Received: by 2002:a17:906:46d8:b0:87a:3b3f:b9da with SMTP id
 k24-20020a17090646d800b0087a3b3fb9damr5926882ejs.10.1678132181333; Mon, 06
 Mar 2023 11:49:41 -0800 (PST)
MIME-Version: 1.0
References: <20230302232758.888157-1-mcgrof@kernel.org> <20230302232758.888157-4-mcgrof@kernel.org>
In-Reply-To: <20230302232758.888157-4-mcgrof@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Mar 2023 11:49:05 -0800
Message-ID: <CAJD7tkb6VMxWx9WCb6nKFvg_KeaJzo85=kgs7ZOaFptdn_kLDw@mail.gmail.com>
Subject: Re: [PATCH 3/6] shmem: move reclaim check early on writepages()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, linux-mm@kvack.org, p.raghav@samsung.com,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 2, 2023 at 3:28=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> i915_gem requires huge folios to be split when swapping.
> However we have  check for usage of writepages() to ensure
> it used only for swap purposes later. Avoid the splits if
> we're not being called for reclaim, even if they should in
> theory not happen.
>
> This makes the conditions easier to follow on shem_writepage().
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Nice cleanup.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/shmem.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 2b9ff585a553..a5a6da51087e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1340,6 +1340,18 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>         swp_entry_t swap;
>         pgoff_t index;
>
> +       /*
> +        * Our capabilities prevent regular writeback or sync from ever c=
alling
> +        * shmem_writepage; but a stacking filesystem might use ->writepa=
ge of
> +        * its underlying filesystem, in which case tmpfs should write ou=
t to
> +        * swap only in response to memory pressure, and not for the writ=
eback
> +        * threads or sync.
> +        */
> +       if (!wbc->for_reclaim) {
> +               WARN_ON_ONCE(1);        /* Still happens? Tell us about i=
t! */
> +               goto redirty;
> +       }
> +
>         /*
>          * If /sys/kernel/mm/transparent_hugepage/shmem_enabled is "alway=
s" or
>          * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge p=
ages,
> @@ -1360,18 +1372,6 @@ static int shmem_writepage(struct page *page, stru=
ct writeback_control *wbc)
>         if (!total_swap_pages)
>                 goto redirty;
>
> -       /*
> -        * Our capabilities prevent regular writeback or sync from ever c=
alling
> -        * shmem_writepage; but a stacking filesystem might use ->writepa=
ge of
> -        * its underlying filesystem, in which case tmpfs should write ou=
t to
> -        * swap only in response to memory pressure, and not for the writ=
eback
> -        * threads or sync.
> -        */
> -       if (!wbc->for_reclaim) {
> -               WARN_ON_ONCE(1);        /* Still happens? Tell us about i=
t! */
> -               goto redirty;
> -       }
> -
>         /*
>          * This is somewhat ridiculous, but without plumbing a SWAP_MAP_F=
ALLOC
>          * value into swapfile.c, the only way we can correctly account f=
or a
> --
> 2.39.1
>
