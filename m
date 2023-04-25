Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701596EDBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjDYGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjDYGjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:39:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4974E9;
        Mon, 24 Apr 2023 23:39:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB8B62B68;
        Tue, 25 Apr 2023 06:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA77C4339B;
        Tue, 25 Apr 2023 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682404789;
        bh=ZeKMdQZ9vwyQ+qNXDDAAqQ/6elVDGZx+Par/yWTe9r8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fuxMai18LWcpcX5V621yfsVxnTozUEy+uy5CLY+CB0+HMeok6dot9UoW7UTvi1Qzm
         rIVLF2GswpNAQKkyKsYOBsVoHwfrE6P53TD6Mwqc5tC95C49381fUxmUiuHloLqgXR
         gUr78zZpuv1I6gU6/ldkXitMARFxjzHKEI+rQFOv+pmbqXfBWpucmQwdLOC4AFN4l9
         C7/99PFAIlXLFYPd+oOsm8Rx1Kiyya71DpS2qkSdWbtAUyE9mC/u0tS5I/lawtW8hP
         p4fS49yNOPaP5PhMn5jdub5XRf8HdeJmo0LG8SyXH5EtPfOehssxU24+nbqjDfBdtM
         /l10w45zJv7Ew==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4eed6ddcae1so23080290e87.0;
        Mon, 24 Apr 2023 23:39:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9enpKmwNDzGRtVZmbWYZ6wfZneXOgJOQYL80MqWnqJp7LBq7Wld
        sB8TtUS2Dutmm96Ni39jHiTCm7E3EIBq41xAryk=
X-Google-Smtp-Source: AKy350Z5fgvdsW4fLqxjIwkO7GGZzQKTMdtZj2vbGgObPYu5MKStpSk3HcPhd145bEnyFLoJfnN2SqIkrn2KFkl2B+M=
X-Received: by 2002:a2e:b5a9:0:b0:2a9:d4f0:6 with SMTP id f9-20020a2eb5a9000000b002a9d4f00006mr3491054ljn.17.1682404787892;
 Mon, 24 Apr 2023 23:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
 <20230420112946.2869956-2-yukuai1@huaweicloud.com> <CAPhsuW5ifaGc47-vJWwbRyjgJHr3CJy+_zZ1wAL=FNxPOk-0WQ@mail.gmail.com>
 <b3393e4d-2fdb-41a6-54ba-fb564c484e56@huaweicloud.com>
In-Reply-To: <b3393e4d-2fdb-41a6-54ba-fb564c484e56@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 24 Apr 2023 23:39:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW47GBgnofLrN8DVMkrBC=tVjhvoQroVZPRrMUHwGcOBLA@mail.gmail.com>
Message-ID: <CAPhsuW47GBgnofLrN8DVMkrBC=tVjhvoQroVZPRrMUHwGcOBLA@mail.gmail.com>
Subject: Re: [PATCH -next 1/8] md/raid10: prevent soft lockup while flush writes
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, akpm@osdl.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:16=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> Hi,
>
> =E5=9C=A8 2023/04/25 8:23, Song Liu =E5=86=99=E9=81=93:
> > On Thu, Apr 20, 2023 at 4:31=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Currently, there is no limit for raid1/raid10 plugged bio. While flush=
ing
> >> writes, raid1 has cond_resched() while raid10 doesn't, and too many
> >> writes can cause soft lockup.
> >>
> >> Follow up soft lockup can be triggered easily with writeback test for
> >> raid10 with ramdisks:
> >>
> >> watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
> >> Call Trace:
> >>   <TASK>
> >>   call_rcu+0x16/0x20
> >>   put_object+0x41/0x80
> >>   __delete_object+0x50/0x90
> >>   delete_object_full+0x2b/0x40
> >>   kmemleak_free+0x46/0xa0
> >>   slab_free_freelist_hook.constprop.0+0xed/0x1a0
> >>   kmem_cache_free+0xfd/0x300
> >>   mempool_free_slab+0x1f/0x30
> >>   mempool_free+0x3a/0x100
> >>   bio_free+0x59/0x80
> >>   bio_put+0xcf/0x2c0
> >>   free_r10bio+0xbf/0xf0
> >>   raid_end_bio_io+0x78/0xb0
> >>   one_write_done+0x8a/0xa0
> >>   raid10_end_write_request+0x1b4/0x430
> >>   bio_endio+0x175/0x320
> >>   brd_submit_bio+0x3b9/0x9b7 [brd]
> >>   __submit_bio+0x69/0xe0
> >>   submit_bio_noacct_nocheck+0x1e6/0x5a0
> >>   submit_bio_noacct+0x38c/0x7e0
> >>   flush_pending_writes+0xf0/0x240
> >>   raid10d+0xac/0x1ed0
> >
> > Is it possible to trigger this with a mdadm test?
> >
>
> The test I mentioned in patch 8 can trigger this problem reliablity, so
> I this add a new test can achieve this.

To be clear, by "mdadm test" I mean the tests included in mdadm:

https://git.kernel.org/pub/scm/utils/mdadm/mdadm.git/tree/tests

Could you please try to add a test? If it works, we should add it to
mdadm.

Thanks,
Song
