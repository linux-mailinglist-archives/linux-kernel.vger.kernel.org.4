Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1879E6B84D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCMWh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:37:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECA29162;
        Mon, 13 Mar 2023 15:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAC4AB81200;
        Mon, 13 Mar 2023 22:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E765C433D2;
        Mon, 13 Mar 2023 22:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678747041;
        bh=I3cnzXH6XK+PRyojyJ6xi8CNN4Myy7ggWdjA5SYU4bM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JBHkSJewjrKNmwVUmzDlvKGAOSZprXxoUtbBgVQDgr+KhcM9qbsIqvWVqluEiYFKt
         1eqDyBP7R+iP68yUEgbVCsm+CgAdU4UV9NXVIZNy2NmX5wBjlHfsPwHyB2GlsxDgFt
         4Ao5+lHdL/uoUVEIINW7kU52iO+tEaHLc4ikHPcw6w2DqI0BDvC47fQUNmRhyQ7YJH
         Wfm4ShBao53X/w39wGKj4uzW1gBf2tnyzIayWhgnsmyPtiT4H6MZE6Sx/GMk+GwJlv
         dM2vzoznRFJK1JKe7IqYC2ZMX7b7VXFaJELQ4c2vD6eO8C8m77yzO3MUD05Hpn6NFK
         XZUipsuccROjw==
Received: by mail-lf1-f43.google.com with SMTP id i28so17706570lfv.0;
        Mon, 13 Mar 2023 15:37:21 -0700 (PDT)
X-Gm-Message-State: AO0yUKWYAJAxNX4Xh8t5YKvvjHDBWGA8/ORBE7vBZ/l08TiGbsqjVZLH
        HBAecw6ArThFMQOQKu+qgX0BlADd++zLUueIvDo=
X-Google-Smtp-Source: AK7set/AogiBkiTjDOK+hkoKhlCVV2O5BpzgGEV7N8M7vaqO+c66thbMbZWjyBmI2GQTpxtOqAr2qbCA+3siX8VP+Dk=
X-Received: by 2002:ac2:5623:0:b0:4dd:a058:f08f with SMTP id
 b3-20020ac25623000000b004dda058f08fmr51578lff.3.1678747039699; Mon, 13 Mar
 2023 15:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230310073855.1337560-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 15:37:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4x9KScK4DZPMMWi4vpGLWMq5pdzqOKR4L0zNYWfjK1Ow@mail.gmail.com>
Message-ID: <CAPhsuW4x9KScK4DZPMMWi4vpGLWMq5pdzqOKR4L0zNYWfjK1Ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] md/raid10: several simple obvious bugfix
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, jgq516@gmail.com, neilb@suse.de,
        shli@fb.com, lzhong@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:39=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> We're running many tests for raid10 currently, and we found a lot of
> problems already. This patchset is the first part for some simple and
> obvious problems. Most of the patches were sent separately already, but
> I think a patchset is better for review.
>
> Yu Kuai (6):
>   md/raid10: don't call bio_start_io_acct twice for bio which
>     experienced read error
>   md: fix soft lockup in status_resync
>   md/raid10: don't BUG_ON() in raise_barrier()
>   md/radi10: fix leak of 'r10bio->remaining' for recovery
>   md/raid10: fix memleak for 'conf->bio_split'
>   md/raid10: fix memleak of md thread

Applied 2/6 to 6/6 to md-next. Thanks!

Song

>
>  drivers/md/md.c     | 18 +++++------
>  drivers/md/raid10.c | 78 +++++++++++++++++++++++----------------------
>  2 files changed, 49 insertions(+), 47 deletions(-)
>
> --
> 2.31.1
>
