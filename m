Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1837233D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjFEX7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjFEX7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283D1F2;
        Mon,  5 Jun 2023 16:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B99EE62B5F;
        Mon,  5 Jun 2023 23:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D73BC4339E;
        Mon,  5 Jun 2023 23:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686009583;
        bh=mogscCAE2TctMMQSNnZNjtKIjPq2PKyh7iz0utP3Kjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RhE55cPP66jNDiifSDCnp320/osWVV85yAW9VCFxmw19JxJbiYHaMZfD+AcUM0p5Y
         l0CMZQByNHRKQi62J34h9ndDf//hF/AvicpSIsr+qdBZp6xoxNd6IL2QmrAikHyIUQ
         /w521l5xgzFeaQpGhq09pn33VK3ioAZ5l8jAaRMNRaow52k2xS2QxvsEEQJWvMDmYk
         iBQjKZ6yZGGhpH5eUNH+DeITQ3lXfBFB8Ono6ZNPi14xXwc02mOSepKoPDwxrYriHS
         5k7hWlRhAY2WbunH2ZXc9eLJkVNtpYKTaKDmhyxmiZV/hxJI00d8Db+PN41xlZhiN4
         Wo6DyXlnMbZ0w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so6839601e87.0;
        Mon, 05 Jun 2023 16:59:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDyChXgPECMdjj922nOazJ2CD6Oo4ibRl7wyFJF68LzxHIkaJmzu
        0AJVohNt5lWypeEEt1swOYpaJSZ3FJyPex8ha2A=
X-Google-Smtp-Source: ACHHUZ42u8NSQekejY3oU/vj6DrkcCZt8qA4yrh0rHaOdWJ0WwM5PbLfRAfLkhkYmlULFUmnUfhXgAzRdRLgSBsW+g8=
X-Received: by 2002:a05:6512:1023:b0:4ef:eb50:4d3d with SMTP id
 r3-20020a056512102300b004efeb504d3dmr238192lfr.18.1686009581096; Mon, 05 Jun
 2023 16:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230529133410.2125914-1-yukuai1@huaweicloud.com>
 <b9fd7105-eadc-29cb-fa2e-24109f4a99b7@linux.dev> <e26af7db-a283-47ca-fc61-89af99f52c17@huaweicloud.com>
 <e2c936ce-5832-9d69-919a-c98af673bb3a@linux.dev> <98f285ff-5afb-1d12-f087-cf04a5208e21@huaweicloud.com>
 <3f6fdbfc-9c35-2bc0-2b44-0e312f89455b@linux.dev>
In-Reply-To: <3f6fdbfc-9c35-2bc0-2b44-0e312f89455b@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Mon, 5 Jun 2023 16:59:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7PDw_SxVrRLcWfKUGEoSd2QF8H-5P+To4BdzfNusj7hQ@mail.gmail.com>
Message-ID: <CAPhsuW7PDw_SxVrRLcWfKUGEoSd2QF8H-5P+To4BdzfNusj7hQ@mail.gmail.com>
Subject: Re: [PATCH v2] md/raid5: don't allow concurrent reshape with recovery
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, pmenzel@molgen.mpg.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:34=E2=80=AFAM Guoqing Jiang <guoqing.jiang@linux=
.dev> wrote:
>
>
>
> On 5/31/23 11:20, Yu Kuai wrote:
> > Hi,
> >
> > =E5=9C=A8 2023/05/31 9:49, Guoqing Jiang =E5=86=99=E9=81=93:
> >>
> >>
> >> On 5/31/23 09:22, Yu Kuai wrote:
> >>> Hi,
> >>>
> >>> =E5=9C=A8 2023/05/31 9:06, Guoqing Jiang =E5=86=99=E9=81=93:
> >>>>
> >>>>
> >>>> On 5/29/23 21:34, Yu Kuai wrote:
> >>>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>>
> >>>>> Commit 0aecb06e2249 ("md/raid5: don't allow replacement while resha=
pe
> >>>>> is in progress") fixes that replacement can be set if reshape is
> >>>>> interrupted, which will cause that array can't be assembled.
> >>
> >> I just pulled md tree, but can't find the commit id either in md-next
> >> or md-fixes .
> >> gjiang@pc:~/storage/md> git branch
> >>   master
> >>   md-fixes
> >> * md-next
> >> gjiang@pc:~/storage/md> git branch --contain 0aecb06e2249
> >> error: malformed object name 0aecb06e2249
> >>
> >>>>> There is a similar problem on the other side, if recovery is
> >>>>> interrupted, then reshape can start, which will cause the same
> >>>>> problem.
> >>>>>
> >>>>> Fix the problem by not starting to reshape while recovery is still =
in
> >>>>> progress.
> >>>>>
> >>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>>> ---
> >>>>> Changes in v2:
> >>>>>   - fix some typo in commit message.
> >>>>>
> >>>>>   drivers/md/raid5.c | 8 ++++++++
> >>>>>   1 file changed, 8 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> >>>>> index 8686d629e3f2..6615abf54d3f 100644
> >>>>> --- a/drivers/md/raid5.c
> >>>>> +++ b/drivers/md/raid5.c
> >>>>> @@ -8525,6 +8525,7 @@ static int raid5_start_reshape(struct mddev
> >>>>> *mddev)
> >>>>>       struct r5conf *conf =3D mddev->private;
> >>>>>       struct md_rdev *rdev;
> >>>>>       int spares =3D 0;
> >>>>> +    int i;
> >>>>>       unsigned long flags;
> >>>>>       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> >>>>> @@ -8536,6 +8537,13 @@ static int raid5_start_reshape(struct mddev
> >>>>> *mddev)
> >>>>>       if (has_failed(conf))
> >>>>>           return -EINVAL;
> >>>>> +    /* raid5 can't handle concurrent reshape and recovery */
> >>>>> +    if (mddev->recovery_cp < MaxSector)
> >>>>> +        return -EBUSY;
> >>>>> +    for (i =3D 0; i < conf->raid_disks; i++)
> >>>>> +        if (rdev_mdlock_deref(mddev, conf->disks[i].replacement))
> >>>>> +            return -EBUSY;
> >>>>> +
> >>>>
> >>>> Does it mean reshape and recovery  can happen in parallel without
> >>>> the change?
> >>>> I really doubt about it given any kind of internal io (resync,
> >>>> reshape and recovery)
> >>>> is handled by resync thread. And IIUC either md_do_sync or
> >>>> md_check_recovery
> >>>> should avoid it, no need to do it in personality layer.
> >>>>
> >>>
> >>> They can't, in this case recovery is interrupted, then recovery can't
> >>> make progress, and md_check_recovery() will start reshape, and after
> >>> reshape is done, recovery will continue, and data will be corrupted
> >>> because raid456 reshape doesn't handle replacement.
> >>
> >> So, do reshape first then recovery, right? I don't see concurrent
> >> reshape and recovery
> >> happen based on your description, if concurrent reshape and recovery
> >> is possible
> >> then I believe we really have big trouble.
> >
> > Yes, reshape first, and yes they can't concurrent.
>
> Then the subject, commit message and above comment are confusing given
> they can't happen
> even without your change.
>

I updated the commit message as:

    md/raid5: don't start reshape when recovery or replace is in progress

    When recovery is interrupted (reboot, etc.) check for MD_RECOVERY_RUNNI=
NG
    is not enough to tell recovery is in progress. Also check recovery_cp
   before starting reshape.

Please let me know if this doesn't make sense.

Thanks,
Song
