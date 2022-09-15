Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87F5BA254
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiIOV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIOV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED68FD5E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663277298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kf+m7U8TSVSl3FSPQuNNTHwEFQv7KyjKqr1qpipUqvU=;
        b=i5sIJgGVSVUHn6mw6cPV/ZW4dFQ3IYfYlzkUnHDnbwpuBtNz85c5lfj/rhIgtEaM2lEcHX
        88Kq6CazxeTxOA8Y4bkb1QeuOh8Ni1WJMt/ZCoqmzXCARyoiO4YBxG4NaTpTcRXu9+jdaa
        BxSo2rsVd0dxaeRi+dUOrfKWDv92w/0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-JQWOvoWFPe6zLh2pQMy87w-1; Thu, 15 Sep 2022 17:28:17 -0400
X-MC-Unique: JQWOvoWFPe6zLh2pQMy87w-1
Received: by mail-il1-f200.google.com with SMTP id j11-20020a056e02218b00b002f17a1f9637so13282405ila.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 14:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Kf+m7U8TSVSl3FSPQuNNTHwEFQv7KyjKqr1qpipUqvU=;
        b=hgUj7RBZ7bKCQEURvcly7deNKQzfqW7y3ms6JzcJVw0HPZmwem6Enuaq4ol3jctd/k
         JMByvBJXGB2+cDX9LVNpydb2EFqDAYA5cfscb5YnmZ9TDEGlT9gpIfHLPHps1VBRLWm6
         z4NoAycQFmgIdwTS0D9XJe13/vEcuPaxaFd7XgROzYaO4U+QL8tuzNYdRyLGjPk2djlJ
         3Q1FqI3SwJa+qNDSCYKwGWusHzYuhPZpTLKpLNhxr9l9zkzzDueHCeq1tChQDAbw1VHF
         wFdBt+ZHnPSEq0MZX9f9af2nhEIgcWpTwVvWuilipU5MCvGVbZL37SJj40XYFYyQB040
         XWNg==
X-Gm-Message-State: ACrzQf36RYunJNm5EYvQNlQ0bMfSjx//iCB1RbEOfqmcz/HM0KK3ggwz
        NF3va6KaZr4c7m2BTzyKSLvAWCK4eUPP06kKikmjDugJAJfatBwhOlUlIX3iXxGBwvD9T07gHzx
        HQ7BzWaLBKiUTxfYy++iVar/89ic1IDvBqfdBIX9V
X-Received: by 2002:a02:3f0e:0:b0:35a:54ec:e725 with SMTP id d14-20020a023f0e000000b0035a54ece725mr976695jaa.233.1663277296518;
        Thu, 15 Sep 2022 14:28:16 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+Qr6vmYVgEJKPxQyeh/ICzFQQbJX82R3/ThO0nXhqfb2CWu4EU1OHHvN27hztpxl7ZJ3WkkmQwJFnvnhXJm4=
X-Received: by 2002:a02:3f0e:0:b0:35a:54ec:e725 with SMTP id
 d14-20020a023f0e000000b0035a54ece725mr976673jaa.233.1663277296269; Thu, 15
 Sep 2022 14:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140357.323297659@linuxfoundation.org> <CA+G9fYv5CJeEaxu6XoaJrpizk+z1uXZ0aaQm2DVTA_w79oa2SA@mail.gmail.com>
 <20220915235936.4AD5.409509F4@e16-tech.com>
In-Reply-To: <20220915235936.4AD5.409509F4@e16-tech.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 15 Sep 2022 17:27:40 -0400
Message-ID: <CALF+zO=u0ehYsEuLBR4HG+KCma8zdjweE_Chgw1oJJEMS4TDjg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/121] 5.15.68-rc1 review
To:     wangyugui@e16-tech.com
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 12:02 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> > I have not bisected the reported problem.
> >
> > hugemmap05.c:99: TINFO: check /proc/meminfo before allocation.
> > hugemmap05.c:278: TINFO: HugePages_Total is 3.
> > hugemmap05.c:278: TINFO: HugePages_Free is 3.
> > hugemmap05.c:278: TINFO: HugePages_Surp is 1.
> > hugemmap05.c:27[   51.077819] ------------[ cut here ]------------
> > [   51.082692] WARNING: CPU: 0 PID: 590 at fs/nfs/inode.c:123
> > nfs_evict_inode+0x58/0x70
> > [   51.090451] Modules linked in: x86_pkg_temp_thermal
> > [   51.095329] CPU: 0 PID: 590 Comm: hugemmap05 Not tainted 5.15.68-rc1 #1
> > [   51.101948] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.5 11/26/2020
> > [   51.109340] RIP: 0010:nfs_evict_inode+0x58/0x70
> > [   51.113872] Code: 29 49 8b 54 24 90 49 8d 44 24 90 48 39 c2 75 2b
> > 4c 89 e7 e8 7a d8 ff ff 4c 89 e7 e8 82 74 ff ff 4c 8b 65 f8 c9 c3 cc
> > cc cc cc <0f> 0b 49 8b 54 24 90 49 8d 44 24 90 48 39 c2 74 d5 0f 0b eb
> > d1 0f
> > [   51.132626] RSP: 0018:ffffb6b140a8fb90 EFLAGS: 00010286
> > [   51.137861] RAX: adacafaea9a8abaa RBX: ffff937fa606a2c0 RCX: ffffb6b140a8fbd0
> > [   51.144986] RDX: ffff937fa606a2d0 RSI: ffffffffbc720682 RDI: ffffffffbc5ec05f
> > [   51.152120] RBP: ffffb6b140a8fb98 R08: 0000000000000000 R09: ffffb6b140a8fcf0
> > [   51.159253] R10: 0000000000000000 R11: 0000000000000002 R12: ffff937fa606a1a8
> > [   51.166395] R13: ffffffffbd851b40 R14: ffff937c40803870 R15: 0000000000000003
> > [   51.173525] FS:  00007f5afcdf4740(0000) GS:ffff937fa7a00000(0000)
> > knlGS:0000000000000000
> > [   51.181602] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   51.187359] CR2: 00007f5afcf10680 CR3: 000000010360a006 CR4: 00000000003706f0
> > 8: TINFO: HugePa[   51.194499] DR0: 0000000000000000 DR1:
> > 0000000000000000 DR2: 0000000000000000
> > [   51.203009] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   51.210135] Call Trace:
> > [   51.212585]  <TASK>
> > [   51.214684]  evict+0xc8/0x180
> > [   51.217682]  prune_icache_sb+0x81/0xc0
> > [   51.221435]  super_cache_scan+0x169/0x200
> > [   51.225447]  do_shrink_slab+0x13f/0x2b0
> > [   51.229288]  shrink_slab+0x186/0x2a0
> > [   51.232868]  drop_slab_node+0x4a/0xa0
> > [   51.236533]  drop_slab+0x41/0x90
> > [   51.239765]  drop_caches_sysctl_handler+0x79/0x90
> > [   51.244471]  proc_sys_call_handler+0x159/0x290
> > [   51.248918]  proc_sys_write+0x13/0x20
> > [   51.252582]  new_sync_write+0x111/0x1a0
> > [   51.256423]  vfs_write+0x1d5/0x270
> > [   51.259828]  ksys_write+0x67/0xf0
> > [   51.263150]  __x64_sys_write+0x19/0x20
> > [   51.266901]  do_syscall_64+0x38/0x90
> > [   51.270479]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> > [   51.275534] RIP: 0033:0x7f5afcef31d7
> > [   51.279112] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
> > 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
> > 74 24
> > [   51.297859] RSP: 002b:00007ffd40638738 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000001
> > [   51.305425] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5afcef31d7
> > [   51.312557] RDX: 0000000000000001 RSI: 00000000016f1480 RDI: 0000000000000003
> > [   51.319689] RBP: 00000000016f1480 R08: 0000000000000001 R09: 0000000000000001
> > [   51.326812] R10: 0000000000001000 R11: 0000000000000246 R12: 0000000000000001
> > [   51.333938] R13: 00000000016f12a0 R14: 0000000000000001 R15: 00007f5afcfe87a0
> > [   51.341073]  </TASK>
> > [   51.343264] ---[ end trace 3420625c1fbde9e9 ]---
> > ges_Rsvd is 3.
> > [   51.348004] hugemmap05 (590): drop_caches: 3
> > hugemmap05.c:253: TINFO: First hex is 7070707
>
> I hit this warning too.
>
> It seems that we need this patch for 5.15.y
>
> commit 0ebeebcf59601bcfa0284f4bb7abdec051eb856d
> Author: Dave Wysochanski <dwysocha@redhat.com>
> Date:   Sun Oct 10 18:23:13 2021 -0400
>
>     NFS: Fix WARN_ON due to unionization of nfs_inode.nrequests
>
>     Fixes the following WARN_ON
>     WARNING: CPU: 2 PID: 18678 at fs/nfs/inode.c:123 nfs_clear_inode+0x3b/0x50 [nfs]
>     ...
>     Call Trace:
>       nfs4_evict_inode+0x57/0x70 [nfsv4]
>       evict+0xd1/0x180
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/09/15
>
>

Sorry, commit 0ebeebcf59601bcfa0284f4bb7abdec051eb856d probably should
have had this
Fixes: e591b298d7ec "NFS: Save some space in the inode"

