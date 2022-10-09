Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC65F88C2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJICCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJICCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:02:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F5320
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:02:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y14so1391087ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e0px72rYv17eGGLFJrNQTSqOtbGfg8k58Qe4LfuI8U0=;
        b=imEpIP/YLhwVcq9RoKj5OQ1UkgBsbwbD1XoyG84N39uIr5nzjo2YL4Undbv+tpr0C0
         OkbVtk4VmWLHalhe8722TkKWoKVgTyhNaIlFpjsEpH0f5clr/Z3GCYDgmAV5xZUlyeal
         b6x30XmspvHtDHfSP6H06t1chXqDaZxCU9ldKwjtUxdqke/s8IjvXUGTgmBaoVWMbuFf
         8fI0IwNw2264U1m4hlVcPhzR5PxVnRMy/RxVbJPrbbaT1n4qvfF/meOxMMFl+VGtQMt5
         Wkmfu2njgfpNMHjnuhQvxNqM5GaRYRcdKpyHoDbwH6N6JAblzFHBzOshXdG838OOvU17
         QYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0px72rYv17eGGLFJrNQTSqOtbGfg8k58Qe4LfuI8U0=;
        b=vo4n3RNZ4ecy8sEoLvXYmSMAvo7DFPutm6JHoPK6Kp6yA20hFWMmt2qLRGR02A2vnC
         SgAcnoxb+/uJdDlFqdReFHDORuhmqfNWmLZH3nsz6gZQ4PWv2LvDrghXPGIalR+3rBmo
         pjXQBpIhnJ4fmH8MxF2kK5nITFNQzEMWWyf9EU5ucgqfbNkaxZMu4keeDACk7seRYEUA
         XO3l+D/GDqdBKkbXEQLZ9wmS+WDa1U0H3Xn32Psbm3ZxgNzq0iJGay5t8JPQwY/oFZyL
         0nfIJyyjZnDg7FzfX4O8xEABskTifkO28NIBVZ3UzaTws5liy/kpQ80/OoAxBtIVtYL3
         zpSg==
X-Gm-Message-State: ACrzQf0cQdnglONG/1YKP0k/a7qtIFn5FC+Q9Byu7sAIBGJ/76yXA9oC
        4rrrk7bux/QFWxh3LWM2cQeiBsyvSnVIQ4UXk98=
X-Google-Smtp-Source: AMsMyM6HZHMRjuWUkkYNJdmK7rGdkCV9J0AAV0p8GsIVBCNxIoU+XcfgeRh8fg7DiyvmfSqNngyuwEQzPOaM/iHQ848=
X-Received: by 2002:a17:906:fd8d:b0:780:997:8b7b with SMTP id
 xa13-20020a170906fd8d00b0078009978b7bmr9671021ejb.635.1665280970954; Sat, 08
 Oct 2022 19:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220929054500.488604-1-dzm91@hust.edu.cn>
In-Reply-To: <20220929054500.488604-1-dzm91@hust.edu.cn>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Sun, 9 Oct 2022 10:00:48 +0800
Message-ID: <CAD-N9QXODN4xjOg3a3chs0yxfXfAO8pY+yud0Den+1padxGoLA@mail.gmail.com>
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbAllocAG
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 1:47 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
>
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>
> Syzbot found a crash : UBSAN: shift-out-of-bounds in dbAllocAG. The
> underlying bug is the missing check of bmp->db_agl2size. The field can
> be greater than 32 and trigger the shift-out-of-bounds.
>
> Fix this bug by adding a check of bmp->db_agl2size in dbMount since this
> field is used in many following functions. Note that, for maintainance,
> I reorganzie the error handling code of dbMount.
>
> Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/jfs/jfs_dmap.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..4c717f245920 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -155,7 +155,7 @@ int dbMount(struct inode *ipbmap)
>         struct bmap *bmp;
>         struct dbmap_disk *dbmp_le;
>         struct metapage *mp;
> -       int i;
> +       int i, err;
>
>         /*
>          * allocate/initialize the in-memory bmap descriptor
> @@ -170,8 +170,8 @@ int dbMount(struct inode *ipbmap)
>                            BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
>                            PSIZE, 0);
>         if (mp == NULL) {
> -               kfree(bmp);
> -               return -EIO;
> +               err = -EIO;
> +               goto err_kfree_bmp;
>         }
>
>         /* copy the on-disk bmap descriptor to its in-memory version. */
> @@ -181,9 +181,8 @@ int dbMount(struct inode *ipbmap)
>         bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
>         bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
>         if (!bmp->db_numag) {
> -               release_metapage(mp);
> -               kfree(bmp);
> -               return -EINVAL;
> +               err = -EINVAL;
> +               goto err_release_metapage;
>         }
>
>         bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
> @@ -194,6 +193,10 @@ int dbMount(struct inode *ipbmap)
>         bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
>         bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
>         bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
> +       if (bmp->db_agl2size >= 32) {
> +               err = -EINVAL;
> +               goto err_release_metapage;
> +       }
>         for (i = 0; i < MAXAG; i++)
>                 bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
>         bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
> @@ -214,6 +217,12 @@ int dbMount(struct inode *ipbmap)
>         BMAP_LOCK_INIT(bmp);
>
>         return (0);
> +
> +err_release_metapage:
> +       release_metapage(mp);
> +err_kfree_bmp:
> +       kfree(bmp);
> +       return err;
>  }
>

ping?

>
> --
> 2.35.1
>
