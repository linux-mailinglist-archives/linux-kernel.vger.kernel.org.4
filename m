Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1AB6FC02C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjEIHJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEIHJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:09:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086BBB;
        Tue,  9 May 2023 00:09:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QFq6N3JvFz4x3d;
        Tue,  9 May 2023 17:09:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683616189;
        bh=c8H4G/Dv234HYjr+KJ10w7TX5wPsTcnHJLfz2R+M/U4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IybDFoZYRCA04a+HfRdbR5lqAQfh2/gLTIZuGwqb1gG1NN/C/GU+vQq7V0pdxysgy
         85ewwIr+8dZ4wfuYcfyzEH2jKNqTOir08D6PlYg3NfZ+ptA1Ti+vz01L3uA0ioOMOv
         4ve7RrFfqbB2GvW+JqZoZa4N4VA+wvwErCbVuNQ1vvH+V7/Xy7gmuRx4q37j2KcmWM
         pLAKpjbChoEiG1Hpaon4ZKRKna8gEtV5q0JeW50u8XhmlwDnw+/VlXLggCS/aExLYW
         N9+b4UcGRm0HePsomadDMDMmvO58JMK7toMhdJ7+XFbh6fbSoSPU+HM9uUmvJSXAW9
         1o9F5FIQ7miWQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Tejun Heo <tj@kernel.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot warning
In-Reply-To: <20230509122440.418068cb@canb.auug.org.au>
References: <20230509122440.418068cb@canb.auug.org.au>
Date:   Tue, 09 May 2023 17:09:43 +1000
Message-ID: <87mt2ex9oo.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's qemu test boot (powerpc pseries_le_defconfig) produced this
> warning:
>
> [    2.048588][    T1] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4 (March 14, 2017)
> [    2.051560][    T1] ------------[ cut here ]------------
> [    2.052297][    T1] WARNING: CPU: 0 PID: 1 at kernel/workqueue.c:5925 workqueue_sysfs_register+0x20/0x1f0

Caused by 59709bb84c22 scsi: Use alloc_ordered_workqueue() to create ordered workqueues.

cheers

> [    2.053294][    T1] Modules linked in:
> [    2.053678][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.4.0-rc1-01511-g91b79de175e1 #1
> [    2.053899][    T1] Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
> [    2.054099][    T1] NIP:  c000000000181d40 LR: c000000000182164 CTR: c0000000001b71e0
> [    2.054171][    T1] REGS: c0000000047632c0 TRAP: 0700   Not tainted  (6.4.0-rc1-01511-g91b79de175e1)
> [    2.054279][    T1] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 48000284  XER: 00000000
> [    2.054608][    T1] CFAR: c000000000182160 IRQMASK: 0 
> [    2.054608][    T1] GPR00: c000000000182164 c000000004763560 c000000001558c00 c000000004d18600 
> [    2.054608][    T1] GPR04: 0000000000000000 0000000000000000 c0000000028eccd8 0000000000000000 
> [    2.054608][    T1] GPR08: 0000000000000000 0000000000080000 0000000000000000 0000000048000288 
> [    2.054608][    T1] GPR12: 0000000000000000 c000000002ad0000 c000000000013788 0000000000000000 
> [    2.054608][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.054608][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.054608][    T1] GPR24: 0000000000000000 c000000004d186b8 c000000004d18610 c000000004d18620 
> [    2.054608][    T1] GPR28: 0000000000000000 c00000000299b310 0000000000000000 c000000004d18600 
> [    2.055488][    T1] NIP [c000000000181d40] workqueue_sysfs_register+0x20/0x1f0
> [    2.055564][    T1] LR [c000000000182164] alloc_workqueue+0x254/0x584
> [    2.055858][    T1] Call Trace:
> [    2.055989][    T1] [c000000004763560] [c0000000047635f0] 0xc0000000047635f0 (unreliable)
> [    2.056509][    T1] [c0000000047635f0] [c0000000001823a8] alloc_workqueue+0x498/0x584
> [    2.056605][    T1] [c0000000047636a0] [c000000000ba016c] scsi_host_alloc+0x2fc/0x500
> [    2.056678][    T1] [c000000004763730] [c000000000bdf7ec] ibmvscsi_probe+0x6c/0xaf8
> [    2.056746][    T1] [c000000004763820] [c000000000105d4c] vio_bus_probe+0x9c/0x4a0
> [    2.056816][    T1] [c0000000047638e0] [c000000000b1c274] really_probe+0x104/0x410
> [    2.056885][    T1] [c000000004763970] [c000000000b1c630] __driver_probe_device+0xb0/0x1e0
> [    2.056956][    T1] [c0000000047639f0] [c000000000b1c7b4] driver_probe_device+0x54/0x130
> [    2.057025][    T1] [c000000004763a30] [c000000000b1cac8] __driver_attach+0xd8/0x200
> [    2.057092][    T1] [c000000004763a70] [c000000000b18cd4] bus_for_each_dev+0xb4/0x140
> [    2.057158][    T1] [c000000004763ad0] [c000000000b1b824] driver_attach+0x34/0x50
> [    2.057226][    T1] [c000000004763af0] [c000000000b1ac1c] bus_add_driver+0x13c/0x2d0
> [    2.057292][    T1] [c000000004763b80] [c000000000b1e3c4] driver_register+0xa4/0x1b0
> [    2.057360][    T1] [c000000004763bf0] [c000000000108054] __vio_register_driver+0x74/0x9c
> [    2.057428][    T1] [c000000004763c10] [c000000002063690] ibmvscsi_module_init+0x98/0xd4
> [    2.057500][    T1] [c000000004763c40] [c0000000000131a0] do_one_initcall+0x80/0x320
> [    2.057583][    T1] [c000000004763d20] [c0000000020049b4] kernel_init_freeable+0x304/0x3ac
> [    2.057657][    T1] [c000000004763df0] [c0000000000137b0] kernel_init+0x30/0x1a0
> [    2.057723][    T1] [c000000004763e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
> [    2.057807][    T1] --- interrupt: 0 at 0x0
> [    2.057858][    T1] NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
> [    2.057909][    T1] REGS: c000000004763e80 TRAP: 0000   Not tainted  (6.4.0-rc1-01511-g91b79de175e1)
> [    2.057964][    T1] MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
> [    2.058031][    T1] CFAR: 0000000000000000 IRQMASK: 0 
> [    2.058031][    T1] GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058031][    T1] GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [    2.058682][    T1] NIP [0000000000000000] 0x0
> [    2.058728][    T1] LR [0000000000000000] 0x0
> [    2.058782][    T1] --- interrupt: 0
> [    2.058965][    T1] Code: 60000000 60000000 60000000 60420000 3c4c013d 38426ee0 7c0802a6 60000000 fb61ffd8 f821ff71 81230100 55290318 <0b090000> 3d22fff0 7c0802a6 fb810070 
> [    2.059420][    T1] ---[ end trace 0000000000000000 ]---
> [    2.065968][   T46] scsi_tmf_0 (46) used greatest stack depth: 15200 bytes left
> [    2.067252][    T1] scsi host0: failed to create tmf workq
> [    2.092458][   T45] scsi_eh_0 (45) used greatest stack depth: 14240 bytes left
> [    2.092852][    T1] ibmvscsi 71000003: couldn't allocate host data
> [    2.093005][    T1] ibmvscsi: probe of 71000003 failed with error -1
>
>
> I have no idea what has caused this.
>
> -- 
> Cheers,
> Stephen Rothwell
