Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277C6DE0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDKQVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 12:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDKQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:21:52 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97C2A0;
        Tue, 11 Apr 2023 09:21:48 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id jg21so21480794ejc.2;
        Tue, 11 Apr 2023 09:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA1URChDyWUe82wBxVnJj2Y9kjeuq+WNWY4WAjgdeNI=;
        b=MG4pWeiTuoYoUHEU7RoLkK2d9yd+xnY/lWOGxoay/9jZ3+1Sf0tvsl1ybJTrwcTIZn
         hEqXbXk3lmTTZlhRUDxgBdcZ2V7PVoAnd8sbcneJuSdxSPdU0cHl+PvI5ia7oHffQDi0
         Buqdwpnv4+ANbiiBek3uHZ6FfsnXJnZG2agRPvz7TSs3WOT/fkQXu4YHzRVC21YPWtag
         kUJIViMmkAcCSwEcO4R0jeikdQxGinEZt62QY2e46JbTXZuDNNcS4dfjvgnQRxnBCibf
         jRf212Q6vxZSfLyBNIHMky/mjH8Mx++nD7RAX0gLPxzEqriK3usmfHCvUd0GPT9yYugz
         Dwhw==
X-Gm-Message-State: AAQBX9fweoJR7TBEDCToDKve1z1qcfJ5uxyzUsn29FG10ghitP4wMVtg
        qoOzB2p+n07lLEKkpB/Dop4ZGZFhh4G/oV1AFdQ=
X-Google-Smtp-Source: AKy350biFncVt62uiW3X/eNh6ohumixHlTCMeLBYhGhcEJ30rZpImbJwYmlIvX5i6Xb/3pVvOsCXtoHGbdbfXjVmwa8=
X-Received: by 2002:a17:906:2981:b0:94b:ffe9:37fc with SMTP id
 x1-20020a170906298100b0094bffe937fcmr2556430eje.2.1681230107422; Tue, 11 Apr
 2023 09:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681186310.git.yu.c.chen@intel.com> <8f917ae09c7a09d1841824908107d6c79a6cd090.1681186310.git.yu.c.chen@intel.com>
In-Reply-To: <8f917ae09c7a09d1841824908107d6c79a6cd090.1681186310.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 18:21:36 +0200
Message-ID: <CAJZ5v0gGbREHrwSg48JfZX9tgNUr0GeYyejGfd80VjR8Wd9Ffw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PM: hibernate: Do not get block device exclusively
 in test_resume mode
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Ye Bin <yebin10@huawei.com>,
        Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yifan Li <yifan2.li@intel.com>
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

On Tue, Apr 11, 2023 at 6:23 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> The system refused to do a test_resume because it found that the
> swap device has already been taken by someone else. Specificly,

"Specifically" I suppose.

> the swsusp_check()->blkdev_get_by_dev(FMODE_EXCL) is supposed to
> do this check.
>
> Steps to reproduce:
>  dd if=/dev/zero of=/swapfile bs=$(cat /proc/meminfo |
>        awk '/MemTotal/ {print $2}') count=1024 conv=notrunc
>  mkswap /swapfile
>  swapon /swapfile
>  swap-offset /swapfile
>  echo 34816 > /sys/power/resume_offset
>  echo test_resume > /sys/power/disk
>  echo disk > /sys/power/state
>
>  PM: Using 3 thread(s) for compression
>  PM: Compressing and saving image data (293150 pages)...
>  PM: Image saving progress:   0%
>  PM: Image saving progress:  10%
>  ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  ata1.00: configured for UDMA/100
>  ata2: SATA link down (SStatus 0 SControl 300)
>  ata5: SATA link down (SStatus 0 SControl 300)
>  ata6: SATA link down (SStatus 0 SControl 300)
>  ata3: SATA link down (SStatus 0 SControl 300)
>  ata4: SATA link down (SStatus 0 SControl 300)
>  PM: Image saving progress:  20%
>  PM: Image saving progress:  30%
>  PM: Image saving progress:  40%
>  PM: Image saving progress:  50%
>  pcieport 0000:00:02.5: pciehp: Slot(0-5): No device found
>  PM: Image saving progress:  60%
>  PM: Image saving progress:  70%
>  PM: Image saving progress:  80%
>  PM: Image saving progress:  90%
>  PM: Image saving done
>  PM: hibernation: Wrote 1172600 kbytes in 2.70 seconds (434.29 MB/s)
>  PM: S|
>  PM: hibernation: Basic memory bitmaps freed
>  PM: Image not found (code -16)
>
> This is because when using the swapfile as the hibernation storage,
> the block device where the swapfile is located has already been mounted
> by the OS distribution(usually been mounted as the rootfs). This is not

"usually mounted"

> an issue for normal hibernation, because software_resume()->swsusp_check()
> happens before the block device(rootfs) mount. But it is a problem for the
> test_resume mode. Because when test_resume happens, the block device has
> been mounted already.
>
> Thus remove the FMODE_EXCL for test_resume mode. This would not be a
> problem because in test_resume stage, the processes have already been
> frozen, and the race condition described in
> Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> is unlikely to happen.
>
> Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
> Reported-by: Yifan Li <yifan2.li@intel.com>
> Suggested-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/hibernate.c | 5 +++--
>  kernel/power/swap.c      | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index aa551b093c3f..defc2257b052 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -688,18 +688,19 @@ static int load_image_and_restore(void)
>  {
>         int error;
>         unsigned int flags;
> +       fmode_t mode = snapshot_test ? FMODE_READ : (FMODE_READ | FMODE_EXCL);

fmode_t mode = FMODE_READ;

if (snapshot_test)
        mode |= FMODE_EXCL;

pretty please, and analogously below.

>
>         pm_pr_dbg("Loading hibernation image.\n");
>
>         lock_device_hotplug();
>         error = create_basic_memory_bitmaps();
>         if (error) {
> -               swsusp_close(FMODE_READ | FMODE_EXCL);
> +               swsusp_close(mode);
>                 goto Unlock;
>         }
>
>         error = swsusp_read(&flags);
> -       swsusp_close(FMODE_READ | FMODE_EXCL);
> +       swsusp_close(mode);
>         if (!error)
>                 error = hibernation_restore(flags & SF_PLATFORM_MODE);
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 36a1df48280c..0f699cd96a89 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1518,9 +1518,10 @@ int swsusp_check(void)
>  {
>         int error;
>         void *holder;
> +       fmode_t mode = snapshot_test ? FMODE_READ : (FMODE_READ | FMODE_EXCL);
>
>         hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -                                           FMODE_READ | FMODE_EXCL, &holder);
> +                                           mode, &holder);
>         if (!IS_ERR(hib_resume_bdev)) {
>                 set_blocksize(hib_resume_bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
> @@ -1547,7 +1548,7 @@ int swsusp_check(void)
>
>  put:
>                 if (error)
> -                       blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
> +                       blkdev_put(hib_resume_bdev, mode);
>                 else
>                         pr_debug("Image signature found, resuming\n");
>         } else {
> --
