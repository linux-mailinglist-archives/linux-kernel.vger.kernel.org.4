Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55A741D45
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjF2AhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjF2AhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBFA2D63
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3230761489
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AA5C433C0;
        Thu, 29 Jun 2023 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687999023;
        bh=RbA+79AH9JCoDWq9dm/zU/V/7D09CMZCr404fAuCY28=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fGXZuB2pfrlyrXMYyVBq+UhBVu7gck/SCxrPPK1triuE7c/KtGKvlEe0sEG6hgjUW
         PjVaVA61ZUqZfxibCNPlGYMPDtnzQYNj4oMCEgaNGuBvJ/LYyasenqIJHjJOu4MO4o
         8FbKHT/uI7f1Y9KZq0uhitwuFbc53ywp0KFSLumsuwRm7ciIyiQ8QYAZ4uI96igrHN
         OClS2PgtxSpOvKAH8VawcpaLIB7+RETmgWFFdlfYTTSWkzzdJ4GC57YkKY4R6b8Y6x
         1lAi4y/WWVNlBqVJdbG5vNrvm79n07LJN1iB1N8LJAw6HbEfxrr/BrmkTIzJrtk5M7
         +5fWnsSd5jk9w==
Date:   Wed, 28 Jun 2023 17:37:01 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>
Subject: Re: [PATCH 1/2] xen/virtio: Fix NULL deref when a bridge of PCI root
 bus has no parent
In-Reply-To: <249a24a2-497f-7695-452d-f509ebe89a14@epam.com>
Message-ID: <alpine.DEB.2.22.394.2306281736502.3936094@ubuntu-linux-20-04-desktop>
References: <20230621131214.9398-1-petr.pavlu@suse.com> <20230621131214.9398-2-petr.pavlu@suse.com> <249a24a2-497f-7695-452d-f509ebe89a14@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Oleksandr Tyshchenko wrote:
> On 21.06.23 16:12, Petr Pavlu wrote:
> Hello Petr
> 
> 
> > When attempting to run Xen on a QEMU/KVM virtual machine with virtio
> > devices (all x86_64), function xen_dt_get_node() crashes on accessing
> > bus->bridge->parent->of_node because a bridge of the PCI root bus has no
> > parent set:
> > 
> > [    1.694192][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000288
> > [    1.695688][    T1] #PF: supervisor read access in kernel mode
> > [    1.696297][    T1] #PF: error_code(0x0000) - not-present page
> > [    1.696297][    T1] PGD 0 P4D 0
> > [    1.696297][    T1] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [    1.696297][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.7-1-default #1 openSUSE Tumbleweed a577eae57964bb7e83477b5a5645a1781df990f0
> > [    1.696297][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> > [    1.696297][    T1] RIP: e030:xen_virtio_restricted_mem_acc+0xd9/0x1c0
> > [    1.696297][    T1] Code: 45 0c 83 e8 c9 a3 ea ff 31 c0 eb d7 48 8b 87 40 ff ff ff 48 89 c2 48 8b 40 10 48 85 c0 75 f4 48 8b 82 10 01 00 00 48 8b 40 40 <48> 83 b8 88 02 00 00 00 0f 84 45 ff ff ff 66 90 31 c0 eb a5 48 89
> > [    1.696297][    T1] RSP: e02b:ffffc90040013cc8 EFLAGS: 00010246
> > [    1.696297][    T1] RAX: 0000000000000000 RBX: ffff888006c75000 RCX: 0000000000000029
> > [    1.696297][    T1] RDX: ffff888005ed1000 RSI: ffffc900400f100c RDI: ffff888005ee30d0
> > [    1.696297][    T1] RBP: ffff888006c75010 R08: 0000000000000001 R09: 0000000330000006
> > [    1.696297][    T1] R10: ffff888005850028 R11: 0000000000000002 R12: ffffffff830439a0
> > [    1.696297][    T1] R13: 0000000000000000 R14: ffff888005657900 R15: ffff888006e3e1e8
> > [    1.696297][    T1] FS:  0000000000000000(0000) GS:ffff88804a000000(0000) knlGS:0000000000000000
> > [    1.696297][    T1] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.696297][    T1] CR2: 0000000000000288 CR3: 0000000002e36000 CR4: 0000000000050660
> > [    1.696297][    T1] Call Trace:
> > [    1.696297][    T1]  <TASK>
> > [    1.696297][    T1]  virtio_features_ok+0x1b/0xd0
> > [    1.696297][    T1]  virtio_dev_probe+0x19c/0x270
> > [    1.696297][    T1]  really_probe+0x19b/0x3e0
> > [    1.696297][    T1]  __driver_probe_device+0x78/0x160
> > [    1.696297][    T1]  driver_probe_device+0x1f/0x90
> > [    1.696297][    T1]  __driver_attach+0xd2/0x1c0
> > [    1.696297][    T1]  bus_for_each_dev+0x74/0xc0
> > [    1.696297][    T1]  bus_add_driver+0x116/0x220
> > [    1.696297][    T1]  driver_register+0x59/0x100
> > [    1.696297][    T1]  virtio_console_init+0x7f/0x110
> > [    1.696297][    T1]  do_one_initcall+0x47/0x220
> > [    1.696297][    T1]  kernel_init_freeable+0x328/0x480
> > [    1.696297][    T1]  kernel_init+0x1a/0x1c0
> > [    1.696297][    T1]  ret_from_fork+0x29/0x50
> > [    1.696297][    T1]  </TASK>
> > [    1.696297][    T1] Modules linked in:
> > [    1.696297][    T1] CR2: 0000000000000288
> > [    1.696297][    T1] ---[ end trace 0000000000000000 ]---
> > 
> > The PCI root bus is in this case created from ACPI description via
> > acpi_pci_root_add() -> pci_acpi_scan_root() -> acpi_pci_root_create() ->
> > pci_create_root_bus() where the last function is called with
> > parent=NULL. It indicates that no parent is present and then
> > bus->bridge->parent is NULL too.
> > 
> > Fix the problem by checking bus->bridge->parent in xen_dt_get_node() for
> > NULL first >
> > Fixes: ef8ae384b4c9 ("xen/virtio: Handle PCI devices which Host controller is described in DT")
> 
> Oops, sorry. I have to admit I checked with DT only.
> 
> 
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
