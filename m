Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9E65E99D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjAELOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjAELOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:14:35 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F276E4E42F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 03:14:29 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id h27so24029133vsq.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 03:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMRjHUwJUvRGpT0uK5naDeFxSpoQz5G/C8mDQel+RtE=;
        b=f2VaMp8wQ1T7VqEI1CIQ7k5CuqJHwxeOyM/XKit9L/+QSS2KCJyxYn3hw256zWkgKx
         AWLjZTHhRKsIwx+buvy0lvGNrU5itGsVEyKfdYA8OGTCgvHLKXuKknbIpcIb1C8VVjXw
         0KKtJtVMTw+s4Y6rz8Hn7P0z6U2eCP/CfjA1/3Ewy+iBxN/wTzGyQv/gTvdsS+qvQtm+
         BaZUCHjNm6YSMR1Tq1/Uq6u0cSPHyRLt7BBm6DpQHehpq7k9cBwmMP+yQUu/PZ59x9M5
         ceub7+/LnVdDtcMwUlGUPfIUiO8f2CeYOzL5GxAk5fz0nA7skdklFgIcaaEwef36T8HC
         FdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMRjHUwJUvRGpT0uK5naDeFxSpoQz5G/C8mDQel+RtE=;
        b=S45ibfFKJE/6XvKd9o7czQMiPKQRwgFDjCu20l3U0m7+L9yfBuQjN5cvN9ERWcjyh/
         bHAqijRAhyCypesjj0VdnfPe59i57LY6D3u03aqTVloDdDsEJ2jmaFP6HBgSh+8na3eL
         A6Ki8hOlpN+hm+Ou29267kMLV/unGtMbPyg1iS25RBIt8+YmixWYEu6YBiTKj1eFSJ1K
         DEjrd+gScQTAnLg1JsxSlqE1IujJ9cOnEDHLxVEyczA1LhvY+SrMkIINBLEbLy0hL4Bt
         1CquBCV5Z/FTjysBVM5Og+JTTLC309F+fjWWPNCyfSu4GX93+R2JCy1PZgLO5qk3E1e6
         tJZw==
X-Gm-Message-State: AFqh2krLo89aywtlnWvDNnGRiRCtKkQY9cf7noKPWuoByqHPmdJTDV5U
        SBAhSsMo1ZuKccFTtdhcGlpHTpBFcFGSaG+hcvUHpA==
X-Google-Smtp-Source: AMrXdXu3qt6GSNBK0DAgHXtuNuKyf7FK7GkUKwWLAta6G5qZTKO6FTIf3n0KgIq8UrBgua6uqEOv0OJ9IUU8u6c6Pms=
X-Received: by 2002:a05:6102:3ca8:b0:3ce:88b3:bdca with SMTP id
 c40-20020a0561023ca800b003ce88b3bdcamr2111697vsv.48.1672917268961; Thu, 05
 Jan 2023 03:14:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c0a08805f07291a0@google.com> <f126fc95-fdbe-cc2e-5efb-ab704d13bd41@linux.alibaba.com>
In-Reply-To: <f126fc95-fdbe-cc2e-5efb-ab704d13bd41@linux.alibaba.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 5 Jan 2023 12:14:17 +0100
Message-ID: <CANp29Y63rCdepVtantxdJEcvbRv0D61gfY_oGV7dgrmEGgPdLw@mail.gmail.com>
Subject: Re: [syzbot] [erofs?] WARNING: CPU: NUM PID: NUM at
 mm/page_alloc.c:LINE get_page_from_freeli
To:     Xiang Gao <hsiangkao@linux.alibaba.com>
Cc:     syzbot <syzbot+c3729cda01706a04fb98@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 5, 2023 at 11:54 AM Xiang Gao <hsiangkao@linux.alibaba.com> wrote:

> I wasn't able to build the kernel with this kernel config, it shows:
> "...
> FATAL: modpost: vmlinux.o is truncated. sechdrs[i].sh_offset=1399394064 > sizeof(*hrd)=64
> make[2]: *** [Module.symvers] Error 1
> make[1]: *** [modpost] Error 2
> make: *** [__sub-make] Error 2
> "

Could you please tell, what exact compiler/linker version did you use?


> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0c8a5f06ceb3/disk-f9ff5644.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/be222e852ae2/vmlinux-f9ff5644.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d9f42a53b05e/bzImage-f9ff5644.xz
>
> Finally I tried the original kernel image, and it printed some other
> random bug when booting system and then reboot, like:
>
> [   36.991123][    T1] ==================================================================
> [   36.991800][    T1] BUG: KASAN: slab-out-of-bounds in copy_array+0x96/0x100
> [   36.992438][    T1] Write of size 32 at addr ffff888018c34640 by task systemd/1
< .. >

Interesting!
I've just tried to boot it with qemu and it was fine.

qemu-system-x86_64 -smp 2,sockets=2,cores=1 -m 4G -drive
file=disk-f9ff5644.raw,format=raw -snapshot -nographic -enable-kvm

So it looks like it's some difference between these VMMs that causes
that bug to fire.

>
> May I ask it can be reproducable on the latest -rc kernel?

We can ask syzbot about v6.2-rc2:

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
88603b6dc419445847923fcb7fe5080067a30f98

>
> Thanks,
> Gao Xiang
>

--
Aleksandr
