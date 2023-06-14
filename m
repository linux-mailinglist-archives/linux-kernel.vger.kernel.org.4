Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DB72F8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbjFNJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjFNJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E489F1BF0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686733741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YuZfFGL1mKI+1SfogZenr2tUCwIM+u0pKlzpY1axVWo=;
        b=hXgFoTBAIMijVJTkmtd/8SkHme8GZikPLII0jH1W2NFBo0cggB3CXkORIIvpYdMkS37Wui
        k6JqO9xyGGZtzs5ngpSOJ6Xd8toupegTO2Eesme+XXmH4W9SX/NdFPNywPsiy2AL06wMkI
        Tso/FqwxPykOP6DqheTJbO/TRaW3AH8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-_ZsyY114MSiz868cOchZCA-1; Wed, 14 Jun 2023 05:08:59 -0400
X-MC-Unique: _ZsyY114MSiz868cOchZCA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39aa9617c6bso4203792b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686733738; x=1689325738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuZfFGL1mKI+1SfogZenr2tUCwIM+u0pKlzpY1axVWo=;
        b=LUIO+tJxYDW5LmcbW1qWaWAsF92leLdeuh2ZkBYTxAgh/Ri7AsCrC3eF4GAc12agPY
         WzvcXVt7w2WBfaqFb7ilExhjx08E9AJBtwsUHzoiYAlWHjI6PRws4EolW5P/aKReL4Ak
         3IDny1SUpSlNLs/GkSwt/He7ywuguc3wRNnDM2xPi53RYdQ4D4LIr4uaxgA+q4WiW0g0
         MDp/RrGgzUGAEyaH/kliwIF/82k638lev4tfTdRhe1xQln0ZZzClZS0uetHqHjWxszgf
         xXXTmg/P6sSt8d8/AoKI1ms10s6SvJ0npQ3y+yQrr/qem4/YmALH65YSinNo6bVi2Tdq
         /eBQ==
X-Gm-Message-State: AC+VfDyn9m9mdNpwH7qpF2lz36FsPs+2FFWgMk3gBxcJZoRvcjyo0AHh
        8Q4gwR7RzQkZen3tyRL3NU9vj72LX9O8yOCoSSn1g4ZbSUzbLEykyqMzlg5/ScUN33mBN8DXKBq
        khVGLrOtwLwWz8g4O+KFzNNAmUUCCdVBJ+smpA8tTosQdKX6dbBvFGw==
X-Received: by 2002:a05:6808:1389:b0:39c:a986:953a with SMTP id c9-20020a056808138900b0039ca986953amr12173551oiw.34.1686733738602;
        Wed, 14 Jun 2023 02:08:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58w+HwbaWwKHZAt1p3B0C+JtvwHZqjZISvxx+b6MeyFNPBBwxTSYad7slNHl4ES3WRCVcszuSBd0EYV84rve0=
X-Received: by 2002:a05:6808:1389:b0:39c:a986:953a with SMTP id
 c9-20020a056808138900b0039ca986953amr12173538oiw.34.1686733738382; Wed, 14
 Jun 2023 02:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com>
 <20230529132037.2124527-5-yukuai1@huaweicloud.com> <05aa3b09-7bb9-a65a-6231-4707b4b078a0@redhat.com>
 <74b404c4-4fdb-6eb3-93f1-0e640793bba6@huaweicloud.com> <6e738d9b-6e92-20b7-f9d9-e1cf71d26d73@huaweicloud.com>
 <CALTww292gwOe-WEjuBwJn0AXvJC4AbfMZXC43EvVt3GCeBoHfw@mail.gmail.com>
 <5bf97ec5-0cb4-1163-6917-2bc98d912c2b@huaweicloud.com> <CALTww28UapJnK+Xfx7O9uEd5ZH2E7ufPT_7pKY6YYuzTZ0Fbdw@mail.gmail.com>
 <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com>
In-Reply-To: <b96ec15b-6102-17bb-2c18-a487f224865b@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 14 Jun 2023 17:08:47 +0800
Message-ID: <CALTww2-knHOoX35NB73X-sMn1u8EJHLA=0aOnoVqVm83+fdG5Q@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH -next v2 4/6] md: refactor idle/frozen_sync_thread()
 to fix deadlock
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, song@kernel.org, linux-raid@vger.kernel.org,
        yangerkun@huawei.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 4:29=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/06/14 15:57, Xiao Ni =E5=86=99=E9=81=93:
> > On Wed, Jun 14, 2023 at 3:38=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/06/14 15:12, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Wed, Jun 14, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud=
.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2023/06/14 9:48, Yu Kuai =E5=86=99=E9=81=93:
> >>>>
> >>>>
> >>>>>>
> >>>>>> In the patch, sync_seq is added in md_reap_sync_thread. In
> >>>>>> idle_sync_thread, if sync_seq isn't equal
> >>>>>>
> >>>>>> mddev->sync_seq, it should mean there is someone that stops the sy=
nc
> >>>>>> thread already, right? Why do
> >>>>>>
> >>>>>> you say 'new started sync thread' here?
> >>>>
> >>>> If someone stops the sync thread, and new sync thread is not started=
,
> >>>> then this sync_seq won't make a difference, above wait_event() will =
not
> >>>> wait because !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) will p=
ass.
> >>>> So 'sync_seq' is only used when the old sync thread stops and new sy=
nc
> >>>> thread starts, add 'sync_seq' will bypass this case.
> >>>
> >>> Hi
> >>>
> >>> If a new sync thread starts, why can sync_seq be different? sync_seq
> >>> is only added in md_reap_sync_thread. And when a new sync request
> >>> starts, it can't stop the sync request again?
> >>>
> >>> Af first, the sync_seq is 0
> >>>
> >>> admin1
> >>> echo idle > sync_action
> >>> idle_sync_thread(sync_seq is 1)
> >>
> >> Wait, I'm confused here, how can sync_seq to be 1 here? I suppose you
> >> mean that there is a sync_thread just finished?
> >
> > Hi Kuai
> >
> > Yes. Because idle_sync_thread needs to wait until md_reap_sync_thread
> > finishes. And md_reap_sync_thread adds sync_seq. Do I understand your
> > patch right?
>
> Yes, noted that idle_sync_thread() will only wait if MD_RECOVERY_RUNNING
> is set.
>
> >
> >>
> >> Then the problem is that idle_sync_thread() read sync_seq after the ol=
d
> >> sync_thread is done, and new sync_thread start before wait_event() is
> >> called, should we wait for this new sync_thread?
> >>
> >> My answer here is that we should, but I'm also ok to not wait this new
> >> sync_thread, I don't think this behaviour matters. The key point here
> >> is that once wait_event() is called from idle_sync_thread(), this
> >> wait_event() should not wait for new sync_thread...
> >
> > I think we should wait. If we don't wait for it, there is a problem.
> > One person echos idle to sync_action and it doesn't work sometimes.
> > It's a strange thing.
> >
>
> Ok. I'll add new comment to emphasize that idle_sync_thread() won't wait
> for new sync_thread that is started after wait_event().

I suggest removing this function. Without this change, it's more
simple and it can work well without problem. The people that echo idle
to sync_action needs to wait until the sync action finishes. The code
semantic is clear and simple.
>
> >>
> >>> echo resync > sync_action (new sync)
> >>
> >> If this is behind "echo idle > sync_action", idle_sync_thread should n=
ot
> >> see that MD_RECOVERY_RUNNING is set and wait_event() won't wait at all=
.
> >
> > `echo resync > sync_action` can't change the sync_seq. So 'echo idle >
> > sync_action' still waits until MD_RECOVERY_RUNNING is cleared?
>
> This is not accurate, if `echo resync > sync_action` triggers a new
> sync_thread, then sync_seq is updated when this sync_thread is done,
> during this period, MD_RECOVERY_RUNNING is still set, so `echo idle
>  >sync_action` will wait for sync_thread to be done.

I can understand your comment, but sorry, I still can't get how
sync_seq works. Could you give a specific case that explains how it
works?

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Regards
> > Xiao
> >
> >>
> >> Thanks,
> >> Kuai
> >>>
> >>> Then admin2 echos idle > sync_action, sync_seq is still 1
> >>>
> >>> Regards
> >>> Xiao
> >>>
> >>>>
> >>>> Thanks,
> >>>> Kuai
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>

