Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F1651F52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiLTKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 05:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiLTKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 05:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A256186C1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671533679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L6sHodn01vkbqA8ncp7KquzV496LkI1ysg4gaIRgYc8=;
        b=cotBuMhaixwMVt/HdfFSIG6ok9WYdkxkY5BY1J1ZK34LONVHlGVQGE1xHcrW1fT73XZ5w9
        JjBjPf+F5jstOdtLTezg4mnkenI7xC5Lks8Rdp9TUMfihpY7+OvBikJL8oqpFhOfjCRHmN
        AuDimzwRoNszfX2N8eBNlM+oWW7dj+U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-hv4EEdeBMSiQZ8PZsBaORw-1; Tue, 20 Dec 2022 05:54:38 -0500
X-MC-Unique: hv4EEdeBMSiQZ8PZsBaORw-1
Received: by mail-qk1-f199.google.com with SMTP id m3-20020a05620a24c300b006fee2294e97so9142032qkn.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 02:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6sHodn01vkbqA8ncp7KquzV496LkI1ysg4gaIRgYc8=;
        b=A5zlV2LXYftBC210r909xcqtgeG+7osEvxp6iepwCc+M+2+R4FWAKCu9uCsDPl5I3c
         U0DDQq3/1cMCtyc8bVeoQd305JRfmAIvoIH2b3K0R/VJQKMxPKRhKlaFobdxbQjQUGOI
         4/vUyuw1b4mhOFpJ+3i8aF7AVNaGewAcKwPItDkA1LurY62yUm4zYBFks9oOJ4/0dan0
         UMTmrTitS/yrW07pGn0E91Q9MgHTWU29d/9Ou3CqdrACvsSw9cYzaiifIsAmL3JETR+V
         iqVTw0C6XbbBNi6tmjPA2KcY5HbTnREIHgezG/2FmQwH7r9qpSq9Cqzr/JLd+4Ima2+p
         +VlQ==
X-Gm-Message-State: AFqh2krbwwsKdVK/9+bIyASCz4aYb5fsoIFqs+u2c7gm/6m3aMjkd1yl
        SIRqnhLQhr2RByecSrgNP6NXnosy+LtarMl2mTsJkkpKGmJNtOnTKsVTfVHJC2radKIJd6lAPES
        FFsyyq+8t/1DJOMyx801/J1DU
X-Received: by 2002:ac8:6644:0:b0:3a9:9170:793c with SMTP id j4-20020ac86644000000b003a99170793cmr5008213qtp.5.1671533676074;
        Tue, 20 Dec 2022 02:54:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt+avM9zY/pKZS8HlCdSEWW9uFiN08wM9x9fk81EX+uopV6hVVp2pfoh+pgdFu8K+RIuCZ0PA==
X-Received: by 2002:ac8:6644:0:b0:3a9:9170:793c with SMTP id j4-20020ac86644000000b003a99170793cmr5008192qtp.5.1671533675807;
        Tue, 20 Dec 2022 02:54:35 -0800 (PST)
Received: from redhat.com ([37.19.199.118])
        by smtp.gmail.com with ESMTPSA id do25-20020a05620a2b1900b006ff8c632259sm8690503qkb.42.2022.12.20.02.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 02:54:35 -0800 (PST)
Date:   Tue, 20 Dec 2022 05:54:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        Shaoqin Huang <shaoqin.huang@intel.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        virtualization@lists.linux-foundation.org, dmitry.fomichev@wdc.com
Subject: Re: next: kernel BUG at drivers/virtio/virtio.c:122!
Message-ID: <20221220054938-mutt-send-email-mst@kernel.org>
References: <CA+G9fYvz1eNS5fw1Wg5f4HqwdWPNg3EQyrGZVEOJ=OQzYzZ_YQ@mail.gmail.com>
 <1671532079.1159124-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671532079.1159124-1-xuanzhuo@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 06:27:59PM +0800, Xuan Zhuo wrote:
> On Tue, 20 Dec 2022 14:51:54 +0530, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > The qemu-x86_64 and qemu-arm64 boot failed with Linux next-20221220 tag.
> > It is always reproducible with gcc-11/ gcc-12 and clang tool chains.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
> > <5>[    0.000000] Linux version 6.1.0-next-20221220 (tuxmake@tuxmake)
> > (Debian clang version 16.0.0
> > (++20221218072110+9c1b82599dac-1~exp1~20221218072217.501), Debian LLD
> > 16.0.0) #1 SMP PREEMPT @1671498176
> > <5>[    0.000000] random: crng init done
> > <6>[    0.000000] Machine model: linux,dummy-virt
> > ....
> > <6>[    3.571098] loop: module loaded
> > <6>[    3.573410] virtio_blk virtio0: 1/0/0 default/read/poll queues
> > <5>[    3.578816] virtio_blk virtio0: [vda] 2816420 512-byte logical
> > blocks (1.44 GB/1.34 GiB)
> > <4>[    3.581234] ------------[ cut here ]------------
> > <2>[    3.581595] kernel BUG at drivers/virtio/virtio.c:122!
> > <0>[    3.582906] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> > <4>[    3.583672] Modules linked in:
> > <4>[    3.584905] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.1.0-next-20221220 #1
> > <4>[    3.585801] Hardware name: linux,dummy-virt (DT)
> > <4>[    3.586591] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
> > -SSBS BTYPE=--)
> > <4>[    3.587349] pc : virtio_check_driver_offered_feature+0x60/0x6c
> > <4>[    3.588613] lr : virtblk_probe+0x7cc/0x8f0
> > <4>[    3.588915] sp : ffff80000802b840
> > <4>[    3.589314] x29: ffff80000802b850 x28: 0000000000000000 x27:
> > 0000000000000001
> > <4>[    3.590509] x26: 0000000000000001 x25: 0000000000000200 x24:
> > ffff0000c1699b00
> > <4>[    3.590832] x23: 00000000000000fe x22: ffff0000c0313c30 x21:
> > ffff0000c0313c00
> > <4>[    3.591568] x20: ffff0000c02f4080 x19: 0000000000000000 x18:
> > ffffffffffffffff
> > <4>[    3.592056] x17: 00000000ffffffea x16: 00000000fffffffe x15:
> > 0000000000000004
> > <4>[    3.592632] x14: 0000000000000fff x13: ffff800008028000 x12:
> > ffff80000802c000
> > <4>[    3.593157] x11: 000000000000000f x10: 000000000000000f x9 :
> > ffffae66eee314d8
> > <4>[    3.594048] x8 : 0000000000000000 x7 : 3631383837352e33 x6 :
> > 202020205b3e353c
> > <4>[    3.594429] x5 : 0000000000000001 x4 : 0000000000000000 x3 :
> > ffff80000802b780
> > <4>[    3.594956] x2 : ffff80000802b6f8 x1 : 0000000000000011 x0 :
> > ffff0000c02f4080
> > <4>[    3.595811] Call trace:
> > <4>[    3.596120]  virtio_check_driver_offered_feature+0x60/0x6c
> > <4>[    3.596632]  virtio_dev_probe+0x274/0x320
> > <4>[    3.597064]  really_probe+0x178/0x418
> > <4>[    3.597547]  __driver_probe_device+0x120/0x188
> > <4>[    3.597820]  driver_probe_device+0x48/0x22c
> > <4>[    3.598189]  __driver_attach+0xf8/0x250
> > <4>[    3.598656]  bus_for_each_dev+0x8c/0xd8
> > <4>[    3.599151]  driver_attach+0x30/0x3c
> > <4>[    3.599321]  bus_add_driver+0x11c/0x22c
> > <4>[    3.599684]  driver_register+0x84/0x120
> > <4>[    3.600175]  register_virtio_driver+0x38/0x48
> > <4>[    3.600575]  virtio_blk_init+0x6c/0xb4
> > <4>[    3.600759]  do_one_initcall+0xe0/0x2f8
> > <4>[    3.601197]  do_initcall_level+0xa8/0x150
> > <4>[    3.601703]  do_initcalls+0x60/0xa0
> > <4>[    3.601892]  do_basic_setup+0x28/0x34
> > <4>[    3.602229]  kernel_init_freeable+0x100/0x178
> > <4>[    3.602706]  kernel_init+0x2c/0x1b4
> > <4>[    3.603162]  ret_from_fork+0x10/0x20
> > <0>[    3.604398] Code: 540000a0 91001129 f1000508 54ffff61 (d4210000)
> > <4>[    3.606108] ---[ end trace 0000000000000000 ]---
> > <6>[    3.606714] note: swapper/0[1] exited with preempt_count 1
> > <0>[    3.608155] Kernel panic - not syncing: Attempted to kill init!
> > exitcode=0x0000000b
> > <2>[    3.609173] SMP: stopping secondary CPUs
> > <0>[    3.610506] Kernel Offset: 0x2e66e4800000 from 0xffff800008000000
> > <0>[    3.610970] PHYS_OFFSET: 0x40000000
> > <0>[    3.611428] CPU features: 0x00000,003a612f,cd22773f
> > <0>[    3.612277] Memory Limit: none
> > <0>[    3.613192] ---[ end Kernel panic - not syncing: Attempted to
> > kill init! exitcode=0x0000000b ]---
> >
> > Ref Links,
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13764099/suite/log-parser-test/test/check-kernel-bug/details/
> > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221220/testrun/13766814/suite/boot/test/clang-nightly-lkftconfig/details/
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2J9l3qxSBmPWVa1S2uWn0Xuwl1J/config
> >
> 
> 
> I think there is a bug, VIRTIO_BLK_F_ZONED depends the CONFIG_BLK_DEV_ZONE, but
> checking its code in virtblk_probe does not depend on this config.
> 
> This option in your config file is indeed not opened.
> 
> 
> static int virtblk_probe(struct virtio_device *vdev){
> .....
> 	virtblk_update_capacity(vblk, false);
> 	virtio_device_ready(vdev);
> 
> 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> 		err = virtblk_probe_zoned_device(vdev, vblk, q);
> 		if (err)
> 			goto out_cleanup_disk;
> 	}
> 
> 	dev_info(&vdev->dev, "blk config size: %zu\n",
> 		sizeof(struct virtio_blk_config));
> 
> ....
> 
> static unsigned int features[] = {
> 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
> 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
> 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
> 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
> #ifdef CONFIG_BLK_DEV_ZONED
> 	VIRTIO_BLK_F_ZONED,
> #endif /* CONFIG_BLK_DEV_ZONED */
> }
> 
> 
> Thanks.

Oh you are right, I wanted to test it so of course I enabled it.

Testing this fixup now:

commit f9503d0fd839b59e0f48b00c20635437c41420ed
Author: Michael S. Tsirkin <mst@redhat.com>
Date:   Tue Dec 20 05:53:41 2022 -0500

    fixup! virtio-blk: add support for zoned block devices

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index ff49052e26f7..d8cdaeb51d1c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -775,6 +775,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 	return ret;
 }
 
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
+}
 #else
 
 /*
@@ -790,6 +794,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /* return id (s/n) string for *disk to *id_str
@@ -1576,11 +1585,11 @@ static int virtblk_probe(struct virtio_device *vdev)
 		else
 			q->limits.discard_granularity = blk_size;
 	}
 
 	virtblk_update_capacity(vblk, false);
 	virtio_device_ready(vdev);
 
-	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
+	if (virtblk_has_zoned_feature(vdev)) {
 		err = virtblk_probe_zoned_device(vdev, vblk, q);
 		if (err)
 			goto out_cleanup_disk;
-- 
MST

