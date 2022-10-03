Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352D75F2B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiJCHvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiJCHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 03:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C624294
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664782029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=afqnNa4LbGAKEE7TpGvc4ly12ZlTyEo8Vo0uR8UYNF4=;
        b=ei7zkXBg1aYlMaZgfgdZ+Rs40GleTS4WqpmEHFu2RTAMCW5AK7XxI71YETG9gRD0MH83rL
        zob+aCKG52vAIJ4p/Yc6I0RCZ7mCdGCm7ojsFo9ROBouXI9yHv4+A0pe9RLbvwBLjgH2gb
        ydX2KuupDNHPS7xjH2SRNN5I1/fWsmQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-vdV7E683ME2ip_1i5lc0AA-1; Mon, 03 Oct 2022 03:16:21 -0400
X-MC-Unique: vdV7E683ME2ip_1i5lc0AA-1
Received: by mail-lj1-f198.google.com with SMTP id a13-20020a2ebe8d000000b0026bfc93da46so2574617ljr.16
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=afqnNa4LbGAKEE7TpGvc4ly12ZlTyEo8Vo0uR8UYNF4=;
        b=ACcYFM8UBuI/9gIfB4pkvDoRKnCPHbl0TpAEeSAEcBUXDlIm9IDND5D7L1RnQbPxan
         5fjCo+U74x6+vev3xuVWxB59El41OUIWFgtJzBdwSYyQT0ZN4izyY0a0nxbMjXd7Rwmo
         VOK4rtaUZWqXSHTEgBY82LRs0YYKxEAELcFYbkFnnPphgQrdoRWydIctOwKpABg/W3Sa
         eTX1P3716JlUljXd8TYybYbi0m98DYZVgCNtillLj3nA42ri3ZOCgGn/zC5ZXRFQ5DLp
         edXyy32yv307vrSa4KI03RRSu/V3bF+wQ97pyf12AhBMLk/Fae2zkjAakC7SiPpgVueE
         apIQ==
X-Gm-Message-State: ACrzQf38WQWK87A3bTjTqI3AbdxpySz8geWMPLcAC1lP9hcTK6Pyxe12
        RHRkbuhoFEdcmQIKsxn/iC2UjRBruV9LISfYVqyyaYhRX7uoZBtUk/W/NL9vUs+JyNihpQ63QEN
        fO07MIyb0uU2JkmcpkJ/KQPLP+mWWboqNTcHFSDwN
X-Received: by 2002:ac2:5a41:0:b0:4a2:4888:7b1 with SMTP id r1-20020ac25a41000000b004a2488807b1mr414378lfn.537.1664781379288;
        Mon, 03 Oct 2022 00:16:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4CDARlvRNnqEUKA6iXuYMUJWtJokyGzOhAs23hDUpl10xaO/++7YeMg3sZE1llYL2C868RsTxBnqgK/qR8KLE=
X-Received: by 2002:ac2:5a41:0:b0:4a2:4888:7b1 with SMTP id
 r1-20020ac25a41000000b004a2488807b1mr414372lfn.537.1664781379039; Mon, 03 Oct
 2022 00:16:19 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 3 Oct 2022 09:16:08 +0200
Message-ID: <CA+QYu4oK8D-89QZnBC8eYS9TxOU48hY5JazTvF=4N2qdeRepbw@mail.gmail.com>
Subject: [6.0.0] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

recently we are hitting the following issue when booting using kernel
with debug options enabled:

[  126.821761] CPU: 1 PID: 296 Comm: cryptomgr_test Not tainted 6.0.0 #1
[  126.824021] Hardware name: Red Hat KVM, BIOS 1.15.0-1.el9 04/01/2014
[  126.825721] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
[  126.827045] Code: df 11 c4 41 31 ef fb 48 83 c2 08 0f 84 eb 01 00
00 48 89 d0 48 c1 e0 04 48 81 c7 80 00 00 00 48 29 c7 0f 10 06 66 41
0f ef c7 <0f> 28 0f c4 63 71 44 f0 01 c4 e3 71 44 d0 10 c4 63 71 44 e0
00 c4
[  126.831535] RSP: 0018:ffff88810ed779d8 EFLAGS: 00010282
[  126.832957] RAX: 0000000000000030 RBX: 0000000000000030 RCX: ffff88810ede19e8
[  126.834907] RDX: 0000000000000003 RSI: ffff8881094b8000 RDI: ffff88811483c408
[  126.836554] RBP: ffff8881094b8000 R08: ffffffffc0300835 R09: ffff88810ede19e8
[  126.838529] R10: ffffed1021dbc33f R11: 0000000000000000 R12: 0000000000000030
[  126.840526] R13: 0000000000000003 R14: ffff88810ede19e8 R15: ffff88810ede19e0
[  126.842702] FS:  0000000000000000(0000) GS:ffff888193d00000(0000)
knlGS:0000000000000000
[  126.844574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  126.846796] CR2: 0000564f48e04178 CR3: 000000010be88002 CR4: 0000000000370ee0
[  126.848934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  126.850913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  126.852879] Call Trace:
[  126.853703]  <TASK>
[  126.854436]  polyval_x86_update+0x102/0x1e0 [polyval_clmulni]
[  126.856092]  test_shash_vec_cfg+0x523/0x9d0
[  126.857360]  ? alg_test_aead+0x170/0x170
[  126.858682]  ? pointer+0x6a0/0x6a0
[  126.859752]  ? ___slab_alloc+0x910/0xf70
[  126.860950]  ? __alg_test_hash.constprop.0+0x200/0x430
[  126.862140]  ? __kmalloc+0x64/0x380
[  126.863233]  ? sprintf+0xb3/0xe0
[  126.864159]  ? rcu_read_lock_sched_held+0x3f/0x80
[  126.865560]  ? trace_kmalloc+0x33/0xf0
[  126.866716]  __alg_test_hash.constprop.0+0x2e7/0x430
[  126.867995]  ? test_ahash_vec_cfg+0xca0/0xca0
[  126.869389]  ? lockdep_hardirqs_on_prepare+0x230/0x230
[  126.870906]  ? lockdep_hardirqs_on+0x7d/0x100
[  126.872221]  ? alg_test_hash+0x8e/0x130
[  126.873398]  alg_test+0x60d/0x7d0
[  126.874463]  ? alloc_cipher_test_sglists+0xb0/0xb0
[  126.875867]  ? lock_release+0x233/0x470
[  126.876726]  ? __kthread_parkme+0x65/0xf0
[  126.877654]  ? reacquire_held_locks+0x270/0x270
[  126.878984]  ? mark_held_locks+0x24/0x90
[  126.879985]  ? preempt_count_sub+0xb7/0x100
[  126.881260]  ? crypto_acomp_scomp_free_ctx+0x70/0x70
[  126.882649]  cryptomgr_test+0x36/0x60
[  126.883786]  kthread+0x17e/0x1b0
[  126.884564]  ? kthread_complete_and_exit+0x20/0x20
[  126.885975]  ret_from_fork+0x22/0x30
[  126.887086]  </TASK>
[  126.887858] Modules linked in: polyval_clmulni(+) polyval_generic
virtio_blk(+) ghash_clmulni_intel floppy virtio_console serio_raw
ata_generic pata_acpi qemu_fw_cfg


full console log:
https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/02/redhat:656405029/build_x86_64_redhat:656405029_x86_64_debug/tests/4/results_0001/console.log/console.log

test logs: https://datawarehouse.cki-project.org/kcidb/tests/5344697
cki issue tracker: https://datawarehouse.cki-project.org/issue/1626

kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/build%20x86_64%20debug/3116060967/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.config
kernel tarball:
https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/publish%20x86_64%20debug/3116060972/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.tar.gz

We didn't bisect, but the first commit we tested that we hit the
problem is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46452d3786a82bd732ba73fb308ae5cbe4e1e591

The last commit we tested and didn't hit the problem is
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1375562c0a87f0fa2eaf3e8ce15824696d4170a

Thanks,
Bruno Goncalves

