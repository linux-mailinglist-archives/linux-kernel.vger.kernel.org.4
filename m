Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137486D5B25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjDDIoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:44:39 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A571FDE;
        Tue,  4 Apr 2023 01:44:24 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6385E7F8;
        Tue,  4 Apr 2023 10:44:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680597862;
        bh=UAYPK5/gF5Yn/7iYTIsOzOrTSuOlbQ9JOwY52h/wB3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qm9b6ucAqlnEKobBHyn6JP7rNDuY0ZV0BBs4ikgCuFEfVy2A9fmqXEWeFBJgibMTV
         hctKTrcRQF7HwHkol9IbCGLxmbJnwGRE9BtAj7bT45nVmN8o3miW3Ud2XhxLy+Bzsl
         bSKIyV+TwssBbMevmus026XRT6qbn7Vq6PHm6mlY=
Message-ID: <28707378-c4e7-38b6-48f5-63b0834c18c9@ideasonboard.com>
Date:   Tue, 4 Apr 2023 11:44:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 00/13] CSI2RX support on J721E
Content-Language: en-US
To:     Vaishnav Achath <vaishnav.a@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, mripard@kernel.org, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, bparrot@ti.com,
        niklas.soderlund+renesas@ragnatech.se, j-luthra@ti.com,
        devarsht@ti.com, praneeth@ti.com, u-kumar1@ti.com, vigneshr@ti.com,
        nm@ti.com, martyn.welch@collabora.com
References: <20230314115516.667-1-vaishnav.a@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230314115516.667-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 13:55, Vaishnav Achath wrote:
> Hi,
> 
> This series adds support for CSI2 capture on J721E. It includes some
> fixes to the Cadence CSI2RX driver, and adds the TI CSI2RX wrapper driver.

I get some errors with 'v4l2-compliance -m /dev/media0', which also causes:

[   51.185172] ------------[ cut here ]------------
[   51.189786] WARNING: CPU: 1 PID: 174 at mm/page_alloc.c:5568 __alloc_pages+0x684/0xd24
[   51.197698] Modules linked in:
[   51.200743] CPU: 1 PID: 174 Comm: v4l2-compliance Not tainted 6.3.0-rc5+ #12
[   51.207772] Hardware name: Texas Instruments J721e EVM (DT)
[   51.213326] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   51.220269] pc : __alloc_pages+0x684/0xd24
[   51.224353] lr : __dma_direct_alloc_pages.constprop.0+0x1d4/0x2a0
[   51.230431] sp : ffff800009fd37b0
[   51.233732] x29: ffff800009fd37b0 x28: ffff000801ad18e0 x27: 0000000000000001
[   51.240852] x26: 0000000000000010 x25: ffff800009fd3b18 x24: ffff800008112c60
[   51.247971] x23: 0000000000000010 x22: 00000000ffffffff x21: 0000000000000cc0
[   51.255089] x20: 0000000010000000 x19: 0000000000000000 x18: 0000000000000000
[   51.262208] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000fff7a238
[   51.269326] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   51.276444] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   51.283562] x8 : ffff000802c4a200 x7 : 0000000000000000 x6 : 0000000000000000
[   51.290680] x5 : 0000000000000000 x4 : ffff0008022a0000 x3 : 0000000000000000
[   51.297798] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff80000937a000
[   51.304916] Call trace:
[   51.307350]  __alloc_pages+0x684/0xd24
[   51.311086]  __dma_direct_alloc_pages.constprop.0+0x1d4/0x2a0
[   51.316814]  dma_direct_alloc+0x210/0x33c
[   51.320809]  dma_alloc_attrs+0x80/0xf4
[   51.324548]  vb2_dc_alloc+0xa0/0x184
[   51.328114]  __vb2_queue_alloc+0x19c/0x490
[   51.332197]  vb2_core_reqbufs+0x250/0x45c
[   51.336192]  vb2_ioctl_reqbufs+0xb0/0xe8
[   51.340103]  v4l_reqbufs+0x50/0x64
[   51.343494]  __video_do_ioctl+0x18c/0x3ec
[   51.347489]  video_usercopy+0x214/0x6c4
[   51.351312]  video_ioctl2+0x18/0x24
[   51.354788]  v4l2_ioctl+0x40/0x60
[   51.358088]  v4l2_compat_ioctl32+0x90/0xb4
[   51.362171]  __arm64_compat_sys_ioctl+0x14c/0x170
[   51.366860]  invoke_syscall+0x48/0x114
[   51.370599]  el0_svc_common.constprop.0+0x44/0xf4
[   51.375288]  do_el0_svc_compat+0x20/0x44
[   51.379198]  el0_svc_compat+0x2c/0x84
[   51.382848]  el0t_32_sync_handler+0x98/0x148
[   51.387102]  el0t_32_sync+0x194/0x198
[   51.390752] ---[ end trace 0000000000000000 ]---
[   51.395408] ti-udma 31150000.dma-controller: dma alloc of size 268435456 failed

  Tomi

