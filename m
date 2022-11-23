Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB400635AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiKWLCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiKWLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B32D9079
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669200913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjN0A038hUNXkFR2KQMpb0VK379m/PpggczZKW7tkGQ=;
        b=HAiZrmoyyWDz6qLMe1OUZkXvgucZamQtNPNftI7g3eiYJgkVGjgNQy9TaqfJHf64LSuAXy
        pOYZWAikiYIe1xktk12CBPmRxjf9ox4925kViP/C86upGTMNxE62Mmj+vQATUFteEsewI5
        zMTY2Co+kxQ2+1FlLyg24GxN+qSOksM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-214-RK5fbJXuN1CUXDhHSH6RHA-1; Wed, 23 Nov 2022 05:55:12 -0500
X-MC-Unique: RK5fbJXuN1CUXDhHSH6RHA-1
Received: by mail-pl1-f198.google.com with SMTP id h16-20020a170902f55000b001871b770a83so13384163plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjN0A038hUNXkFR2KQMpb0VK379m/PpggczZKW7tkGQ=;
        b=ddXJGrT10EC9tekNM1awxuenNJQbK79NHaUaCvz3pJg+GEk5jNJJakG79Ve3zCca7Q
         2XHqxxNgKRreRugJdu59hhN/CtYZsvkl+ISVipAhji+OGse4aXhlguBdLwDuktRN5i9j
         djbF9h84CDw+fzbRj+junhv7m+G9yo28/vPqXwRlw3Gzrm/FfQZxKdH0mv+KYbu7vHml
         DRWkMw3PXlIBYMPs4Ui7cwxcuwzOJ0Tsl/W8SXAmz8kVKj7rkZ6VTMjef1d6MucWuif4
         TAm3WnRoueBxFYsXTHIJ4cNmJiOF7XPCQnsVd/VDybCWhrsVd9Ks/LV3BfQI14iQDLlm
         QsXQ==
X-Gm-Message-State: ANoB5pngexLBRaOabpe4eOBZ3cM+BIc/nTrtxMfb83Z3k0KoEHs3qSzg
        MAOPaYNYF/odZIvVmyz31uFMM33ngKQs0DcLunA1yPnByGpuMkPf2p5cWDeFAAAILZ7u5ieF6gV
        vaLLKjnrjlvLQehwa9pwB9XHObBjYnwXuLpE6R0Zq
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id d5-20020a621d05000000b0056ba0f4deccmr8151857pfd.33.1669200911120;
        Wed, 23 Nov 2022 02:55:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5KV3rIew/dEZSatpPIXrjXgboVSGvhiHt840etOO/utTaf9Qo74JgvSdAvUco5bJMPfGwpHH4LH6hXVj9IHa0=
X-Received: by 2002:a62:1d05:0:b0:56b:a0f4:decc with SMTP id
 d5-20020a621d05000000b0056ba0f4deccmr8151844pfd.33.1669200910826; Wed, 23 Nov
 2022 02:55:10 -0800 (PST)
MIME-Version: 1.0
References: <Y3Ybpuy67I0xlwLa@xpf.sh.intel.com>
In-Reply-To: <Y3Ybpuy67I0xlwLa@xpf.sh.intel.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 23 Nov 2022 11:54:59 +0100
Message-ID: <CAOssrKdNRew=5OMsmc+F01NEzyz1cd6ctJKV=FBVrHardpEZSg@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is "notify_change" WARNING in v6.1-rc5 kernel
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:32 PM Pengfei Xu <pengfei.xu@intel.com> wrote:
>
> Hi Miklos Szeredi and developer,
>
> Greeting!
>
> There is "notify_change" WARNING in v6.1-rc5:
> [   45.378232] ------------[ cut here ]------------
> [   45.378741] WARNING: CPU: 0 PID: 463 at fs/attr.c:327 notify_change+0x9a1/0xb50
> [   45.379511] Modules linked in:
> [   45.379868] CPU: 0 PID: 463 Comm: repro Not tainted 6.1.0-rc5-094226ad94f4 #1
> [   45.380617] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   45.381752] RIP: 0010:notify_change+0x9a1/0xb50
> [   45.382234] Code: 44 89 f6 e8 81 2d cf ff 41 83 fe ff 74 0c c7 45 c4 00 00 00 00 e9 e1 fd ff ff 41 be b5 ff ff ff e9 ea fb ff ff e8 ef 2b cf ff <0f> 0b e9 c2 4
> [   45.384114] RSP: 0018:ffffc90000ef3b30 EFLAGS: 00010246
> [   45.384661] RAX: 0000000000000000 RBX: 0000000000004200 RCX: ffffffff8155b451
> [   45.385389] RDX: 0000000000000000 RSI: ffff88800cd40000 RDI: 0000000000000002
> [   45.386112] RBP: ffffc90000ef3b90 R08: ffff888009ed2f50 R09: 0101010101010101
> [   45.386840] R10: ffffc90000ef3bb0 R11: 0000000000005c67 R12: ffffc90000ef3bb8
> [   45.387568] R13: ffff88800af5ed80 R14: 0000000000000000 R15: ffffffff8385ff40
> [   45.388312] FS:  00007f914d059700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> [   45.389142] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.389727] CR2: 0000000020006000 CR3: 000000000bfc0006 CR4: 0000000000770ef0
> [   45.390458] PKRU: 55555554
> [   45.390752] Call Trace:
> [   45.391015]  <TASK>
> [   45.391253]  ? write_comp_data+0x2f/0x90
> [   45.391697]  __file_remove_privs+0x1de/0x240
> [   45.392181]  ? __file_remove_privs+0x1de/0x240
> [   45.392671]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   45.393181]  ? current_time+0x64/0xb0
> [   45.393592]  file_modified_flags+0x51/0x160
> [   45.394055]  file_modified+0x20/0x30
> [   45.394462]  fuse_file_fallocate+0x53a/0x620
> [   45.394928]  ? __schedule+0x2e6/0x8f0
> [   45.395347]  ? fuse_copy_file_range+0xc0/0xc0
> [   45.395835]  vfs_fallocate+0x336/0x690
> [   45.396243]  ioctl_preallocate+0xdf/0x110
> [   45.396677]  do_vfs_ioctl+0xaf9/0xc20
> [   45.397080]  ? __fget_light+0xb0/0x220
> [   45.397488]  ? __sanitizer_cov_trace_pc+0x25/0x60
> [   45.397993]  ? write_comp_data+0x2f/0x90
> [   45.398419]  __x64_sys_ioctl+0xca/0x160
> [   45.398836]  do_syscall_64+0x3b/0x90
> [   45.399235]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [   45.399788] RIP: 0033:0x7f914d17f59d
> [   45.400182] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [   45.402039] RSP: 002b:00007f914d058b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   45.402815] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f914d17f59d
> [   45.403543] RDX: 00000000200001c0 RSI: 0000000040305828 RDI: 0000000000000004
> [   45.404286] RBP: 00007f914d058e00 R08: 0000000100000001 R09: 0000000000000000
> [   45.405023] R10: 0000000100000001 R11: 0000000000000246 R12: 00007fff22e7ec4e
> [   45.405758] R13: 00007fff22e7ec4f R14: 00007fff22e7ece0 R15: 00007f914d059700
> [   45.406496]  </TASK>
> [   45.406736] ---[ end trace 0000000000000000 ]---
>
> Bisected and found the first bad commit:
> 4a6f278d4827b59ba26ceae0ff4529ee826aa258
> "fuse: add file_modified() to fallocate"
>
> After only revert this commit, this issue was gone.
>
> Kconfig, reproduced code from syzkaller, bisect info is in attached.
>
> All detailed info is in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221117_083125_notify_change
>
> If you find this info is useful, please add the "Reviewed-by" tag from me.

Thanks for the report, fix now sent out.

Miklos

