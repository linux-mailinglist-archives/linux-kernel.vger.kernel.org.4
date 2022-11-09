Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0919B62291E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiKIKxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiKIKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:52:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA4013F46
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:52:25 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F81B1EC03B9;
        Wed,  9 Nov 2022 11:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667991144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=OHEQD9knIsVX43ZDdRle56rw0hgWVR+NJHFg2Jb5tb8=;
        b=oUloTHgSK3OhV2iuftrVhbpGpyz9ZaaPKf385+TpclWvQgO+n3k0eFV0I6n5s1yDl8IlPk
        UiJz6lZs+cyf6CGt15iSse3d2ncU1qPh7HDZwHXPFClo7TcCnJEKSB4riEizwkjdalSems
        NEZTTjcVZ/l1Z2aIk8eEZ5KfyY0KlMU=
Date:   Wed, 9 Nov 2022 11:52:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: AMD uncore kmemleak
Message-ID: <Y2uGZL1ou+JGu2mh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Peter said you liked this stuff so here it is. :-)

On one of my test boxes (Carrizo laptop - that's an Excavator core) I
see the below. It happens with 6.1-rc1.

I booted latest -rc4 + tip/master and it is gone so something has
changed in the meantime or this particular version doesn't fire...

Anyway, we thought you should know in case you want to dig deeper.

Thx.

cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888101a3d3a0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294892455 (age 294.968s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002f5fe849>] __kmalloc_node+0x5f/0x180
    [<00000000066a1fb1>] amd_uncore_cpu_up_prepare+0xc7/0x240
    [<000000005fa7fab5>] cpuhp_invoke_callback+0xf8/0x460
    [<00000000d4b0952e>] cpuhp_issue_call+0x118/0x190
    [<000000008cb1592a>] __cpuhp_setup_state_cpuslocked+0xee/0x2a0
    [<0000000007534fa6>] __cpuhp_setup_state+0x76/0x100
    [<00000000d8277f50>] amd_uncore_init+0x275/0x336
    [<000000004af336cd>] do_one_initcall+0x44/0x200
    [<0000000040cb5caf>] kernel_init_freeable+0x198/0x1e4
    [<000000008b0e9fae>] kernel_init+0x16/0x120
    [<00000000459bcaeb>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888101a3d240 (size 32):
  comm "swapper/0", pid 1, jiffies 4294892455 (age 294.968s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002f5fe849>] __kmalloc_node+0x5f/0x180
    [<00000000066a1fb1>] amd_uncore_cpu_up_prepare+0xc7/0x240
    [<000000005fa7fab5>] cpuhp_invoke_callback+0xf8/0x460
    [<00000000d4b0952e>] cpuhp_issue_call+0x118/0x190
    [<000000008cb1592a>] __cpuhp_setup_state_cpuslocked+0xee/0x2a0
    [<0000000007534fa6>] __cpuhp_setup_state+0x76/0x100
    [<00000000d8277f50>] amd_uncore_init+0x275/0x336
    [<000000004af336cd>] do_one_initcall+0x44/0x200
    [<0000000040cb5caf>] kernel_init_freeable+0x198/0x1e4
    [<000000008b0e9fae>] kernel_init+0x16/0x120
    [<00000000459bcaeb>] ret_from_fork+0x22/0x30
unreferenced object 0xffff888101a3d4a0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294892455 (age 294.968s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000002f5fe849>] __kmalloc_node+0x5f/0x180
    [<00000000066a1fb1>] amd_uncore_cpu_up_prepare+0xc7/0x240
    [<000000005fa7fab5>] cpuhp_invoke_callback+0xf8/0x460
    [<00000000d4b0952e>] cpuhp_issue_call+0x118/0x190
    [<000000008cb1592a>] __cpuhp_setup_state_cpuslocked+0xee/0x2a0
    [<0000000007534fa6>] __cpuhp_setup_state+0x76/0x100
    [<00000000d8277f50>] amd_uncore_init+0x275/0x336
    [<000000004af336cd>] do_one_initcall+0x44/0x200
    [<0000000040cb5caf>] kernel_init_freeable+0x198/0x1e4
    [<000000008b0e9fae>] kernel_init+0x16/0x120
    [<00000000459bcaeb>] ret_from_fork+0x22/0x30

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
