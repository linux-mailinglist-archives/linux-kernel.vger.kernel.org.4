Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70671539F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjE3C0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjE3CZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E29A9D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685413516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uieFtjVfb+duqtQkCjKxvaxLp1SVaQ3BfgAhKOaOwUw=;
        b=LKMR9/ioTAL5YS42nEHLwyotHbaxjxDL2ot4l8wigRagBskQWSv7hakwdJ1k76SiD6zW3d
        RjtlhlQNrA3Hkd3nWJiHOCPqGwwE3zVfccVzAZ9trzheR5SnFQKjUFH395clTbAjbayQIP
        eijCeAU6oW90qIp6pRvjxlEkfV0LxRM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-yvhNvvtxNdKLTzsW3eNihA-1; Mon, 29 May 2023 22:25:14 -0400
X-MC-Unique: yvhNvvtxNdKLTzsW3eNihA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53f44c25595so2040952a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685413514; x=1688005514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uieFtjVfb+duqtQkCjKxvaxLp1SVaQ3BfgAhKOaOwUw=;
        b=VV6UjV8RRRXgRbhuBYqNBZaq4UcctxRpXDj7IjklweP2HvKAOUEJiztv01C6Vp8IuR
         QGRibL7MCXpIQc90scl2dbdNolW17OUNyjtchPo/jZRwiHhSCLeAjWiDF40pox8bxbaA
         jD7bVslThqsasobD2UTBmRzYzb1U65kAXdK6f1ePubW9DukUNbmkOzrJv4goek1DohlQ
         O9NZaCe/tpzaLUyA+ACJTcOjCJ40se+TpuUUrIJByPViwHql/27EvrgpQdokIJTwHXP1
         X/kB/cComwT6keclVKHD/Vo+8MCQfe2LlCPehqqxwS0vKw/CIsH24iITRgPETM97vUCh
         G+zA==
X-Gm-Message-State: AC+VfDxe+MM0AhSqK2NANor3yPe/vcersf5N00yHLJxXVFeUJi40IxjB
        vNB1W2O9kuHU7gAllj2O64QhtiLzTXDFuEbYbX6pV4eZt8sdGgbktVXmxBXvan0XDReaoG16BhC
        R7AtkyF5F5LF1oWrA5pxtdbenRS059+KMOn8HK7pS
X-Received: by 2002:a17:902:db0f:b0:1ac:750e:33ef with SMTP id m15-20020a170902db0f00b001ac750e33efmr1244689plx.3.1685413513819;
        Mon, 29 May 2023 19:25:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UqEXLhWR0XVLbn5s+0CiAVVT1WPczmOGN7HHfw2C+mK4xiknHx8GbmvWSaat6sdbm5vHjWKW41bleWHiG04I=
X-Received: by 2002:a17:902:db0f:b0:1ac:750e:33ef with SMTP id
 m15-20020a170902db0f00b001ac750e33efmr1244669plx.3.1685413513489; Mon, 29 May
 2023 19:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
 <20230426082031.1299149-8-yukuai1@huaweicloud.com> <CALTww2-yTsHXNFgkAVu0v++HHahZCnvXEUv2qJqbvcGUhKanDw@mail.gmail.com>
 <5e9852fe-0d47-92fc-f6a9-16d028d09ad4@huaweicloud.com> <CALTww28ur_S0UpGQqq0TubSgkxGG7dicc1ZKrJ3Pno4CpSOWUw@mail.gmail.com>
 <25279079-2600-b0d3-5279-caaf6f664d71@huaweicloud.com> <CALTww2-PjJ74J61jYz032t8K5tszN1tnhEbcv5h+MJjkKuVq2A@mail.gmail.com>
 <c56e7e9c-90ca-29ca-2003-1a9a88d75fa6@huaweicloud.com> <CALTww2_JAmqU19Stb1UBVVL-w=ecRFt8WNZo+TmMJVD+O2RJqw@mail.gmail.com>
 <37fc3178-c812-ee5e-bd90-34f8e0816a3d@huaweicloud.com>
In-Reply-To: <37fc3178-c812-ee5e-bd90-34f8e0816a3d@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 30 May 2023 10:25:02 +0800
Message-ID: <CALTww28kXk8-1sdiDTCa7Qbu1Uh0hDtDTuPvswORWc+5h+BP4A@mail.gmail.com>
Subject: Re: [PATCH -next v2 7/7] md/raid1-10: limit the number of plugged bio
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, akpm@osdl.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 9:20=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/30 8:58, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 29, 2023 at 4:50=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/05/29 15:57, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Mon, May 29, 2023 at 11:18=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud=
.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2023/05/29 11:10, Xiao Ni =E5=86=99=E9=81=93:
> >>>>> On Mon, May 29, 2023 at 10:20=E2=80=AFAM Yu Kuai <yukuai1@huaweiclo=
ud.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> =E5=9C=A8 2023/05/29 10:08, Xiao Ni =E5=86=99=E9=81=93:
> >>>>>>> Hi Kuai
> >>>>>>>
> >>>>>>> There is a limitation of the memory in your test. But for most
> >>>>>>> situations, customers should not set this. Can this change introd=
uce a
> >>>>>>> performance regression against other situations?
> >>>>>>
> >>>>>> Noted that this limitation is just to triggered writeback as soon =
as
> >>>>>> possible in the test, and it's 100% sure real situations can trigg=
er
> >>>>>> dirty pages write back asynchronously and continue to produce new =
dirty
> >>>>>> pages.
> >>>>>
> >>>>> Hi
> >>>>>
> >>>>> I'm confused here. If we want to trigger write back quickly, it nee=
ds
> >>>>> to set these two values with a smaller number, rather than 0 and 60=
.
> >>>>> Right?
> >>>>
> >>>> 60 is not required, I'll remove this setting.
> >>>>
> >>>> 0 just means write back if there are any dirty pages.
> >>>
> >>> Hi Kuai
> >>>
> >>> Does 0 mean disabling write back? I tried to find the doc that
> >>> describes the meaning when setting dirty_background_ratio to 0, but I
> >>> didn't find it.
> >>> In https://www.kernel.org/doc/html/next/admin-guide/sysctl/vm.html it
> >>> doesn't describe this. But it says something like this
> >>>
> >>> Note:
> >>>     dirty_background_bytes is the counterpart of dirty_background_rat=
io. Only
> >>>     one of them may be specified at a time. When one sysctl is writte=
n it is
> >>>     immediately taken into account to evaluate the dirty memory limit=
s and the
> >>>     other appears as 0 when read.
> >>>
> >>> Maybe you can specify dirty_background_ratio to 1 if you want to
> >>> trigger write back ASAP.
> >>
> >> The purpose here is to trigger write back ASAP, I'm not an expert here=
,
> >> but based on test result, 0 obviously doesn't mean disable write back.
> >>
> >> Set dirty_background_bytes to a value, dirty_background_ratio will be
> >> set to 0 together, which means dirty_background_ratio is disabled.
> >> However, change dirty_background_ratio from default value to 0, will e=
nd
> >> up both dirty_background_ratio and dirty_background_bytes to be 0, and
> >> based on following related code, I think 0 just means write back if
> >> there are any dirty pages.
> >>
> >> domain_dirty_limits:
> >>    bg_bytes =3D dirty_background_bytes -> 0
> >>    bg_ratio =3D (dirty_background_ratio * PAGE_SIZE) / 100 -> 0
> >>
> >>    if (bg_bytes)
> >>           bg_thresh =3D DIV_ROUND_UP(bg_bytes, PAGE_SIZE);
> >>    else
> >>           bg_thresh =3D (bg_ratio * available_memory) / PAGE_SIZE; -> =
0
> >>
> >>    dtc->bg_thresh =3D bg_thresh; -> 0
> >>
> >> balance_dirty_pages
> >>    nr_reclaimable =3D global_node_page_state(NR_FILE_DIRTY);
> >>    if (!laptop_mode && nr_reclaimable > gdtc->bg_thresh &&
> >>         !writeback_in_progress(wb))
> >>      wb_start_background_writeback(wb); -> writeback ASAP
> >>
> >> Thanks,
> >> Kuai
> >
> > Hi Kuai
> >
> > I'm not an expert about this either. Thanks for all your patches, I
> > can study more things too. But I still have some questions.
> >
> > I did a test in my environment something like this:
> > modprobe brd rd_nr=3D4 rd_size=3D10485760
> > mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
> > echo 0 > /proc/sys/vm/dirty_background_ratio
> > fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -thread -bs=3D1=
k-8k
> > -numjobs=3D1 -iodepth=3D128 --runtime=3D10 -name=3Dxxx
> > It will cause OOM and the system hangs
>
> OOM means you trigger this problem... Plug hold lots of bios and cost
> lots of memory, it's not that write back is disabled, you can verify
> this by monitor md inflight, noted that don't use too much memory for
> ramdisk(rd_nr * rd_size) in the test so that OOM won't be triggered.
>
> Have you tried to test with this patchset?

Yes, I know I have reproduced this problem. I'll have the v3 patchest.
>
> >
> > modprobe brd rd_nr=3D4 rd_size=3D10485760
> > mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
> > echo 1 > /proc/sys/vm/dirty_background_ratio (THIS is the only differen=
t place)
> > fio -filename=3D/dev/md0 -ioengine=3Dlibaio -rw=3Dwrite -thread -bs=3D1=
k-8k
> > -numjobs=3D1 -iodepth=3D128 --runtime=3D10 -name=3Dxxx
> > It can finish successfully.  The value of dirty_background_ration is 1
> > here means it flushes ASAP
>
> This really doesn't mean flushes ASAP, our test report this problem in
> the real test that doesn't modify dirty_background_ratio. I guess
> somewhere triggers io_scheduler(), probably background thread think
> dirty pages doesn't match threshold, but I'm not sure for now.

Thanks for notifying me of this.

Regards
Xiao
>
> Thanks,
> Kuai
> >
> > So your method should be the opposite way as you designed. All the
> > memory can't be flushed in time, so it uses all memory very soon and
> > the memory runs out and the system hangs. The reason I'm looking at
> > the test is that do we really need this change. Because in the real
> > world, most customers don't disable write back. Anyway, it depends on
> > Song's decision and thanks for your patches again. I'll review V3 and
> > try to do some performance tests.
> >
> > Best Regards
> > Xiao
>

