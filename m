Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1936D938A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbjDFKDF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbjDFKCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:02:39 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B87ED2;
        Thu,  6 Apr 2023 03:02:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id cw23so26794ejb.12;
        Thu, 06 Apr 2023 03:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IeCwi9+3jSL1nb4jEHqH6GkeCus1uyB0RiSCcDwhPI=;
        b=GpYFAZvt43qQh/7pYICkFAtADru3JiyKL7fuP6GJV0VuQh4y6JKBjgiUAiXDI24TM7
         Ck6F6Mgje2kI10mVDLbnLd7P+ciUDglvpcfran19e7AFgpVZkMVOLQbWkRSHyOa0eSVb
         IwU3WBv+4ZMTUWLEAm5Qeldkzg/9t7umuSsdcPgSMm7MIaDyH0Vw0xzOwi1KdR7vCtO4
         atcsN42Znf8mlXB4xhDMg+/9uCew76oTdih8m+EagAzhlKxozw9dEgs5Cv5QSwWPp4LN
         3OakdPSyUNHDgQvTbPhl1PfEbFZ1Y6nb9pW8sbxl+5ZBGRxelelFGre6Wp6IX/Bzy1mo
         nf8w==
X-Gm-Message-State: AAQBX9faGMrKo5HCcNcERYccA8Bph5FTOwsDTNyq90aE8P4hsCG3pKg+
        k+TVRk4JyR9lLCJKltugDB3oZoFaJyinGfGM6g59ts6f
X-Google-Smtp-Source: AKy350aevNmeeVnSdZHM6/cq3n2nSTXTAkl8tU6AAI8yhSRPn6cYfYENtrPMGZ3MdMHz51Aca8LLPVgkXTfsHfPWE7g=
X-Received: by 2002:a17:907:8c17:b0:931:6921:bdbb with SMTP id
 ta23-20020a1709078c1700b009316921bdbbmr2076614ejc.2.1680775333753; Thu, 06
 Apr 2023 03:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230401165540.322665-1-yu.c.chen@intel.com> <CAJZ5v0j704JoCPTrDO1jTHwP1+8NVdLk7hym5036uFcfo7YHXQ@mail.gmail.com>
 <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
In-Reply-To: <ZC4zMv1SCiUMbcqs@chenyu5-mobl1>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 12:02:01 +0200
Message-ID: <CAJZ5v0j5PWsF6zCCVMRW59WevYLvWiBk82U4MpxqWdFnAcrqrQ@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Do not get block device exclusively in
 test_resume mode
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yifan Li <yifan2.li@intel.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 4:49 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Rafael,
> On 2023-04-05 at 20:37:32 +0200, Rafael J. Wysocki wrote:
> > On Sat, Apr 1, 2023 at 10:59 AM Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > The system refused to do a test_resume because it found that the
> > > swap device has already been taken by someone else. Specificly,
> > > the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> > > do this check.
> > >
> > > Steps to reproduce:
> > >  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
> > >        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
> > >  mkswap /swapfile
> > >  swapon /swapfile
> > >  swap-offset /swapfile
> > >  echo 34816 > /sys/power/resume_offset
> > >  echo test_resume > /sys/power/disk
> > >  echo disk > /sys/power/state
> > >
> > >  PM: Using 3 thread(s) for compression
> > >  PM: Compressing and saving image data (293150 pages)...
> > >  PM: Image saving progress:   0%
> > >  PM: Image saving progress:  10%
> > >  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >  ata1.00: configured for UDMA/100
> > >  ata2: SATA link down (SStatus 0 SControl 300)
> > >  ata5: SATA link down (SStatus 0 SControl 300)
> > >  ata6: SATA link down (SStatus 0 SControl 300)
> > >  ata3: SATA link down (SStatus 0 SControl 300)
> > >  ata4: SATA link down (SStatus 0 SControl 300)
> > >  PM: Image saving progress:  20%
> > >  PM: Image saving progress:  30%
> > >  PM: Image saving progress:  40%
> > >  PM: Image saving progress:  50%
> > >  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
> > >  PM: Image saving progress:  60%
> > >  PM: Image saving progress:  70%
> > >  PM: Image saving progress:  80%
> > >  PM: Image saving progress:  90%
> > >  PM: Image saving done
> > >  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
> > >  PM: S|
> > >  PM: hibernation: Basic memory bitmaps freed
> > >  PM: Image not found (code -16)
> > >
> > > This is because when using the swapfile as the hibernation storage,
> > > the block device where the swapfile is located has already been mounted
> > > by the OS distribution(usually been mounted as the rootfs). This is not
> > > an issue for normal hibernation, because software_resume()->swsusp_check()
> > > happens before the block device(rootfs) mount. But it is a problem for the
> > > test_resume mode. Because when test_resume happens, the block device has
> > > been mounted already.
> > >
> > > Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> > > problem because in test_resume stage, the processes have already been
> > > frozen, and the race condition described in
> > > Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > is unlikely to happen.
> > >
> > > Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> > > Reported-by: Yifan Li <yifan2.li@intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  kernel/power/hibernate.c | 18 +++++++++++-------
> > >  kernel/power/power.h     |  2 +-
> > >  kernel/power/swap.c      | 10 +++++++---
> > >  3 files changed, 19 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > > index 793c55a2becb..f50456e72f0a 100644
> > > --- a/kernel/power/hibernate.c
> > > +++ b/kernel/power/hibernate.c
> > > @@ -683,22 +683,26 @@ static void power_down(void)
> > >                 cpu_relax();
> > >  }
> > >
> > > -static int load_image_and_restore(void)
> > > +static int load_image_and_restore(bool safe)
> >
> > It is not very clear why the argument is called "safe".
> >
> > Either this needs to be explained in a comment, or I would just call
> > it "exclusive" and rework the checks accordingly.
> >
> OK, I can change it to "exclusive". Pavan proposed to add a global
> variable snapshot_testing to indicate that the system is in test_resume mode,
> and we can check this flag to decide whether to open the block device
> exclusively or not. Then we don't have to add parameter for load_image_and_restore()
> nor swsusp_check(). Could you please give advice whether this is applicable?

Well, in that case, why don't you simply check pm_test_level?

> If yes I can change the code accordingly, otherwise I can change the "safe"
> to "exclusive" and add some comments.
