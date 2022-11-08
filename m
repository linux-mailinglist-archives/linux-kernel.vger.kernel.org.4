Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71D620CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiKHJ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiKHJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:59:56 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F192113CFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:59:54 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667901592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EMkuLdfSQLSirQ8jlC+1HOH0BNO4JwnCeqnVpRV5Hls=;
        b=Tsm26ZDb1wlvwWj8GQp9rtRsrE+D2Gc37EJFCt45dgPxsf6TKVdiSL1KmuYu6wZx/PxM3b
        /urhLVl4vwWM4uoQVlsAkiB/GNxqr43CW8y6mvlM6NhpVL6DmKq5X6XEhfK17H5S7NwtRk
        YX9UxmoiXiESq3iegM1PZiDiA2WlL0Y=
Date:   Tue, 08 Nov 2022 09:59:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <473d7ded2b2d176e093daec2244b2e01@linux.dev>
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
To:     "Mike Rapoport" <rppt@linux.ibm.com>
Cc:     "Sachin Sant" <sachinp@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        "open list" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <Y2oLYB7Tu7J91tVm@linux.ibm.com>
References: <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 8, 2022 3:55 PM, "Mike Rapoport" <rppt@linux.ibm.com> wrote:=0A=
=0A> Hi Yajun,=0A> =0A> On Tue, Nov 08, 2022 at 02:27:53AM +0000, Yajun D=
eng wrote:=0A> =0A>> Hi Sachin,=0A>> I didn't have a powerpc architecture=
 machine. I don't know why this happened.=0A>> =0A>> Hi Mike,=0A>> Do you=
 have any suggestions?=0A> =0A> You can try reproducing the bug qemu or w=
ork with Sachin to debug the=0A> issue.=0A> =0A=0AThanks, I'll try it.=0A=
=0A>> I tested in tools/testing/memblock, and it was successful.=0A> =0A>=
 Memblock tests provide limited coverage still and they don't deal with a=
ll=0A> possible cases.=0A> =0A> For now I'm dropping this patch from the =
memblock tree until the issue is=0A> fixed.=0A> =0A>> November 6, 2022 8:=
07 PM, "Sachin Sant" <sachinp@linux.ibm.com> wrote:=0A>> =0A>> While boot=
ing recent linux-next on a IBM Power10 Server LPAR=0A>> following crash i=
s observed:=0A>> =0A>> [ 0.000000] numa: Partition configured for 32 NUMA=
 nodes.=0A>> [ 0.000000] ------------[ cut here ]------------=0A>> [ 0.00=
0000] kernel BUG at mm/memblock.c:519!=0A>> [ 0.000000] Oops: Exception i=
n kernel mode, sig: 5 [#1]=0A>> [ 0.000000] LE PAGE_SIZE=3D64K MMU=3DRadi=
x SMP NR_CPUS=3D2048 NUMA pSeries=0A>> [ 0.000000] Modules linked in:=0A>=
> [ 0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc3-next-2022=
1104 #1=0A>> [ 0.000000] Hardware name: IBM,9080-HEX POWER10 (raw) 0x8002=
00 0xf000006 of:IBM,FW1030.00=0A>> (NH1030_026) hv:phyp pSeries=0A>> [ 0.=
000000] NIP: c0000000004ba240 LR: c0000000004bb240 CTR: c0000000004ba210=
=0A>> [ 0.000000] REGS: c000000002a8b7b0 TRAP: 0700 Not tainted (6.1.0-rc=
3-next-20221104)=0A>> [ 0.000000] MSR: 8000000000021033 <SF,ME,IR,DR,RI,L=
E> CR: 24042424 XER: 00000001=0A>> [ 0.000000] CFAR: c0000000004ba290 IRQ=
MASK: 1=0A>> [ 0.000000] GPR00: c0000000004bb240 c000000002a8ba50 c000000=
00136ee00 c0000010f3ac00a8=0A>> [ 0.000000] GPR04: 0000000000000000 c0000=
010f3ac0090 00000010f3ac0000 0000000000000d00=0A>> [ 0.000000] GPR08: 000=
0000000000001 0000000000000007 0000000000000001 0000000000000081=0A>> [ 0=
.000000] GPR12: c0000000004ba210 c000000002e10000 0000000000000000 000000=
000000000d=0A>> [ 0.000000] GPR16: 000000000f6be620 000000000f6be8e8 0000=
00000f6be788 000000000f6bed58=0A>> [ 0.000000] GPR20: 000000000f6f6d58 c0=
000000029a8de8 00000010f3ad8800 0000000000000080=0A>> [ 0.000000] GPR24: =
00000010f3ad7b00 0000000000000000 0000000000000100 0000000000000d00=0A>> =
[ 0.000000] GPR28: 00000010f3ad7b00 c0000000029a8de8 c0000000029a8e00 000=
0000000000006=0A>> [ 0.000000] NIP [c0000000004ba240] memblock_merge_regi=
ons.isra.12+0x40/0x130=0A>> [ 0.000000] LR [c0000000004bb240] memblock_ad=
d_range+0x190/0x300=0A>> [ 0.000000] Call Trace:=0A>> [ 0.000000] [c00000=
0002a8ba50] [0000000000000100] 0x100 (unreliable)=0A>> [ 0.000000] [c0000=
00002a8ba90] [c0000000004bb240] memblock_add_range+0x190/0x300=0A>> [ 0.0=
00000] [c000000002a8bb10] [c0000000004bb5e0] memblock_reserve+0x70/0xd0=
=0A>> [ 0.000000] [c000000002a8bba0] [c000000002045234] memblock_alloc_ra=
nge_nid+0x11c/0x1e8=0A>> [ 0.000000] [c000000002a8bc60] [c0000000020453a4=
] memblock_alloc_internal+0xa4/0x110=0A>> [ 0.000000] [c000000002a8bcb0] =
[c0000000020456cc] memblock_alloc_try_nid+0x94/0xcc=0A>> [ 0.000000] [c00=
0000002a8bd40] [c00000000200b570] alloc_paca_data+0x7c/0xcc=0A>> [ 0.0000=
00] [c000000002a8bdb0] [c00000000200b770] allocate_paca+0x8c/0x28c=0A>> [=
 0.000000] [c000000002a8be50] [c00000000200a26c] setup_arch+0x1c4/0x4d8=
=0A>> [ 0.000000] [c000000002a8bed0] [c000000002004378] start_kernel+0xb4=
/0xa84=0A>> [ 0.000000] [c000000002a8bf90] [c00000000000da90] start_here_=
common+0x1c/0x20=0A>> [ 0.000000] Instruction dump:=0A>> [ 0.000000] 7c08=
02a6 fba1ffe8 fbc1fff0 fbe1fff8 7c7d1b78 7c9e2378 3be00000 f8010010=0A>> =
[ 0.000000] f821ffc1 e9230000 3969ffff 4800000c <0b0a0000> 7d3f4b78 393f0=
001 7fbf5840=0A>> [ 0.000000] ---[ end trace 0000000000000000 ]---=0A>> [=
 0.000000]=0A>> [ 0.000000] Kernel panic - not syncing: Fatal exception=
=0A>> [ 0.000000] Rebooting in 180 seconds..=0A>> =0A>> This problem was =
introduced with next-20221101. Git bisect points to=0A>> following patch=
=0A>> =0A>> commit 3f82c9c4ac377082e1230f5299e0ccce07b15e12=0A>> Date: Tu=
e Oct 25 15:09:43 2022 +0800=0A>> memblock: don't run loop in memblock_ad=
d_range() twice=0A>> =0A>> Reverting this patch helps boot the kernel to =
login prompt.=0A>> =0A>> Have attached .config=0A>> =0A>> - Sachin=0A> =
=0A> --=0A> Sincerely yours,=0A> Mike.
