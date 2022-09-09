Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C60B5B3AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiIIOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIIOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:46:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536410BA5A;
        Fri,  9 Sep 2022 07:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB4A61D0E;
        Fri,  9 Sep 2022 14:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC221C433B5;
        Fri,  9 Sep 2022 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662734761;
        bh=9gSGA2hfH49spBN23ew93MuTF9U1tiaHt2Iw1TUjlMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Vk/rPwDsA7RKtVm1RTXqOC3pU9kiClv5WQjLYFoYRmCREJcHg7i8gYuc3N3Z878Hf
         jmwQBIfn48M3KgzXsEA53Km09PPqEqrN90RpwmM+vpXE2Py34jY8xBzp/shpuEGfIb
         JGHjHTL3I6mgoHcT9eZmpqOLGXIAOTgYmIbb5htf3PGQYl5jH1D2xuHDGNlTFbZonU
         7/ogxXcq9hcZYn07pQnQjl272dbFL6bNRRBMdGdvyD+fmZs2qKzz2xdeea7yoa/VS3
         x1VBQPTfsYpxTrGl817Luhtv04bfgn5KbyBrzZeKyGko69I9gxLqcRZAUqfvHwgX6I
         1OoboPeaT3R+g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1274ec87ad5so4537892fac.0;
        Fri, 09 Sep 2022 07:46:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo1+P6fwBIYSy3GxOFFzpr1fEmEJ3jT1Q2N4lCNYgfi50l2QhDwf
        RdgipyQsLmPK4BmI4PS/9AYbfkl5xktAMnXJnMo=
X-Google-Smtp-Source: AA6agR75/qUGmnXgLr5EAw1GrE//OTfT/Ba/Jq6HJBB+ogB1sHH3NMMKIpbz3UzTr0y6sC6hO7+TGL/YJULQD78oQoc=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr5417377oac.22.1662734760114; Fri, 09
 Sep 2022 07:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
 <CAPhsuW6pKMeaULJajDGSjDRVmBUDEd=QQdGftK_Oo0vgsEuKVg@mail.gmail.com> <3e9385af-b02c-e886-bc4b-d85cb4f447af@huaweicloud.com>
In-Reply-To: <3e9385af-b02c-e886-bc4b-d85cb4f447af@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 07:45:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4aOfOjnUx39k4YHcZrNck-WGax1z4qdb61koE0ZugAEA@mail.gmail.com>
Message-ID: <CAPhsuW4aOfOjnUx39k4YHcZrNck-WGax1z4qdb61koE0ZugAEA@mail.gmail.com>
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com,
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

On Fri, Sep 2, 2022 at 11:08 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi, Song
>
> =E5=9C=A8 2022/09/01 2:00, Song Liu =E5=86=99=E9=81=93:
> > On Mon, Aug 29, 2022 at 6:03 AM Yu Kuai <yukuai1@huaweicloud.com> wrote=
:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> patch 1 is a small problem found by code review.
> >> patch 2 avoid holding resync_lock in fast path.
> >> patch 3 avoid holding lock in wake_up() in fast path.
> >>
> >> Test environment:
> >>
> >> Architecture: aarch64
> >> Cpu: Huawei KUNPENG 920, there are four numa nodes
> >>
> >> Raid10 initialize:
> >> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 /dev=
/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
> >>
> >> Test cmd:
> >> fio -name=3D0 -ioengine=3Dlibaio -direct=3D1 -group_reporting=3D1 -ran=
dseed=3D2022 -rwmixread=3D70 -refill_buffers -filename=3D/dev/md0 -numjobs=
=3D16 -runtime=3D60s -bs=3D4k -iodepth=3D256 -rw=3Drandread
> >>
> >> Test result:
> >> before this patchset:   2.9 GiB/s
> >> after this patchset:    6.6 Gib/s
> >
> > Nice work! Applied to md-next.
>
> Can you drop this version? There are something to improve. I can send a
> new version.

Sure, I will drop it from md-next.

Song
