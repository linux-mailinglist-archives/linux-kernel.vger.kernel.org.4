Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69F76A7D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCBJCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBJCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:02:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49383BD82
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176EA61563
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 09:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCE4C433D2;
        Thu,  2 Mar 2023 09:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677747731;
        bh=Bcfx6nVDLJrWKBsWRtdfRmhrHrEZ4wJahsgLTst7PpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+4iM+EmMvS1TmmMh+A7fca0q3jWPaiD1O/os062ZtxMV6Mp9/+LQjnWamJcCK6Zr
         0Mu/8A0e8Om+YqRyV/kM42Ml5LGIcVGx6v0wOeoaQLC/o509OK2SpwZklQELkr17D2
         e9Apui9OzQDZdtcarqTg7T9TPd9eUqNkGg5dYjkk8Qg2HxOG634oulRpFpmp54gZAe
         6Y1z3Oz69eZJMpZSncDN+IEyHg5q7FbpbqCuiyFmGgeB3swfy/Uywa0118iAQMk0D6
         Z+lsEyepmtNLUzlUWcqTojoMivnAt1dH+44dbEAaGrMDU7VqkoRIcLBShet9znQuN8
         mIJHMsdl84j0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pXepj-0003yA-K7; Thu, 02 Mar 2023 10:02:39 +0100
Date:   Thu, 2 Mar 2023 10:02:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, hsinyi@chromium.org,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        david.e.box@linux.intel.com
Subject: Re: System boot failure related to commit 'irqdomain: Switch to
 per-domain locking'
Message-ID: <ZABmL3/4oeN9EFsT@hovoldconsulting.com>
References: <d2290916-f78c-4b0a-d706-0955ae0aa4ff@linux.intel.com>
 <d595de9168d45bb5e863942ab7a78e3d@kernel.org>
 <32175259-ee22-9288-475c-db0da1ccee41@linux.intel.com>
 <87o7pch6lo.wl-maz@kernel.org>
 <bc72258e-ce88-6812-08bf-0f16f15e02ce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc72258e-ce88-6812-08bf-0f16f15e02ce@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 04:55:21PM +0800, Bingbu Cao wrote:

> I can dump the log by initramfs-tool now and checked that the change
> https://lore.kernel.org/all/20230223083800.31347-1-jgross@suse.com/ 
> can fix my problem, thanks for your help.

Thanks for confirming.

> [    1.726080] BUG: kernel NULL pointer dereference, address: 0000000000000050
> [    1.726874] #PF: supervisor read access in kernel mode
> [    1.727687] #PF: error_code(0x0000) - not-present page
> [    1.728491] PGD 0 P4D 0 
> [    1.729280] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [    1.730078] CPU: 3 PID: 154 Comm: systemd-udevd Not tainted 6.2.0-ipu #10
> [    1.730870] Hardware name: Dell Inc. XPS 9315/, BIOS 0.0.22 12/23/2021
> [    1.731670] RIP: 0010:irq_domain_create_hierarchy+0x2d/0x70
> [    1.732470] Code: 00 00 55 48 89 e5 41 55 49 89 fd 48 89 cf 41 54 53 89 f3 85 d2 74 3f 89 d6 31 c9 89 d2 e8 6b fd ff ff 49 89 c4 4d 85 e4 74 1e <49> 8b 45 50 41 09 5c 24 28 4c 89 e7 4d 89 ac 24 80 00 00 00 49 89
> [    1.733321] RSP: 0018:ffffb811c08e38f8 EFLAGS: 00010282
> [    1.734156] RAX: ffff975001456540 RBX: 0000000000000010 RCX: 0000000000000000
> [    1.734993] RDX: ffffffffadf8be90 RSI: ffffffffac7290a0 RDI: ffff975001456570
> [    1.735841] RBP: ffffb811c08e3910 R08: ffff975001452900 R09: ffff975001452900
> [    1.736676] R10: ffff975001452900 R11: ffff97510145206f R12: ffff975001456540
> [    1.737515] R13: 0000000000000000 R14: 0000000000000013 R15: ffff975011860628
> [    1.738349] FS:  00007f20175c08c0(0000) GS:ffff97537f8c0000(0000) knlGS:0000000000000000
> [    1.739198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.740042] CR2: 0000000000000050 CR3: 0000000111e1c004 CR4: 0000000000770ee0
> [    1.740892] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    1.741741] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [    1.742592] PKRU: 55555554
> [    1.743415] Call Trace:
> [    1.744226]  <TASK>
> [    1.745045]  __msi_create_irq_domain+0xb8/0x180
> [    1.745863]  msi_create_irq_domain+0x13/0x20
> [    1.746680]  pci_msi_create_irq_domain+0x7a/0xe0
> [    1.747493]  vmd_probe+0x85e/0x9a0 [vmd]
> [    1.748313]  local_pci_probe+0x48/0xb0
> [    1.749133]  pci_device_probe+0xc8/0x280
> [    1.749961]  really_probe+0x186/0x3f0

Johan
