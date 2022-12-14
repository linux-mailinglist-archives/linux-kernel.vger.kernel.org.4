Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F1164CCF8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiLNPUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiLNPUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:20:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BB21146C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671031199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XDlWGgFZ4ZJyCtk12LGJK7/45dwv0NSxLqyhRKbdjcM=;
        b=EjS5EFUJ8UeJaHI1/J0KLwSE3RjsFSgQvikvcMQN3XQvXAawrAnSufDi/XQH2WxlaWCuFd
        5cC4tx6U7lFKq0UAnh9aHtk/F91CSjBO/D64aW2UXQdxedAUN/BDxodZHF4nvfBMMZ+n0o
        XFN+2dX4KmlAJsSuREZD17dy+JLSDEo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-360-wYrhVLAeOFKu5WgGrGAOUg-1; Wed, 14 Dec 2022 10:19:58 -0500
X-MC-Unique: wYrhVLAeOFKu5WgGrGAOUg-1
Received: by mail-qk1-f197.google.com with SMTP id v7-20020a05620a0f0700b006faffce43b2so3290567qkl.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 07:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDlWGgFZ4ZJyCtk12LGJK7/45dwv0NSxLqyhRKbdjcM=;
        b=22D3qN+fG3SMdEOPSEECPG2iIzmOLHpnh6aO3dmYPm6Ip+RHi0r6Es2paCykyxNX9E
         Jbil+/cINCXsfhGo/0+i6zVqgjTeUuwj4FeIqlWS9lsST4wdXFALBNVUvaXu2PmNvncb
         sXickKnRNUA/Kz8YfBsisLCZbkD0accfUylLxudFp2tfCWs7TcSgC/qzBr7ftnY4kg/X
         MpY91E1XKMgodpHBHOt675J2gLGirUDH3mxspXQ8YSr9IhExv0yVyiDdBSTlDeusy3h6
         pYRjC/298yANQjuK3DegzSjS8spHgz4pjjXPSObp9peA9uLWXfgbJqXPvwfG0LzSL34I
         rDAA==
X-Gm-Message-State: ANoB5pmTPnNh1+blN1u/96LzhBffmMeWYTM5NZ548DpgN8V8NK98D1hU
        QCG/WVAcm6DEpMppFVlC3KcqZ0QAspmkDIMBrDv7OlD8CYdx83h2MVNzaePWw9pt+8KcSDMIXCj
        ud9W8QPAGjKSjK+MBfJokYF9F
X-Received: by 2002:ac8:4251:0:b0:3a8:1ef2:7c6b with SMTP id r17-20020ac84251000000b003a81ef27c6bmr11524695qtm.13.1671031195894;
        Wed, 14 Dec 2022 07:19:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6KQlmzlt2L7c7Sh/fOd/bml9WovQwKi5o2TgK38jbPxa7vNBiJmb67d6SoLzFqmlTCQhEF5Q==
X-Received: by 2002:ac8:4251:0:b0:3a8:1ef2:7c6b with SMTP id r17-20020ac84251000000b003a81ef27c6bmr11524678qtm.13.1671031195634;
        Wed, 14 Dec 2022 07:19:55 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-45-70-31-26-132.dsl.bell.ca. [70.31.26.132])
        by smtp.gmail.com with ESMTPSA id p20-20020ac84614000000b003a611cb2a95sm1838265qtn.9.2022.12.14.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:19:54 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:19:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com, linux-mm@kvack.org
Subject: Re: [Syzkaller & bisect] There is "copy_page_range WARNING" in
 v6.1-rc8 and v6.1
Message-ID: <Y5npmXzUx4FD12Rp@x1n>
References: <Y5l871w6bwDnJ9HD@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5l871w6bwDnJ9HD@xpf.sh.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:36:15PM +0800, Pengfei Xu wrote:
> Hi Peter and memory expert,

Pengfei,

> 
> It's a soft remind.
> There is "copy_page_range WARNING" in v6.1-rc8 and v6.1.
> [   28.138268] ------------[ cut here ]------------
> [   28.138277] WARNING: CPU: 1 PID: 568 at mm/memory.c:874 copy_page_range+0x1858/0x2960
> [   28.139002] Modules linked in:
> [   28.139219] CPU: 1 PID: 568 Comm: repro Not tainted 5.19.0-rc1-6ff40f00e5a4+ #1
> [   28.139706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   28.140306] RIP: 0010:copy_page_range+0x1858/0x2960
> [   28.140584] Code: 5b e2 ff 41 83 fc 1e 0f 85 b1 fe ff ff e8 00 5a e2 ff 31 ff 4c 89 ee e8 26 5b e2 ff 4d 85 ed 0f 85 b6 fe ff ff e8 e8 59 e2 ff <0f> 0b e9 aa 5
> [   28.141550] RSP: 0018:ffffc90000c9baf0 EFLAGS: 00010246
> [   28.141838] RAX: 0000000000000000 RBX: f7fffffffffffc00 RCX: ffffffff81415aba
> [   28.142229] RDX: 0000000000000000 RSI: ffff888007e28000 RDI: 0000000000000002
> [   28.142612] RBP: ffffc90000c9bc98 R08: 0000000000000040 R09: 0000000000000000
> [   28.142996] R10: 0000000000000001 R11: ffffea00002ab580 R12: 000000000000001e
> [   28.143405] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000000
> [   28.143905] FS:  00007f5b23733740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
> [   28.144335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   28.144648] CR2: 00000000200000c0 CR3: 0000000007d5c005 CR4: 0000000000770ee0
> [   28.145032] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   28.145413] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [   28.145791] PKRU: 55555554
> [   28.145946] Call Trace:
> [   28.146097]  <TASK>
> [   28.146242]  dup_mm+0x689/0x900
> [   28.146436]  copy_process+0x1ade/0x23e0
> [   28.146656]  ? __sanitizer_cov_trace_pc+0x25/0x50
> [   28.146928]  kernel_clone+0x90/0x670
> [   28.147152]  ? userfaultfd_ioctl+0xd2/0x23c0
> [   28.147491]  __do_sys_clone+0xa2/0xd0
> [   28.147779]  __x64_sys_clone+0x2f/0x40
> [   28.148023]  do_syscall_64+0x3b/0x90
> [   28.148243]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [   28.148538] RIP: 0033:0x7f5b2385859d
> [   28.148749] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 8
> [   28.149722] RSP: 002b:00007ffc5a2e6b58 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> [   28.150133] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5b2385859d
> [   28.150555] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000001000
> [   28.150938] RBP: 00007ffc5a2e6ba0 R08: 0000000000000000 R09: 0000000000000000
> [   28.151340] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000401060
> [   28.151846] R13: 00007ffc5a2e6ca0 R14: 0000000000000000 R15: 0000000000000000
> [   28.152230]  </TASK>
> [   28.152363] ---[ end trace 0000000000000000 ]---
> 
> This issue could be reproduced in v6.1 kernel in guest also.
> 
> Bisected and found that bad commit was:
> "
> 81e0f15f2ef6dad7ccb9c03d8e61ef7ded836b38
> mm: enable PTE markers by default
> "
> 
> After reverted above commit on top of v6.1-rc8 kernel, this issue was gone.
> 
> All detailed bisect info, reproduced code and kconfig are in link:
> https://github.com/xupengfe/syzkaller_logs/tree/main/221208_115556_copy_page_range
> 
> 
> If the info was helpful and it's fixed, please added the Reported tag from me.

I think the warning was improper indeed as when without UFFD_EVENT_FORK
registered dst_vma will not inherit VM_UFFD_WP.

This also reminded me that this can also trigger after the swapin error
replacement using pte markers when there's the swapin error markers and if
we fork() we may hit the same thing.

I'll post a fix soon.  Thanks for the report.

-- 
Peter Xu

