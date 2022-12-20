Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE21651E14
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiLTJwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiLTJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C97FC5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671529799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5iOx7aV2uJMaHdJjEtnE4+t4p7oYZUq1Hmr1StADmsw=;
        b=X6BDragYGKpS10SFqFT9A/jyXlAjrSgUz7uco4RFadjoksi7gkuLXcDLSs12KqaTWchKEx
        KWY+e6snD3BljVLu4Cir0aeDNEUuUUewqs9PMosygRlt2/SQ54gyL2TofMGjeFvCY490YK
        6RpYrRfflcKIw03VuUc8D+DZgpFFOOo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-192-xjJVIuIjPWO0buaw6EzTuA-1; Tue, 20 Dec 2022 04:49:57 -0500
X-MC-Unique: xjJVIuIjPWO0buaw6EzTuA-1
Received: by mail-wr1-f71.google.com with SMTP id i13-20020adfa50d000000b0025f5084b95dso1161337wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 01:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iOx7aV2uJMaHdJjEtnE4+t4p7oYZUq1Hmr1StADmsw=;
        b=SGn8x6jIof7aYnyhmWb+tOj/zX/5nUC3nYIeFjHL0zS1NVL9b4xRwQtmRz//mjkadf
         WyHZEGb3q7/AlkUgThkPFsaH0vS8QbgXh1x/agMRglRKnVRlTbM5MO6yLwnRhpGWYcSe
         BeLThSyapM/LXregUE20R3msf1UwklrF96r1IVPL7IdeeHG2ZfqWprq9RjZO+1/dYj60
         pmPddM+l6GDJS5MfwYBTSRwFg9PDILW8GTklJJEP5EUOSP/UqX9G4U5Rbz5aQ8+FRPwS
         fra/sVz6PrhmlxfB3JuBCTfZ91puD4ubKqgi/WeH6VIAI5qU+sXZBC3tmZDH2ZrNwfz9
         B6Lg==
X-Gm-Message-State: ANoB5pmsiWsJdk4HUMGSTOBWU2nUol1fC93FIPHOECHFytNi617r3LFN
        F/bC8G1Lz5K7Q/U1rsmNnVIJuEOkm0hzhNG+TQL07qhCKTC0zMinoGXpnnHPF8Oq4RAe9iP4WJK
        M02CGVps0zsjjjoqqBcEoVxYI
X-Received: by 2002:a5d:4750:0:b0:242:15e0:d592 with SMTP id o16-20020a5d4750000000b0024215e0d592mr38064541wrs.33.1671529795889;
        Tue, 20 Dec 2022 01:49:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6pso3Pfy2U+0SiN/LpAXFM7ECDXSiOCfB01EnQKmKSP3+yIxzqvNsgLDvg80F+P8NgEGr5rQ==
X-Received: by 2002:a5d:4750:0:b0:242:15e0:d592 with SMTP id o16-20020a5d4750000000b0024215e0d592mr38064526wrs.33.1671529795666;
        Tue, 20 Dec 2022 01:49:55 -0800 (PST)
Received: from redhat.com ([2.52.8.61])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm12190894wrn.52.2022.12.20.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:49:55 -0800 (PST)
Date:   Tue, 20 Dec 2022 04:49:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
Message-ID: <20221220044740-mutt-send-email-mst@kernel.org>
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:51:54PM +0530, Naresh Kamboju wrote:
> The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
> It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
> (Debian clang version 16.0.0
> (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
> 16.0.0) #1 SMP PREEMPT @1671498176
> <5>[    0.000000] random: crng init done
> <6>[    0.000000] Machine model: linux,dummy-virt
> ....
> <6>[    3.571098] loop: module loaded
> <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
> <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
> blocks (1.44 GB/1.34 GiB)
> <4>[    3.581234] ------------[ cut here ]------------
> <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
> <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> <4>[    3.583672] Modules linked in:
> <4>[    3.584905] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.1.0-next-20221220 #1
> <4>[    3.585801] Hardware name: linux,dummy-virt (DT)
> <4>[    3.586591] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
> -SSBS BTYPE=--)
> <4>[    3.587349] pc : virtio_check_driver_offered_feature+0x60/0x6c
> <4>[    3.588613] lr : virtblk_probe+0x7cc/0x8f0
> <4>[    3.588915] sp : ffff80000802b840
> <4>[    3.589314] x29: ffff80000802b850 x28: 0000000000000000 x27:
> 0000000000000001
> <4>[    3.590509] x26: 0000000000000001 x25: 0000000000000200 x24:
> ffff0000c1699b00
> <4>[    3.590832] x23: 00000000000000fe x22: ffff0000c0313c30 x21:
> ffff0000c0313c00
> <4>[    3.591568] x20: ffff0000c02f4080 x19: 0000000000000000 x18:
> ffffffffffffffff
> <4>[    3.592056] x17: 00000000ffffffea x16: 00000000fffffffe x15:
> 0000000000000004
> <4>[    3.592632] x14: 0000000000000fff x13: ffff800008028000 x12:
> ffff80000802c000
> <4>[    3.593157] x11: 000000000000000f x10: 000000000000000f x9 :
> ffffae66eee314d8
> <4>[    3.594048] x8 : 0000000000000000 x7 : 3631383837352e33 x6 :
> 202020205b3e353c
> <4>[    3.594429] x5 : 0000000000000001 x4 : 0000000000000000 x3 :
> ffff80000802b780
> <4>[    3.594956] x2 : ffff80000802b6f8 x1 : 0000000000000011 x0 :
> ffff0000c02f4080
> <4>[    3.595811] Call trace:
> <4>[    3.596120]  virtio_check_driver_offered_feature+0x60/0x6c
> <4>[    3.596632]  virtio_dev_probe+0x274/0x320
> <4>[    3.597064]  really_probe+0x178/0x418
> <4>[    3.597547]  __driver_probe_device+0x120/0x188
> <4>[    3.597820]  driver_probe_device+0x48/0x22c
> <4>[    3.598189]  __driver_attach+0xf8/0x250
> <4>[    3.598656]  bus_for_each_dev+0x8c/0xd8
> <4>[    3.599151]  driver_attach+0x30/0x3c
> <4>[    3.599321]  bus_add_driver+0x11c/0x22c
> <4>[    3.599684]  driver_register+0x84/0x120
> <4>[    3.600175]  register_virtio_driver+0x38/0x48
> <4>[    3.600575]  virtio_blk_init+0x6c/0xb4
> <4>[    3.600759]  do_one_initcall+0xe0/0x2f8
> <4>[    3.601197]  do_initcall_level+0xa8/0x150
> <4>[    3.601703]  do_initcalls+0x60/0xa0
> <4>[    3.601892]  do_basic_setup+0x28/0x34
> <4>[    3.602229]  kernel_init_freeable+0x100/0x178
> <4>[    3.602706]  kernel_init+0x2c/0x1b4
> <4>[    3.603162]  ret_from_fork+0x10/0x20
> <0>[    3.604398] Code: 540000a0 91001129 f1000508 54ffff61 (d4210000)
> <4>[    3.606108] ---[ end trace 0000000000000000 ]---
> <6>[    3.606714] note: swapper/0[1] exited with preempt_count 1
> <0>[    3.608155] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> <2>[    3.609173] SMP: stopping secondary CPUs
> <0>[    3.610506] Kernel Offset: 0x2e66e4800000 from 0xffff800008000000
> <0>[    3.610970] PHYS_OFFSET: 0x40000000
> <0>[    3.611428] CPU features: 0x00000,003a612f,cd22773f
> <0>[    3.612277] Memory Limit: none
> <0>[    3.613192] ---[ end Kernel panic - not syncing: Attempted to
> kill init! exitcode=0x0000000b ]---
> 
> Ref Links,
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13764099/suite/log-parser-test/test/check-kernel-bug/details/
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13766814/suite/boot/test/clang-nightly-lkftconfig/details/
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9l3qxSBmPWVa1S2uWn0Xuwl1J/config
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

Could you post a bit more detail pls?
- qemu version and command line
- .config
- compiler / compiler flags if any

Thanks!

-- 
MST

