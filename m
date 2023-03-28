Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C228C6CCE0D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjC1Xbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjC1Xbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:31:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11F2D52;
        Tue, 28 Mar 2023 16:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51F33B81F65;
        Tue, 28 Mar 2023 23:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209EAC433A4;
        Tue, 28 Mar 2023 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680046289;
        bh=f6mXSm7e2TzCi7OfP4gtXCf7l1sYhyFNfXWnEy1hKGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eVwieGxD/OsmiBqsC7hbOI45S4M1FdMhBWQMJA5pDrUWfjErBN9wb9wAF0o/yrITp
         J9bdxdTovCzNP/POKpezbFaGIvx7gKzdYHNN5tYNc8/j7vETxKCOjDzgRG/AwyfJRg
         u7kgCWCrMmSa0lLMJVSYWDrOFDLWv2IRNFveMyAEaGBha5qrenqQ3KQqV2ipqOvBmS
         S/sdUFTVUcAREkoD/t3XADIM3cBu6uDMgyX4IoMizkIMoVprF5ZzpDcnHLD4M+/c5H
         /4ikycv94u2nJ//d5ZnV5RDphlx4xV7lg11MV+zf8lHa63GlbQU114pqj5Exj3rdLA
         bj+aA4BzEFQMA==
Received: by mail-lf1-f41.google.com with SMTP id h25so17903717lfv.6;
        Tue, 28 Mar 2023 16:31:29 -0700 (PDT)
X-Gm-Message-State: AAQBX9dZLD8Xb1AoBmnethoJajgY5C8tsMRmtL2TvU6R5wV+6PAXId8i
        QtDcWxhZuL7QBNhmlLzc/D8kDT1Tyzlj9kwHEYU=
X-Google-Smtp-Source: AKy350YQMcC1+47AFrMaRWuhSXYGhQl9m67feGsAA/QFamVMP4j1Gzd+aBos6gk9u+fqGsQxpc0FI0/okuD/s3v5cKQ=
X-Received: by 2002:ac2:5338:0:b0:4eb:1316:a2e6 with SMTP id
 f24-20020ac25338000000b004eb1316a2e6mr2107735lfh.3.1680046287127; Tue, 28 Mar
 2023 16:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
 <e1a5fe1c-ea3d-adef-62ec-3b30bedbe4f8@molgen.mpg.de> <606b1388-10e7-a0ae-f314-52274b0942dd@deltatee.com>
 <d0dfd5ad-12d4-c6d1-68b2-a112d3f3c163@huaweicloud.com>
In-Reply-To: <d0dfd5ad-12d4-c6d1-68b2-a112d3f3c163@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Mar 2023 16:31:14 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6iuoAu=QBrvz8QvEZ3PtEjj=MKdVAbihZ88Dkj3_h-nw@mail.gmail.com>
Message-ID: <CAPhsuW6iuoAu=QBrvz8QvEZ3PtEjj=MKdVAbihZ88Dkj3_h-nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] md: fix uaf for sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>, agk@redhat.com,
        snitzer@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 6:26=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/03/16 6:55, Logan Gunthorpe =E5=86=99=E9=81=93:
[...]
> > I was going to try and confirm that no new regressions were introduced
> > by Yu's patches, but seems the tests are getting worse. I tried running
> > the tests on the current md-next branch and found that one of the early
> > tests, 00raid5-zero, hangs indefinitely. I quickly ran the same test on

I am not able to repro the issue with 00raid5-zero. (I did a rebase before
running the test, so that might be the reason).

> > v6.3-rc2 and found that it runs just fine there. So it looks like
> > there's already a regression in md-next that is not part of this series
> > and I don't have the time to dig into the root cause right now.
> >
> > Yu's patches don't apply cleanly to v6.3-rc2 and I can't run the tests
> > against md-next; so I didn't bother running them, but I did do a quick
> > review. The locking changes make sense to me so it might be worth
> > merging for correctness. However, I'm not entirely sure it's the best
> > solution -- the md thread stuff seems like a bit of a mess and passing
> > an mddev to thread functions that were not related to the mddev to get =
a
> > lock seems to just make the mess a bit worse.
> >
> > For example, it seems a bit ugly to me for the lock mddev->thread_lock
> > to protect the access of a pointer in struct r5l_log. Just spit-balling=
,
> > but perhaps RCU would be more appropriate here. Then md_wakeup_thread()
> > would just need to hold the RCU read lock when dereferencing, and
> > md_unregister_thread() would just need to synchronize_rcu() before
> > stopping and freeing the thread. This has the benefit of not requiring
> > the mddev object for every md_thread and would probably require a lot
> > less churn than the current patches.
>
> Thanks for your suggestion, this make sense to me. I'll try to use rcu.

Yu Kuai, do you plan to resend the set with Logan suggestions?

Thanks,
Song
