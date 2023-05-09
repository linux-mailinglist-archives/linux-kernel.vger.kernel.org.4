Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DD6FCB4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEIQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEIQ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:28:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70584210
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:28:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9659c5b14d8so990557166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1683649710; x=1686241710;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OC8n/uXlcKr2NqIRtICycl1P6N257MT/IFD3g9x1RYg=;
        b=F6X6VwC0MM2xJrULO90f7zNyo1CfUKrmhpdXPtVRAkWQfgAdS2ohwcmLedp51ovgEH
         1FcajRwfbttk6crVdHc3QQ0Pje2CHSqZaDceVJA//v7ApHLQFzI1/OwlaTGcPLuufgip
         BvKRkpeWwdGsAS7XKEUxSULt+qp+CvYdzsGCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683649710; x=1686241710;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OC8n/uXlcKr2NqIRtICycl1P6N257MT/IFD3g9x1RYg=;
        b=Zp8Oy+9QDq0T5ph/RE3W030c9oQC+R/Fu5oHWYK10lwkph0Cg6YlR8BxY7r5dIg1mN
         hZ8NDtUECooooBFUU5nKXvZmx8wpImohSwYvh4rrV/8bNrJp4/vXho4AiIcpWU/bv/i/
         SVfjDtaE92WcYN/fg6UtqF75RfQsAthjtwUK1SYK1kOw1l3jbQGmsD8HPRiq7xAno7Ja
         5hL++UNTsbRGSN+NhBb9xDcO4SAj9Mb69qchjzfDEqE89o2n9cnVK6i/fks4DzEwGwft
         WjrtaLtNkotWgPb+ax+tSCzWG8A1LUQqQRcHEDJhoi9h87BZ/zd3AwdnQ4yP/ZYW6Zpz
         PlWg==
X-Gm-Message-State: AC+VfDz8BW6b/D9cFAoCpauYNMXFJQ4iJjATM3bNHlhtKVj9SaeeCT11
        jqb8TlSM704ht52V3woE+4wm0p3beykewaHwzDkJU7SCjuPtBSFm3t8=
X-Google-Smtp-Source: ACHHUZ7tSJ0RwAGl4DjiCCbAgI+ex3IFXIGOR3DSWKYLtSIFkvou1biC9xLhpTVgM+jortXHE2iRtIO4s4DCsv0ap2E=
X-Received: by 2002:a17:907:7291:b0:96a:717:d452 with SMTP id
 dt17-20020a170907729100b0096a0717d452mr1333174ejc.19.1683649709854; Tue, 09
 May 2023 09:28:29 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Tue, 9 May 2023 17:28:19 +0100
Message-ID: <CA+wXwBS7YTHUmxGP3JrhcKMnYQJcd6=7HE+E1v-guk01L2K3Zw@mail.gmail.com>
Subject: rcu_preempt self-detected stall in filemap_get_read_batch
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

I'm trying to track down a problem that occurred intermittenly when
doing rocksdb compaction
and manifested in RCU self detected stall

  [949170.657126][   C97] rcu: INFO: rcu_preempt self-detected stall on CPU
  [949170.666237][   C97] rcu:    97-....: (701243 ticks this GP)
idle=948c/1/0x4000000000000000 softirq=295729919/295729919 fqs=286689
  [949170.683019][   C97]         (t=718763 jiffies g=500631033
q=31964872 ncpus=128)
  [949170.692508][   C97] CPU: 97 PID: 184960 Comm: rocksdb:low1
Kdump: loaded Tainted: G        W  O L     6.1.22-cloudflare-2023.3.27
#1
  [949170.710034][   C97] Hardware name: HYVE
EDGE-METAL-GEN11/HS1811D_Lite, BIOS V0.11-sig 12/23/2022
  [949170.721788][   C97] RIP: 0010:xas_load+0x61/0xa0
  [949170.729326][   C97] Code: ea 83 e2 3f 89 d0 48 83 c0 04 48 8b 44
c6 08 48 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d fd 00 00
00 76 0d 88 57 12 <80> 3e 00 75 a5 c3 cc cc cc cc 48 c1 e8 02 89 c2 89
c0 48 83 c0 04
  [949170.757643][   C97] RSP: 0018:ffffabeee65f3bf8 EFLAGS: 00000293
  [949170.766704][   C97] RAX: fffff17ec1cc3000 RBX: ffffabeee65f3d70
RCX: 0000000000000000
  [949170.777729][   C97] RDX: 0000000000000000 RSI: ffff99e781536d80
RDI: ffffabeee65f3c00
  [949170.788799][   C97] RBP: 000000000000157e R08: 0000000000000402
R09: fffff17ec1cc3000
  [949170.799865][   C97] R10: 0000000000000001 R11: 0000000000000000
R12: ffffabeee65f3e90
  [949170.810927][   C97] R13: 000000000000157e R14: 0000000000001540
R15: ffff99e2615f6538
  [949170.821983][   C97] FS:  00007ff7be571700(0000)
GS:ffff99d51fc40000(0000) knlGS:0000000000000000
  [949170.834065][   C97] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [949170.843820][   C97] CR2: 00007fa0ea422000 CR3: 0000004b17f62002
CR4: 0000000000770ee0
  [949170.855008][   C97] PKRU: 55555554
  [949170.861762][   C97] Call Trace:
  [949170.868244][   C97]  <TASK>
  [949170.874358][   C97]  filemap_get_read_batch+0x186/0x250
  [949170.882949][   C97]  filemap_get_pages+0xa2/0x630
  [949170.890991][   C97]  ? free_unref_page_commit+0x7c/0x170
  [949170.899646][   C97]  ? _raw_spin_unlock_irqrestore+0x1b/0x40
  [949170.908603][   C97]  ? free_unref_page+0x1a8/0x1e0
  [949170.916604][   C97]  filemap_read+0xc1/0x320
  [949170.923990][   C97]  ? find_css_set+0x200/0x680
  [949170.931570][   C97]  xfs_file_buffered_read+0x50/0xd0
  [949170.939639][   C97]  xfs_file_read_iter+0x6a/0xd0
  [949170.947322][   C97]  vfs_read+0x204/0x2d0
  [949170.954298][   C97]  __x64_sys_pread64+0x90/0xc0
  [949170.961865][   C97]  do_syscall_64+0x3b/0x90
  [949170.969094][   C97]  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
  [949170.977781][   C97] RIP: 0033:0x7ff7ee27b917
  [949170.984964][   C97] Code: 08 89 3c 24 48 89 4c 24 18 e8 05 f4 ff
ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8
11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 35
f4 ff ff 48 8b
  [949171.013041][   C97] RSP: 002b:00007ff7be56d1b0 EFLAGS: 00000293
ORIG_RAX: 0000000000000011
  [949171.024300][   C97] RAX: ffffffffffffffda RBX: 0000000001595dd0
RCX: 00007ff7ee27b917
  [949171.035104][   C97] RDX: 00000000000b20c3 RSI: 0000000027460000
RDI: 0000000000000050
  [949171.045842][   C97] RBP: 00007ff7be56d2f0 R08: 0000000000000000
R09: 00007ff7be56d3a0
  [949171.056529][   C97] R10: 00000000014cccf2 R11: 0000000000000293
R12: 0000000003a2fc80
  [949171.067185][   C97] R13: 00000000000b20c3 R14: 00000000000b20c3
R15: 00000000014cccf2
  [949171.077761][   C97]  </TASK>

We have not been able to reproduce this reliably.

Does this look similar to problems seen in
https://lore.kernel.org/linux-mm/Y1lZ9Rm87GpFRM%2FQ@casper.infradead.org/.
I wonder if it's reasonable to try the patch and see what we have
since it looks sane.

Best,
Daniel.
