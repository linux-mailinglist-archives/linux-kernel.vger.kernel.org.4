Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8610E6A8BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCBWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCBWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:21:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069073B237
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:21:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so4271236pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 14:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1677795686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sqaDMJkfZlaBf387zIPkPPqYIp4w31qGTsCwBc2LaNg=;
        b=U9jW3W/0nX/tB3yQS15Ol1Hnwe3FYIzbnIGT6VLdTeHw+lT9orFaoGAnK0gsQpz+vM
         pItPNyJZRQQ93kJPSdTXCKMYZnTANtsEyfrWZDmS+30OFBSVnR5xzyjT0duLbvqGzKiM
         GI0+TnGwAUUkVOvdwFsqB6LwVWrF2tht+UIw9gUQxz75GjIcDKwjeaBJfQSNjY1LTf5A
         ooiodduLz2hB4+6QRKJYfi0qFnIYJf8F7eDeaN9P581KUzjXYk/o38vQ1Vemk+urI7Hs
         Jgsob17owkjIei+veogh6M7N9foYAAIzyqtJUNwmV1gJZzQvGLW2t24NQmPrQ6vsLPYl
         at+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677795686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqaDMJkfZlaBf387zIPkPPqYIp4w31qGTsCwBc2LaNg=;
        b=LFtyUkO34Q4oPvhV83GfFDHfYDlOMdBRhTF/DgwXmIxA1pg04zxRgLeZqqxSoKwWve
         iwhlvvOiZr/rqgiFCUlWBn4viz3UEFhNAlS4CE/5gAxQrAUnFuvtrCoyTdKqGnmA6YI4
         g2pXIYZxswWX48vfiD8FDJm3mU55DoZ1WXrWFNdBfKHWXTLSy6TPktEBTPjmdM2u5qmv
         ysKmU/QnbTI26vnNSvPP2CD3UE6Wmq5OgDYh3pFfENzzxdgelzrg8FnaYcAak1xVxd88
         P2/B3LbSyt+i4Lfyg+41V5B+GU5txLZjdX+oHPwTWCkUS6JxPI2ECbfEgFmbh3XxSwhk
         EAVQ==
X-Gm-Message-State: AO0yUKWRSVNEOg6HFtdACVfwMFY8g4FXvOOu7IaLgjMTjyGI2itPcieF
        BUuapRUgy7nKhaAxHxxKvwkSmw==
X-Google-Smtp-Source: AK7set/EODVNSi77M77LXutCMLGRhE693lonQd3jU3ZAa0dwaxpiAt6d0Ub1+0xiBAQiQ6Kag/wlbA==
X-Received: by 2002:a05:6a20:1609:b0:cc:d44a:bec2 with SMTP id l9-20020a056a20160900b000ccd44abec2mr84229pzj.1.1677795686414;
        Thu, 02 Mar 2023 14:21:26 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id u21-20020a63ef15000000b004eecc3080f8sm168123pgh.29.2023.03.02.14.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:21:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pXrIg-00455X-Jw; Fri, 03 Mar 2023 09:21:22 +1100
Date:   Fri, 3 Mar 2023 09:21:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [xfs] 304a68b9c6:
 WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release
Message-ID: <20230302222122.GJ360264@dread.disaster.area>
References: <202302281653.51938721-yujie.liu@intel.com>
 <20230228221107.GD360264@dread.disaster.area>
 <ZABgp1uBzcE49EG9@yujie-X299>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZABgp1uBzcE49EG9@yujie-X299>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:39:03PM +0800, Yujie Liu wrote:
> On Wed, Mar 01, 2023 at 09:11:07AM +1100, Dave Chinner wrote:
> > On Tue, Feb 28, 2023 at 04:40:01PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed WARNING:at_fs/iomap/buffered-io.c:#iomap_write_delalloc_release due to commit (built with gcc-11):
> > > 
> > > commit: 304a68b9c63bbfc1f6e159d68e8892fc54a06067 ("xfs: use iomap_valid method to detect stale cached iomaps")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > [test failed on linux-next/master 058f4df42121baadbb8a980c06011e912784dbd2]
> > > in testcase: xfstests
> > > version: xfstests-i386-5a5e419-1_20220926
> > > with following parameters:
> > > 
> > > 	disk: 4HDD
> > > 	fs: xfs
> > > 	test: generic-group-32
> > 
> > Which fstest was running at the time this warning was thrown?
> 
> It is fstests generic/648 running at that time.

Ok.

Can you add this patch and see if it fixes the problem?

https://lore.kernel.org/linux-xfs/20230301221227.GH360264@dread.disaster.area/

> [ 70.647665][ T1431] run fstests generic/648 at 2023-02-28 01:01:42
> [ 71.823863][ T6673] XFS (sda4): Mounting V5 Filesystem
> [ 71.883835][ T6673] XFS (sda4): Ending clean mount
> [ 71.889345][ T6673] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> [ 71.942655][ T6686] XFS (sda4): Unmounting Filesystem
> [ 72.055909][ T6718] loop: module verification failed: signature and/or required key missing - tainting kernel
> [ 72.066111][ T6718] calling loop_init+0x0/0x1000 [ loop] @ 6718
> [ 72.073700][ T6718] loop: module loaded
> [ 72.077534][ T6718] initcall loop_init+0x0/0x1000 [ loop] returned 0 after 5536 usecs
> [ 73.097330][ T6767] XFS (dm-0): Mounting V5 Filesystem
> [ 73.261204][ T6767] XFS (dm-0): Ending clean mount
> [ 73.267558][ T6767] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> [ 73.335169][ T6801] loop0: detected capacity change from 0 to 138745493
> [ 73.374666][ T6801] XFS (loop0): Mounting V5 Filesystem
> [ 73.382659][ T6801] XFS (loop0): Ending clean mount
> [ 73.387588][ T6801] xfs filesystem being mounted at /tmp/6480.mount supports timestamps until 2038 (0x7fffffff)
> [ 74.446227][ T3540] Buffer I/O error on dev dm-1, logical block 52428784, async page read
> [ 74.457497][ T66] dm-0: writeback error on inode 131, offset 131072, sector 78144
> [ 74.457500][ T66] dm-0: writeback error on inode 131, offset 262144, sector 74928
> [ 74.459752][ T3540] Buffer I/O error on dev dm-0, logical block 52428784, async page read
> [ 74.465109][ T66] dm-0: writeback error on inode 131, offset 2228224, sector 78400
> [ 74.480852][ T66] dm-0: writeback error on inode 131, offset 3969024, sector 78504
> [ 74.488596][ T66] dm-0: writeback error on inode 131, offset 4005888, sector 78576
> [ 74.496292][ T66] dm-0: writeback error on inode 131, offset 4063232, sector 192
> [ 74.496418][ C3] I/O error, dev loop0, sector 69373014 op 0x1:(WRITE) flags 0x9800 phys_seg 1 prio class 2
> [ 74.521346][ T144] XFS (loop0): log I/O error -5
> [ 74.526022][ T144] XFS (loop0): Filesystem has been shut down due to log error (0x2).
> [ 74.533882][ T144] XFS (loop0): Please unmount the filesystem and rectify the problem(s).
> [ 74.542294][ T67] dm-0: writeback error on inode 131, offset 53279154176, sector 78688
> [ 74.542299][ C3] I/O error, dev loop0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 2
> [ 75.364416][ T6868] XFS (loop0): Unmounting Filesystem
> [ 75.370061][ T164] XFS (dm-0): log I/O error -5
> [ 75.374652][ T164] XFS (dm-0): Filesystem has been shut down due to log error (0x2).
> [ 75.382433][ T164] XFS (dm-0): Please unmount the filesystem and rectify the problem(s).
> [ 75.390581][ C6] I/O error, dev loop0, sector 0 op 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 2
> [ 76.403161][ T6876] XFS (dm-0): Unmounting Filesystem
> [ 76.554265][ T6888] XFS (dm-0): Mounting V5 Filesystem
> [ 76.602707][ T6888] XFS (dm-0): Starting recovery (logdev: internal)
> [ 76.678261][ T6888] XFS (dm-0): Ending recovery (logdev: internal)
> [ 76.705011][ T6888] xfs filesystem being mounted at /fs/scratch supports timestamps until 2038 (0x7fffffff)
> [ 76.720823][ T6905] loop0: detected capacity change from 0 to 138745493
> [ 76.765868][ T6905] XFS (loop0): Mounting V5 Filesystem
> [ 76.811151][ T6905] XFS (loop0): Starting recovery (logdev: internal)
> [ 76.820611][ T6905] XFS (loop0): Ending recovery (logdev: internal)
> [ 76.826950][ T6905] xfs filesystem being mounted at /tmp/6480.mount supports timestamps until 2038 (0x7fffffff)
> [ 78.565703][ T59] ------------[ cut here ]------------
> [ 78.570983][ T59] WARNING: CPU: 4 PID: 59 at fs/iomap/buffered-io.c:984 iomap_write_delalloc_release (fs/iomap/buffered-io.c:984 (discriminator 1))

Ok, that is:

	WARN_ON_ONCE(start_byte < punch_start_byte);

Which I can't immediately see how that happens. This is a 32-bit
i386 kernel which we largely don't test or support, so maybe there's
32/64 bit variable size change problem somewhere in the code path
being executed.

> [ 78.671542][ T59] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
> [ 78.679578][ T59] Workqueue: loop0 loop_rootcg_workfn [ loop]

Ok, so this is happening while writing to the loopback image file
which is racing with cloning and removing the clone of the image
file.

Looking at the rest of the trace, IO to the entire loopback file
hung, but this warning doesn't explain that happening either.

I'll try to reproduce it, but I don't actually have an i386 test
environment here (I haven't tested i386 at all the last 5-6
years!) so it might be a while before I can get to testing this
specific environment.

Do you see it reproduce on any other architecture, of just this one?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
