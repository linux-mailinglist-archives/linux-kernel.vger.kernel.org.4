Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CA621B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiKHRuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiKHRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:50:49 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9631A4;
        Tue,  8 Nov 2022 09:50:47 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id n68so14203602vsc.3;
        Tue, 08 Nov 2022 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d65wWk/jkg9zuxHphjdBu6sKY6MHpZ4T91fr96Os0Ho=;
        b=RQ/6rqoyLWdaIBU9C8GBbJdzpecc8Uh+vL2EmdTuDBf61diLNt0JJhMyFz1MGs3KpQ
         z3N/ueyJJfUGX5OKgMHvd/dKddywizJ0pTrz8QzfGrY3RgdD2RY+pNhNl1SoCnr67mZ6
         fPsw+X2LLT37htk+gaDw05X6sx2I5XMO0d093LdjZ0DvD6OAShIIwhpCnDCM7PpnT9iE
         P4hpjFQrxkMAhzULjjm/5Lm0rzRKi+XLE0aOzxtX4TcJVZQh1RbxwFar41eeVg7Om7jP
         yArwoG2nrGS9qOG5IOApeYP1xSXc3Xev71or7Qfdk9/B6gnfwa7MRp7sllyghVa5VndF
         A3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d65wWk/jkg9zuxHphjdBu6sKY6MHpZ4T91fr96Os0Ho=;
        b=PssIR/xKTbyyy/AWqwVHsyNwSaIJI21tnb4agqBi7Ek/+TEeeVDm/MdBJzdENCsAIa
         kwYo8V4j0WQXYg8euovYUD04U4mT2W0+1m6lmfI0tgBrVWgw9PEVvYrmIKa3bBs5vG7l
         O0AED8zOs5SsYOTzXDlARdTEJDBTPrHhP7klIco/5D0vV/Z+n9YW1D0056yuIRKR4IxY
         pM2sVxRf9lpSrSGKfQTCWiCcednQ3h167QBMy1zo9LTBHKBxeaB97ch+XCkfly2mfUtu
         67aO2E3EuIdr5WJyM7ODXIbGBfW+TWDCiAs6RzE8c7YNhOmvJ88dhe6Sbt5ulJRX4di5
         tLuA==
X-Gm-Message-State: ACrzQf3/VSudUv7BHmlclXQg7pO+1dhvXhJjWf1/6NBIJZ83PFsCr375
        KdLqOA1yIJ4pmAH5YY5KOiW6exABRz9AJ4duM92CQV8O59U=
X-Google-Smtp-Source: AMsMyM7KI08K/eJwrODFYfCfj18wXDAUmtmwf/JhftS3M3XPZqadhnjIptGawkeVc8eSxoRG45D0TZhOR6mBzTylr/4=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr29806643vsj.26.1667929846784; Tue, 08
 Nov 2022 09:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com> <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
 <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com> <CAKFNMomK=C4JY7ftNQs7Zs3dr0m=e_k-vVXTfmR-mpumuGUtDw@mail.gmail.com>
 <CAKFNMokX6wudO+WJbdc4-1gTXLXn59=dvm0CLGeXAFiA+kJXdg@mail.gmail.com>
In-Reply-To: <CAKFNMokX6wudO+WJbdc4-1gTXLXn59=dvm0CLGeXAFiA+kJXdg@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 9 Nov 2022 02:50:29 +0900
Message-ID: <CAKFNMomUYhQOHnKJohN_84ROhaD4TgPD=bsV0SPG992uG-8fCQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_segctor_prepare_write()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Liu Shixin,

I'm sorry for my repeated emails.

On Wed, Nov 9, 2022 at 12:13 AM Ryusuke Konishi wrote:
> >
> > I think the most likely cause is metadata corruption.  If so, we
> > should fix it by adding a proper sanity check, yes.
> > However, there is still the possibility that the error retry logic
> > after detecting errors has a flaw. (I believe at least this is not a
> > problem with normal paths.)
> > The sufile state inconsistency above is hypothetical for now.
> > Either way, I'd like to make sure what's actually happening (and where
> > the anomaly is coming from) so we can decide how to fix it.
>
> I noticed that this syzbot report has a disk image "mount_0.gz", so I
> tried to mount it read-only.
> The result was as follows:
>
> $ sudo mount -t nilfs2 -r ./mount_0 /mnt/test
> $ lssu
>               SEGNUM        DATE     TIME STAT     NBLOCKS
>                    0  26760730-10-29 19:40:00  -de   527958016
>                    1  26760730-11-01 20:29:04  -de   527958016
>                    2  1176433641-11-01 02:01:52  -de  2983038235
>                    3  -1158249729-11-01 04:57:19  a--       25375
>                    4  1970-01-02 21:24:32  a--           0
>                    5  -1415215929-01-02 00:19:15  --e  1631451365
>                    6  841067190-01-02 13:02:59  -d-  3101461260
>                    7  1495233207-01-02 01:31:11  -de  1697748441
>                    8  1875753393-01-02 21:54:14  -de   337757600
>                    9  648878284-01-02 21:06:08  ---  2133388152
>                   10  2122778986-01-02 17:49:43  --e   874605800
>                   11  55846197-01-02 09:50:53  -de  4262365368
>                   12  1872396026-01-02 06:45:18  ---  1051768258
>                   13  820920473-01-02 19:28:35  --e  2932336675
>                   14  2128306755-01-02 10:17:45  ---  3568501216
>                   15  1457063063-01-02 01:24:17  --e  2330511560
>                   16  586864775-01-02 16:08:15  ---   355283425
>                   17  -824870041-01-02 22:47:26  -d-  4177999057
>                   18  1562176264-01-02 08:06:45  ---  1312597355
>                   19  -392925420-01-02 17:08:27  -d-  3811075948
>                   20  1927575458-01-02 21:26:51  -de  1384562525
>                   21  2139923505-01-02 08:16:04  -d-    41861305
>
> Here,  we can see that neither segment #3 (= ns_segnum) nor #4 (=
> ns_nextnum) has the dirty flag
> ("d" in STAT).   So, as expected, this seems to be the root cause of
> the duplicate assignments and oops.
> The proper correction would be, therefore, to check and reject (or
> fix) this anomaly while outputting an error message
> (or warning if fix it at the same time).

> It should be inserted in mount time logic because the segments that
> nilfs2 itself allocates are always marked dirty with
> nilfs_sufile_alloc().

I will change my opinion.

Considering the possibility of sufile corruption at runtime, it seems
that the sanity check should be done on every nilfs_sufile_alloc()
call.

I now think nilfs_sufile_alloc() should call nilfs_error() and return
-EIO if the number of a newly found vacant segment matches
nilfs->ns_segnum or nilfs->ns_nextnum.

This test should not need to be done for every segbuf's sb_segnum
because metadata blocks that contain the information about allocated
segments are kept in memory because of its dirty state and will not be
destroyed until they are finally written out.

One correction then.  Just checking the output of the lssu command
wasn't enough because the following test is done on all flags except
the active flag "a".  (this flag is not persistent and visible only
when seeing via ioctl.)

>                         if (!nilfs_segment_usage_clean(su))
>                                 continue;
>                         /* found a clean segment */

We also had to see the invisible flags as well to confirm if that is
the root cause, but lssu doens't show them all.  So I checked the dump
data of the mount_0 file.
As a result, the segment at ns_segnum was not clean, but that of
ns_nextnum was clean, which means it's the root cause as expected.

Regards,
Ryusuke Konishi
