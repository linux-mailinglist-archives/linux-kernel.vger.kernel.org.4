Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B11A6008C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJQIdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiJQIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEEC4456B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665995586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DL22C15AzqG7yN7r6cP3xELiCmGRDvacAs2ij+9ObWs=;
        b=bJcO4CxdVTL7/Ato7tbQjpgO25M1XC0HUEYjNta5CHDCnaTO/SW7nMSdI1J3sw/VYWxB6r
        9G2Yh/vHo0uy2Iq3YT+alNArZFifz6mihQchjz2jDot/miUl/FRRISAT5g2MwflS2XhXQ0
        IoRq9DsFTkVUQXNrMNYKcuVqZLHNIjs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-JRMQEFk4Opa-HIeDwvByvA-1; Mon, 17 Oct 2022 04:33:04 -0400
X-MC-Unique: JRMQEFk4Opa-HIeDwvByvA-1
Received: by mail-lf1-f70.google.com with SMTP id f35-20020a0565123b2300b004a442356475so3411459lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL22C15AzqG7yN7r6cP3xELiCmGRDvacAs2ij+9ObWs=;
        b=B0lgGpj0YkHmy4kkRRar0EoHL3UO2XPwc1gzY8zgEkyNTGHgFbFs2/7W8Ex7HWlZZi
         pJjtjWsVdD0ME8R4XlQBHxw1oifgaAd1PK15QaC+xr1UdkiVHqprDLE4NnAk6moYIcJl
         UeLj8zUROLjV9WewglvJ0doRJE0l+7MJ5xTACQ4w0bAaMPITuJCbZUNQhsbnXl8xxCba
         0Q3MIsSWHg+WQw1azEaWfhLJyaUp9bjvWgmGkr9mPA5fu6Ad+nIxVzgOR8fx06Y7GJZp
         XO28UrIKjX6CcQXw0C9zoshzQ11f9pDctQ2UZ9HpTnIdR81Wb7krPvCEtPce8Ehdd/V3
         jWHw==
X-Gm-Message-State: ACrzQf3fBvweMAgxsB26OjdOIKNvOdfT8qh3G+kHdlg6A7rDVEvXjEEb
        +22wLv7ZKb7xOGF1KDEkCC33jaJ3NCvSxcbeH6UfAi8HU4PFY9NivDxZMpbw4z8BhafcWrwYKr4
        kuIrHOOo1ld8v5Re5DGMGoAEXEsdicCyGsyO5zfmy
X-Received: by 2002:ac2:5239:0:b0:4a4:215e:6c79 with SMTP id i25-20020ac25239000000b004a4215e6c79mr3437568lfl.91.1665995582780;
        Mon, 17 Oct 2022 01:33:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM71ia5PVXHKp3YODweBmFmkzm41xRl+Zk+3mtVPWUo0CIj2rAzFfbmUDyQR40xCbg1w53z+flscunJUBAnxP8Y=
X-Received: by 2002:ac2:5239:0:b0:4a4:215e:6c79 with SMTP id
 i25-20020ac25239000000b004a4215e6c79mr3437562lfl.91.1665995582541; Mon, 17
 Oct 2022 01:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4oK8D-89QZnBC8eYS9TxOU48hY5JazTvF=4N2qdeRepbw@mail.gmail.com>
 <a21c90d5-5793-6b0d-e081-1ea450570774@infradead.org>
In-Reply-To: <a21c90d5-5793-6b0d-e081-1ea450570774@infradead.org>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Mon, 17 Oct 2022 10:32:49 +0200
Message-ID: <CA+QYu4oDz6FD9AwGEQXcoG7M-0dEmqhpbUtsMKdF=F+EBqQXLA@mail.gmail.com>
Subject: Re: [6.0.0] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 at 20:09, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> [adding maintainers]
>
> Bruno- is this still an issue?

Yes, we continue to reproduce it.

Here is an example with 6.1-rc1
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9abf2313adc1ca1b6180c508c25f22f9395cc780)

console log: https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/17/redhat:668163532/build_x86_64_redhat:668163532_x86_64_debug/tests/1/results_0001/console.log/console.log
tarball: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/668163532/publish%20x86_64%20debug/3180162139/artifacts/kernel-mainline.kernel.org-redhat_668163532_x86_64_debug.tar.gz
kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/668163532/build%20x86_64%20debug/3180162134/artifacts/kernel-mainline.kernel.org-redhat_668163532_x86_64_debug.config


Bruno
>
>
> On 10/3/22 00:16, Bruno Goncalves wrote:
> > Hello,
> >
> > recently we are hitting the following issue when booting using kernel
> > with debug options enabled:
> >
> > [  126.821761] CPU: 1 PID: 296 Comm: cryptomgr_test Not tainted 6.0.0 #1
> > [  126.824021] Hardware name: Red Hat KVM, BIOS 1.15.0-1.el9 04/01/2014
> > [  126.825721] RIP: 0010:clmul_polyval_update+0x3e9/0x5d0 [polyval_clmulni]
> > [  126.827045] Code: df 11 c4 41 31 ef fb 48 83 c2 08 0f 84 eb 01 00
> > 00 48 89 d0 48 c1 e0 04 48 81 c7 80 00 00 00 48 29 c7 0f 10 06 66 41
> > 0f ef c7 <0f> 28 0f c4 63 71 44 f0 01 c4 e3 71 44 d0 10 c4 63 71 44 e0
> > 00 c4
>
> This is in 'partial_stride' handling at the 'movaps' instruction:
>
>   11:   48 89 d0                mov    %rdx,%rax
>   14:   48 c1 e0 04             shl    $0x4,%rax
>   18:   48 81 c7 80 00 00 00    add    $0x80,%rdi
>   1f:   48 29 c7                sub    %rax,%rdi
>   22:   0f 10 06                movups (%rsi),%xmm0
>   25:   66 41 0f ef c7          pxor   %xmm15,%xmm0
>   2a:*  0f 28 0f                movaps (%rdi),%xmm1             <-- trapping instruction
>
> > [  126.831535] RSP: 0018:ffff88810ed779d8 EFLAGS: 00010282
> > [  126.832957] RAX: 0000000000000030 RBX: 0000000000000030 RCX: ffff88810ede19e8
> > [  126.834907] RDX: 0000000000000003 RSI: ffff8881094b8000 RDI: ffff88811483c408
> > [  126.836554] RBP: ffff8881094b8000 R08: ffffffffc0300835 R09: ffff88810ede19e8
> > [  126.838529] R10: ffffed1021dbc33f R11: 0000000000000000 R12: 0000000000000030
> > [  126.840526] R13: 0000000000000003 R14: ffff88810ede19e8 R15: ffff88810ede19e0
> > [  126.842702] FS:  0000000000000000(0000) GS:ffff888193d00000(0000)
> > knlGS:0000000000000000
> > [  126.844574] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  126.846796] CR2: 0000564f48e04178 CR3: 000000010be88002 CR4: 0000000000370ee0
> > [  126.848934] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  126.850913] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  126.852879] Call Trace:
> > [  126.853703]  <TASK>
> > [  126.854436]  polyval_x86_update+0x102/0x1e0 [polyval_clmulni]
> > [  126.856092]  test_shash_vec_cfg+0x523/0x9d0
> > [  126.857360]  ? alg_test_aead+0x170/0x170
> > [  126.858682]  ? pointer+0x6a0/0x6a0
> > [  126.859752]  ? ___slab_alloc+0x910/0xf70
> > [  126.860950]  ? __alg_test_hash.constprop.0+0x200/0x430
> > [  126.862140]  ? __kmalloc+0x64/0x380
> > [  126.863233]  ? sprintf+0xb3/0xe0
> > [  126.864159]  ? rcu_read_lock_sched_held+0x3f/0x80
> > [  126.865560]  ? trace_kmalloc+0x33/0xf0
> > [  126.866716]  __alg_test_hash.constprop.0+0x2e7/0x430
> > [  126.867995]  ? test_ahash_vec_cfg+0xca0/0xca0
> > [  126.869389]  ? lockdep_hardirqs_on_prepare+0x230/0x230
> > [  126.870906]  ? lockdep_hardirqs_on+0x7d/0x100
> > [  126.872221]  ? alg_test_hash+0x8e/0x130
> > [  126.873398]  alg_test+0x60d/0x7d0
> > [  126.874463]  ? alloc_cipher_test_sglists+0xb0/0xb0
> > [  126.875867]  ? lock_release+0x233/0x470
> > [  126.876726]  ? __kthread_parkme+0x65/0xf0
> > [  126.877654]  ? reacquire_held_locks+0x270/0x270
> > [  126.878984]  ? mark_held_locks+0x24/0x90
> > [  126.879985]  ? preempt_count_sub+0xb7/0x100
> > [  126.881260]  ? crypto_acomp_scomp_free_ctx+0x70/0x70
> > [  126.882649]  cryptomgr_test+0x36/0x60
> > [  126.883786]  kthread+0x17e/0x1b0
> > [  126.884564]  ? kthread_complete_and_exit+0x20/0x20
> > [  126.885975]  ret_from_fork+0x22/0x30
> > [  126.887086]  </TASK>
> > [  126.887858] Modules linked in: polyval_clmulni(+) polyval_generic
> > virtio_blk(+) ghash_clmulni_intel floppy virtio_console serio_raw
> > ata_generic pata_acpi qemu_fw_cfg
> >
> >
> > full console log:
> > https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/10/02/redhat:656405029/build_x86_64_redhat:656405029_x86_64_debug/tests/4/results_0001/console.log/console.log
> >
> > test logs: https://datawarehouse.cki-project.org/kcidb/tests/5344697
> > cki issue tracker: https://datawarehouse.cki-project.org/issue/1626
> >
> > kernel config: https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/build%20x86_64%20debug/3116060967/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.config
> > kernel tarball:
> > https://s3.amazonaws.com/arr-cki-prod-trusted-artifacts/trusted-artifacts/656405029/publish%20x86_64%20debug/3116060972/artifacts/kernel-mainline.kernel.org-redhat_656405029_x86_64_debug.tar.gz
> >
> > We didn't bisect, but the first commit we tested that we hit the
> > problem is https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46452d3786a82bd732ba73fb308ae5cbe4e1e591
> >
> > The last commit we tested and didn't hit the problem is
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1375562c0a87f0fa2eaf3e8ce15824696d4170a
> >
> > Thanks,
> > Bruno Goncalves
> >
>
> --
> ~Randy
>

