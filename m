Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD16A7B82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 07:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBGyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 01:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 01:54:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B055618B2B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 22:54:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s26so63455201edw.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 22:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677740071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3eEPZH6njnIeK/Um5RxY6UEilrW6WZVGGBJ9v9v6eE=;
        b=pcN6KUJN58g9p6RYtH/MZIlTzhEfGDqqL2hPl8Hkjn9FZwmPCqX2KhqlZso+onNJMT
         x6IQWEF8zvWhrSBj8bRt4ezhy2ReAicvN4sxdrKyAUixv7WwZrzDU6OiF+MnBMCmw48Q
         M4pbSj6+IvyH8quy2lv7fuxcBiKCRwSQ0VyFMwfDaL3JltN7uBXO953gHDBwQ2mc+Sd9
         25g/t8eF3RwgA0syGE8SySJK8zaINJ4cUauBXZo/jiqoMOtMUI3Q++A1goC7twR72Yo7
         8ZAqT5cNCtHgfpLykVlzk9jD6vXkrANt2r5SXmvUzmq2Qz0xykqp2nDyAQYuUti74ONs
         2URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677740071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3eEPZH6njnIeK/Um5RxY6UEilrW6WZVGGBJ9v9v6eE=;
        b=o7b6fg4hIJqG8PFESF4GNc3DhPc9z/jPI1UVCszieVg8XpNaksRMf0Rsb51y5F4Nay
         3C40KeSOb1mNyFEtiMtUVjqFGkywxouSyz4rHkxYBx4CpC3vDCdIO+lMEfKBg4sSihsu
         hg/22GI62UOQf0d0bI5uxtFZzZdye4UPekCPf/uIYwfbXw0EQUVKAkgdd0dRvmQTdMgS
         nPVws4IQJoqnCrE3cuGc2LveinEZqaMOAl4ycTutmI7pUMP7BejD735ZG24DSVfSpomm
         CfBtQkPBVSnmNA3hBFkvNRcYvkl6v6JTMu15alySJ0w77zOjP5WAW99CjTxWhZTUs/M7
         lgUg==
X-Gm-Message-State: AO0yUKWQlWMkh4jHiYOEvIWLEWPNKPW0nDmF7iRSvBQ0tpGQiQcFkS93
        VHkP0xqVugRFLjGVDnq9N0lls8o82GVPiZi+Fv8=
X-Google-Smtp-Source: AK7set+boTiUTcwEo3KjdbcZ5gH+8EbalFWZcGOdBtUzQ9tWk+fX3xE0o9WAtL/1S43iHmkz0dPxwTV8rum+tVE1TqE=
X-Received: by 2002:a17:906:4f99:b0:8b0:e909:9136 with SMTP id
 o25-20020a1709064f9900b008b0e9099136mr4530151eju.1.1677740070945; Wed, 01 Mar
 2023 22:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20230302055103.60116-1-frank.li@vivo.com>
In-Reply-To: <20230302055103.60116-1-frank.li@vivo.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Thu, 2 Mar 2023 15:54:19 +0900
Message-ID: <CAD14+f2qj8XKPzNog5WZQHONS9CL9X6jbuGO=mUGzB115JdwZQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce discard_cpuset mount opt
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems very counterintuitive.

a. GC and discard operations are mostly I/O-bound.
b. Both run when the storage is idle unless background conditions are
not met and are forced to run synchronously (i.e., foreground).

Setting the cpumask to run on the most efficient CPU core makes more
sense in my books (especially considering Android's I/O
characteristics).

Please provide data/elaborations for:
i. Why just the discard thread?
ii. Does setting the discard thread to big cores provide meaningful
and practical improvements?
iii. Is it enough to justify an explicit mask over HMP scheduler's own
heuristic?
iv. Is the additional power consumption for setting the mask to more
power hungry cores justified?

f2fs mount options are already pretty convoluted, and unfortunately
neither your commit message nor the code itself seem to justify its
addition imho.

Thanks,

On Thu, Mar 2, 2023 at 2:52=E2=80=AFPM Yangtao Li via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> It makes the discard process run faster on a more powerful CPU, or not.
> And if bind it to a specific cpu, it is possible to have more cache
> locality.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -fix kernel test robot warn
>  Documentation/filesystems/f2fs.rst |  2 ++
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/segment.c                  |  8 ++++++-
>  fs/f2fs/super.c                    | 36 ++++++++++++++++++++++++++++++
>  kernel/kthread.c                   |  1 +
>  5 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesyste=
ms/f2fs.rst
> index 2055e72871fe..dc005f3b784a 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -351,6 +351,8 @@ age_extent_cache     Enable an age extent cache based=
 on rb-tree. It records
>                          data block update frequency of the extent per in=
ode, in
>                          order to provide better temperature hints for da=
ta block
>                          allocation.
> +discard_cpuset=3D%u               Set the cpumask of dicard thread, it m=
akes the discard
> +                        process run faster on a more powerful CPU, or no=
t.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  Debugfs Entries
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b0ab2062038a..62ce02a87d33 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -183,6 +183,7 @@ struct f2fs_mount_info {
>         int compress_mode;                      /* compression mode */
>         unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /=
* extensions */
>         unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];=
 /* extensions */
> +       struct cpumask discard_cpumask; /* discard thread cpumask */
>  };
>
>  #define F2FS_FEATURE_ENCRYPT           0x0001
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 227e25836173..2648c564833e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2054,11 +2054,17 @@ int f2fs_start_discard_thread(struct f2fs_sb_info=
 *sbi)
>         if (!f2fs_realtime_discard_enable(sbi))
>                 return 0;
>
> -       dcc->f2fs_issue_discard =3D kthread_run(issue_discard_thread, sbi=
,
> +       dcc->f2fs_issue_discard =3D kthread_create(issue_discard_thread, =
sbi,
>                                 "f2fs_discard-%u:%u", MAJOR(dev), MINOR(d=
ev));
>         if (IS_ERR(dcc->f2fs_issue_discard)) {
>                 err =3D PTR_ERR(dcc->f2fs_issue_discard);
>                 dcc->f2fs_issue_discard =3D NULL;
> +       } else {
> +               if (!cpumask_empty(&F2FS_OPTION(sbi).discard_cpumask)) {
> +                       kthread_bind_mask(dcc->f2fs_issue_discard,
> +                                       &F2FS_OPTION(sbi).discard_cpumask=
);
> +               }
> +               wake_up_process(dcc->f2fs_issue_discard);
>         }
>
>         return err;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fbaaabbcd6de..8ecbe3595f34 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -164,6 +164,7 @@ enum {
>         Opt_discard_unit,
>         Opt_memory_mode,
>         Opt_age_extent_cache,
> +       Opt_discard_cpuset,
>         Opt_err,
>  };
>
> @@ -243,6 +244,7 @@ static match_table_t f2fs_tokens =3D {
>         {Opt_discard_unit, "discard_unit=3D%s"},
>         {Opt_memory_mode, "memory=3D%s"},
>         {Opt_age_extent_cache, "age_extent_cache"},
> +       {Opt_discard_cpuset, "discard_cpuset=3D%u"},
>         {Opt_err, NULL},
>  };
>
> @@ -1256,6 +1258,22 @@ static int parse_options(struct super_block *sb, c=
har *options, bool is_remount)
>                 case Opt_age_extent_cache:
>                         set_opt(sbi, AGE_EXTENT_CACHE);
>                         break;
> +               case Opt_discard_cpuset:
> +                       if (!f2fs_hw_support_discard(sbi)) {
> +                               f2fs_warn(sbi, "device does not support d=
iscard");
> +                               break;
> +                       }
> +
> +                       if (args->from && match_int(args, &arg))
> +                               return -EINVAL;
> +
> +                       if (!cpu_possible(arg)) {
> +                               f2fs_err(sbi, "invalid cpu%d for discard_=
cpuset", arg);
> +                               return -EINVAL;
> +                       }
> +
> +                       cpumask_set_cpu(arg, &F2FS_OPTION(sbi).discard_cp=
umask);
> +                       break;
>                 default:
>                         f2fs_err(sbi, "Unrecognized mount option \"%s\" o=
r missing value",
>                                  p);
> @@ -1358,6 +1376,14 @@ static int parse_options(struct super_block *sb, c=
har *options, bool is_remount)
>                 f2fs_err(sbi, "Allow to mount readonly mode only");
>                 return -EROFS;
>         }
> +
> +       if (!cpumask_empty(&F2FS_OPTION(sbi).discard_cpumask) &&
> +                       !cpumask_intersects(cpu_online_mask,
> +                               &F2FS_OPTION(sbi).discard_cpumask)) {
> +               f2fs_err(sbi, "Must include one online CPU for discard_cp=
uset");
> +               return -EINVAL;
> +       }
> +
>         return 0;
>  }
>
> @@ -1884,6 +1910,7 @@ static inline void f2fs_show_compress_options(struc=
t seq_file *seq,
>  static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  {
>         struct f2fs_sb_info *sbi =3D F2FS_SB(root->d_sb);
> +       unsigned int cpu;
>
>         if (F2FS_OPTION(sbi).bggc_mode =3D=3D BGGC_MODE_SYNC)
>                 seq_printf(seq, ",background_gc=3D%s", "sync");
> @@ -1909,6 +1936,8 @@ static int f2fs_show_options(struct seq_file *seq, =
struct dentry *root)
>                         seq_printf(seq, ",discard_unit=3D%s", "segment");
>                 else if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNI=
T_SECTION)
>                         seq_printf(seq, ",discard_unit=3D%s", "section");
> +               for_each_cpu(cpu, &F2FS_OPTION(sbi).discard_cpumask)
> +                       seq_printf(seq, ",discard_cpuset=3D%u", cpu);
>         } else {
>                 seq_puts(seq, ",nodiscard");
>         }
> @@ -2340,6 +2369,13 @@ static int f2fs_remount(struct super_block *sb, in=
t *flags, char *data)
>                 goto restore_opts;
>         }
>
> +       if (!cpumask_equal(&org_mount_opt.discard_cpumask,
> +                       &F2FS_OPTION(sbi).discard_cpumask)) {
> +               err =3D -EINVAL;
> +               f2fs_warn(sbi, "switch discard_cpuset option is not allow=
ed");
> +               goto restore_opts;
> +       }
> +
>         if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
>                 err =3D -EINVAL;
>                 f2fs_warn(sbi, "disabling checkpoint not compatible with =
read-only");
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 7e6751b29101..8ddc2cd1b27e 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -541,6 +541,7 @@ void kthread_bind_mask(struct task_struct *p, const s=
truct cpumask *mask)
>  {
>         __kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
>  }
> +EXPORT_SYMBOL_GPL(kthread_bind_mask);
>
>  /**
>   * kthread_bind - bind a just-created kthread to a cpu.

This change to kernel/kthread.c should be made in a separate commit.

> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
