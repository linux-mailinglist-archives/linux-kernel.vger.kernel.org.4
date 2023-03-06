Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8506ACED2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCFUEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCFUEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:04:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8341E6544A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:04:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ay14so39918075edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678133074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwdV6oPXDHYeWDAi/RiRemVmk6PbuPEZPN9dBbLlQuc=;
        b=AJidX8wsGSpgBXq+HxNIxFLkm81d+8OurwL3na6qTBQ4BpQOYCBwEz/dKNWutHzm7L
         mlz36IyLPJrpnu3GM4tRf2PktEV3BAxsGIrxkgsp2eSJTKzGc6XLQEcWApPxNiW0LBUU
         ntgB+Sj4RmC/VsBWGD/4QdFpH92ppHWE/ASHWyQy20Ag/Zt92zCjslrPxonpjvEeA0pQ
         8lqQ0App73sRlQPVzWX3CaakOPb8FXxw8deDwpIV9HCotapXR9w0kbM02ZKMzrAKSglk
         ZF4/lJ2lbFJ57ryjC3Id66rPruFGZwEQnGKZVLsoi7VrcQ4FSgvtd60lErkV8ESI7cPY
         5Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwdV6oPXDHYeWDAi/RiRemVmk6PbuPEZPN9dBbLlQuc=;
        b=WxzF8z+HCy60Q3YLKsJZ6YtdzGU3nKpu7FAV1+87BUaN/qf+l5s3NC+eQTm3l2TLC4
         xvzsZMkPTmzRBkKag+kdjW6qYgaSM6zAC3+WYizIShFVUuarIUJ82FHJ8lap2bN3PCfa
         Avv6J0L5Cx42pEgdK3EgPLXvTCe/9sQQIRUaIr+Kk3iiYfSabp+hgw3XGOxWcIxIzwjb
         WVvPZ9WHzCjxPcpmlmkGfyT2ZsWNIV+gyFDi4FsDQMoAunj3Xo31Ny7Q+8N9DwnyiqMA
         jOhQ7mqWUrg6unS99T7y7rdtwQDvNbnhvVJ7V+MGX9FYPSY6MGq817TE5SajtYahvtpI
         /Z2Q==
X-Gm-Message-State: AO0yUKWC0f/4qH0kSztKQj9gm3829FyHz0emrrV4/f4E/9u17SA9UUta
        mZ77Hr82/mumm5BtRXzxB34wMiKFtTnjVgGF3Bx3UA==
X-Google-Smtp-Source: AK7set99xlB4THBtP/IHqKjKahSVsEGzPuzvwz4xiE2wyonl2vPjHgwa67gOzP+IYXOz+SHmhf8/P2UvrONDkbNJ78k=
X-Received: by 2002:a50:bae3:0:b0:4c0:ef64:9299 with SMTP id
 x90-20020a50bae3000000b004c0ef649299mr6578904ede.5.1678133073729; Mon, 06 Mar
 2023 12:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20230302232758.888157-1-mcgrof@kernel.org> <20230302232758.888157-7-mcgrof@kernel.org>
In-Reply-To: <20230302232758.888157-7-mcgrof@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Mar 2023 12:03:57 -0800
Message-ID: <CAJD7tkZOPbCEb_5VvmEyimcDmpaOxe9dtmuenUH3mwVADH+RSA@mail.gmail.com>
Subject: Re: [PATCH 6/6] shmem: add support to ignore swap
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
> In doing experimentations with shmem having the option to avoid swap
> becomes a useful mechanism. One of the *raves* about brd over shmem is
> you can avoid swap, but that's not really a good reason to use brd if
> we can instead use shmem. Using brd has its own good reasons to exist,
> but just because "tmpfs" doesn't let you do that is not a great reason
> to avoid it if we can easily add support for it.
>
> I don't add support for reconfiguring incompatible options, but if
> we really wanted to we can add support for that.
>
> To avoid swap we use mapping_set_unevictable() upon inode creation,
> and put a WARN_ON_ONCE() stop-gap on writepages() for reclaim.
>
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  Documentation/filesystems/tmpfs.rst  |  9 ++++++---
>  Documentation/mm/unevictable-lru.rst |  2 ++
>  include/linux/shmem_fs.h             |  1 +
>  mm/shmem.c                           | 28 +++++++++++++++++++++++++++-
>  4 files changed, 36 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesyst=
ems/tmpfs.rst
> index e77ebdacadd0..551b621f34d9 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -13,7 +13,8 @@ everything stored therein is lost.
>
>  tmpfs puts everything into the kernel internal caches and grows and
>  shrinks to accommodate the files it contains and is able to swap
> -unneeded pages out to swap space.
> +unneeded pages out to swap space, if swap was enabled for the tmpfs
> +filesystem.

Nit: s/filesystem/mount to make it clear it's a per-mount setting?

>
>  tmpfs extends ramfs with a few userspace configurable options listed and
>  explained further below, some of which can be reconfigured dynamically o=
n the
> @@ -33,8 +34,8 @@ configured in size at initialization and you cannot dyn=
amically resize them.
>  Contrary to brd ramdisks, tmpfs has its own filesystem, it does not rely=
 on the
>  block layer at all.
>
> -Since tmpfs lives completely in the page cache and on swap, all tmpfs
> -pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
> +Since tmpfs lives completely in the page cache and on optionally on swap=
,

Nit: s/on optionally on swap/optionally on swap
(extra on)

> +all tmpfs pages will be shown as "Shmem" in /proc/meminfo and "Shared" i=
n
>  free(1). Notice that these counters also include shared memory
>  (shmem, see ipcs(1)). The most reliable way to get the count is
>  using df(1) and du(1).
> @@ -83,6 +84,8 @@ nr_inodes  The maximum number of inodes for this instan=
ce. The default
>             is half of the number of your physical RAM pages, or (on a
>             machine with highmem) the number of lowmem RAM pages,
>             whichever is the lower.
> +noswap     Disables swap. Remounts must respect the original settings.
> +           By default swap is enabled.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  These parameters accept a suffix k, m or g for kilo, mega and giga and
> diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unev=
ictable-lru.rst
> index 92ac5dca420c..3cdcbb6e00a0 100644
> --- a/Documentation/mm/unevictable-lru.rst
> +++ b/Documentation/mm/unevictable-lru.rst
> @@ -42,6 +42,8 @@ The unevictable list addresses the following classes of=
 unevictable pages:
>
>   * Those owned by ramfs.
>
> + * Those owned by tmpfs with the noswap option.
> +

Nit: s/noswap option/noswap mount option

to make it easier to understand what noswap is

>   * Those mapped into SHM_LOCK'd shared memory regions.
>
>   * Those mapped into VM_LOCKED [mlock()ed] VMAs.
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 103d1000a5a2..21989d4f8cbe 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -45,6 +45,7 @@ struct shmem_sb_info {
>         kuid_t uid;                 /* Mount uid for root directory */
>         kgid_t gid;                 /* Mount gid for root directory */
>         bool full_inums;            /* If i_ino should be uint or ino_t *=
/
> +       bool noswap;                /* ingores VM relcaim / swap requests=
 */

Nit: typos
s/ingores/ignores
s/relcaim/reclaim

>         ino_t next_ino;             /* The next per-sb inode number to us=
e */
>         ino_t __percpu *ino_batch;  /* The next per-cpu inode number to u=
se */
>         struct mempolicy *mpol;     /* default memory policy for mappings=
 */
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6006dbb7dbcb..cd36cb3d974c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -119,10 +119,12 @@ struct shmem_options {
>         bool full_inums;
>         int huge;
>         int seen;
> +       bool noswap;
>  #define SHMEM_SEEN_BLOCKS 1
>  #define SHMEM_SEEN_INODES 2
>  #define SHMEM_SEEN_HUGE 4
>  #define SHMEM_SEEN_INUMS 8
> +#define SHMEM_SEEN_NOSWAP 16
>  };
>
>  #ifdef CONFIG_TMPFS
> @@ -1337,6 +1339,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>         struct address_space *mapping =3D folio->mapping;
>         struct inode *inode =3D mapping->host;
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> +       struct shmem_sb_info *sbinfo =3D SHMEM_SB(inode->i_sb);
>         swp_entry_t swap;
>         pgoff_t index;
>
> @@ -1352,7 +1355,7 @@ static int shmem_writepage(struct page *page, struc=
t writeback_control *wbc)
>                 goto redirty;
>         }
>
> -       if (WARN_ON_ONCE(info->flags & VM_LOCKED))
> +       if (WARN_ON_ONCE((info->flags & VM_LOCKED) || sbinfo->noswap))
>                 goto redirty;
>
>         if (!total_swap_pages)
> @@ -2489,6 +2492,8 @@ static struct inode *shmem_get_inode(struct mnt_idm=
ap *idmap, struct super_block
>                         shmem_set_inode_flags(inode, info->fsflags);
>                 INIT_LIST_HEAD(&info->shrinklist);
>                 INIT_LIST_HEAD(&info->swaplist);
> +               if (sbinfo->noswap)
> +                       mapping_set_unevictable(inode->i_mapping);
>                 simple_xattrs_init(&info->xattrs);
>                 cache_no_acl(inode);
>                 mapping_set_large_folios(inode->i_mapping);
> @@ -3576,6 +3581,7 @@ enum shmem_param {
>         Opt_uid,
>         Opt_inode32,
>         Opt_inode64,
> +       Opt_noswap,
>  };
>
>  static const struct constant_table shmem_param_enums_huge[] =3D {
> @@ -3597,6 +3603,7 @@ const struct fs_parameter_spec shmem_fs_parameters[=
] =3D {
>         fsparam_u32   ("uid",           Opt_uid),
>         fsparam_flag  ("inode32",       Opt_inode32),
>         fsparam_flag  ("inode64",       Opt_inode64),
> +       fsparam_flag  ("noswap",        Opt_noswap),
>         {}
>  };
>
> @@ -3680,6 +3687,10 @@ static int shmem_parse_one(struct fs_context *fc, =
struct fs_parameter *param)
>                 ctx->full_inums =3D true;
>                 ctx->seen |=3D SHMEM_SEEN_INUMS;
>                 break;
> +       case Opt_noswap:
> +               ctx->noswap =3D true;
> +               ctx->seen |=3D SHMEM_SEEN_NOSWAP;
> +               break;
>         }
>         return 0;
>
> @@ -3778,6 +3789,14 @@ static int shmem_reconfigure(struct fs_context *fc=
)
>                 err =3D "Current inum too high to switch to 32-bit inums"=
;
>                 goto out;
>         }
> +       if ((ctx->seen & SHMEM_SEEN_NOSWAP) && ctx->noswap && !sbinfo->no=
swap) {
> +               err =3D "Cannot disable swap on remount";
> +               goto out;
> +       }
> +       if (!(ctx->seen & SHMEM_SEEN_NOSWAP) && !ctx->noswap && sbinfo->n=
oswap) {
> +               err =3D "Cannot enable swap on remount if it was disabled=
 on first mount";
> +               goto out;
> +       }
>
>         if (ctx->seen & SHMEM_SEEN_HUGE)
>                 sbinfo->huge =3D ctx->huge;
> @@ -3798,6 +3817,10 @@ static int shmem_reconfigure(struct fs_context *fc=
)
>                 sbinfo->mpol =3D ctx->mpol;       /* transfers initial re=
f */
>                 ctx->mpol =3D NULL;
>         }
> +
> +       if (ctx->noswap)
> +               sbinfo->noswap =3D true;
> +
>         raw_spin_unlock(&sbinfo->stat_lock);
>         mpol_put(mpol);
>         return 0;
> @@ -3852,6 +3875,8 @@ static int shmem_show_options(struct seq_file *seq,=
 struct dentry *root)
>                 seq_printf(seq, ",huge=3D%s", shmem_format_huge(sbinfo->h=
uge));
>  #endif
>         shmem_show_mpol(seq, sbinfo->mpol);
> +       if (sbinfo->noswap)
> +               seq_printf(seq, ",noswap");
>         return 0;
>  }
>
> @@ -3895,6 +3920,7 @@ static int shmem_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>                         ctx->inodes =3D shmem_default_max_inodes();
>                 if (!(ctx->seen & SHMEM_SEEN_INUMS))
>                         ctx->full_inums =3D IS_ENABLED(CONFIG_TMPFS_INODE=
64);
> +               sbinfo->noswap =3D ctx->noswap;
>         } else {
>                 sb->s_flags |=3D SB_NOUSER;
>         }
> --
> 2.39.1
>

The change logically makes sense to me but I am not at all familiar
with shmem and fs stuff, so I would rather someone else take a look.
