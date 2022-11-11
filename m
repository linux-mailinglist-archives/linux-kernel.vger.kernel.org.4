Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AFC6254CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKKH7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKKH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:59:10 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A5367112;
        Thu, 10 Nov 2022 23:59:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b62so3864337pgc.0;
        Thu, 10 Nov 2022 23:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pveMSuEdi3DIeMZ1Uax+ZhWeXDUKZE4SO272ZTa5I1Q=;
        b=L+ngB/6ctN6+fdzn3cxFKD7rgYm67zAXAilqHhG6DzHtRp7Q48uShWTLNQLhq19iYo
         EiW39dXpUVZd2JqSD4eKq88YHZkijkGtPaMTAcONnKaUdXsRh0Uj/Uf3r44Jni5KP5k4
         wiVw0E0n8pEb3Bhec/JqaV/xAhUcTklaY7oz+ut6C2/OppO7WRv9X7SBZRvyPYBrl2QS
         39prxqz93Up+p3QQCso0YhV0D0ddyrZE1YHdXsPPLjr28CxVD4qlCUYrUpe934iGDpEW
         fdd/pG+benRFXzyKJffTyvSV7fDVwsNrk708tgrMNXvpD6TTw8B+SrcY4XSnoJ5sEYWz
         PjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pveMSuEdi3DIeMZ1Uax+ZhWeXDUKZE4SO272ZTa5I1Q=;
        b=2RfggDE2fY2R8oW7ud8xqzInW5/xbZJmwlf+mSUaH7gDFsEaw6S1HEz2BwAL1y+dlM
         xP7szAESMq60JNmqX+rOT2q4Gzgg0Nt+QMAcQpg9F1PGu5p8UrB7ck9YfSpkCppRmMUt
         CcfsX5S0hVBRcI+V7/spE45O2NSTWQs3BVsR0vACKmBq7fXBGfUjx5ruka1V5zvtvpZ6
         kcD45VA3xHCDzqA9e5wE8Tbuw6Qu0Sep460VJWJ5ZrmrNp4iFbD7r3S/PnLfP8/Obu2S
         MjXIp2g8FYQtHems9M7PZi0hROrJ/qsDKtpuK/WXwi26Uh4c3TPf6twmrcrrBrVxlZRU
         hZig==
X-Gm-Message-State: ANoB5pmV47pJwjcMfpuPupC2QGf+xDKL0z32KDX8yromcafqFsiDwkyF
        QsJYXfdTQQ8OOdJhHblEYzZQZTPqttOWnM6+75k=
X-Google-Smtp-Source: AA0mqf7t/aEwRs6hHuzyCXOK7zP1ELR4qOfpipiy+XfjjmLkexGnAtX7s7V1SdR+voJcuTEGU344joHIjGJ3kCn/5JA=
X-Received: by 2002:aa7:946f:0:b0:56e:174e:efdf with SMTP id
 t15-20020aa7946f000000b0056e174eefdfmr1544172pfq.29.1668153549039; Thu, 10
 Nov 2022 23:59:09 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com> <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com>
In-Reply-To: <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 11 Nov 2022 15:58:57 +0800
Message-ID: <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        axboe@kernel.dk, avri.altman@wdc.com, kch@nvidia.com,
        CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hunter
Thank you for your review!
I'm sorry to reply you so late because I've been too busy lately.

On Fri, Oct 21, 2022 at 11:50 PM Adrian Hunter <adrian.hunter@intel.com> wr=
ote:
>
> On 21/10/22 10:30, Wenchao Chen wrote:
> > From: Wenchao Chen <wenchao.chen@unisoc.com>
> >
> > Summary
> > =3D=3D=3D=3D=3D=3D=3D
> > These patches[1] supports the host to turn off FUA.
> >
> > About FUA, roughly deal with the following two parts:
> > 1) FUA(Forced Unit Access):
> > - The REQ_FUA flag can be OR ed into the r/w flags of a bio submitted f=
rom the
> >   filesystem and will make sure that I/O completion for this request is=
 only
> >   signaled after the data has been committed to non-volatile storage.
> >
> > 2) In emmc, FUA is represented as Reliable write. code show as below:
> > static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_re=
q *mqrq,
> >               int recovery_mode, bool *do_rel_wr_p, bool *do_data_tag_p=
)
> > {
> >       ...
> >       /*
> >        * Reliable writes are used to implement Forced Unit Access and
> >        * are supported only on MMCs.
> >        */
> >       do_rel_wr =3D (req->cmd_flags & REQ_FUA) &&
> >                       rq_data_dir(req) =3D=3D WRITE &&
> >                       (md->flags & MMC_BLK_REL_WR);
> >       ...
> > }
> >
> > Patch structure
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > patch#1:  for block
> > patch#2:  for sdhci-sprd
> >
> > Tests
> > =3D=3D=3D=3D=3D
> > Ran 'AndroBench' to evaluate the performance:
>
> It would be good to have more details e.g.
> What file system? What block size?  What journal size?
> What file size? What record size?
>

What file system?
F2FS
What block size?
Sequential: 32768KB, Random: 4KB
What file size?
64MB

> > 1. fua_disable =3D 1
> > /sys/block/mmcblk0/queue # cat fua 0
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 266.8MiB/s, 265.1MiB/s, 262.9MiB/s, 268.7MiB/s, 265.2MiB/s
> > Average speed: 265.74MiB/s
> >
> > 2) Random read:
> > Speed: 98.75MiB/s, 98.7MiB/s, 98.5MiB/s, 99.4MiB/s, 98.7MiB/s
> > Average speed: 98.81MiB/s
> >
> > 3) Sequential write:
> > Speed: 199.94MiB/s, 199.1MiB/s, 205.5MiB/s, 206.5MiB/s, 191.5MiB/s
> > Average speed: 200.5MiB/s
> >
> > 4) Random write:
> > Speed: 68.6MiB/s, 71.8MiB/s, 77.1MiB/s, 64.8MiB/s, 69.3MiB/s
> > Average speed: 70.32MiB/s
> >
> > 2. fua_disable =3D 0 (default 0)
> > /sys/block/mmcblk0/queue # cat fua 1
> > I tested 5 times for each case and output a average speed.
> >
> > 1) Sequential read:
> > Speed: 259.3MiB/s, 258.8MiB/s, 258.2MiB/s, 259.5MiB/s, 253.5MiB/s
> > Average speed: 257.86MiB/s
> >
> > 2) Random read:
> > Speed: 98.9MiB/s, 101MiB/s, 101MiB/s, 99MiB/s, 101.1MiB/s
> > Average speed: 100.2MiB/s
> >
> > 3) Sequential write:
> > Speed: 153.7MiB/s, 146.2MiB/s, 151.2MiB/s, 148.8MiB/s, 147.5MiB/s
> > Average speed: 149.48MiB/s
> >
> > 4) Random write:
> > Speed: 12.9MiB/s, 12.3MiB/s, 12.6MiB/s, 12.8MiB/s, 12.8MiB/s
> > Average speed: 12.68MiB/s
>
> Is every write being sync'ed of just sync at the end?
>

/*
* Reliable writes are used to implement Forced Unit Access and
* are supported only on MMCs.
*/
do_rel_wr =3D (req->cmd_flags & REQ_FUA) &&
    rq_data_dir(req) =3D=3D WRITE &&
    (md->flags & MMC_BLK_REL_WR);

A Reliable Write access shall force the data to be written to the
nonvolatile storage=E3=80=82
It will consume more time.

> >
> > According to the above data, disable FUA (fua_disable =3D 1) improves t=
he
> > performance:
> > 1)Sequential read improved by 3%.
> > 2)Random read were down 1%.
>
> FUA should not affect reads.  If it is, you may want to investigate how.
>
> > 3)Sequential write improved by 34%.
> > 4)Random write improved by 454%.
> > Therefore, it is recommended to support the host to control FUA.
> >
> > Reference
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/block/writeback_cache_control.rst
> > [2] Embedded Multi-Media Card (e=E2=80=A2MMC) Electrical Standard (5.1)=
''
>
> You do not seem to have considered data integrity.
>
> Regular disks are assumed to provide atomic sector writes.  That is, a se=
ctor has either the old data or the new data, but not some corrupt mixture.
>
> mmc does not have that assumption, which is presumably why Reliable Write=
 has been used instead.  Although that idea appears to have been thrown awa=
y for devices with no cache by commit 08ebf903af57 ("mmc: core: Fixup suppo=
rt for writeback-cache for eMMC and SD").
>
> File systems can use FUA to mark a successful journal flush.  Whether or =
not getting a torn sector at that point will corrupt the file system recove=
ry is presumably file system specific, and maybe specific to file system op=
tions e.g. the use of checksums.
>
> It may well be that a file system can survive a torn sector at that point=
, or that user space would prefer to take the risk in order to get better p=
erformance.  In either of those cases, it is not really a decision for the =
host controller driver.
>

Considering the data integrity, we did a random power-down test, and
the experimental results were good.

FUA can only reduce data loss under abnormal conditions, but cannot
prevent data loss under abnormal conditions.

I think there should be a balance between FUA and NO FUA, but
filesystems seem to favor FUA.

FUA brings a drop in random write performance. If enough tests are
done, NO FUA is acceptable.

I found a discussion about FUA:
https://lore.kernel.org/linux-f2fs-devel/20220528051238.GX1098723@dread.dis=
aster.area/

UFS reference:
https://lore.kernel.org/linux-scsi/20220531201053.3300018-1-jaegeuk@kernel.=
org/

> >
> > Wenchao Chen (2):
> >   mmc: block: Support Host to control FUA
> >   mmc: sdhci-sprd: enable fua_disable for SPRDSDHCI
> >
> >  drivers/mmc/core/block.c      | 3 ++-
> >  drivers/mmc/host/sdhci-sprd.c | 2 ++
> >  include/linux/mmc/host.h      | 3 +++
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
>
