Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA08F605490
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJTAof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJTAob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:44:31 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 17:44:28 PDT
Received: from hermod.demsh.org (hermod.demsh.org [45.140.147.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6C1F2D8;
        Wed, 19 Oct 2022 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demsh.org; s=022020;
        t=1666225049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PitPpvBRybfPPe6/pxVq4EPkWt4tnsAnPvET5cdSUOk=;
        b=P1iB3c9JflVU/YeTa5Neb4ZDMqlOaTYDUR19wNgMsDv8aV3iXG+ncSXN1JwvnaH7zrnD7u
        fwz3vDpE7YCsBcrrnLJnGcR9D56nvR58YnI6DkclNv8cJ11nNvrpgkMGf6zKskHtQ6eDOq
        PX8Br4gwRyjERUrdkiDd1ufYQswAC89A3uM4y8iIx2J8WvtWSQKw/ACEywuCkivVHZ/2KB
        wHpXZxyxHQbpql4ya5DrbK8lgYqa2tc+jDJd7rk8ii/EhEoL0KeEr2TEA7EV2kWm1YPPQC
        pQUIRfTA2Met8DzFhMjpm1xRxg2vjIQhrPHeraNKUDguh5ippPMs77ECUXxSCA==
Received: from xps.demsh.org (algiz.demsh.org [94.103.82.47])
        by hermod.demsh.org (OpenSMTPD) with ESMTPSA id 2bd9e388 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) auth=yes user=me;
        Thu, 20 Oct 2022 00:17:28 +0000 (UTC)
Date:   Thu, 20 Oct 2022 03:17:25 +0300
From:   Dmitrii Tcvetkov <me@demsh.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [bisected] QEMU guest boot failure since 6.0 on x86_64 host
Message-ID: <20221020031725.7d01051a@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After upgrading host kernel to 6.0 QEMU 7.0.0 guests can't boot if their
underlying disk image has 4096 byte sectors and cache property set to
"none".

Host kernel: 
Linux version 6.0.2 (root@heim.demsh.org) (gcc (Gentoo 11.3.0 p4)
11.3.0, GNU ld (Gentoo 2.38 p4) 2.38) #1 SMP

Bisect led me to commit b1a000d3b8ec5  ("block: relax direct io memory
alignment"). I was unable to resolve revert conflicts when
tried to revert b1a000d3b8ec5  ("block: relax direct io memory
alignment") as I lack necessary understanding of block subsystem.

This fails to boot on 6.0+ host:
# losetup -b 4096 -f image.raw
# qemu-system-x86_64 -enable-kvm -drive
file=/dev/loop0,format=raw,cache=none

These boot fine on 6.0+ host:
# losetup -b 4096 -f image.raw
# qemu-system-x86_64 -enable-kvm -drive
file=/dev/loop0,format=raw

# losetup -f image.raw
# qemu-system-x86_64 -enable-kvm -drive
file=/dev/loop0,format=raw,cache=none

On 5.19 and older kernels the guest boots in all cases above. Problem
reproduces on 6.1-rc1.

What other info I can provide to help to find root cause?

Bisect log:
git bisect start
# status: waiting for both good and bad commits
# bad: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
git bisect bad 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
# status: waiting for good commit(s), bad commit known
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
# bad: [78acd4ca433425e6dd4032cfc2156c60e34931f2] usb: cdns3: Don't use priv_dev uninitialized in cdns3_gadget_ep_enable()
git bisect bad 78acd4ca433425e6dd4032cfc2156c60e34931f2
# bad: [526942b8134cc34d25d27f95dfff98b8ce2f6fcd] Merge tag 'ata-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
git bisect bad 526942b8134cc34d25d27f95dfff98b8ce2f6fcd
# good: [2e7a95156d64667a8ded606829d57c6fc92e41df] Merge tag 'regmap-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect good 2e7a95156d64667a8ded606829d57c6fc92e41df
# bad: [c013d0af81f60cc7dbe357c4e2a925fb6738dbfe] Merge tag 'for-5.20/block-2022-07-29' of git://git.kernel.dk/linux-block
git bisect bad c013d0af81f60cc7dbe357c4e2a925fb6738dbfe
# good: [efb2883060afc79638bb1eb19e2c30e7f6c5a178] Merge branch 'turbostat' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
git bisect good efb2883060afc79638bb1eb19e2c30e7f6c5a178
# good: [cb309ae49da7a7c28f0051deea13970291134fac] io_uring/net: improve io_get_notif_slot types
git bisect good cb309ae49da7a7c28f0051deea13970291134fac
# bad: [22c80aac882f712897b88b7ea8f5a74ea19019df] blktrace: Trace remapped requests correctly
git bisect bad 22c80aac882f712897b88b7ea8f5a74ea19019df
# bad: [22d0c4080fe49299640d9d6c43154c49794c2825] block: simplify disk_set_independent_access_ranges
git bisect bad 22d0c4080fe49299640d9d6c43154c49794c2825
# bad: [3c8f9da41ed90294d8ca42b3ad8a13c5379bd549] blk-mq: Don't disable preemption around __blk_mq_run_hw_queue().
git bisect bad 3c8f9da41ed90294d8ca42b3ad8a13c5379bd549
# bad: [798f2a6f734de87633351c3ab13b17b07397cf68] block: Directly use ida_alloc()/free()
git bisect bad 798f2a6f734de87633351c3ab13b17b07397cf68
# good: [67927d22015060967122facc8cfeaad8012e8808] block/merge: count bytes instead of sectors
git bisect good 67927d22015060967122facc8cfeaad8012e8808
# good: [5debd9691c3ac64c3acd6867c264ad38bbe48cdc] block: introduce bdev_iter_is_aligned helper
git bisect good 5debd9691c3ac64c3acd6867c264ad38bbe48cdc
# bad: [bf8d08532bc19a14cfb54ae61099dccadefca446] iomap: add support for dma aligned direct-io
git bisect bad bf8d08532bc19a14cfb54ae61099dccadefca446
# bad: [b1a000d3b8ec582da64bb644be633e5a0beffcbf] block: relax direct io memory alignment
git bisect bad b1a000d3b8ec582da64bb644be633e5a0beffcbf
# first bad commit: [b1a000d3b8ec582da64bb644be633e5a0beffcbf] block: relax direct io memory alignment
