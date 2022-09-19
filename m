Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFA5BD48C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiISSKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiISSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD0476CF;
        Mon, 19 Sep 2022 11:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF85A61975;
        Mon, 19 Sep 2022 18:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A38BC433B5;
        Mon, 19 Sep 2022 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663610960;
        bh=VJm+P9KFcr5097FWH1+8BCAEzA4C9xFzKzMDnxTKqNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iHPt++Lfp10tqX3ervJ3BdILDePf09F+JHOUg0RBs9ttbfSOhRjMMsTX6EEZjhJb0
         4sTOzoTUvIu7NRQ1/vz+raiCODi445KFJlzGRAchy6kOGW2rJ/+BHt6eTWklxoC28F
         vwu1N+XIaBFvpsRg1Eb1DbSatbPy9QECA4w/lZIwNQdeuaKpXQAPKbETDdnum+nkbR
         GfM7BX104wVkNydQlhhHWaS5fgq2Lz+RzF0QzEeZOUrHJmXSY4Ws144Th7sBNGuigi
         TBENKJftU0E+mR2hrTxNJyTijq/qEdn2ET1GGUxGmLjBamLOwIRJ0gMX1VvlYSMIBj
         kSH+GLgM5baRA==
Received: by mail-ej1-f49.google.com with SMTP id dv25so480981ejb.12;
        Mon, 19 Sep 2022 11:09:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf0WJk169yrrAbur7z/nGwdwgHzI6crQwETwKh9PxJZnDguUdZZf
        5nIb98s7jkTp+iW4/SzetuvcRPxUMhidT5wFcdY=
X-Google-Smtp-Source: AMsMyM5vduYtNbA9i0oVFZCeILZpBKOFQ21px7Kkm37BzUnXENP7tzg+7WcF3NsEUgSyBv0V61lIqk5BOTzEp5w7rxg=
X-Received: by 2002:a17:907:2c67:b0:77d:740a:e9b1 with SMTP id
 ib7-20020a1709072c6700b0077d740ae9b1mr13382038ejc.614.1663610958458; Mon, 19
 Sep 2022 11:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <1661280664-10588-1-git-send-email-ssengar@linux.microsoft.com> <PUZP153MB0749E4AA8A8039412DC87080BE4D9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB0749E4AA8A8039412DC87080BE4D9@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
From:   Song Liu <song@kernel.org>
Date:   Mon, 19 Sep 2022 11:09:06 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Mubp18wkG43HDgjwq=MVx21Bkj2JrEBaMJVFT2cAZkA@mail.gmail.com>
Message-ID: <CAPhsuW7Mubp18wkG43HDgjwq=MVx21Bkj2JrEBaMJVFT2cAZkA@mail.gmail.com>
Subject: Re: [PATCH v2] md : Replace snprintf with scnprintf
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "shli@fb.com" <shli@fb.com>, "neilb@suse.com" <neilb@suse.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "guoqing.jiang@linux.dev" <guoqing.jiang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 9:47 AM Saurabh Singh Sengar
<ssengar@microsoft.com> wrote:
>
> Is this queued  for 6.0 ?

This is queued for 6.1.

Thanks,
Song

>
> > -----Original Message-----
> > From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Sent: Wednesday, August 24, 2022 12:21 AM
> > To: song@kernel.org; shli@fb.com; neilb@suse.com; linux-
> > raid@vger.kernel.org; linux-kernel@vger.kernel.org; Saurabh Singh Senga=
r
> > <ssengar@microsoft.com>; Michael Kelley (LINUX)
> > <mikelley@microsoft.com>; guoqing.jiang@linux.dev
> > Subject: [PATCH v2] md : Replace snprintf with scnprintf
> >
> > Current code produces a warning as shown below when total characters in
> > the constituent block device names plus the slashes exceeds 200.
> > snprintf() returns the number of characters generated from the given in=
put,
> > which could cause the expression =E2=80=9C200 =E2=80=93 len=E2=80=9D to=
 wrap around to a large
> > positive number. Fix this by using scnprintf() instead, which returns t=
he
> > actual number of characters written into the buffer.
> >
> > [ 1513.267938] ------------[ cut here ]------------ [ 1513.267943] WARN=
ING:
> > CPU: 15 PID: 37247 at <snip>/lib/vsprintf.c:2509 vsnprintf+0x2c8/0x510 =
[
> > 1513.267944] Modules linked in:  <snip> [ 1513.267969] CPU: 15 PID: 372=
47
> > Comm: mdadm Not tainted 5.4.0-1085-azure #90~18.04.1-Ubuntu [
> > 1513.267969] Hardware name: Microsoft Corporation Virtual Machine/Virtu=
al
> > Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022 [ 1513.267971] RIP:
> > 0010:vsnprintf+0x2c8/0x510 <-snip-> [ 1513.267982] Call Trace:
> > [ 1513.267986]  snprintf+0x45/0x70
> > [ 1513.267990]  ? disk_name+0x71/0xa0
> > [ 1513.267993]  dump_zones+0x114/0x240 [raid0] [ 1513.267996]  ?
> > _cond_resched+0x19/0x40 [ 1513.267998]  raid0_run+0x19e/0x270 [raid0] [
> > 1513.268000]  md_run+0x5e0/0xc50 [ 1513.268003]  ?
> > security_capable+0x3f/0x60 [ 1513.268005]  do_md_run+0x19/0x110 [
> > 1513.268006]  md_ioctl+0x195e/0x1f90 [ 1513.268007]
> > blkdev_ioctl+0x91f/0x9f0 [ 1513.268010]  block_ioctl+0x3d/0x50 [
> > 1513.268012]  do_vfs_ioctl+0xa9/0x640 [ 1513.268014]  ? __fput+0x162/0x=
260
> > [ 1513.268016]  ksys_ioctl+0x75/0x80 [ 1513.268017]
> > __x64_sys_ioctl+0x1a/0x20 [ 1513.268019]  do_syscall_64+0x5e/0x200 [
> > 1513.268021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Fixes: 766038846e875 ("md/raid0: replace printk() with pr_*()")
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > V2 :
> >       - Rebase
> >
> >  drivers/md/raid0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c index 78addfe..857=
c493
> > 100644
> > --- a/drivers/md/raid0.c
> > +++ b/drivers/md/raid0.c
> > @@ -47,7 +47,7 @@ static void dump_zones(struct mddev *mddev)
> >               int len =3D 0;
> >
> >               for (k =3D 0; k < conf->strip_zone[j].nb_dev; k++)
> > -                     len +=3D snprintf(line+len, 200-len, "%s%pg", k?"=
/":"",
> > +                     len +=3D scnprintf(line+len, 200-len, "%s%pg", k?=
"/":"",
> >                               conf->devlist[j * raid_disks + k]->bdev);
> >               pr_debug("md: zone%d=3D[%s]\n", j, line);
> >
> > --
> > 1.8.3.1
>
