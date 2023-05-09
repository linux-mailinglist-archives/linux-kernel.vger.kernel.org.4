Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF646FC790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjEINKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEINKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:10:45 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BFE72
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:10:42 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab0c697c84so44482015ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1683637841; x=1686229841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gMtUFVUtibAULZvPwd52M7BBopM3ogrSj/Sov+ZbTA=;
        b=MUXgsOwhUmVTd0d2v2rqyJytIQAKHt88dY61EYVuxmrW9QK1SOei5onvE1pUo8bO2J
         w3iqKtEsk+ZmemRHsQUSjqh0NL03G+aG2onR7PoKn4BkUka/gYZCGvOcKoqCKis3gQ+s
         E793pRqYyT9Vtg2gQQf1t9Kh3m73ANaZBsIYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637841; x=1686229841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gMtUFVUtibAULZvPwd52M7BBopM3ogrSj/Sov+ZbTA=;
        b=IchSHmb5SsI1krIcpL51nUI86Q6yQvXFKynPg85zXws3AoHVWnAlfghCLy5VmTNabj
         QggXxY/eGedIWqduTljL2gbYhSVsKfKE+8lNcutiLHARTGh6DC09V3O8OUrMtpcnSVMu
         EZRab0U06UtmNHlS5S1L/zmLCrx9hrj0yOAU0C3ObKQRP7XEVhyGY+gu3ooV6gjiv/6C
         3TSVAgMDeZV9TiJuvXQzCe/4VpnuBjv18HCwm5ZeQJwLTNMjF+R5Dtx7KiuJ4n/5FU2/
         kNKDR1I7ZwBXeJHxwxk7fdjbIyNBVR9biJeA7Blqg7+ratwYDKbJDSOeVLAYjXw2JvOR
         XkeQ==
X-Gm-Message-State: AC+VfDyDI2Sd8tnL6Grl0Xm0z6xpGlwxVdjzc9zUhPV9pDDk4QMpcaUm
        nZHTgFPy6N4OE8Ffkz5VGW4GmuuNZcCEWVAfhuU/t+VH
X-Google-Smtp-Source: ACHHUZ4/F48HMp1JD8Oe8h9sGL4Qb9YV1T5D9JJmTvkyZPVNCLnLZ81EWKuvWBDv8FVEbDmmh465Pw==
X-Received: by 2002:a17:902:8a82:b0:1a8:11d3:6b93 with SMTP id p2-20020a1709028a8200b001a811d36b93mr13022275plo.66.1683637840981;
        Tue, 09 May 2023 06:10:40 -0700 (PDT)
Received: from 9ed91d9f7b3c ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001a641e4738asm1539567plb.1.2023.05.09.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:10:39 -0700 (PDT)
Date:   Tue, 9 May 2023 13:10:32 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        ntfs3@lists.linux.dev, almaz.alexandrovich@paragon-software.com
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <20230509131032.GA8@9ed91d9f7b3c>
References: <20230509030705.399628514@linuxfoundation.org>
 <20230509080658.GA152864@d6921c044a31>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509080658.GA152864@d6921c044a31>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 08:06:58AM +0000, Rudi Heitbaum wrote:
> On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.3.2 release.
> > There are 694 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > Anything received after that time might be too late.
> 
> Hi Greg,
> 
> 6.3.2-rc2 tested.

Hi Greg,

Further testing and have seen ntfs3: NULL pointer dereference with ntfs_lookup errors 
with 6.3.2-rc2 (I have not seen this error before.) No other errors in the logs.

https://bugzilla.kernel.org/show_bug.cgi?id=217422

[ 9471.878611] BUG: kernel NULL pointer dereference, address: 0000000000000020
[ 9471.879864] #PF: supervisor read access in kernel mode
[ 9471.881177] #PF: error_code(0x0000) - not-present page
[ 9471.882447] PGD 0 P4D 0 
[ 9471.883680] Oops: 0000 [#1] SMP NOPTI
[ 9471.884932] CPU: 15 PID: 81926 Comm: .NET ThreadPool Tainted: P     U     O       6.3.2-rc2 #1
[ 9471.886494] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
[ 9471.887641] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
[ 9471.888795] Code: 00 00 00 49 89 c4 e8 d9 33 fe ff 85 c0 79 3a 48 63 d8 48 8b 3d 2b 61 6d cb 4c 89 e6 e8 83 b0 cc c1 48 81 fb 00 f0 ff ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 e8 95 d1 c1 5b 41 5c 41
[ 9471.890042] RSP: 0018:ffff949ca06d7bb8 EFLAGS: 00010207
[ 9471.891291] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000010e7c3
[ 9471.892555] RDX: 000000000010e7c2 RSI: ffffcb8fc0000000 RDI: 00000000000324f0
[ 9471.893824] RBP: ffff949ca06d7bd8 R08: ffff90e24896b000 R09: ffff90e24187e702
[ 9471.895081] R10: 0000000000000788 R11: 000000000000000a R12: ffff90e2c0caa000
[ 9471.896343] R13: ffff90e4fbf9e780 R14: ffff90e2dee4aeb8 R15: ffff90e2dee4af90
[ 9471.897615] FS:  00007f1f627fc6c0(0000) GS:ffff90e9779c0000(0000) knlGS:0000000000000000
[ 9471.898907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9471.900198] CR2: 0000000000000020 CR3: 000000015b37c001 CR4: 0000000000f70ea0
[ 9471.901503] PKRU: 55555554
[ 9471.902803] Call Trace:
[ 9471.904099]  <TASK>
[ 9471.905381]  __lookup_slow+0x81/0x130
[ 9471.906676]  walk_component+0x10b/0x180
[ 9471.907966]  path_lookupat+0x6a/0x1a0
[ 9471.909247]  filename_lookup+0xd0/0x190
[ 9471.910533]  ? schedule+0x59/0xa0
[ 9471.911813]  ? futex_wait_queue+0x69/0xa0
[ 9471.913095]  ? kmem_cache_alloc+0x47/0x3c0
[ 9471.914376]  vfs_statx+0x84/0x150
[ 9471.915649]  ? getname_flags+0x54/0x1d0
[ 9471.916926]  vfs_fstatat+0x5c/0x80
[ 9471.918196]  __do_sys_newlstat+0x37/0x70
[ 9471.919472]  ? do_futex+0x12e/0x1a0
[ 9471.920758]  ? __x64_sys_futex+0x112/0x1d0
[ 9471.922033]  ? trace_hardirqs_off.part.0+0x20/0x70
[ 9471.923319]  ? trace_hardirqs_on+0x2f/0x80
[ 9471.924598]  __x64_sys_newlstat+0x1a/0x20
[ 9471.925897]  do_syscall_64+0x3c/0x90
[ 9471.927639]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 9471.928951] RIP: 0033:0x7f206b4db184
[ 9471.930235] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 89 f8 48 89 f7 48 89 d6 83 f8 01 77 2b b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 04 c3 0f 1f 00 48 8b 15 61 cc 0b 00 f7 d8 64
[ 9471.931627] RSP: 002b:00007f1f627fa378 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[ 9471.933021] RAX: ffffffffffffffda RBX: 00007f1fbe6ad248 RCX: 00007f206b4db184
[ 9471.934435] RDX: 00007f1f627fa380 RSI: 00007f1f627fa380 RDI: 00007f1f627fa4f0
[ 9471.935850] RBP: 00007f1f627fa4d0 R08: 00007f1f627fa600 R09: 000000000000002e
[ 9471.937263] R10: 00007f1ff1ba15e8 R11: 0000000000000246 R12: 00007f1fbc018408
[ 9471.938683] R13: 00007f1f627fa4f0 R14: 00007f1fbe6ad248 R15: 000000000000002e
[ 9471.940106]  </TASK>
[ 9471.941523] Modules linked in: rfcomm veth 8021q xt_nat xt_tcpudp xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables x_tables br_netfilter bridge stp llc overlay ntfs3 exfat bnep btusb btrtl btbcm btintel btmtk bluetooth ecdh_generic ecc iwlmvm mac80211 libarc4 snd_hda_codec_hdmi iwlwifi wl(PO) snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel mei_pxp mei_hdcp x86_pkg_temp_thermal snd_hda_codec cfg80211 intel_powerclamp snd_hwdep intel_rapl_msr tpm_tis mei_me snd_hda_core idma64 tpm_tis_core intel_rapl_common mei snd_intel_dspcfg rfkill tpm_crb tpm rng_core pkcs8_key_parser fuse dmi_sysfs
[ 9471.948020] CR2: 0000000000000020
[ 9471.949674] ---[ end trace 0000000000000000 ]---
[ 9471.949674] BUG: kernel NULL pointer dereference, address: 0000000000000020
[ 9471.951352] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
[ 9471.953035] #PF: supervisor read access in kernel mode
[ 9471.954720] Code: 00 00 00 49 89 c4 e8 d9 33 fe ff 85 c0 79 3a 48 63 d8 48 8b 3d 2b 61 6d cb 4c 89 e6 e8 83 b0 cc c1 48 81 fb 00 f0 ff ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 e8 95 d1 c1 5b 41 5c 41
[ 9471.956410] #PF: error_code(0x0000) - not-present page
[ 9471.958201] RSP: 0018:ffff949ca06d7bb8 EFLAGS: 00010207
[ 9471.959982] PGD 0 P4D 0 
[ 9471.961783] 
[ 9471.961783] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000010e7c3
[ 9471.963554] 
[ 9471.965305] RDX: 000000000010e7c2 RSI: ffffcb8fc0000000 RDI: 00000000000324f0
[ 9471.967092] Oops: 0000 [#2] SMP NOPTI
[ 9471.969251] RBP: ffff949ca06d7bd8 R08: ffff90e24896b000 R09: ffff90e24187e702
[ 9471.971054] CPU: 13 PID: 81947 Comm: .NET ThreadPool Tainted: P     UD    O       6.3.2-rc2 #1
[ 9471.972824] R10: 0000000000000788 R11: 000000000000000a R12: ffff90e2c0caa000
[ 9471.974610] Hardware name: Intel(R) Client Systems NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0085.2022.0718.1739 07/18/2022
[ 9471.976406] R13: ffff90e4fbf9e780 R14: ffff90e2dee4aeb8 R15: ffff90e2dee4af90
[ 9471.978206] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
[ 9471.980039] FS:  00007f1f627fc6c0(0000) GS:ffff90e9779c0000(0000) knlGS:0000000000000000
[ 9471.981887] Code: 00 00 00 49 89 c4 e8 d9 33 fe ff 85 c0 79 3a 48 63 d8 48 8b 3d 2b 61 6d cb 4c 89 e6 e8 83 b0 cc c1 48 81 fb 00 f0 ff ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 e8 95 d1 c1 5b 41 5c 41
[ 9471.983737] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9471.985576] RSP: 0018:ffff949c8ff7fbb8 EFLAGS: 00010207
[ 9471.987490] CR2: 0000000000000020 CR3: 000000015b37c001 CR4: 0000000000f70ea0
[ 9471.989339] 
[ 9471.991159] PKRU: 55555554
[ 9471.991160] note: .NET ThreadPool[81926] exited with irqs disabled
[ 9471.992978] RAX: ffff90e24ac6d001 RBX: 0000000000000000 RCX: 00000000000eea5f
[ 9472.000239] RDX: 00000000000eea5e RSI: ffffcb8fc0000000 RDI: 00000000000324f0
[ 9472.002036] RBP: ffff949c8ff7fbd8 R08: ffff90e24ac69002 R09: ffff90e3b570a5ea
[ 9472.003843] R10: ffff90e25c340000 R11: 000000000000000a R12: ffff90e24ac69000
[ 9472.005628] R13: ffff90e4fbeb2fc0 R14: ffff90e2dee4e488 R15: ffff90e2dee4e560
[ 9472.007414] FS:  00007f1f01ffb6c0(0000) GS:ffff90e977940000(0000) knlGS:0000000000000000
[ 9472.009218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9472.011496] CR2: 0000000000000020 CR3: 000000015b37c006 CR4: 0000000000f70ea0
[ 9472.013344] PKRU: 55555554
[ 9472.015171] Call Trace:
[ 9472.016999]  <TASK>
[ 9472.018813]  __lookup_slow+0x81/0x130
[ 9472.020639]  walk_component+0x10b/0x180
[ 9472.022454]  path_lookupat+0x6a/0x1a0
[ 9472.024289]  filename_lookup+0xd0/0x190
[ 9472.026106]  ? sched_clock+0xd/0x20
[ 9472.027930]  ? sched_clock_cpu+0x14/0x190
[ 9472.029753]  ? __smp_call_single_queue+0x40/0x50
[ 9472.031576]  ? ttwu_queue_wakelist+0xfd/0x100
[ 9472.033403]  ? kmem_cache_alloc+0x47/0x3c0
[ 9472.035232]  vfs_statx+0x84/0x150
[ 9472.037056]  ? getname_flags+0x54/0x1d0
[ 9472.038876]  vfs_fstatat+0x5c/0x80
[ 9472.040699]  __do_sys_newlstat+0x37/0x70
[ 9472.042515]  ? do_futex+0x12e/0x1a0
[ 9472.044332]  ? __x64_sys_futex+0x112/0x1d0
[ 9472.046146]  ? switch_fpu_return+0x55/0xd0
[ 9472.047912]  ? trace_hardirqs_off.part.0+0x20/0x70
[ 9472.049636]  ? trace_hardirqs_on+0x2f/0x80
[ 9472.051409]  __x64_sys_newlstat+0x1a/0x20
[ 9472.053491]  do_syscall_64+0x3c/0x90
[ 9472.055213]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 9472.056940] RIP: 0033:0x7f206b4db184
[ 9472.058658] Code: 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 89 f8 48 89 f7 48 89 d6 83 f8 01 77 2b b8 06 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 04 c3 0f 1f 00 48 8b 15 61 cc 0b 00 f7 d8 64
[ 9472.060473] RSP: 002b:00007f1f01ff9378 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
[ 9472.062212] RAX: ffffffffffffffda RBX: 00007f1fbe689478 RCX: 00007f206b4db184
[ 9472.063898] RDX: 00007f1f01ff9380 RSI: 00007f1f01ff9380 RDI: 00007f1f01ff94f0
[ 9472.065522] RBP: 00007f1f01ff94d0 R08: 00007f1f01ff9600 R09: 0000000000000035
[ 9472.067094] R10: 00007f1ff1ba15e8 R11: 0000000000000246 R12: 00007f1fbc018408
[ 9472.068665] R13: 00007f1f01ff94f0 R14: 00007f1fbe689478 R15: 0000000000000035
[ 9472.070238]  </TASK>
[ 9472.071799] Modules linked in: rfcomm veth 8021q xt_nat xt_tcpudp xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_tables x_tables br_netfilter bridge stp llc overlay ntfs3 exfat bnep btusb btrtl btbcm btintel btmtk bluetooth ecdh_generic ecc iwlmvm mac80211 libarc4 snd_hda_codec_hdmi iwlwifi wl(PO) snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel mei_pxp mei_hdcp x86_pkg_temp_thermal snd_hda_codec cfg80211 intel_powerclamp snd_hwdep intel_rapl_msr tpm_tis mei_me snd_hda_core idma64 tpm_tis_core intel_rapl_common mei snd_intel_dspcfg rfkill tpm_crb tpm rng_core pkcs8_key_parser fuse dmi_sysfs
[ 9472.078669] CR2: 0000000000000020
[ 9472.080365] ---[ end trace 0000000000000000 ]---
...
[ 9476.855987] RIP: 0010:ntfs_lookup+0x76/0xe0 [ntfs3]
[ 9476.857799] Code: 00 00 00 49 89 c4 e8 d9 33 fe ff 85 c0 79 3a 48 63 d8 48 8b 3d 2b 61 6d cb 4c 89 e6 e8 83 b0 cc c1 48 81 fb 00 f0 ff ff 77 07 <48> 83 7b 20 00 74 41 4c 89 ee 48 89 df e8 e8 95 d1 c1 5b 41 5c 41
[ 9476.859687] RSP: 0018:ffff949ca06d7bb8 EFLAGS: 00010207
[ 9476.861557] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000010e7c3
[ 9476.863433] RDX: 000000000010e7c2 RSI: ffffcb8fc0000000 RDI: 00000000000324f0
[ 9476.865302] RBP: ffff949ca06d7bd8 R08: ffff90e24896b000 R09: ffff90e24187e702
[ 9476.867160] R10: 0000000000000788 R11: 000000000000000a R12: ffff90e2c0caa000
[ 9476.869017] R13: ffff90e4fbf9e780 R14: ffff90e2dee4aeb8 R15: ffff90e2dee4af90
[ 9476.870864] FS:  00007f1f617fa6c0(0000) GS:ffff90e977900000(0000) knlGS:0000000000000000
[ 9476.872702] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9476.874529] CR2: 0000000000000020 CR3: 000000015b37c003 CR4: 0000000000f70ea0
[ 9476.876353] PKRU: 55555554
[ 9476.878161] note: .NET ThreadPool[81927] exited with irqs disabled



--
Rudi
