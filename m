Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E035FEAC6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJNIrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJNIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:47:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854BD9F37F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:47:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sc25so8954516ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQiJsgQr5TBzKYI/UzuN+aYvAiaOIe2Dysr8E2kN8No=;
        b=P63uH698engtPrPitLKkFMZZDMV9ltLDXjIjOsvY0gG1TKrDXtPn7dvgbOgEnjgm9R
         vuSYj+7APn56QHIOtm36+p8PrdhEdDlePLuKKQ41JfeEt9uhscZxOOVwhoF7aD/aX+4F
         acru0x7EQVj7P7zxe2cxC/EPfom8bo817otFReRYdnFM7lO42OboFdGpOplGuuleM84x
         bBeXvTLxCD0SONDU6AWLTUHji8XkRWRotokcwKP0ZDgpkOH20oCOTHjBEFqaQPbJizqr
         T3lqRO02kKsQQxw0qdkFgTqYdCiZK+yLzVYTJLtCve9RPGupQB8foKWEV6DJuNGceoPg
         9fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQiJsgQr5TBzKYI/UzuN+aYvAiaOIe2Dysr8E2kN8No=;
        b=06k4ytRLlj+MMwIdylmKUHcD6x0o4nbvoPsMcUNhiBi/WI+LqGeOhiJgRnly3rrJ39
         4hV2ohDvriHy+4qGGgcdjUEjLGAIFW5GY/LuwZ1a9LkU36A+kljoAh4/q6A8KorKUJDE
         F2pBL1EHPo89yVXe1CxgRL2Dr70PCuzmhcNbO3r9uA9Yu6yWirKi53sVuTMTV/33RDK9
         Nb7ys6jvaG8PVWSCRkLaU5SKXi0Ga3oem5bV/vjbyDbrSB3a+E+0Enm+A4Cx9Vp2Au9H
         GtN/ll1rOvLfERCczVdmpqT4JgCsiEerWbA0tvntecGyMGzyPDAzw3KHnG+m8udCzjKJ
         p+Bg==
X-Gm-Message-State: ACrzQf2ebrXS56b6Yean262K8moAENXgWRkcOILwgea5OmDkW4h1ew/t
        N8EZ1xG8OClhRFeulcU9fd9w6JARfZR1a+FH47GyDcdEFinE6w==
X-Google-Smtp-Source: AMsMyM6CVSNNCeKIrx5gVla87CuZzPSu52JpjxtXVE399tVPbQQDzqtkT4pk6H8cORO7yUAcNd05DvkXQO4880fkyvU=
X-Received: by 2002:a17:907:c18:b0:78d:8577:7c30 with SMTP id
 ga24-20020a1709070c1800b0078d85777c30mr2626336ejc.413.1665737225935; Fri, 14
 Oct 2022 01:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220929054500.488604-1-dzm91@hust.edu.cn> <96566993-e888-6d98-25a6-818dd4f2a327@oracle.com>
In-Reply-To: <96566993-e888-6d98-25a6-818dd4f2a327@oracle.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 14 Oct 2022 16:45:02 +0800
Message-ID: <CAD-N9QWdqwGZZFN02TyT=Ht2Fhe3NyodZPzssFN2n-0_YX8t1Q@mail.gmail.com>
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbAllocAG
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
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

On Fri, Oct 14, 2022 at 4:55 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 9/29/22 12:44AM, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Syzbot found a crash : UBSAN: shift-out-of-bounds in dbAllocAG. The
> > underlying bug is the missing check of bmp->db_agl2size. The field can
> > be greater than 32 and trigger the shift-out-of-bounds.
>
> The shift is done to a 64-byte value, not 32.
>
> The volume can contain up to 2^43 blocks, which are divided up into 128
> (2^7) aggregate groups, so each AG can have 2^36 blocks, which makes 36
> a valid value for db_agl2size.

Thanks for your explanation. Will send a v2 patch after testing in Syzbot.

>
> >
> > Fix this bug by adding a check of bmp->db_agl2size in dbMount since this
> > field is used in many following functions. Note that, for maintainance,
> > I reorganzie the error handling code of dbMount.
> >
> > Reported-by: syzbot+15342c1aa6a00fb7a438@syzkaller.appspotmail.com
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >   fs/jfs/jfs_dmap.c | 21 +++++++++++++++------
> >   1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> > index 6b838d3ae7c2..4c717f245920 100644
> > --- a/fs/jfs/jfs_dmap.c
> > +++ b/fs/jfs/jfs_dmap.c
> > @@ -155,7 +155,7 @@ int dbMount(struct inode *ipbmap)
> >       struct bmap *bmp;
> >       struct dbmap_disk *dbmp_le;
> >       struct metapage *mp;
> > -     int i;
> > +     int i, err;
> >
> >       /*
> >        * allocate/initialize the in-memory bmap descriptor
> > @@ -170,8 +170,8 @@ int dbMount(struct inode *ipbmap)
> >                          BMAPBLKNO << JFS_SBI(ipbmap->i_sb)->l2nbperpage,
> >                          PSIZE, 0);
> >       if (mp == NULL) {
> > -             kfree(bmp);
> > -             return -EIO;
> > +             err = -EIO;
> > +             goto err_kfree_bmp;
> >       }
> >
> >       /* copy the on-disk bmap descriptor to its in-memory version. */
> > @@ -181,9 +181,8 @@ int dbMount(struct inode *ipbmap)
> >       bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
> >       bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
> >       if (!bmp->db_numag) {
> > -             release_metapage(mp);
> > -             kfree(bmp);
> > -             return -EINVAL;
> > +             err = -EINVAL;
> > +             goto err_release_metapage;
> >       }
> >
> >       bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
> > @@ -194,6 +193,10 @@ int dbMount(struct inode *ipbmap)
> >       bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
> >       bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
> >       bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
> > +     if (bmp->db_agl2size >= 32) {
>
> I think the right number here is MAXMAPSIZE - L2MAXAG, so
>
>         if (bmp->db_agl2size > (MAXMAPSIZE - L2MAXAG)) {
>
> > +             err = -EINVAL;
> > +             goto err_release_metapage;
> > +     }
> >       for (i = 0; i < MAXAG; i++)
> >               bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
> >       bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
> > @@ -214,6 +217,12 @@ int dbMount(struct inode *ipbmap)
> >       BMAP_LOCK_INIT(bmp);
> >
> >       return (0);
> > +
> > +err_release_metapage:
> > +     release_metapage(mp);
> > +err_kfree_bmp:
> > +     kfree(bmp);
> > +     return err;
> >   }
> >
> >
