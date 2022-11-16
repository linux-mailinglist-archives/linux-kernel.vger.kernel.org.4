Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF762B34F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiKPGdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiKPGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:32:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC906474
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:32:40 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E93D63F0E1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668580357;
        bh=bRhMbSmo/lMCzW8rsAjxBhsY1shEPnKNLW5ka1HnzPU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=SvruCZB6WQA9Rfpl5ThWfpzAWV6Rvk1/hWTl/okJFbPgUiZAynLggAAylYfqFzj8k
         4AIa4ya6xt2v9+FDlEh2h4RNmz9Uml5PsFO9IABRLnWi+/3Ib40v4I8r5DCcp0opqn
         J5eWIY8BjQKPDLCE+PqB+N/qmKCvF/Wtsdflni1HGdrEag4/aA4xlthOu+pU44oEML
         GYkcwk0nEGRr13B5rxt5ao081lPiSfeY6EeVsxJ7txjiDQ0G1BorS9BxxnFJadkteQ
         a5XEePrUBq2g8/Ta1aYoyqxnjqG5OEyRTclGioOPifRWasPl4t7wpralFXMCnoqoVB
         agIPAFJkJq5ug==
Received: by mail-pf1-f197.google.com with SMTP id x8-20020aa79568000000b0056dd717e051so9175444pfq.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 22:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRhMbSmo/lMCzW8rsAjxBhsY1shEPnKNLW5ka1HnzPU=;
        b=VNvHyyOk3xr8m9cQ9rqdLKpFTwtmHPv06aQTycLd/i70bsYRbZSPATsEQ/rs4n9KGY
         chHCExfteG1JkohXQuSPOWJruDGQkmt8F7mG+2qm4DMm2vs5yxFX7EE7duL24qoKds0G
         RVdIHE+f9NbKLVrIYI0XCebC2lOkrL4vZuZ01p27F1KybPGGzlheLHHIJHK/g99kOPR1
         OgtBQpXPAU5EuwJ/Lw/j+VAB188CHXRLZ9+nyV9toW6hTavFOP4VfosfffR093UPu/cK
         Z6idqTFVLsnz8UKH5gtzNmOexmSLMjE90DvPS+Ud57HSl3AFI6Imsw0Z9b9q2X9wNMC8
         XsYA==
X-Gm-Message-State: ANoB5pk7ZYt6NgeWWRTpwtzK5IDM3Cif0XSqdoILUReZ4XsiLgHyffws
        +LoHoFYvIu2tnYQAuMymfi+5BzHYGwRjJK1LUYG0xVERPuXEbuD65OFM1l0L7N6hx8iWBktKIJl
        AWiuvCUqDXNVBD5LP1lJICd6TfeOSOKTY2lsIvAkO1DNhzEGyo9pepava8A==
X-Received: by 2002:a17:902:8608:b0:186:61a7:ae94 with SMTP id f8-20020a170902860800b0018661a7ae94mr7572077plo.2.1668580353177;
        Tue, 15 Nov 2022 22:32:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ujDAzFRMce2M9GGPWc96PwOT0RKJipVuubCMq0+POqiwJv+IROcjlP+YUhB4IHPLadJ/ic4henb4nUAxnCtU=
X-Received: by 2002:a17:902:8608:b0:186:61a7:ae94 with SMTP id
 f8-20020a170902860800b0018661a7ae94mr7572061plo.2.1668580352844; Tue, 15 Nov
 2022 22:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20220930173652.1251349-1-koba.ko@canonical.com>
 <20221102180726.fuwwk2npsse56ius@cantor> <Y2USwbAzuaCKTGdX@matsya>
 <20221104153644.sz35cvgbhudr6ad7@cantor> <Y2YOUV0Ym+7DsWQb@matsya>
In-Reply-To: <Y2YOUV0Ym+7DsWQb@matsya>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 16 Nov 2022 14:32:21 +0800
Message-ID: <CAJB-X+UAF_CCq6uctLzqUwO5=R90Ddw4kC35kKL607uPo23Drw@mail.gmail.com>
Subject: Re: [PATCH V2] dmaengine: Fix client_count is countered one more incorrectly.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Hai <haijie1@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Vinod,
Should i re-submit v3 as per comments?

Koba Ko

On Sat, Nov 5, 2022 at 3:18 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 04-11-22, 08:36, Jerry Snitselaar wrote:
> > On Fri, Nov 04, 2022 at 06:55:21PM +0530, Vinod Koul wrote:
> > > On 02-11-22, 11:07, Jerry Snitselaar wrote:
> > > > Hi Vinod,
> > > >
> > > > Thoughts on this patch?
> > > >
> > > > Maybe changing the summary to "dmaengine: Fix double increment of c=
lient_count in dma_chan_get()"
> > > > would be clearer?
> > >
> > > Yes that would be better
> > >
> > > >
> > > > On Sat, Oct 01, 2022 at 01:36:52AM +0800, Koba Ko wrote:
> > > > > If the passed client_count is 0,
> > > > > it would be incremented by balance_ref_count first
> > > > > then increment one more.
> > > > > This would cause client_count to 2.
> > > > >
> > > > > cat /sys/class/dma/dma0chan*/in_use
> > > > > 2
> > > > > 2
> > > > > 2
> > > >
> > > > Would this be better?
> > > >
> > > >     The first time dma_chan_get() is called for a channel the chann=
el
> > > >     client_count is incorrectly incremented twice for public channe=
ls,
> > > >     first in balance_ref_count(), and again prior to returning. Thi=
s
> > > >     results in an incorrect client count which will lead to the
> > > >     channel resources not being freed when they should be. A simple
> > > >     test of repeated module load and unload of async_tx on a Dell
> > > >     Power Edge R7425 also shows this resulting in a kref underflow
> > > >     warning.
> > >
> > > Agree, also if you have the underflow warning handy, do add it to the
> > > log
> > >
> >
> > I don't know if Canonical saw that in their testing, but that was how o=
ur
> > QE initially found the issue.
> >
> > [  124.329662] async_tx: api initialized (async)
> > [  129.000627] async_tx: api initialized (async)
> > [  130.047839] ------------[ cut here ]------------
> > [  130.052472] refcount_t: underflow; use-after-free.
> > [  130.057279] WARNING: CPU: 3 PID: 19364 at lib/refcount.c:28 refcount=
_warn_saturate+0xba/0x110
> > [  130.065811] Modules linked in: async_tx(-) rfkill intel_rapl_msr int=
el_rapl_common amd64_edac edac_mce_amd ipmi_ssif kvm_amd dcdbas kvm mgag200=
 drm_shmem_helper acpi_ipmi irqbypass drm_kms_helper ipmi_si syscopyarea sy=
sfillrect rapl pcspkr ipmi_devintf sysimgblt fb_sys_fops k10temp i2c_piix4 =
ipmi_msghandler acpi_power_meter acpi_cpufreq vfat fat drm fuse xfs libcrc3=
2c sd_mod t10_pi sg ahci crct10dif_pclmul libahci crc32_pclmul crc32c_intel=
 ghash_clmulni_intel igb megaraid_sas i40e libata i2c_algo_bit ccp sp5100_t=
co dca dm_mirror dm_region_hash dm_log dm_mod [last unloaded: async_tx]
> > [  130.117361] CPU: 3 PID: 19364 Comm: modprobe Kdump: loaded Not taint=
ed 5.14.0-185.el9.x86_64 #1
> > [  130.126091] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.=
18.0 01/17/2022
> > [  130.133806] RIP: 0010:refcount_warn_saturate+0xba/0x110
> > [  130.139041] Code: 01 01 e8 6d bd 55 00 0f 0b e9 72 9d 8a 00 80 3d 26=
 18 9c 01 00 75 85 48 c7 c7 f8 a3 03 9d c6 05 16 18 9c 01 01 e8 4a bd 55 00=
 <0f> 0b e9 4f 9d 8a 00 80 3d 01 18 9c 01 00 0f 85 5e ff ff ff 48 c7
> > [  130.157807] RSP: 0018:ffffbf98898afe68 EFLAGS: 00010286
> > [  130.163036] RAX: 0000000000000000 RBX: ffff9da06028e598 RCX: 0000000=
000000000
> > [  130.170172] RDX: ffff9daf9de26480 RSI: ffff9daf9de198a0 RDI: ffff9da=
f9de198a0
> > [  130.177316] RBP: ffff9da7cddf3970 R08: 0000000000000000 R09: 0000000=
0ffff7fff
> > [  130.184459] R10: ffffbf98898afd00 R11: ffffffff9d9e8c28 R12: ffff9da=
7cddf1970
> > [  130.191596] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
> > [  130.198739] FS:  00007f646435c740(0000) GS:ffff9daf9de00000(0000) kn=
lGS:0000000000000000
> > [  130.206832] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  130.212586] CR2: 00007f6463b214f0 CR3: 00000008ab98c000 CR4: 0000000=
0003506e0
> > [  130.219729] Call Trace:
> > [  130.222192]  <TASK>
> > [  130.224305]  dma_chan_put+0x10d/0x110
> > [  130.227988]  dmaengine_put+0x7a/0xa0
> > [  130.231575]  __do_sys_delete_module.constprop.0+0x178/0x280
> > [  130.237157]  ? syscall_trace_enter.constprop.0+0x145/0x1d0
> > [  130.242652]  do_syscall_64+0x5c/0x90
> > [  130.246240]  ? exc_page_fault+0x62/0x150
> > [  130.250178]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  130.255243] RIP: 0033:0x7f6463a3f5ab
> > [  130.258830] Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83=
 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
> > [  130.277591] RSP: 002b:00007fff22f972c8 EFLAGS: 00000206 ORIG_RAX: 00=
000000000000b0
> > [  130.285164] RAX: ffffffffffffffda RBX: 000055b6786edd40 RCX: 00007f6=
463a3f5ab
> > [  130.292303] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b=
6786edda8
> > [  130.299443] RBP: 000055b6786edd40 R08: 0000000000000000 R09: 0000000=
000000000
> > [  130.306584] R10: 00007f6463b9eac0 R11: 0000000000000206 R12: 000055b=
6786edda8
> > [  130.313731] R13: 0000000000000000 R14: 000055b6786edda8 R15: 00007ff=
f22f995f8
> > [  130.320875]  </TASK>
> > [  130.323081] ---[ end trace eff7156d56b5cf25 ]---
>
> This is good, give more details and should be added to log in next
> iteration
>
> --
> ~Vinod
