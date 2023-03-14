Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3286C6B8C47
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCNH5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCNH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:57:01 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734C21956
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:56:59 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p6so8402677pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678780619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3teonhZv+4GRlKpPnO2/OV+dP6gf7xXIPN2idr7AcQ=;
        b=XXcOs+U1IpI+nSDvWEMSJ2itr1PZ3rdDUiN643AYkn54z/+mPIZUtdI4Yn27jeNLSc
         WwdvfKBXFef8++RK2vvH+7vA9n40bc46o/8FpIXfi9QXY56saGoB3ExXpFbHMv6EXUQy
         wo4CEdG+4Ad+bvYNCbPBpzGOGOGY5eCzvSAm18pLfgsq3pddKBXmCzYWblRtFqjmdwax
         b6n16yNNkoKwMIPWOBWqRunl3JLs2XyBV7nHM3CnXyUTkkjCFIBU7xCUY9CUxy1/0HbZ
         5OIteIR/XsdnTaYC6RsllbdUf88L3TOrHfL/301jpixsWxBepUYKxawn+N51q9xaCYnH
         h8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678780619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3teonhZv+4GRlKpPnO2/OV+dP6gf7xXIPN2idr7AcQ=;
        b=RT5kIjefWm2S/HPJ9acMrLErdbVtYCN46prhj7eXbMiAGd2tqOSSMEGaMfE8pcUVSQ
         f3dx0WgRv2riL+J5iqXW0EuYSr7OOKROH4u2O5KH7xLx3EJxSj5s6mRAl7RJI0LY0bNl
         49txgt87k/pucf7lSC3ociv/d/jduhw9uxwBEAV5Ilau3vmGskGsiEn+Zl486OxAZbV8
         4OID6+NpFJzoeTvLNRw996KZ/vS5XuvbTwkbWMADRCmqFsIv8WHKiUhnOC3P0lmU2UDi
         sUEo3BkUbG9Za07JQUt/FDYRWwLu44NqESp2lWR+qrysn+Wxh8LucOjQTN/xek0HY6cT
         Y0YQ==
X-Gm-Message-State: AO0yUKULH5CV26yKisyinFGIQX9FS4v3ItP+aHYQmPfuWbQEHPY697el
        cDwlD3ZPyHdIjPmtVjx2Vys+esRw14p0ZeYirhAKtfhY3N6rhl11
X-Google-Smtp-Source: AK7set+bVfFYE/JyksHLCXI6t1BgriFQonrsjT0nIy8sCYFSoIWrB8ZhENFGAWcdVHW4WeTwKyUlI9gCo9XNthhGTCQ=
X-Received: by 2002:a62:f801:0:b0:5eb:e0e0:d650 with SMTP id
 d1-20020a62f801000000b005ebe0e0d650mr14155093pfh.6.1678780618707; Tue, 14 Mar
 2023 00:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230302144330.274947-1-ulf.hansson@linaro.org>
 <54cee7de4ab7479db74b21e64e5f53cf@hyperstone.com> <CAPDyKFq-qToEX+qiuHirNbcuedii_f0KKuHiPAv7+tydrUTpqQ@mail.gmail.com>
 <4a2c5b752968496ca72966f80e148d47@hyperstone.com> <3effa855-1668-db9f-7d38-2c3352ea6ef1@intel.com>
In-Reply-To: <3effa855-1668-db9f-7d38-2c3352ea6ef1@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Mar 2023 08:56:22 +0100
Message-ID: <CAPDyKFpVZaHA0jPBa=uxLSCzcUTZujUzJvh1oqar6NbBHg9wtQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: core: Disable REQ_FUA if the eMMC supports an
 internal cache
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 at 17:56, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 10/03/23 19:06, Christian L=C3=B6hle wrote:
> >
> >>>
> >>> I have benchmarked the FUA/Cache behavior a bit.
> >>> I don't have an actual filesystem benchmark that does what I wanted a=
nd is easy to port to the target so I used:
> >>>
> >>> # call with
> >>> # for loop in {1..3}; do sudo dd if=3D/dev/urandom bs=3D1M
> >>> of=3D/dev/mmcblk2; done; for loop in {1..5}; do time
> >>> ./filesystembenchmark.sh; umount /mnt; done
> >>> mkfs.ext4 -F /dev/mmcblk2
> >>> mount /dev/mmcblk2 /mnt
> >>> for i in {1..3}
> >>> do
> >>> cp -r linux-6.2.2 /mnt/$i
> >>> done
> >>> for i in {1..3}
> >>> do
> >>> rm -r /mnt/$i
> >>> done
> >>> for i in {1..3}
> >>> do
> >>> cp -r linux-6.2.2 /mnt/$i
> >>> done
> >>>
> >>>
> >>> I found a couple of DUTs that I can link, I also tested one industria=
l card.
> >>>
> >>> DUT1: blue PCB Foresee eMMC
> >>> https://pine64.com/product/32gb-emmc-module/
> >>> DUT2: green PCB SiliconGo eMMC
> >>> Couldn't find that one online anymore unfortunately
> >>> DUT3: orange hardkernel PCB 8GB
> >>> https://www.hardkernel.com/shop/8gb-emmc-module-c2-android/
> >>> DUT4: orange hardkernel PCB white dot
> >>> https://rlx.sk/en/odroid/3198-16gb-emmc-50-module-xu3-android-for-odr=
o
> >>> id-xu3.html
> >>> DUT5: Industrial card
> >>
> >> Thanks a lot for helping out with testing! Much appreciated!
> >
> > No problem, glad to be of help.
> >
> >>
> >>>
> >>>
> >>> The test issued 461 DO_REL_WR during one of the iterations for DUT5
> >>>
> >>> DUT1:
> >>> Cache, no FUA:
> >>> 13:04.49
> >>> 13:13.82
> >>> 13:30.59
> >>> 13:28:13
> >>> 13:20:64
> >>> FUA:
> >>> 13:30.32
> >>> 13:36.26
> >>> 13:10.86
> >>> 13:32.52
> >>> 13:48.59
> >>>
> >>> DUT2:
> >>> FUA:
> >>> 8:11.24
> >>> 7:47.73
> >>> 7:48.00
> >>> 7:48.18
> >>> 7:47.38
> >>> Cache, no FUA:
> >>> 8:10.30
> >>> 7:48.97
> >>> 7:48.47
> >>> 7:47.93
> >>> 7:44.18
> >>>
> >>> DUT3:
> >>> Cache, no FUA:
> >>> 7:02.82
> >>> 6:58.94
> >>> 7:03.20
> >>> 7:00.27
> >>> 7:00.88
> >>> FUA:
> >>> 7:05.43
> >>> 7:03.44
> >>> 7:04.82
> >>> 7:03.26
> >>> 7:04.74
> >>>
> >>> DUT4:
> >>> FUA:
> >>> 7:23.92
> >>> 7:20.15
> >>> 7:20.52
> >>> 7:19.10
> >>> 7:20.71
> >>> Cache, no FUA:
> >>> 7:20.23
> >>> 7:20.48
> >>> 7:19.94
> >>> 7:18.90
> >>> 7:19.88
> >>
> >> Without going into the details of the above, it seems like for DUT1, D=
UT2, DUT3 and DUT4 there a good reasons to why we should move forward with =
$subject patch.
> >>
> >> Do you agree?
> >
> > That is a good question, that's why I just posted the data without furt=
her comment from my side.
> > I was honestly expecting the difference to be much higher, given the or=
iginal patch.
> > If this is representative for most cards, you would require quite an un=
usual workload to actually notice the difference IMO.
> > If there are cards where the difference is much more significant then o=
f course a quirk would be nicer.
> > On the other side I don't see why not and any improvement is a good one=
?
> >
> >>
> >>>
> >>> Cache, no FUA:
> >>> 7:19.36
> >>> 7:02.11
> >>> 7:01.53
> >>> 7:01.35
> >>> 7:00.37
> >>> Cache, no FUA CQE:
> >>> 7:17.55
> >>> 7:00.73
> >>> 6:59.25
> >>> 6:58.44
> >>> 6:58.60
> >>> FUA:
> >>> 7:15.10
> >>> 6:58.99
> >>> 6:58.94
> >>> 6:59.17
> >>> 6:60.00
> >>> FUA CQE:
> >>> 7:11.03
> >>> 6:58.04
> >>> 6:56.89
> >>> 6:56.43
> >>> 6:56:28
> >>>
> >>> If anyone has any comments or disagrees with the benchmark, or has a =
specific eMMC to test, let me know.
> >>
> >> If I understand correctly, for DUT5, it seems like using FUA may be sl=
ightly better than just cache-flushing, right?
> >
> > That is correct, I specifically tested with this card as under the assu=
mption that reliable write is without much additional cost, the DCMD would =
be slightly worse for performance and SYNC a bit worse.
> >
> >>
> >> For CQE, it seems like FUA could be slightly even better, at least for=
 DUT5.  Do you know if REQ_OP_FLUSH translates into MMC_ISSUE_DCMD or MMC_I=
SSUE_SYNC for your case? See mmc_cqe_issue_type().
> > It is SYNC (this is sdhci-of-arasan on rk3399, no DCMD), but even SYNC =
is not too bad here it seems, could of course be worse if the workload was =
less sequential.
> >
> >>
> >> When it comes to CQE, maybe Adrian have some additional thoughts aroun=
d this? Perhaps we should keep using REQ_FUA, if we have CQE?
> > Sure, I'm also interested in Adrian's take on this.
>
> Testing an arbitrary system and looking only at individual I/Os,
> which may not be representative of any use-case, resulted in
> FUA always winning, see below.
>
> All values are approximate and in microseconds.
>
>                 With FUA                Without FUA
>
> With CQE        Reliable Write  350     Write   125
>                                         Flush   300
>                 Total           350             425
>
> Without CQE     Reliable Write  350     Write   125
>                 CMD13           100     CMD13   100
>                                         Flush   300
>                                         CMD13   100
>                 Total           450             625
>
> FYI the test I was doing was:
>
>   # cat test.sh
>         #!/bin/sh
>
>         echo "hi" > /mnt/mmc/hi.txt
>
>         sync
>
>
>   # perf record --no-bpf-event -e mmc:* -a -- ./test.sh
>   # perf script --ns --deltatime
>
>
> The conclusion in this case would seem to be that CQE
> makes the case for removing FUA less bad.
>
> Perhaps CQE is more common in newer eMMCs which in turn
> have better FUA implementations.

Very interesting data - and thanks for helping out with tests!

A few observations and thoughts from the above.

1)
A "normal" use case would probably include additional writes (regular
writes) and I guess that could impact the flushing behavior. Maybe the
flushing becomes less heavy, if the device internally/occasionally
needs to flush its cache anyway? Or - maybe it doesn't matter at all,
because the reliable writes are triggering the cache to be flushed
too.

2)
Assuming that a reliable write is triggering the internal cache to be
flushed too, then we need less number of commands to be sent/acked to
the eMMC - compared to not using FUA. This means less protocol
overhead when using FUA - and perhaps that's what your tests is
actually telling us?

Kind regards
Uffe
