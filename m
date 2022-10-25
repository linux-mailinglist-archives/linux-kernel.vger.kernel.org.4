Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3311560C325
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJYFMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJYFMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:12:51 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D1264B9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:12:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a5so21501822edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 22:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9aTHUqAheweyy4ly5f1XL+MDpqeGn6Gh3fTd+xRqqGg=;
        b=Su5LRX20NO5m7VHBO9GKbjIzmeZNIIurDnF3KvBWymvVp1/y2NrbbxBtoeuUs9b3iD
         n3PsRkwVWd9dpB40ElzE08bjqRBzM1EXQZxRHfABeGllH8PPvIy7CJD1ALU+qq5Jn+fD
         vfA5RuYErAMoArBEaEOuXFCg4S8cZ2B+YBVpF1yHKQD+6cAblY70ibk+I7M1AbJqDMG1
         Fw8tMT1omuN5az73TY9wlGEd6ay7wD5RjReMaOr/XBDLL8jpbu67DrWmb674lRoUcQyB
         c/MxaimY3/lJhUY95/NRJC1n4Xwa1Ujul1NSBbkAd7L4MA5LM80Cu+OJnRf0k7eDdgne
         caBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9aTHUqAheweyy4ly5f1XL+MDpqeGn6Gh3fTd+xRqqGg=;
        b=jSo67tO5jLiuPE8q+ou2zYscys3t0WLbhKwvMvJiQD7s7ujdN4e7Mf3prw5V8gGFUb
         gEPh5fJC7Rwb3wFtn6IgQ24VEYmmy2vi0OQ3dn7m01TD5zIe03iXscLcysXH3o/ee+cV
         O091Cssy+tmLDRaY58J/ug+N8VpoqqEVMkE2ri/4JF1NOZ8eL9BUPfuodAQGiSM/uCwc
         N6ErWZPl6UZQUIwaUF9Kuy+WMMuASaZx5qBCJL/w4FvPdhsaccAGTgLI8Ynh1HfR9wVm
         vsKS77x0MeVH2XOFiM/x09RVicCIQjeHF0kroSqQD0frbRQFkqehAG8gTU1/rAz8hl5D
         lcOw==
X-Gm-Message-State: ACrzQf0zhTGe5I0zz57ZYLBkQuuGFg7yCBD05IJQcG3g/0gI1Do53mcQ
        CSOG5E8NdTHFYyd7tFq3AdNVXetQ2/19cLiPLttZ14NA
X-Google-Smtp-Source: AMsMyM6RArFbp850nkgtiOqcN7VB6Bf8Ce8q8gjZVQC1pTTQD0UTubifiigV5lFZS4AvnymXd1WpZoY87T7/uU/lo7s=
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id
 g9-20020a056402090900b004350a8b5232mr33858562edz.240.1666674768924; Mon, 24
 Oct 2022 22:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221019093825.339991-1-wuhoipok@gmail.com> <286146b0-51bb-a1d0-fa28-50e5a792aeed@oracle.com>
In-Reply-To: <286146b0-51bb-a1d0-fa28-50e5a792aeed@oracle.com>
From:   Hoi Pok Wu <wuhoipok@gmail.com>
Date:   Tue, 25 Oct 2022 13:12:43 +0800
Message-ID: <CANyH0kDm8rMVBDNJVsXxYxDH+=S_UsKu82PgFL82WhgmtvsXig@mail.gmail.com>
Subject: Re: [PATCH] fs: jfs: fix shift-out-of-bounds in dbDiscardAG
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
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

Thanks for the suggestion! I will send a Patch V2 soon.


On Tue, Oct 25, 2022 at 5:05 AM Dave Kleikamp <dave.kleikamp@oracle.com> wrote:
>
> On 10/19/22 4:38AM, Hoi Pok Wu wrote:
> > Bug reported by syzbot, UBSAN: array-index-out-of-bounds in dbDiscardAG.
> > Fixed by simply rearranging agno_end smaller than MAXAG. However, I wonder if it
> > is a better idea to return -EINVAL, rejecting user input. Thank you.
>
> I don't think the problem is simply that the user input is bad, the
> range is already limited:
>
>          if (end >= bmp->db_mapsize)
>                  end = bmp->db_mapsize - 1;
>
> It seems syzbot corrupted some on-disk data structure to trigger this
> failure. It may be best to call jfs_error() and bail out.
>
> Thanks,
> Shaggy
>
> >
> > Reported-by: syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com
> > Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
> > ---
> >   fs/jfs/jfs_discard.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
> > index 575cb2ba74fc..3101eaf3098a 100644
> > --- a/fs/jfs/jfs_discard.c
> > +++ b/fs/jfs/jfs_discard.c
> > @@ -96,6 +96,10 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
> >        */
> >       agno = BLKTOAG(start, JFS_SBI(ip->i_sb));
> >       agno_end = BLKTOAG(end, JFS_SBI(ip->i_sb));
> > +
> > +     if (agno_end >= MAXAG)
> > +             agno_end = MAXAG - 1;
> > +
> >       while (agno <= agno_end) {
> >               trimmed += dbDiscardAG(ip, agno, minlen);
> >               agno++;
