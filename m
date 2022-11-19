Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10D2630D68
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKSIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiKSIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:45:06 -0500
X-Greylist: delayed 1018 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Nov 2022 00:45:04 PST
Received: from server.eikelenboom.it (server.eikelenboom.it [91.121.65.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD04193E9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DJreaUMvt4zA0FCli4gW45voLTfYum2Sr88dejDCL4o=; b=Bgk45hLnCBxrR7FghkDkLpbkG/
        kVkd17OfU2UZVIKRFbrCpf9wfzuVPRPSQGwjUpFPEq4YFkrHe+Hv4dRsbw1FMNDcjPe6Ix8vZpkW9
        WvMHqOKM8OAt5trzx149PgwazaUWtB5TnfemqDokgn9NGn9xKFmwufMpIOuldh41CrGE=;
Received: from 131-195-250-62.ftth.glasoperator.nl ([62.250.195.131]:46996 helo=[172.16.1.212])
        by server.eikelenboom.it with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux@eikelenboom.it>)
        id 1owJDZ-0001cM-Jm; Sat, 19 Nov 2022 09:28:53 +0100
Message-ID: <42579618-f8e2-9fd2-0b6c-f2c87f7c57a6@eikelenboom.it>
Date:   Sat, 19 Nov 2022 09:28:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: nl-NL, en-US
To:     Juergen Gross <jgross@suse.com>, Yu Zhao <yuzhao@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Xen-devel <xen-devel@lists.xen.org>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Subject: Xen-unstable Linux-6.1.0-rc5 BUG: unable to handle page fault for
 address: ffff8880083374d0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu / Juergen,

This night I got a dom0 kernel crash on my new Ryzen box running Xen-unstable and a Linux-6.1.0-rc5 kernel.
I did enable the new and shiny MGLRU, could this be related ?

--
Sander


Nov 19 06:30:11 serveerstertje kernel: [68959.647371] BUG: unable to handle page fault for address: ffff8880083374d0
Nov 19 06:30:11 serveerstertje kernel: [68959.663555] #PF: supervisor write access in kernel mode
Nov 19 06:30:11 serveerstertje kernel: [68959.677542] #PF: error_code(0x0003) - permissions violation
Nov 19 06:30:11 serveerstertje kernel: [68959.691181] PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
Nov 19 06:30:11 serveerstertje kernel: [68959.705084] Oops: 0003 [#1] PREEMPT SMP NOPTI
Nov 19 06:30:11 serveerstertje kernel: [68959.718710] CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr-mac80211debug+ #1
Nov 19 06:30:11 serveerstertje kernel: [68959.732457] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4 R2.0, BIOS P5.60 10/20/2022
Nov 19 06:30:11 serveerstertje kernel: [68959.746391] RIP: e030:pmdp_test_and_clear_young+0x25/0x40
Nov 19 06:30:11 serveerstertje kernel: [68959.760294] Code: 00 00 00 66 90 48 b9 ff ff 1f 00 00 00 f0 ff 48 8b 02 48 be ff 0f 00 00 00 00 f0 ff a8 80 48 0f 44 ce 48 21 c8 83 e0 20 74 0c <f0> 48 0f ba 32 05 0f 92 c0 0f b6 c0 c3 cc cc c
Nov 19 06:30:11 serveerstertje kernel: [68959.787908] RSP: e02b:ffffc9000161f940 EFLAGS: 00010202
Nov 19 06:30:11 serveerstertje kernel: [68959.801637] RAX: 0000000000000020 RBX: 0000000000000000 RCX: fff0000000000fff
Nov 19 06:30:11 serveerstertje kernel: [68959.815243] RDX: ffff8880083374d0 RSI: fff0000000000fff RDI: ffff888010f41000
Nov 19 06:30:11 serveerstertje kernel: [68959.828683] RBP: ffffc9000161fa70 R08: 000ffffffffff000 R09: 00005654134b5000
Nov 19 06:30:11 serveerstertje kernel: [68959.842026] R10: 000000000000689e R11: 0000000000000000 R12: ffff8880083374d0
Nov 19 06:30:11 serveerstertje kernel: [68959.855214] R13: ffff88807fc1a000 R14: ffff8880083374d0 R15: 0000000000000000
Nov 19 06:30:11 serveerstertje kernel: [68959.868118] FS:  0000000000000000(0000) GS:ffff8880801c0000(0000) knlGS:0000000000000000
Nov 19 06:30:11 serveerstertje kernel: [68959.880689] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
Nov 19 06:30:11 serveerstertje kernel: [68959.893457] CR2: ffff8880083374d0 CR3: 000000000f33c000 CR4: 0000000000050660
Nov 19 06:30:11 serveerstertje kernel: [68959.906377] Call Trace:
Nov 19 06:30:11 serveerstertje kernel: [68959.919219]  <TASK>
Nov 19 06:30:11 serveerstertje kernel: [68959.931844]  walk_pmd_range_locked.isra.87+0x2e9/0x4e0
Nov 19 06:30:11 serveerstertje kernel: [68959.944840]  walk_pud_range+0x69c/0x980
Nov 19 06:30:11 serveerstertje kernel: [68959.957562]  walk_pgd_range+0xe9/0x810
Nov 19 06:30:11 serveerstertje kernel: [68959.970161]  ? mt_find+0x1f8/0x3c0
Nov 19 06:30:11 serveerstertje kernel: [68959.982808]  __walk_page_range+0x17b/0x180
Nov 19 06:30:11 serveerstertje kernel: [68959.995440]  walk_page_range+0x106/0x170
Nov 19 06:30:11 serveerstertje kernel: [68960.008014]  try_to_inc_max_seq+0x40a/0x9e0
Nov 19 06:30:11 serveerstertje kernel: [68960.020262]  lru_gen_age_node+0x1d3/0x280
Nov 19 06:30:11 serveerstertje kernel: [68960.032222]  ? shrink_node+0x294/0x710
Nov 19 06:30:11 serveerstertje kernel: [68960.044129]  balance_pgdat+0x1c3/0x650
Nov 19 06:30:11 serveerstertje kernel: [68960.055995]  ? prepare_to_wait_event+0x110/0x110
Nov 19 06:30:11 serveerstertje kernel: [68960.068022]  kswapd+0x1f0/0x3a0
Nov 19 06:30:11 serveerstertje kernel: [68960.079997]  ? prepare_to_
